Received: from eggs.gnu.org ([2001:4830:134:3::10]:38679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ee74K-00034K-Ul
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ee74H-0000CW-1N
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:28 -0500
Received: from mail-bl2nam02on0078.outbound.protection.outlook.com
	([104.47.38.78]:14704
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ee74G-0000Be-PM
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:24 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:24:50 -0800
Message-ID: <fcd0cec830ccc7d49b79ad3c8017147e6608ecd8.1516746211.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1516746211.git.alistair.francis@xilinx.com>
References: <cover.1516746211.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 3/3] xlnx-zynqmp: Connect the RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, f4bug@amsat.org

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

 include/hw/arm/xlnx-zynqmp.h |  2 ++
 hw/arm/xlnx-zynqmp.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 3e6fb9b7bd..9e8c9e18dd 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -28,6 +28,7 @@
 #include "hw/ssi/xilinx_spips.h"
 #include "hw/dma/xlnx_dpdma.h"
 #include "hw/display/xlnx_dp.h"
+#include "hw/timer/xlnx-zynqmp-rtc.h"
=20
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
@@ -90,6 +91,7 @@ typedef struct XlnxZynqMPState {
     XlnxZynqMPQSPIPS qspi;
     XlnxDPState dp;
     XlnxDPDMAState dpdma;
+    XlnxZynqMPRTC rtc;
=20
     char *boot_cpu;
     ARMCPU *boot_cpu_ptr;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 325642058b..deef583c2a 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -50,6 +50,9 @@
 #define DPDMA_ADDR          0xfd4c0000
 #define DPDMA_IRQ           116
=20
+#define RTC_ADDR            0xffa60000
+#define RTC_IRQ             26
+
 static const uint64_t gem_addr[XLNX_ZYNQMP_NUM_GEMS] =3D {
     0xFF0B0000, 0xFF0C0000, 0xFF0D0000, 0xFF0E0000,
 };
@@ -183,6 +186,9 @@ static void xlnx_zynqmp_init(Object *obj)
=20
     object_initialize(&s->dpdma, sizeof(s->dpdma), TYPE_XLNX_DPDMA);
     qdev_set_parent_bus(DEVICE(&s->dpdma), sysbus_get_default());
+
+    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_XLNX_ZYNQMP_RTC);
+    qdev_set_parent_bus(DEVICE(&s->rtc), sysbus_get_default());
 }
=20
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
@@ -454,6 +460,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Erro=
r **errp)
                              &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
+
+    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
 }
=20
 static Property xlnx_zynqmp_props[] =3D {
--=20
2.14.1
