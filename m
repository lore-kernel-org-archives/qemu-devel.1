Received: from eggs.gnu.org ([2001:4830:134:3::10]:52314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd46-0007YH-P6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd45-0000CV-Ov
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd45-0000Al-Hb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:41 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd44-0005ju-80
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:40 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:16 +0000
Message-Id: <1515677902-23436-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/26] imx_fec: Reserve full FSL_IMX25_FEC_SIZE
 page for the register file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

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
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx25.h | 1 -
 include/hw/net/imx_fec.h   | 1 +
 hw/net/imx_fec.c           | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index d0e8e9d..65a7371 100644
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
index 91ef8f8..7b3faa4 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -245,6 +245,7 @@ typedef struct {
 
 #define ENET_TX_RING_NUM       3
 
+#define FSL_IMX25_FEC_SIZE      0x4000
 
 typedef struct IMXFECState {
     /*< private >*/
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index c1cf7f9..4fb48f6 100644
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
-- 
2.7.4
