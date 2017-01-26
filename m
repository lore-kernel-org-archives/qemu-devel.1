Received: from eggs.gnu.org ([2001:4830:134:3::10]:39136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgew-0005D1-CC
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgev-0000vg-MT
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:02 -0500
Received: from greensocs.com ([193.104.36.180]:33157)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgev-0000vS-B7
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:01 -0500
From: fred.konrad@greensocs.com
Date: Thu, 26 Jan 2017 10:47:39 +0100
Message-Id: <1485424060-12217-10-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V2 09/10] zynqmp: add the zynqmp_crf to the
 platform
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

This adds the zynqmp_crf to the zynqmp platform.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 hw/arm/xlnx-zynqmp.c         | 7 +++++++
 include/hw/arm/xlnx-zynqmp.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index bc4e66b..27dccdb 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -177,6 +177,11 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize(&s->dpdma, sizeof(s->dpdma), TYPE_XLNX_DPDMA);
     qdev_set_parent_bus(DEVICE(&s->dpdma), sysbus_get_default());
+
+    s->crf = object_new("xlnx.zynqmp_crf");
+    qdev_set_parent_bus(DEVICE(s->crf), sysbus_get_default());
+    object_property_add_child(obj, "xlnx.zynqmp_crf", OBJECT(s->crf),
+                              &error_abort);
 }
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
@@ -424,6 +429,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(s->crf), 0, 0xFD1A0000);
 }
 
 static Property xlnx_zynqmp_props[] = {
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c2931bf..379a17a 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -86,6 +86,8 @@ typedef struct XlnxZynqMPState {
     XlnxDPState dp;
     XlnxDPDMAState dpdma;
 
+    Object *crf;
+
     char *boot_cpu;
     ARMCPU *boot_cpu_ptr;
 
-- 
1.8.3.1
