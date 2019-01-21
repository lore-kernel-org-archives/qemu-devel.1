Received: from eggs.gnu.org ([209.51.188.92]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevN-00081G-Uj
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefi-0002xA-UU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefi-0002we-K3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:46 -0500
Received: by mail-wm1-x341.google.com with SMTP id r24so6819296wmh.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:17 +0000
Message-Id: <20190121185118.18550-23-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 22/23] hw/arm/mps2-tz: Add IRQ infrastructure
 to support SSE-200
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

In preparation for adding support for the AN521 MPS2 image, we need
to handle wiring up the MPS2 device interrupt lines to both CPUs in
the SSE-200, rather than just the one that the IoTKit has.

Abstract out a "connect to the IoTKit interrupt line" function
and make it connect to a splitter which feeds both sets of inputs
for the SSE-200 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 79 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 3859f17d98b..95adcd478ab 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -53,8 +53,11 @@
 #include "net/net.h"
 #include "hw/core/split-irq.h"
 
+#define MPS2TZ_NUMIRQ 92
+
 typedef enum MPS2TZFPGAType {
     FPGA_AN505,
+    FPGA_AN521,
 } MPS2TZFPGAType;
 
 typedef struct {
@@ -85,6 +88,7 @@ typedef struct {
     SplitIRQ sec_resp_splitter;
     qemu_or_irq uart_irq_orgate;
     DeviceState *lan9118;
+    SplitIRQ cpu_irq_splitter[MPS2TZ_NUMIRQ];
 } MPS2TZMachineState;
 
 #define TYPE_MPS2TZ_MACHINE "mps2tz"
@@ -111,6 +115,23 @@ static void make_ram_alias(MemoryRegion *mr, const char *name,
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
 
+static qemu_irq get_sse_irq_in(MPS2TZMachineState *mms, int irqno)
+{
+    /* Return a qemu_irq which will signal IRQ n to all CPUs in the SSE. */
+    MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_GET_CLASS(mms);
+
+    assert(irqno < MPS2TZ_NUMIRQ);
+
+    switch (mmc->fpga_type) {
+    case FPGA_AN505:
+        return qdev_get_gpio_in_named(DEVICE(&mms->iotkit), "EXP_IRQ", irqno);
+    case FPGA_AN521:
+        return qdev_get_gpio_in(DEVICE(&mms->cpu_irq_splitter[irqno]), 0);
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Most of the devices in the AN505 FPGA image sit behind
  * Peripheral Protection Controllers. These data structures
  * define the layout of which devices sit behind which PPCs.
@@ -161,7 +182,6 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
     int txirqno = i * 2 + 1;
     int combirqno = i + 10;
     SysBusDevice *s;
-    DeviceState *iotkitdev = DEVICE(&mms->iotkit);
     DeviceState *orgate_dev = DEVICE(&mms->uart_irq_orgate);
 
     sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(mms->uart[0]),
@@ -170,14 +190,11 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
     qdev_prop_set_uint32(DEVICE(uart), "pclk-frq", SYSCLK_FRQ);
     object_property_set_bool(OBJECT(uart), true, "realized", &error_fatal);
     s = SYS_BUS_DEVICE(uart);
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in_named(iotkitdev,
-                                                    "EXP_IRQ", txirqno));
-    sysbus_connect_irq(s, 1, qdev_get_gpio_in_named(iotkitdev,
-                                                    "EXP_IRQ", rxirqno));
+    sysbus_connect_irq(s, 0, get_sse_irq_in(mms, txirqno));
+    sysbus_connect_irq(s, 1, get_sse_irq_in(mms, rxirqno));
     sysbus_connect_irq(s, 2, qdev_get_gpio_in(orgate_dev, i * 2));
     sysbus_connect_irq(s, 3, qdev_get_gpio_in(orgate_dev, i * 2 + 1));
-    sysbus_connect_irq(s, 4, qdev_get_gpio_in_named(iotkitdev,
-                                                    "EXP_IRQ", combirqno));
+    sysbus_connect_irq(s, 4, get_sse_irq_in(mms, combirqno));
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(uart), 0);
 }
 
@@ -213,7 +230,6 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
                                   const char *name, hwaddr size)
 {
     SysBusDevice *s;
-    DeviceState *iotkitdev = DEVICE(&mms->iotkit);
     NICInfo *nd = &nd_table[0];
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
@@ -225,7 +241,7 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
     qdev_init_nofail(mms->lan9118);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in_named(iotkitdev, "EXP_IRQ", 16));
+    sysbus_connect_irq(s, 0, get_sse_irq_in(mms, 16));
     return sysbus_mmio_get_region(s, 0);
 }
 
