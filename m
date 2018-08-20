Received: from eggs.gnu.org ([2001:4830:134:3::10]:42130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuF-0003eV-8s
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuD-0007OS-V3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:08 +0100
Message-Id: <20180820141116.9118-15-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/22] hw/arm/mps2-tz: Create PL081s and MSCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The AN505 FPGA image includes four PL081 DMA controllers, each
of which is gated by a Master Security Controller that allows
the guest to prevent a non-secure DMA controller from accessing
memory that is used by secure guest code. Create and wire
up these devices.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2 changes:
 - use 'sizeof(*msc)', 'sizeof(*dma)' as suggested
   by Phillipe in code review
 - s/init_sysbus_child/sysbus_init_child_obj/, required by
   rebase on current master
---
 hw/arm/mps2-tz.c | 100 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 7 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index dc0f34abe53..d810e51a1b4 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -45,7 +45,9 @@
 #include "hw/misc/mps2-scc.h"
 #include "hw/misc/mps2-fpgaio.h"
 #include "hw/misc/tz-mpc.h"
+#include "hw/misc/tz-msc.h"
 #include "hw/arm/iotkit.h"
+#include "hw/dma/pl080.h"
 #include "hw/devices.h"
 #include "net/net.h"
 #include "hw/core/split-irq.h"
@@ -75,8 +77,9 @@ typedef struct {
     UnimplementedDeviceState i2c[4];
     UnimplementedDeviceState i2s_audio;
     UnimplementedDeviceState gpio[4];
-    UnimplementedDeviceState dma[4];
     UnimplementedDeviceState gfx;
+    PL080State dma[4];
+    TZMSC msc[4];
     CMSDKAPBUART uart[5];
     SplitIRQ sec_resp_splitter;
     qemu_or_irq uart_irq_orgate;
@@ -263,6 +266,64 @@ static MemoryRegion *make_mpc(MPS2TZMachineState *mms, void *opaque,
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 0);
 }
 
+static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
+                              const char *name, hwaddr size)
+{
+    PL080State *dma = opaque;
+    int i = dma - &mms->dma[0];
+    SysBusDevice *s;
+    char *mscname = g_strdup_printf("%s-msc", name);
+    TZMSC *msc = &mms->msc[i];
+    DeviceState *iotkitdev = DEVICE(&mms->iotkit);
+    MemoryRegion *msc_upstream;
+    MemoryRegion *msc_downstream;
+
+    /*
+     * Each DMA device is a PL081 whose transaction master interface
+     * is guarded by a Master Security Controller. The downstream end of
+     * the MSC connects to the IoTKit AHB Slave Expansion port, so the
+     * DMA devices can see all devices and memory that the CPU does.
+     */
+    sysbus_init_child_obj(OBJECT(mms), mscname, msc, sizeof(*msc), TYPE_TZ_MSC);
+    msc_downstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(&mms->iotkit), 0);
+    object_property_set_link(OBJECT(msc), OBJECT(msc_downstream),
+                             "downstream", &error_fatal);
+    object_property_set_link(OBJECT(msc), OBJECT(mms),
+                             "idau", &error_fatal);
+    object_property_set_bool(OBJECT(msc), true, "realized", &error_fatal);
+
+    qdev_connect_gpio_out_named(DEVICE(msc), "irq", 0,
+                                qdev_get_gpio_in_named(iotkitdev,
+                                                       "mscexp_status", i));
+    qdev_connect_gpio_out_named(iotkitdev, "mscexp_clear", i,
+                                qdev_get_gpio_in_named(DEVICE(msc),
+                                                       "irq_clear", 0));
+    qdev_connect_gpio_out_named(iotkitdev, "mscexp_ns", i,
+                                qdev_get_gpio_in_named(DEVICE(msc),
+                                                       "cfg_nonsec", 0));
+    qdev_connect_gpio_out(DEVICE(&mms->sec_resp_splitter),
+                          ARRAY_SIZE(mms->ppc) + i,
+                          qdev_get_gpio_in_named(DEVICE(msc),
+                                                 "cfg_sec_resp", 0));
+    msc_upstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(msc), 0);
+
+    sysbus_init_child_obj(OBJECT(mms), name, dma, sizeof(*dma), TYPE_PL081);
+    object_property_set_link(OBJECT(dma), OBJECT(msc_upstream),
+                             "downstream", &error_fatal);
+    object_property_set_bool(OBJECT(dma), true, "realized", &error_fatal);
+
+    s = SYS_BUS_DEVICE(dma);
+    /* Wire up DMACINTR, DMACINTERR, DMACINTTC */
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in_named(iotkitdev,
+                                                    "EXP_IRQ", 58 + i * 3));
+    sysbus_connect_irq(s, 1, qdev_get_gpio_in_named(iotkitdev,
+                                                    "EXP_IRQ", 56 + i * 3));
+    sysbus_connect_irq(s, 2, qdev_get_gpio_in_named(iotkitdev,
+                                                    "EXP_IRQ", 57 + i * 3));
+
+    return sysbus_mmio_get_region(s, 0);
+}
+
 static void mps2tz_common_init(MachineState *machine)
 {
     MPS2TZMachineState *mms = MPS2TZ_MACHINE(machine);
@@ -289,13 +350,14 @@ static void mps2tz_common_init(MachineState *machine)
                              &error_fatal);
 
     /* The sec_resp_cfg output from the IoTKit must be split into multiple
-     * lines, one for each of the PPCs we create here.
+     * lines, one for each of the PPCs we create here, plus one per MSC.
      */
     object_initialize(&mms->sec_resp_splitter, sizeof(mms->sec_resp_splitter),
                       TYPE_SPLIT_IRQ);
     object_property_add_child(OBJECT(machine), "sec-resp-splitter",
                               OBJECT(&mms->sec_resp_splitter), &error_abort);
