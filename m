Received: from eggs.gnu.org ([2001:4830:134:3::10]:42966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC9-0000fp-69
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC8-0007w3-34
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC7-0007PR-OJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRBz-0003mU-Bf
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:08 +0100
Message-Id: <20181016152325.31367-3-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/19] target/arm: Fix aarch64_sve_change_el wrt
 EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

At present we assert:

  arm_el_is_aa64: Assertion `el >= 1 && el <= 3' failed.

The comment in arm_el_is_aa64 explains why asking about EL0 without
extra information is impossible.  Add an extra argument to provide
it from the surrounding context.

Fixes: 0ab5953b00b3
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181008212205.17752-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  7 +++++--
 target/arm/helper.c    | 16 ++++++++++++----
 target/arm/op_helper.c |  6 +++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3a2aff11928..54362ddce81 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -911,10 +911,13 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
 int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
-void aarch64_sve_change_el(CPUARMState *env, int old_el, int new_el);
+void aarch64_sve_change_el(CPUARMState *env, int old_el,
+                           int new_el, bool el0_a64);
 #else
 static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
-static inline void aarch64_sve_change_el(CPUARMState *env, int o, int n) { }
+static inline void aarch64_sve_change_el(CPUARMState *env, int o,
+                                         int n, bool a)
+{ }
 #endif
 
 target_ulong do_arm_semihosting(CPUARMState *env);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c83f7c1109c..0efbb5c76ce 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8374,7 +8374,11 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int cur_el = arm_current_el(env);
 
-    aarch64_sve_change_el(env, cur_el, new_el);
+    /*
+     * Note that new_el can never be 0.  If cur_el is 0, then
+     * el0_a64 is is_a64(), else el0_a64 is ignored.
+     */
+    aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
 
     if (cur_el < new_el) {
         /* Entry vector offset depends on whether the implemented EL
@@ -12791,9 +12795,11 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
 /*
  * Notice a change in SVE vector size when changing EL.
  */
-void aarch64_sve_change_el(CPUARMState *env, int old_el, int new_el)
+void aarch64_sve_change_el(CPUARMState *env, int old_el,
+                           int new_el, bool el0_a64)
 {
     int old_len, new_len;
+    bool old_a64, new_a64;
 
     /* Nothing to do if no SVE.  */
     if (!arm_feature(env, ARM_FEATURE_SVE)) {
@@ -12817,9 +12823,11 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el, int new_el)
      * we already have the correct register contents when encountering the
      * vq0->vq0 transition between EL0->EL1.
      */
-    old_len = (arm_el_is_aa64(env, old_el) && !sve_exception_el(env, old_el)
+    old_a64 = old_el ? arm_el_is_aa64(env, old_el) : el0_a64;
+    old_len = (old_a64 && !sve_exception_el(env, old_el)
                ? sve_zcr_len_for_el(env, old_el) : 0);
-    new_len = (arm_el_is_aa64(env, new_el) && !sve_exception_el(env, new_el)
+    new_a64 = new_el ? arm_el_is_aa64(env, new_el) : el0_a64;
+    new_len = (new_a64 && !sve_exception_el(env, new_el)
                ? sve_zcr_len_for_el(env, new_el) : 0);
 
     /* When changing vector length, clear inaccessible state.  */
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index fb15a13e6c9..d9155797126 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1101,7 +1101,11 @@ void HELPER(exception_return)(CPUARMState *env)
                       "AArch64 EL%d PC 0x%" PRIx64 "\n",
                       cur_el, new_el, env->pc);
     }
-    aarch64_sve_change_el(env, cur_el, new_el);
+    /*
+     * Note that cur_el can never be 0.  If new_el is 0, then
+     * el0_a64 is return_to_aa64, else el0_a64 is ignored.
+     */
+    aarch64_sve_change_el(env, cur_el, new_el, return_to_aa64);
 
     qemu_mutex_lock_iothread();
     arm_call_el_change_hook(arm_env_get_cpu(env));
-- 
2.19.0
