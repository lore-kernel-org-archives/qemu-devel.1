Received: from eggs.gnu.org ([209.51.188.92]:49748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeQ-0002vd-JI
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGUW-0006yg-If
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:54 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGUR-0006fa-HX
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so6308990wrt.13
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:51:04 +0000
Message-Id: <20190214125107.22178-12-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/14] hw/arm/musca: Add PPCs
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

Many of the devices on the Musca board live behind TrustZone
Peripheral Protection Controllers (PPCs); add models of the
PPCs, using a similar scheme to the MPS2 board models.
This commit wires up the PPCs with "unimplemented device"
stubs behind them in the correct places in the address map.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musca.c | 289 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 289 insertions(+)

diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index cc624c7d160..8774e0b87b7 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -27,8 +27,11 @@
 #include "hw/arm/armsse.h"
 #include "hw/boards.h"
 #include "hw/core/split-irq.h"
+#include "hw/misc/tz-ppc.h"
+#include "hw/misc/unimp.h"
 
 #define MUSCA_NUMIRQ_MAX 96
+#define MUSCA_PPC_MAX 3
 
 typedef enum MuscaType {
     MUSCA_A,
@@ -48,6 +51,24 @@ typedef struct {
 
     ARMSSE sse;
     SplitIRQ cpu_irq_splitter[MUSCA_NUMIRQ_MAX];
+    SplitIRQ sec_resp_splitter;
+    TZPPC ppc[MUSCA_PPC_MAX];
+    MemoryRegion container;
+    UnimplementedDeviceState eflash[2];
+    UnimplementedDeviceState qspi;
+    UnimplementedDeviceState mpc[5];
+    UnimplementedDeviceState mhu[2];
+    UnimplementedDeviceState pwm[3];
+    UnimplementedDeviceState i2s;
+    UnimplementedDeviceState uart[2];
+    UnimplementedDeviceState i2c[2];
+    UnimplementedDeviceState spi;
+    UnimplementedDeviceState scc;
+    UnimplementedDeviceState timer;
+    UnimplementedDeviceState rtc;
+    UnimplementedDeviceState pvt;
+    UnimplementedDeviceState sdio;
+    UnimplementedDeviceState gpio;
 } MuscaMachineState;
 
 #define TYPE_MUSCA_MACHINE "musca"
@@ -68,6 +89,94 @@ typedef struct {
  */
 #define SYSCLK_FRQ 40000000
 
+/*
+ * Most of the devices in the Musca board sit behind Peripheral Protection
+ * Controllers. These data structures define the layout of which devices
+ * sit behind which PPCs.
+ * The devfn for each port is a function which creates, configures
+ * and initializes the device, returning the MemoryRegion which
+ * needs to be plugged into the downstream end of the PPC port.
+ */
+typedef MemoryRegion *MakeDevFn(MuscaMachineState *mms, void *opaque,
+                                const char *name, hwaddr size);
+
+typedef struct PPCPortInfo {
+    const char *name;
+    MakeDevFn *devfn;
+    void *opaque;
+    hwaddr addr;
+    hwaddr size;
+} PPCPortInfo;
+
+typedef struct PPCInfo {
+    const char *name;
+    PPCPortInfo ports[TZ_NUM_PORTS];
+} PPCInfo;
+
+static MemoryRegion *make_unimp_dev(MuscaMachineState *mms,
+                                    void *opaque, const char *name, hwaddr size)
+{
+    /*
+     * Initialize, configure and realize a TYPE_UNIMPLEMENTED_DEVICE,
+     * and return a pointer to its MemoryRegion.
+     */
+    UnimplementedDeviceState *uds = opaque;
+
+    sysbus_init_child_obj(OBJECT(mms), name, uds,
+                          sizeof(UnimplementedDeviceState),
+                          TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(DEVICE(uds), "name", name);
+    qdev_prop_set_uint64(DEVICE(uds), "size", size);
+    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+    return sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0);
+}
+
+static MemoryRegion *make_musca_a_devs(MuscaMachineState *mms, void *opaque,
+                                       const char *name, hwaddr size)
+{
+    /*
+     * Create the container MemoryRegion for all the devices that live
+     * behind the Musca-A PPC's single port. These devices don't have a PPC
+     * port each, but we use the PPCPortInfo struct as a convenient way
+     * to describe them. Note that addresses here are relative to the base
+     * address of the PPC port region: 0x40100000, and devices appear both
+     * at the 0x4... NS region and the 0x5... S region.
+     */
+    int i;
+    MemoryRegion *container = &mms->container;
+
+    const PPCPortInfo devices[] = {
+        { "uart0", make_unimp_dev, &mms->uart[0], 0x1000, 0x1000 },
+        { "uart1", make_unimp_dev, &mms->uart[1], 0x2000, 0x1000 },
+        { "spi", make_unimp_dev, &mms->spi, 0x3000, 0x1000 },
+        { "i2c0", make_unimp_dev, &mms->i2c[0], 0x4000, 0x1000 },
+        { "i2c1", make_unimp_dev, &mms->i2c[1], 0x5000, 0x1000 },
+        { "i2s", make_unimp_dev, &mms->i2s, 0x6000, 0x1000 },
+        { "pwm0", make_unimp_dev, &mms->pwm[0], 0x7000, 0x1000 },
+        { "rtc", make_unimp_dev, &mms->rtc, 0x8000, 0x1000 },
+        { "qspi", make_unimp_dev, &mms->qspi, 0xa000, 0x1000 },
+        { "timer", make_unimp_dev, &mms->timer, 0xb000, 0x1000 },
+        { "scc", make_unimp_dev, &mms->scc, 0xc000, 0x1000 },
+        { "pwm1", make_unimp_dev, &mms->pwm[1], 0xe000, 0x1000 },
+        { "pwm2", make_unimp_dev, &mms->pwm[2], 0xf000, 0x1000 },
+        { "gpio", make_unimp_dev, &mms->gpio, 0x10000, 0x1000 },
+        { "mpc0", make_unimp_dev, &mms->mpc[0], 0x12000, 0x1000 },
+        { "mpc1", make_unimp_dev, &mms->mpc[1], 0x13000, 0x1000 },
+    };
+
+    memory_region_init(container, OBJECT(mms), "musca-device-container", size);
+
+    for (i = 0; i < ARRAY_SIZE(devices); i++) {
+        const PPCPortInfo *pinfo = &devices[i];
+        MemoryRegion *mr;
+
+        mr = pinfo->devfn(mms, pinfo->opaque, pinfo->name, pinfo->size);
+        memory_region_add_subregion(container, pinfo->addr, mr);
+    }
+
+    return &mms->container;
+}
+
 static void musca_init(MachineState *machine)
 {
     MuscaMachineState *mms = MUSCA_MACHINE(machine);
@@ -75,6 +184,9 @@ static void musca_init(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *ssedev;
+    DeviceState *dev_splitter;
+    const PPCInfo *ppcs;
+    int num_ppcs;
     int i;
 
     assert(mmc->num_irqs <= MUSCA_NUMIRQ_MAX);
@@ -121,6 +233,183 @@ static void musca_init(MachineState *machine)
                                                      "EXP_CPU1_IRQ", i));
     }
 
+    /*
+     * The sec_resp_cfg output from the SSE-200 must be split into multiple
+     * lines, one for each of the PPCs we create here.
+     */
+    object_initialize(&mms->sec_resp_splitter, sizeof(mms->sec_resp_splitter),
+                      TYPE_SPLIT_IRQ);
+    object_property_add_child(OBJECT(machine), "sec-resp-splitter",
+                              OBJECT(&mms->sec_resp_splitter), &error_fatal);
+    object_property_set_int(OBJECT(&mms->sec_resp_splitter),
+                            ARRAY_SIZE(mms->ppc), "num-lines", &error_fatal);
+    object_property_set_bool(OBJECT(&mms->sec_resp_splitter), true,
+                             "realized", &error_fatal);
+    dev_splitter = DEVICE(&mms->sec_resp_splitter);
+    qdev_connect_gpio_out_named(ssedev, "sec_resp_cfg", 0,
+                                qdev_get_gpio_in(dev_splitter, 0));
+
+    /*
+     * Most of the devices in the board are behind Peripheral Protection
+     * Controllers. The required order for initializing things is:
+     *  + initialize the PPC
+     *  + initialize, configure and realize downstream devices
+     *  + connect downstream device MemoryRegions to the PPC
+     *  + realize the PPC
+     *  + map the PPC's MemoryRegions to the places in the address map
+     *    where the downstream devices should appear
+     *  + wire up the PPC's control lines to the SSE object
+     *
+     * The PPC mapping differs for the -A and -B1 variants; the -A version
+     * is much simpler, using only a single port of a single PPC and putting
+     * all the devices behind that.
+     */
+    const PPCInfo a_ppcs[] = { {
+            .name = "ahb_ppcexp0",
+            .ports = {
+                { "musca-devices", make_musca_a_devs, 0, 0x40100000, 0x100000 },
+            },
+        },
+    };
+
+    /*
+     * Devices listed with an 0x4.. address appear in both the NS 0x4.. region
+     * and the 0x5.. S region. Devices listed with an 0x5.. address appear
+     * only in the S region.
+     */
+    const PPCInfo b1_ppcs[] = { {
+            .name = "apb_ppcexp0",
+            .ports = {
+                { "eflash0", make_unimp_dev, &mms->eflash[0],
+                  0x52400000, 0x1000 },
+                { "eflash1", make_unimp_dev, &mms->eflash[1],
+                  0x52500000, 0x1000 },
+                { "qspi", make_unimp_dev, &mms->qspi, 0x42800000, 0x100000 },
+                { "mpc0", make_unimp_dev, &mms->mpc[0], 0x52000000, 0x1000 },
+                { "mpc1", make_unimp_dev, &mms->mpc[1], 0x52100000, 0x1000 },
+                { "mpc2", make_unimp_dev, &mms->mpc[2], 0x52200000, 0x1000 },
+                { "mpc3", make_unimp_dev, &mms->mpc[3], 0x52300000, 0x1000 },
+                { "mhu0", make_unimp_dev, &mms->mhu[0], 0x42600000, 0x100000 },
+                { "mhu1", make_unimp_dev, &mms->mhu[1], 0x42700000, 0x100000 },
+                { }, /* port 9: unused */
+                { }, /* port 10: unused */
+                { }, /* port 11: unused */
+                { }, /* port 12: unused */
+                { }, /* port 13: unused */
+                { "mpc4", make_unimp_dev, &mms->mpc[4], 0x52e00000, 0x1000 },
+            },
+        }, {
+            .name = "apb_ppcexp1",
+            .ports = {
+                { "pwm0", make_unimp_dev, &mms->pwm[0], 0x40101000, 0x1000 },
+                { "pwm1", make_unimp_dev, &mms->pwm[1], 0x40102000, 0x1000 },
+                { "pwm2", make_unimp_dev, &mms->pwm[2], 0x40103000, 0x1000 },
+                { "i2s", make_unimp_dev, &mms->i2s, 0x40104000, 0x1000 },
+                { "uart0", make_unimp_dev, &mms->uart[0], 0x40105000, 0x1000 },
+                { "uart1", make_unimp_dev, &mms->uart[1], 0x40106000, 0x1000 },
+                { "i2c0", make_unimp_dev, &mms->i2c[0], 0x40108000, 0x1000 },
+                { "i2c1", make_unimp_dev, &mms->i2c[1], 0x40109000, 0x1000 },
+                { "spi", make_unimp_dev, &mms->spi, 0x4010a000, 0x1000 },
+                { "scc", make_unimp_dev, &mms->scc, 0x5010b000, 0x1000 },
+                { "timer", make_unimp_dev, &mms->timer, 0x4010c000, 0x1000 },
+                { "rtc", make_unimp_dev, &mms->rtc, 0x4010d000, 0x1000 },
+                { "pvt", make_unimp_dev, &mms->pvt, 0x4010e000, 0x1000 },
+                { "sdio", make_unimp_dev, &mms->sdio, 0x4010f000, 0x1000 },
+            },
+        }, {
+            .name = "ahb_ppcexp0",
+            .ports = {
+                { }, /* port 0: unused */
+                { "gpio", make_unimp_dev, &mms->gpio, 0x41000000, 0x1000 },
+            },
+        },
+    };
+
+    switch (mmc->type) {
+    case MUSCA_A:
+        ppcs = a_ppcs;
+        num_ppcs = ARRAY_SIZE(a_ppcs);
+        break;
+    case MUSCA_B1:
+        ppcs = b1_ppcs;
+        num_ppcs = ARRAY_SIZE(b1_ppcs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    assert(num_ppcs <= MUSCA_PPC_MAX);
+
+    for (i = 0; i < num_ppcs; i++) {
+        const PPCInfo *ppcinfo = &ppcs[i];
+        TZPPC *ppc = &mms->ppc[i];
+        DeviceState *ppcdev;
+        int port;
+        char *gpioname;
+
+        sysbus_init_child_obj(OBJECT(machine), ppcinfo->name, ppc,
+                              sizeof(TZPPC), TYPE_TZ_PPC);
+        ppcdev = DEVICE(ppc);
+
+        for (port = 0; port < TZ_NUM_PORTS; port++) {
+            const PPCPortInfo *pinfo = &ppcinfo->ports[port];
+            MemoryRegion *mr;
+            char *portname;
+
+            if (!pinfo->devfn) {
+                continue;
+            }
+
+            mr = pinfo->devfn(mms, pinfo->opaque, pinfo->name, pinfo->size);
+            portname = g_strdup_printf("port[%d]", port);
+            object_property_set_link(OBJECT(ppc), OBJECT(mr),
+                                     portname, &error_fatal);
+            g_free(portname);
+        }
+
+        object_property_set_bool(OBJECT(ppc), true, "realized", &error_fatal);
+
+        for (port = 0; port < TZ_NUM_PORTS; port++) {
+            const PPCPortInfo *pinfo = &ppcinfo->ports[port];
+
+            if (!pinfo->devfn) {
+                continue;
+            }
+            sysbus_mmio_map(SYS_BUS_DEVICE(ppc), port, pinfo->addr);
+
+            gpioname = g_strdup_printf("%s_nonsec", ppcinfo->name);
+            qdev_connect_gpio_out_named(ssedev, gpioname, port,
+                                        qdev_get_gpio_in_named(ppcdev,
+                                                               "cfg_nonsec",
+                                                               port));
+            g_free(gpioname);
+            gpioname = g_strdup_printf("%s_ap", ppcinfo->name);
+            qdev_connect_gpio_out_named(ssedev, gpioname, port,
+                                        qdev_get_gpio_in_named(ppcdev,
+                                                               "cfg_ap", port));
+            g_free(gpioname);
+        }
+
+        gpioname = g_strdup_printf("%s_irq_enable", ppcinfo->name);
+        qdev_connect_gpio_out_named(ssedev, gpioname, 0,
+                                    qdev_get_gpio_in_named(ppcdev,
+                                                           "irq_enable", 0));
+        g_free(gpioname);
+        gpioname = g_strdup_printf("%s_irq_clear", ppcinfo->name);
+        qdev_connect_gpio_out_named(ssedev, gpioname, 0,
+                                    qdev_get_gpio_in_named(ppcdev,
+                                                           "irq_clear", 0));
+        g_free(gpioname);
+        gpioname = g_strdup_printf("%s_irq_status", ppcinfo->name);
+        qdev_connect_gpio_out_named(ppcdev, "irq", 0,
+                                    qdev_get_gpio_in_named(ssedev,
+                                                           gpioname, 0));
+        g_free(gpioname);
+
+        qdev_connect_gpio_out(dev_splitter, i,
+                              qdev_get_gpio_in_named(ppcdev,
+                                                     "cfg_sec_resp", 0));
+    }
+
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x2000000);
 }
 
-- 
2.20.1
