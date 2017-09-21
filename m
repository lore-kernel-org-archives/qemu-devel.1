Received: from eggs.gnu.org ([2001:4830:134:3::10]:60149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XK-00032Q-FJ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XJ-0002pa-E1
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XJ-0002la-6p
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XI-000585-6A
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:22 +0100
Message-Id: <1506012099-13605-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 14/31] nvic: Disable the non-secure HardFault if
 AIRCR.BFHFNMINS is clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If AIRCR.BFHFNMINS is clear, then although NonSecure HardFault
can still be pended via SHCSR.HARDFAULTPENDED it mustn't actually
preempt execution. The simple way to achieve this is to clear the
enable bit for it, since the enable bit isn't guest visible.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505240046-11454-15-git-send-email-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 0c1d591..35225c8 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -937,11 +937,16 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                     (R_V7M_AIRCR_SYSRESETREQS_MASK |
                      R_V7M_AIRCR_BFHFNMINS_MASK |
                      R_V7M_AIRCR_PRIS_MASK);
-                /* BFHFNMINS changes the priority of Secure HardFault */
+                /* BFHFNMINS changes the priority of Secure HardFault, and
+                 * allows a pending Non-secure HardFault to preempt (which
+                 * we implement by marking it enabled).
+                 */
                 if (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
                     s->sec_vectors[ARMV7M_EXCP_HARD].prio = -3;
+                    s->vectors[ARMV7M_EXCP_HARD].enabled = 1;
                 } else {
                     s->sec_vectors[ARMV7M_EXCP_HARD].prio = -1;
+                    s->vectors[ARMV7M_EXCP_HARD].enabled = 0;
                 }
             }
             nvic_irq_update(s);
@@ -1566,7 +1571,6 @@ static void armv7m_nvic_reset(DeviceState *dev)
     NVICState *s = NVIC(dev);
 
     s->vectors[ARMV7M_EXCP_NMI].enabled = 1;
-    s->vectors[ARMV7M_EXCP_HARD].enabled = 1;
     /* MEM, BUS, and USAGE are enabled through
      * the System Handler Control register
      */
@@ -1588,6 +1592,10 @@ static void armv7m_nvic_reset(DeviceState *dev)
 
         /* AIRCR.BFHFNMINS resets to 0 so Secure HF is priority -1 (R_CMTC) */
         s->sec_vectors[ARMV7M_EXCP_HARD].prio = -1;
+        /* If AIRCR.BFHFNMINS is 0 then NS HF is (effectively) disabled */
+        s->vectors[ARMV7M_EXCP_HARD].enabled = 0;
+    } else {
+        s->vectors[ARMV7M_EXCP_HARD].enabled = 1;
     }
 
     /* Strictly speaking the reset handler should be enabled.
-- 
2.7.4
