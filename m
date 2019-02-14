Received: from eggs.gnu.org ([209.51.188.92]:49778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeQ-0002xU-GR
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGUd-00070Z-0I
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGUa-0006hL-BB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:54 -0500
Received: by mail-wr1-x441.google.com with SMTP id o17so6368064wrw.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:51:05 +0000
Message-Id: <20190214125107.22178-13-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/14] hw/arm/musca: Add MPCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The Musca board puts its SRAM and flash behind TrustZone
Memory Protection Controllers (MPCs). Each MPC sits between
the CPU and the RAM/flash, and also has a set of memory mapped
control registers. Wire up the MPCs, and the memory behind them.
For the moment we implement the flash as simple ROM, which
cannot be reprogrammed by the guest.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musca.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 8 deletions(-)

diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 8774e0b87b7..5fadac8c09b 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -27,11 +27,15 @@
 #include "hw/arm/armsse.h"
 #include "hw/boards.h"
 #include "hw/core/split-irq.h"
+#include "hw/misc/tz-mpc.h"
 #include "hw/misc/tz-ppc.h"
 #include "hw/misc/unimp.h"
 
 #define MUSCA_NUMIRQ_MAX 96
 #define MUSCA_PPC_MAX 3
+#define MUSCA_MPC_MAX 5
+
+typedef struct MPCInfo MPCInfo;
 
 typedef enum MuscaType {
     MUSCA_A,
@@ -44,19 +48,23 @@ typedef struct {
     uint32_t init_svtor;
     int sram_addr_width;
     int num_irqs;
+    const MPCInfo *mpc_info;
+    int num_mpcs;
 } MuscaMachineClass;
 
 typedef struct {
     MachineState parent;
 
     ARMSSE sse;
+    /* RAM and flash */
+    MemoryRegion ram[MUSCA_MPC_MAX];
     SplitIRQ cpu_irq_splitter[MUSCA_NUMIRQ_MAX];
     SplitIRQ sec_resp_splitter;
     TZPPC ppc[MUSCA_PPC_MAX];
     MemoryRegion container;
     UnimplementedDeviceState eflash[2];
     UnimplementedDeviceState qspi;
-    UnimplementedDeviceState mpc[5];
+    TZMPC mpc[MUSCA_MPC_MAX];
     UnimplementedDeviceState mhu[2];
     UnimplementedDeviceState pwm[3];
     UnimplementedDeviceState i2s;
@@ -69,6 +77,7 @@ typedef struct {
     UnimplementedDeviceState pvt;
     UnimplementedDeviceState sdio;
     UnimplementedDeviceState gpio;
+    UnimplementedDeviceState cryptoisland;
 } MuscaMachineState;
 
 #define TYPE_MUSCA_MACHINE "musca"
@@ -131,6 +140,131 @@ static MemoryRegion *make_unimp_dev(MuscaMachineState *mms,
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0);
 }
 
+typedef enum MPCInfoType {
+    MPC_RAM,
+    MPC_ROM,
+    MPC_CRYPTOISLAND,
+} MPCInfoType;
+
+typedef struct MPCInfo {
+    const char *name;
+    hwaddr addr;
+    hwaddr size;
+    MPCInfoType type;
+} MPCInfo;
+
+/* Order of the MPCs here must match the order of the bits in SECMPCINTSTATUS */
+static const MPCInfo a_mpc_info[] = { {
+        .name = "qspi",
+        .type = MPC_ROM,
+        .addr = 0x00200000,
+        .size = 0x00800000,
+    }, {
+        .name = "sram",
+        .type = MPC_RAM,
+        .addr = 0x00000000,
+        .size = 0x00200000,
+    }
+};
+
+static const MPCInfo b1_mpc_info[] = { {
+        .name = "qspi",
+        .type = MPC_ROM,
+        .addr = 0x00000000,
+        .size = 0x02000000,
+    }, {
+        .name = "sram",
+        .type = MPC_RAM,
+        .addr = 0x0a400000,
+        .size = 0x00080000,
+    }, {
+        .name = "eflash0",
+        .type = MPC_ROM,
+        .addr = 0x0a000000,
+        .size = 0x00200000,
+    }, {
+        .name = "eflash1",
+        .type = MPC_ROM,
+        .addr = 0x0a200000,
+        .size = 0x00200000,
+    }, {
+        .name = "cryptoisland",
+        .type = MPC_CRYPTOISLAND,
+        .addr = 0x0a000000,
+        .size = 0x00200000,
+    }
+};
+
+static MemoryRegion *make_mpc(MuscaMachineState *mms, void *opaque,
+                              const char *name, hwaddr size)
+{
+    /*
+     * Create an MPC and the RAM or flash behind it.
+     * MPC 0: eFlash 0
+     * MPC 1: eFlash 1
+     * MPC 2: SRAM
+     * MPC 3: QSPI flash
+     * MPC 4: CryptoIsland
+     * For now we implement the flash regions as ROM (ie not programmable)
+     * (with their control interface memory regions being unimplemented
+     * stubs behind the PPCs).
+     * The whole CryptoIsland region behind its MPC is an unimplemented stub.
+     */
+    MuscaMachineClass *mmc = MUSCA_MACHINE_GET_CLASS(mms);
+    TZMPC *mpc = opaque;
+    int i = mpc - &mms->mpc[0];
+    MemoryRegion *downstream;
+    MemoryRegion *upstream;
+    UnimplementedDeviceState *uds;
+    char *mpcname;
+    const MPCInfo *mpcinfo = mmc->mpc_info;
+
+    mpcname = g_strdup_printf("%s-mpc", mpcinfo[i].name);
+
+    switch (mpcinfo[i].type) {
+    case MPC_ROM:
+        downstream = &mms->ram[i];
+        memory_region_init_rom(downstream, NULL, mpcinfo[i].name,
+                               mpcinfo[i].size, &error_fatal);
+        break;
+    case MPC_RAM:
+        downstream = &mms->ram[i];
+        memory_region_init_ram(downstream, NULL, mpcinfo[i].name,
+                               mpcinfo[i].size, &error_fatal);
+        break;
+    case MPC_CRYPTOISLAND:
+        /* We don't implement the CryptoIsland yet */
+        uds = &mms->cryptoisland;
+        sysbus_init_child_obj(OBJECT(mms), name, uds,
+                              sizeof(UnimplementedDeviceState),
+                              TYPE_UNIMPLEMENTED_DEVICE);
+        qdev_prop_set_string(DEVICE(uds), "name", mpcinfo[i].name);
+        qdev_prop_set_uint64(DEVICE(uds), "size", mpcinfo[i].size);
+        object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+        downstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    sysbus_init_child_obj(OBJECT(mms), mpcname, mpc, sizeof(mms->mpc[0]),
+                          TYPE_TZ_MPC);
+    object_property_set_link(OBJECT(mpc), OBJECT(downstream),
+                             "downstream", &error_fatal);
+    object_property_set_bool(OBJECT(mpc), true, "realized", &error_fatal);
+    /* Map the upstream end of the MPC into system memory */
+    upstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 1);
+    memory_region_add_subregion(get_system_memory(), mpcinfo[i].addr, upstream);
+    /* and connect its interrupt to the SSE-200 */
+    qdev_connect_gpio_out_named(DEVICE(mpc), "irq", 0,
+                                qdev_get_gpio_in_named(DEVICE(&mms->sse),
+                                                       "mpcexp_status", i));
+
+    g_free(mpcname);
+    /* Return the register interface MR for our caller to map behind the PPC */
+    return sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 0);
+}
+
 static MemoryRegion *make_musca_a_devs(MuscaMachineState *mms, void *opaque,
                                        const char *name, hwaddr size)
 {
@@ -160,8 +294,8 @@ static MemoryRegion *make_musca_a_devs(MuscaMachineState *mms, void *opaque,
         { "pwm1", make_unimp_dev, &mms->pwm[1], 0xe000, 0x1000 },
         { "pwm2", make_unimp_dev, &mms->pwm[2], 0xf000, 0x1000 },
         { "gpio", make_unimp_dev, &mms->gpio, 0x10000, 0x1000 },
-        { "mpc0", make_unimp_dev, &mms->mpc[0], 0x12000, 0x1000 },
-        { "mpc1", make_unimp_dev, &mms->mpc[1], 0x13000, 0x1000 },
+        { "mpc0", make_mpc, &mms->mpc[0], 0x12000, 0x1000 },
+        { "mpc1", make_mpc, &mms->mpc[1], 0x13000, 0x1000 },
     };
 
     memory_region_init(container, OBJECT(mms), "musca-device-container", size);
@@ -190,6 +324,7 @@ static void musca_init(MachineState *machine)
     int i;
 
     assert(mmc->num_irqs <= MUSCA_NUMIRQ_MAX);
+    assert(mmc->num_mpcs <= MUSCA_MPC_MAX);
 
     if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
         error_report("This board can only be used with CPU %s",
@@ -285,10 +420,10 @@ static void musca_init(MachineState *machine)
                 { "eflash1", make_unimp_dev, &mms->eflash[1],
                   0x52500000, 0x1000 },
                 { "qspi", make_unimp_dev, &mms->qspi, 0x42800000, 0x100000 },
-                { "mpc0", make_unimp_dev, &mms->mpc[0], 0x52000000, 0x1000 },
-                { "mpc1", make_unimp_dev, &mms->mpc[1], 0x52100000, 0x1000 },
-                { "mpc2", make_unimp_dev, &mms->mpc[2], 0x52200000, 0x1000 },
-                { "mpc3", make_unimp_dev, &mms->mpc[3], 0x52300000, 0x1000 },
+                { "mpc0", make_mpc, &mms->mpc[0], 0x52000000, 0x1000 },
+                { "mpc1", make_mpc, &mms->mpc[1], 0x52100000, 0x1000 },
+                { "mpc2", make_mpc, &mms->mpc[2], 0x52200000, 0x1000 },
+                { "mpc3", make_mpc, &mms->mpc[3], 0x52300000, 0x1000 },
                 { "mhu0", make_unimp_dev, &mms->mhu[0], 0x42600000, 0x100000 },
                 { "mhu1", make_unimp_dev, &mms->mhu[1], 0x42700000, 0x100000 },
                 { }, /* port 9: unused */
@@ -296,7 +431,7 @@ static void musca_init(MachineState *machine)
                 { }, /* port 11: unused */
                 { }, /* port 12: unused */
                 { }, /* port 13: unused */
-                { "mpc4", make_unimp_dev, &mms->mpc[4], 0x52e00000, 0x1000 },
+                { "mpc4", make_mpc, &mms->mpc[4], 0x52e00000, 0x1000 },
             },
         }, {
             .name = "apb_ppcexp1",
@@ -434,6 +569,8 @@ static void musca_a_class_init(ObjectClass *oc, void *data)
     mmc->init_svtor = 0x10200000;
     mmc->sram_addr_width = 15;
     mmc->num_irqs = 64;
+    mmc->mpc_info = a_mpc_info;
+    mmc->num_mpcs = ARRAY_SIZE(a_mpc_info);
 }
 
 static void musca_b1_class_init(ObjectClass *oc, void *data)
@@ -453,6 +590,8 @@ static void musca_b1_class_init(ObjectClass *oc, void *data)
     mmc->init_svtor = 0x10000000;
     mmc->sram_addr_width = 17;
     mmc->num_irqs = 96;
+    mmc->mpc_info = b1_mpc_info;
+    mmc->num_mpcs = ARRAY_SIZE(b1_mpc_info);
 }
 
 static const TypeInfo musca_info = {
-- 
2.20.1
