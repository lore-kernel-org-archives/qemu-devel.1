Received: from eggs.gnu.org ([2001:4830:134:3::10]:43576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph6-0003X3-5f
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph4-0006UU-JY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:14:00 +0100
Message-Id: <1505240046-11454-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 13/19] nvic: Implement v8M changes to fixed
 priority exceptions
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

In v7M, the fixed-priority exceptions are:
 Reset: -3
 NMI: -2
 HardFault: -1

In v8M, this changes because Secure HardFault may need
to be prioritised above NMI:
 Reset: -4
 Secure HardFault if AIRCR.BFHFNMINS == 1: -3
 NMI: -2
 Secure HardFault if AIRCR.BFHFNMINS == 0: -1
 NonSecure HardFault: -1

Make these changes, including support for changing the
priority of Secure HardFault as AIRCR.BFHFNMINS changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index c4670f7..db2f170 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -937,6 +937,12 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
                     (R_V7M_AIRCR_SYSRESETREQS_MASK |
                      R_V7M_AIRCR_BFHFNMINS_MASK |
                      R_V7M_AIRCR_PRIS_MASK);
+                /* BFHFNMINS changes the priority of Secure HardFault */
+                if (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
+                    s->sec_vectors[ARMV7M_EXCP_HARD].prio = -3;
+                } else {
+                    s->sec_vectors[ARMV7M_EXCP_HARD].prio = -1;
+                }
             }
             nvic_irq_update(s);
         }
@@ -1452,9 +1458,12 @@ static int nvic_post_load(void *opaque, int version_id)
 {
     NVICState *s = opaque;
     unsigned i;
+    int resetprio;
 
     /* Check for out of range priority settings */
-    if (s->vectors[ARMV7M_EXCP_RESET].prio != -3 ||
+    resetprio = arm_feature(&s->cpu->env, ARM_FEATURE_V8) ? -4 : -3;
+
+    if (s->vectors[ARMV7M_EXCP_RESET].prio != resetprio ||
         s->vectors[ARMV7M_EXCP_NMI].prio != -2 ||
         s->vectors[ARMV7M_EXCP_HARD].prio != -1) {
         return 1;
@@ -1497,7 +1506,12 @@ static int nvic_security_post_load(void *opaque, int version_id)
     int i;
 
     /* Check for out of range priority settings */
-    if (s->sec_vectors[ARMV7M_EXCP_HARD].prio != -1) {
+    if (s->sec_vectors[ARMV7M_EXCP_HARD].prio != -1
+        && s->sec_vectors[ARMV7M_EXCP_HARD].prio != -3) {
+        /* We can't cross-check against AIRCR.BFHFNMINS as we don't know
+         * if the CPU state has been migrated yet; a mismatch won't
+         * cause the emulation to blow up, though.
+         */
         return 1;
     }
     for (i = ARMV7M_EXCP_MEM; i < ARRAY_SIZE(s->sec_vectors); i++) {
@@ -1544,6 +1558,7 @@ static Property props_nvic[] = {
 
 static void armv7m_nvic_reset(DeviceState *dev)
 {
+    int resetprio;
     NVICState *s = NVIC(dev);
 
     s->vectors[ARMV7M_EXCP_NMI].enabled = 1;
@@ -1556,7 +1571,8 @@ static void armv7m_nvic_reset(DeviceState *dev)
     s->vectors[ARMV7M_EXCP_PENDSV].enabled = 1;
     s->vectors[ARMV7M_EXCP_SYSTICK].enabled = 1;
 
-    s->vectors[ARMV7M_EXCP_RESET].prio = -3;
+    resetprio = arm_feature(&s->cpu->env, ARM_FEATURE_V8) ? -4 : -3;
+    s->vectors[ARMV7M_EXCP_RESET].prio = resetprio;
     s->vectors[ARMV7M_EXCP_NMI].prio = -2;
     s->vectors[ARMV7M_EXCP_HARD].prio = -1;
 
-- 
2.7.4
