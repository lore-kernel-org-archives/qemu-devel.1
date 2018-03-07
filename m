Received: from eggs.gnu.org ([2001:4830:134:3::10]:34904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1etd05-0007VZ-K5
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1etd01-0002TP-K2
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:37:13 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1etd01-0002SB-Ea
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:37:09 -0500
Received: by mail-pl0-x244.google.com with SMTP id f23-v6so1716094plr.10
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 09:37:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Date: Wed,  7 Mar 2018 09:37:03 -0800
Message-Id: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, wpaul@windriver.com, Guenter Roeck <linux@roeck-us.net>

The sabrelite machine model used by qemu-system-arm is based on the
Freescale/NXP i.MX6Q processor. This SoC has an on-board ethernet
controller which is supported in QEMU using the imx_fec.c module
(actually called imx.enet for this model.)

The include/hw/arm/fsm-imx6.h file defines the interrupt vectors for the
imx.enet device like this:

 #define FSL_IMX6_ENET_MAC_1588_IRQ 118
 #define FSL_IMX6_ENET_MAC_IRQ 119

According to https://www.nxp.com/docs/en/reference-manual/IMX6DQRM.pdf,
page 225, in Table 3-1. ARM Cortex A9 domain interrupt summary,
interrupts are as follows.

150 ENET MAC 0 IRQ
151 ENET MAC 0 1588 Timer interrupt

where

150 - 32 == 118
151 - 32 == 119

In other words, the vector definitions in the fsl-imx6.h file are reversed.

This results in lost interrupt warnings when running recent (v4.15+) Linux
kernels, and the Ethernet interface will fail to probe.

Note that applying this patch will cause problems with older Linux kernels:
The Ethernet interface will fail to probe with Linux v4.9 and earlier.
Linux v4.1 and earlier will crash. This is a Linux kernel problem, not a
qemu problem: the Linux kernel only worked by accident since it requested
both interrupts.

Link: https://bugs.launchpad.net/qemu/+bug/1753309
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/hw/arm/fsl-imx6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index ec6c509..06f8aae 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -438,8 +438,8 @@ typedef struct FslIMX6State {
 #define FSL_IMX6_HDMI_MASTER_IRQ 115
 #define FSL_IMX6_HDMI_CEC_IRQ 116
 #define FSL_IMX6_MLB150_LOW_IRQ 117
-#define FSL_IMX6_ENET_MAC_1588_IRQ 118
-#define FSL_IMX6_ENET_MAC_IRQ 119
+#define FSL_IMX6_ENET_MAC_IRQ 118
+#define FSL_IMX6_ENET_MAC_1588_IRQ 119
 #define FSL_IMX6_PCIE1_IRQ 120
 #define FSL_IMX6_PCIE2_IRQ 121
 #define FSL_IMX6_PCIE3_IRQ 122
-- 
2.7.4
