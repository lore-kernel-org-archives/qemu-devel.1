Received: from eggs.gnu.org ([209.51.188.92]:58118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gmWDZ-0005Rh-JS
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 23:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gmVzg-0001Sf-Gm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 22:47:57 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gmVzg-0001O5-9T
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 22:47:56 -0500
Received: by mail-lj1-x242.google.com with SMTP id t18-v6so3951538ljd.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 19:47:55 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 23 Jan 2019 19:47:36 -0800
Message-Id: <20190124034736.23125-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: fix access to the INTERRUPT SR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

INTERRUPT special register may be changed both by the core (by writing
to INTSET and INTCLEAR registers) and by external events (by triggering
and clearing HW IRQs). In MTTCG this state must be protected from
concurrent access, otherwise interrupts may be lost or spurious
interrupts may be detected.

Move manipulation of INTSET SR to helpers and protect it with BQL.
Fix wsr.intset: it may not clear any bits.
Fix wsr.intclear: it may not clear bit that corresponds to NMI.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/exc_helper.c | 15 +++++++++++++++
 target/xtensa/helper.h     |  2 ++
 target/xtensa/op_helper.c  |  3 +++
 target/xtensa/translate.c  | 14 ++------------
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 371a32ba5ad9..3e430a5da383 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -127,6 +127,21 @@ void HELPER(check_interrupts)(CPUXtensaState *env)
     qemu_mutex_unlock_iothread();
 }
 
+void HELPER(intset)(CPUXtensaState *env, uint32_t v)
+{
+    qemu_mutex_lock_iothread();
+    env->sregs[INTSET] |= v & env->config->inttype_mask[INTTYPE_SOFTWARE];
+    qemu_mutex_unlock_iothread();
+}
+
+void HELPER(intclear)(CPUXtensaState *env, uint32_t v)
+{
+    qemu_mutex_lock_iothread();
+    env->sregs[INTSET] &= ~(v & (env->config->inttype_mask[INTTYPE_SOFTWARE] |
+                                 env->config->inttype_mask[INTTYPE_EDGE]));
+    qemu_mutex_unlock_iothread();
+}
+
 static uint32_t relocated_vector(CPUXtensaState *env, uint32_t vector)
 {
     if (xtensa_option_enabled(env->config,
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 89eb97e26514..2a7db35874fe 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -22,6 +22,8 @@ DEF_HELPER_1(update_ccount, void, env)
 DEF_HELPER_2(wsr_ccount, void, env, i32)
 DEF_HELPER_2(update_ccompare, void, env, i32)
 DEF_HELPER_1(check_interrupts, void, env)
+DEF_HELPER_2(intset, void, env, i32)
+DEF_HELPER_2(intclear, void, env, i32)
 DEF_HELPER_3(check_atomctl, void, env, i32, i32)
 DEF_HELPER_2(wsr_memctl, void, env, i32)
 
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 1865f46c4b5f..b1b162b01b19 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -62,6 +62,9 @@ void HELPER(update_ccompare)(CPUXtensaState *env, uint32_t i)
 {
     uint64_t dcc;
 
+    qemu_mutex_lock_iothread();
+    env->sregs[INTSET] &= ~(1u << env->config->timerint[i]);
+    qemu_mutex_unlock_iothread();
     HELPER(update_ccount)(env);
     dcc = (uint64_t)(env->sregs[CCOMPARE + i] - env->sregs[CCOUNT] - 1) + 1;
     timer_mod(env->ccompare[i].timer,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index a435d9c36cf1..d1e9f59b31bd 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -646,20 +646,12 @@ static void gen_check_interrupts(DisasContext *dc)
 
 static void gen_wsr_intset(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
-    tcg_gen_andi_i32(cpu_SR[sr], v,
-            dc->config->inttype_mask[INTTYPE_SOFTWARE]);
+    gen_helper_intset(cpu_env, v);
 }
 
 static void gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
-
-    tcg_gen_andi_i32(tmp, v,
-            dc->config->inttype_mask[INTTYPE_EDGE] |
-            dc->config->inttype_mask[INTTYPE_NMI] |
-            dc->config->inttype_mask[INTTYPE_SOFTWARE]);
-    tcg_gen_andc_i32(cpu_SR[INTSET], cpu_SR[INTSET], tmp);
-    tcg_temp_free(tmp);
+    gen_helper_intclear(cpu_env, v);
 }
 
 static void gen_wsr_intenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
@@ -706,12 +698,10 @@ static void gen_wsr_icountlevel(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static void gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     uint32_t id = sr - CCOMPARE;
-    uint32_t int_bit = 1 << dc->config->timerint[id];
     TCGv_i32 tmp = tcg_const_i32(id);
 
     assert(id < dc->config->nccompare);
     tcg_gen_mov_i32(cpu_SR[sr], v);
-    tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
-- 
2.11.0
