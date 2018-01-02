Received: from eggs.gnu.org ([2001:4830:134:3::10]:58768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eWSMk-0003Mw-Jo
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eWSMj-0000RW-If
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:36:50 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue,  2 Jan 2018 11:36:22 -0800
Message-Id: <20180102193622.27215-12-andrew.smirnov@gmail.com>
In-Reply-To: <20180102193622.27215-1-andrew.smirnov@gmail.com>
References: <20180102193622.27215-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/11] imx_fec: Reserve full
 FSL_IMX25_FEC_SIZE page for the register file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Some i.MX SoCs (e.g. i.MX7) have FEC registers going as far as offset
0x614, so to avoid getting aborts when accessing those on QEMU, extend
the register file to cover FSL_IMX25_FEC_SIZE(16K) of address space
instead of just 1K.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/net/imx_fec.c           | 2 +-
 include/hw/arm/fsl-imx25.h | 1 -
 include/hw/net/imx_fec.h   | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index c1cf7f9c58..4fb48f62ba 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1281,7 +1281,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     memory_region_init_io(&s->iomem, OBJECT(dev), &imx_eth_ops, s,
-                          TYPE_IMX_FEC, 0x400);
+                          TYPE_IMX_FEC, FSL_IMX25_FEC_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq[0]);
     sysbus_init_irq(sbd, &s->irq[1]);
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index d0e8e9d956..65a73714ef 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -192,7 +192,6 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_UART5_ADDR    0x5002C000
 #define FSL_IMX25_UART5_SIZE    0x4000
 #define FSL_IMX25_FEC_ADDR      0x50038000
-#define FSL_IMX25_FEC_SIZE      0x4000
 #define FSL_IMX25_CCM_ADDR      0x53F80000
 #define FSL_IMX25_CCM_SIZE      0x4000
 #define FSL_IMX25_GPT4_ADDR     0x53F84000
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 91ef8f89a6..7b3faa4019 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -245,6 +245,7 @@ typedef struct {
 
 #define ENET_TX_RING_NUM       3
 
+#define FSL_IMX25_FEC_SIZE      0x4000
 
 typedef struct IMXFECState {
     /*< private >*/
-- 
2.14.3