@@ -315,12 +331,9 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
 
     s = SYS_BUS_DEVICE(dma);
     /* Wire up DMACINTR, DMACINTERR, DMACINTTC */
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in_named(iotkitdev,
-                                                    "EXP_IRQ", 58 + i * 3));
-    sysbus_connect_irq(s, 1, qdev_get_gpio_in_named(iotkitdev,
-                                                    "EXP_IRQ", 56 + i * 3));
-    sysbus_connect_irq(s, 2, qdev_get_gpio_in_named(iotkitdev,
-                                                    "EXP_IRQ", 57 + i * 3));
+    sysbus_connect_irq(s, 0, get_sse_irq_in(mms, 58 + i * 3));
+    sysbus_connect_irq(s, 1, get_sse_irq_in(mms, 56 + i * 3));
+    sysbus_connect_irq(s, 2, get_sse_irq_in(mms, 57 + i * 3));
 
     g_free(mscname);
     return sysbus_mmio_get_region(s, 0);
@@ -339,21 +352,20 @@ static MemoryRegion *make_spi(MPS2TZMachineState *mms, void *opaque,
      */
     PL022State *spi = opaque;
     int i = spi - &mms->spi[0];
-    DeviceState *iotkitdev = DEVICE(&mms->iotkit);
     SysBusDevice *s;
 
     sysbus_init_child_obj(OBJECT(mms), name, spi, sizeof(mms->spi[0]),
                           TYPE_PL022);
     object_property_set_bool(OBJECT(spi), true, "realized", &error_fatal);
     s = SYS_BUS_DEVICE(spi);
-    sysbus_connect_irq(s, 0,
-                       qdev_get_gpio_in_named(iotkitdev, "EXP_IRQ", 51 + i));
+    sysbus_connect_irq(s, 0, get_sse_irq_in(mms, 51 + i));
     return sysbus_mmio_get_region(s, 0);
 }
 
 static void mps2tz_common_init(MachineState *machine)
 {
     MPS2TZMachineState *mms = MPS2TZ_MACHINE(machine);
+    MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_GET_CLASS(mms);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *iotkitdev;
@@ -371,11 +383,38 @@ static void mps2tz_common_init(MachineState *machine)
     iotkitdev = DEVICE(&mms->iotkit);
     object_property_set_link(OBJECT(&mms->iotkit), OBJECT(system_memory),
                              "memory", &error_abort);
-    qdev_prop_set_uint32(iotkitdev, "EXP_NUMIRQ", 92);
+    qdev_prop_set_uint32(iotkitdev, "EXP_NUMIRQ", MPS2TZ_NUMIRQ);
     qdev_prop_set_uint32(iotkitdev, "MAINCLK", SYSCLK_FRQ);
     object_property_set_bool(OBJECT(&mms->iotkit), true, "realized",
                              &error_fatal);
 
+    /*
+     * The AN521 needs us to create splitters to feed the IRQ inputs
+     * for each CPU in the SSE-200 from each device in the board.
+     */
+    if (mmc->fpga_type == FPGA_AN521) {
+        for (i = 0; i < MPS2TZ_NUMIRQ; i++) {
+            char *name = g_strdup_printf("mps2-irq-splitter%d", i);
+            SplitIRQ *splitter = &mms->cpu_irq_splitter[i];
+
+            object_initialize_child(OBJECT(machine), name,
+                                    splitter, sizeof(*splitter),
+                                    TYPE_SPLIT_IRQ, &error_fatal, NULL);
+            g_free(name);
+
+            object_property_set_int(OBJECT(splitter), 2, "num-lines",
+                                    &error_fatal);
+            object_property_set_bool(OBJECT(splitter), true, "realized",
+                                     &error_fatal);
+            qdev_connect_gpio_out(DEVICE(splitter), 0,
+                                  qdev_get_gpio_in_named(DEVICE(&mms->iotkit),
+                                                         "EXP_IRQ", i));
+            qdev_connect_gpio_out(DEVICE(splitter), 1,
+                                  qdev_get_gpio_in_named(DEVICE(&mms->iotkit),
+                                                         "EXP_CPU1_IRQ", i));
+        }
+    }
+
     /* The sec_resp_cfg output from the IoTKit must be split into multiple
      * lines, one for each of the PPCs we create here, plus one per MSC.
      */
@@ -426,7 +465,7 @@ static void mps2tz_common_init(MachineState *machine)
     object_property_set_bool(OBJECT(&mms->uart_irq_orgate), true,
                              "realized", &error_fatal);
     qdev_connect_gpio_out(DEVICE(&mms->uart_irq_orgate), 0,
-                          qdev_get_gpio_in_named(iotkitdev, "EXP_IRQ", 15));
+                          get_sse_irq_in(mms, 15));
 
     /* Most of the devices in the FPGA are behind Peripheral Protection
      * Controllers. The required order for initializing things is:
-- 
2.20.1
