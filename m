Received: from eggs.gnu.org ([2001:4830:134:3::10]:39170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgez-0005Np-IL
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgex-0000wG-1h
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:05 -0500
Received: from greensocs.com ([193.104.36.180]:33180)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgew-0000vv-MF
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:02 -0500
From: fred.konrad@greensocs.com
Date: Thu, 26 Jan 2017 10:47:40 +0100
Message-Id: <1485424060-12217-11-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V2 10/10] zynqmp: add reference clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This adds some fixed reference clock to the zynqmp platform.
They will feed the zynqmp_crf block.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 hw/arm/xlnx-zynqmp.c         | 49 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |  6 ++++++
 2 files changed, 55 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 27dccdb..1bef77d 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -24,6 +24,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "qemu/qemu-clock.h"
 
 #define GIC_NUM_SPI_INTR 160
 
@@ -182,6 +183,22 @@ static void xlnx_zynqmp_init(Object *obj)
     qdev_set_parent_bus(DEVICE(s->crf), sysbus_get_default());
     object_property_add_child(obj, "xlnx.zynqmp_crf", OBJECT(s->crf),
                               &error_abort);
+
+    s->pss_ref_clk = object_new(TYPE_FIXED_CLOCK);
+    object_property_add_child(obj, "pss_ref_clk", s->pss_ref_clk,
+                              &error_abort);
+    object_property_set_int(s->pss_ref_clk, 50000000, "rate", &error_abort);
+    s->video_clk = object_new(TYPE_FIXED_CLOCK);
+    object_property_add_child(obj, "video_clk", s->video_clk, &error_abort);
+    object_property_set_int(s->video_clk, 27000000, "rate", &error_abort);
+    s->pss_alt_ref_clk = object_new(TYPE_FIXED_CLOCK);
+    object_property_add_child(obj, "pss_alt_ref_clk", s->pss_alt_ref_clk,
+                              &error_abort);
+    s->aux_refclk = object_new(TYPE_FIXED_CLOCK);
+    object_property_add_child(obj, "aux_refclk", s->aux_refclk, &error_abort);
+    s->gt_crx_ref_clk = object_new(TYPE_FIXED_CLOCK);
+    object_property_add_child(obj, "gt_crx_ref_clk", s->gt_crx_ref_clk,
+                              &error_abort);
 }
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
@@ -431,6 +448,38 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(s->crf), 0, 0xFD1A0000);
+
+    /* Bind the clock */
+    qemu_clk_bind_clock(qemu_clk_device_get_clock(DEVICE(s->pss_ref_clk),
+                                                  "clk_out"),
+                        qemu_clk_device_get_clock(DEVICE(s->crf),
+                                                  "pss_ref_clk"));
+
+    qemu_clk_bind_clock(qemu_clk_device_get_clock(DEVICE(s->video_clk),
+                                                  "clk_out"),
+                        qemu_clk_device_get_clock(DEVICE(s->crf), "video_clk"));
+
+    qemu_clk_bind_clock(qemu_clk_device_get_clock(DEVICE(s->pss_alt_ref_clk),
+                                                  "clk_out"),
+                        qemu_clk_device_get_clock(DEVICE(s->crf),
+                                                  "pss_alt_ref_clk"));
+
+    qemu_clk_bind_clock(qemu_clk_device_get_clock(DEVICE(s->aux_refclk),
+                                                  "clk_out"),
+                        qemu_clk_device_get_clock(DEVICE(s->crf),
+                                                  "aux_refclk"));
+
+    qemu_clk_bind_clock(qemu_clk_device_get_clock(DEVICE(s->gt_crx_ref_clk),
+                                                  "clk_out"),
+                        qemu_clk_device_get_clock(DEVICE(s->crf),
+                                                  "gt_crx_ref_clk"));
+
+    object_property_set_bool(s->crf, true, "realized", &err);
+    object_property_set_bool(s->pss_ref_clk, true, "realized", &err);
+    object_property_set_bool(s->video_clk, true, "realized", &err);
+    object_property_set_bool(s->pss_alt_ref_clk, true, "realized", &err);
+    object_property_set_bool(s->aux_refclk, true, "realized", &err);
+    object_property_set_bool(s->gt_crx_ref_clk, true, "realized", &err);
 }
 
 static Property xlnx_zynqmp_props[] = {
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 379a17a..d0cc57f 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -28,6 +28,7 @@
 #include "hw/ssi/xilinx_spips.h"
 #include "hw/dma/xlnx_dpdma.h"
 #include "hw/display/xlnx_dp.h"
+#include "hw/misc/fixed-clock.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
@@ -86,6 +87,11 @@ typedef struct XlnxZynqMPState {
     XlnxDPState dp;
     XlnxDPDMAState dpdma;
 
+    Object *pss_ref_clk;
+    Object *video_clk;
+    Object *pss_alt_ref_clk;
+    Object *aux_refclk;
+    Object *gt_crx_ref_clk;
     Object *crf;
 
     char *boot_cpu;
-- 
1.8.3.1
