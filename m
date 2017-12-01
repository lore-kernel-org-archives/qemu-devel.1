Received: from eggs.gnu.org ([2001:4830:134:3::10]:53132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqIu-0006Et-02
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqIt-00032J-6U
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:51 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Dec 2017 18:44:33 +0000
Message-Id: <1512153879-5291-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/7] target/arm: Handle SPSEL and current stack
 being out of sync in MSP/PSP reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

For v8M it is possible for the CONTROL.SPSEL bit value and the
current stack to be out of sync. This means we need to update
the checks used in reads and writes of the PSP and MSP special
registers to use v7m_using_psp() rather than directly checking
the SPSEL bit in the control register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 91a9300..88394d4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9953,11 +9953,9 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
 
     switch (reg) {
     case 8: /* MSP */
-        return (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) ?
-            env->v7m.other_sp : env->regs[13];
+        return v7m_using_psp(env) ? env->v7m.other_sp : env->regs[13];
     case 9: /* PSP */
-        return (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) ?
-            env->regs[13] : env->v7m.other_sp;
+        return v7m_using_psp(env) ? env->regs[13] : env->v7m.other_sp;
     case 16: /* PRIMASK */
         return env->v7m.primask[env->v7m.secure];
     case 17: /* BASEPRI */
@@ -10059,14 +10057,14 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         }
         break;
     case 8: /* MSP */
-        if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) {
+        if (v7m_using_psp(env)) {
             env->v7m.other_sp = val;
         } else {
             env->regs[13] = val;
         }
         break;
     case 9: /* PSP */
-        if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) {
+        if (v7m_using_psp(env)) {
             env->regs[13] = val;
         } else {
             env->v7m.other_sp = val;
-- 
2.7.4
