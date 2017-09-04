Received: from eggs.gnu.org ([2001:4830:134:3::10]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSG-0004sW-Kt
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS6-0004gD-8K
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS5-0004ej-W5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:06 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS5-0005TQ-18
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:41 +0100
Message-Id: <1504527967-29248-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/36] target/arm: Don't use
 cpsr_write/cpsr_read to transfer M profile XPSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For M profile the XPSR is a similar but not identical format to the
A profile CPSR/SPSR. (For instance the Thumb bit is in a different
place.) For guest accesses we make the M profile code go through
xpsr_read() and xpsr_write() which handle the different layout.
However for migration we use cpsr_read() and cpsr_write() to
marshal state into and out of the migration data stream. This
is pretty confusing and works more by luck than anything else.
Make M profile migration use xpsr_read() and xpsr_write() instead.

The most complicated part of this is handling the possibility
that the migration source is an older QEMU which hands us a
CPSR format value; helpfully we can always tell the two apart.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-11-git-send-email-peter.maydell@linaro.org
---
 target/arm/machine.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 2fb4b762..3193b00 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -217,21 +217,37 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
     uint32_t val = qemu_get_be32(f);
 
     if (arm_feature(env, ARM_FEATURE_M)) {
-        /* If the I or F bits are set then this is a migration from
-         * an old QEMU which still stored the M profile FAULTMASK
-         * and PRIMASK in env->daif. Set v7m.faultmask and v7m.primask
-         * accordingly, and then clear the bits so they don't confuse
-         * cpsr_write(). For a new QEMU, the bits here will always be
-         * clear, and the data is transferred using the
-         * vmstate_m_faultmask_primask subsection.
-         */
-        if (val & CPSR_F) {
-            env->v7m.faultmask = 1;
-        }
-        if (val & CPSR_I) {
-            env->v7m.primask = 1;
+        if (val & XPSR_EXCP) {
+            /* This is a CPSR format value from an older QEMU. (We can tell
+             * because values transferred in XPSR format always have zero
+             * for the EXCP field, and CPSR format will always have bit 4
+             * set in CPSR_M.) Rearrange it into XPSR format. The significant
+             * differences are that the T bit is not in the same place, the
+             * primask/faultmask info may be in the CPSR I and F bits, and
+             * we do not want the mode bits.
+             */
+            uint32_t newval = val;
+
+            newval &= (CPSR_NZCV | CPSR_Q | CPSR_IT | CPSR_GE);
+            if (val & CPSR_T) {
+                newval |= XPSR_T;
+            }
+            /* If the I or F bits are set then this is a migration from
+             * an old QEMU which still stored the M profile FAULTMASK
+             * and PRIMASK in env->daif. For a new QEMU, the data is
+             * transferred using the vmstate_m_faultmask_primask subsection.
+             */
+            if (val & CPSR_F) {
+                env->v7m.faultmask = 1;
+            }
+            if (val & CPSR_I) {
+                env->v7m.primask = 1;
+            }
+            val = newval;
         }
-        val &= ~(CPSR_F | CPSR_I);
+        /* Ignore the low bits, they are handled by vmstate_m. */
+        xpsr_write(env, val, ~XPSR_EXCP);
+        return 0;
     }
 
     env->aarch64 = ((val & PSTATE_nRW) == 0);
@@ -252,7 +268,10 @@ static int put_cpsr(QEMUFile *f, void *opaque, size_t size,
     CPUARMState *env = &cpu->env;
     uint32_t val;
 
-    if (is_a64(env)) {
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /* The low 9 bits are v7m.exception, which is handled by vmstate_m. */
+        val = xpsr_read(env) & ~XPSR_EXCP;
+    } else if (is_a64(env)) {
         val = pstate_read(env);
     } else {
         val = cpsr_read(env);
-- 
2.7.4
