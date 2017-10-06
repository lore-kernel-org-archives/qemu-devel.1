Received: from eggs.gnu.org ([2001:4830:134:3::10]:58143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1m-0004F6-IP
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1k-0007p2-8S
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1j-0007js-VZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1c-0002uS-DR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:56 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:33 +0100
Message-Id: <1507305585-20608-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/20] target/arm: Restore SPSEL to correct
 CONTROL register on exception return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On exception return for v8M, the SPSEL bit in the EXC_RETURN magic
value should be restored to the SPSEL bit in the CONTROL register
banked specified by the EXC_RETURN.ES bit.

Add write_v7m_control_spsel_for_secstate() which behaves like
write_v7m_control_spsel() but allows the caller to specify which
CONTROL bank to use, reimplement write_v7m_control_spsel() in
terms of it, and use it in exception return.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1506092407-26985-6-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b82fc9f..1bab86c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6059,28 +6059,42 @@ static bool v7m_using_psp(CPUARMState *env)
         env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK;
 }
 
-/* Write to v7M CONTROL.SPSEL bit. This may change the current
- * stack pointer between Main and Process stack pointers.
+/* Write to v7M CONTROL.SPSEL bit for the specified security bank.
+ * This may change the current stack pointer between Main and Process
+ * stack pointers if it is done for the CONTROL register for the current
+ * security state.
  */
-static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
+static void write_v7m_control_spsel_for_secstate(CPUARMState *env,
+                                                 bool new_spsel,
+                                                 bool secstate)
 {
-    uint32_t tmp;
-    bool new_is_psp, old_is_psp = v7m_using_psp(env);
+    bool old_is_psp = v7m_using_psp(env);
 
-    env->v7m.control[env->v7m.secure] =
-        deposit32(env->v7m.control[env->v7m.secure],
+    env->v7m.control[secstate] =
+        deposit32(env->v7m.control[secstate],
                   R_V7M_CONTROL_SPSEL_SHIFT,
                   R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
 
-    new_is_psp = v7m_using_psp(env);
+    if (secstate == env->v7m.secure) {
+        bool new_is_psp = v7m_using_psp(env);
+        uint32_t tmp;
 
-    if (old_is_psp != new_is_psp) {
-        tmp = env->v7m.other_sp;
-        env->v7m.other_sp = env->regs[13];
-        env->regs[13] = tmp;
+        if (old_is_psp != new_is_psp) {
+            tmp = env->v7m.other_sp;
+            env->v7m.other_sp = env->regs[13];
+            env->regs[13] = tmp;
+        }
     }
 }
 
+/* Write to v7M CONTROL.SPSEL bit. This may change the current
+ * stack pointer between Main and Process stack pointers.
+ */
+static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
+{
+    write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure);
+}
+
 void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
 {
     /* Write a new value to v7m.exception, thus transitioning into or out
@@ -6379,7 +6393,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
      * Handler mode (and will be until we write the new XPSR.Interrupt
      * field) this does not switch around the current stack pointer.
      */
-    write_v7m_control_spsel(env, return_to_sp_process);
+    write_v7m_control_spsel_for_secstate(env, return_to_sp_process, exc_secure);
 
     switch_v7m_security_state(env, return_to_secure);
 
-- 
2.7.4
