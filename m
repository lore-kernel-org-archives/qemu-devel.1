Received: from eggs.gnu.org ([2001:4830:134:3::10]:34806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1eunXw-0005vg-Tf
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 18:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1eunXs-0003al-D8
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 18:05:00 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 10 Mar 2018 15:04:50 -0800
Message-Id: <1520723090-22130-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH v3] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, wpaul@windriver.com, Guenter Roeck <linux@roeck-us.net>

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

Fixing the interrupts alone causes problems with older Linux kernels:
The Ethernet interface will fail to probe with Linux v4.9 and earlier.
Linux v4.1 and earlier will crash due to a bug in Ethernet driver probe
error handling. This is a Linux kernel problem, not a qemu problem:
the Linux kernel only worked by accident since it requested both interrupts.

For backward compatibility, generate the Ethernet interrupt on both interrupt
lines. This was shown to work from all Linux kernel releases starting with
v3.16.

Link: https://bugs.launchpad.net/qemu/+bug/1753309
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: More prosa
v2: Generate Ethernet interrupts on both interrupt lines

 hw/net/imx_fec.c          | 28 +++++++++++++++++++++++++++-
 include/hw/arm/fsl-imx6.h |  4 ++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 9506f9b..6e297c5 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -417,7 +417,33 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_addr_t addr)
 
 static void imx_eth_update(IMXFECState *s)
 {
-    if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] & ENET_INT_TS_TIMER) {
+    /*
+     * Previous versions of qemu had the ENET_INT_MAC and ENET_INT_TS_TIMER
+     * interrupts swapped. This worked with older versions of Linux (4.14
+     * and older) since Linux associated both interrupt lines with Ethernet
+     * MAC interrupts. Specifically,
+     * - Linux 4.15 and later have separate interrupt handlers for the MAC and
+     *   timer interrupts. Those versions of Linux fail with versions of QEMU
+     *   with swapped interrupt assignments.
+     * - In linux 4.14, both interrupt lines were registered with the Ethernet
+     *   MAC interrupt handler. As a result, all versions of qemu happen to
+     *   work, though that is accidental.
+     * - In Linux 4.9 and older, the timer interrupt was registered directly
+     *   with the Ethernet MAC interrupt handler. The MAC interrupt was
+     *   redirected to a GPIO interrupt to work around erratum ERR006687.
+     *   This was implemented using the SOC's IOMUX block. In qemu, this GPIO
+     *   interrupt never fired since IOMUX is currently not supported in qemu.
+     *   Linux instead received MAC interrupts on the timer interrupt.
+     *   As a result, qemu versions with the swapped interrupt assignment work,
+     *   albeit accidentally, but qemu versions with the correct interrupt
+     *   assignment fail.
+     *
+     * To ensure that all versions of Linux work, generate ENET_INT_MAC
+     * interrrupts on both interrupt lines. This should be changed if and when
+     * qemu supports IOMUX.
+     */
+    if (s->regs[ENET_EIR] & s->regs[ENET_EIMR] &
+        (ENET_INT_MAC | ENET_INT_TS_TIMER)) {
         qemu_set_irq(s->irq[1], 1);
     } else {
         qemu_set_irq(s->irq[1], 0);
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