-    object_property_set_int(OBJECT(&mms->sec_resp_splitter), 5,
+    object_property_set_int(OBJECT(&mms->sec_resp_splitter),
+                            ARRAY_SIZE(mms->ppc) + ARRAY_SIZE(mms->msc),
                             "num-lines", &error_fatal);
     object_property_set_bool(OBJECT(&mms->sec_resp_splitter), true,
                              "realized", &error_fatal);
@@ -396,10 +458,10 @@ static void mps2tz_common_init(MachineState *machine)
         }, {
             .name = "ahb_ppcexp1",
             .ports = {
-                { "dma0", make_unimp_dev, &mms->dma[0], 0x40110000, 0x1000 },
-                { "dma1", make_unimp_dev, &mms->dma[1], 0x40111000, 0x1000 },
-                { "dma2", make_unimp_dev, &mms->dma[2], 0x40112000, 0x1000 },
-                { "dma3", make_unimp_dev, &mms->dma[3], 0x40113000, 0x1000 },
+                { "dma0", make_dma, &mms->dma[0], 0x40110000, 0x1000 },
+                { "dma1", make_dma, &mms->dma[1], 0x40111000, 0x1000 },
+                { "dma2", make_dma, &mms->dma[2], 0x40112000, 0x1000 },
+                { "dma3", make_dma, &mms->dma[3], 0x40113000, 0x1000 },
             },
         },
     };
@@ -480,12 +542,32 @@ static void mps2tz_common_init(MachineState *machine)
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x400000);
 }
 
+static void mps2_tz_idau_check(IDAUInterface *ii, uint32_t address,
+                               int *iregion, bool *exempt, bool *ns, bool *nsc)
+{
+    /*
+     * The MPS2 TZ FPGA images have IDAUs in them which are connected to
+     * the Master Security Controllers. Thes have the same logic as
+     * is used by the IoTKit for the IDAU connected to the CPU, except
+     * that MSCs don't care about the NSC attribute.
+     */
+    int region = extract32(address, 28, 4);
+
+    *ns = !(region & 1);
+    *nsc = false;
+    /* 0xe0000000..0xe00fffff and 0xf0000000..0xf00fffff are exempt */
+    *exempt = (address & 0xeff00000) == 0xe0000000;
+    *iregion = region;
+}
+
 static void mps2tz_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(oc);
 
     mc->init = mps2tz_common_init;
     mc->max_cpus = 1;
+    iic->check = mps2_tz_idau_check;
 }
 
 static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
@@ -506,6 +588,10 @@ static const TypeInfo mps2tz_info = {
     .instance_size = sizeof(MPS2TZMachineState),
     .class_size = sizeof(MPS2TZMachineClass),
     .class_init = mps2tz_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_IDAU_INTERFACE },
+        { }
+    },
 };
 
 static const TypeInfo mps2tz_an505_info = {
-- 
2.18.0
