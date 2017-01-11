Received: from eggs.gnu.org ([2001:4830:134:3::10]:35444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V5-0006Rt-2h
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V4-0003Np-1U
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:55 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8V3-0003NV-S8
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:53 -0500
Received: by mail-pf0-x241.google.com with SMTP id b22so15072660pfd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:53 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:52 -0800
Message-Id: <20170111021820.24416-38-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 37/65] target-xtensa: Use clz opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/xtensa/helper.h    |  2 --
 target/xtensa/op_helper.c | 13 -------------
 target/xtensa/translate.c | 13 +++++++++++--
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 5ea9c5b..0c8adae 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -3,8 +3,6 @@ DEF_HELPER_3(exception_cause, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_cause_vaddr, noreturn, env, i32, i32, i32)
 DEF_HELPER_3(debug_exception, noreturn, env, i32, i32)
 
-DEF_HELPER_FLAGS_1(nsa, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_FLAGS_1(nsau, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_2(wsr_windowbase, void, env, i32)
 DEF_HELPER_4(entry, void, env, i32, i32, i32)
 DEF_HELPER_2(retw, i32, env, i32)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 0a4b214..dc25625 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -161,19 +161,6 @@ void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
     HELPER(exception)(env, EXC_DEBUG);
 }
 
-uint32_t HELPER(nsa)(uint32_t v)
-{
-    if (v & 0x80000000) {
-        v = ~v;
-    }
-    return v ? clz32(v) - 1 : 31;
-}
-
-uint32_t HELPER(nsau)(uint32_t v)
-{
-    return v ? clz32(v) : 32;
-}
-
 static void copy_window_from_phys(CPUXtensaState *env,
         uint32_t window, uint32_t phys, uint32_t n)
 {
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 0858c29..5c719a4 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1372,14 +1372,23 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 case 14: /*NSAu*/
                     HAS_OPTION(XTENSA_OPTION_MISC_OP_NSA);
                     if (gen_window_check2(dc, RRR_S, RRR_T)) {
-                        gen_helper_nsa(cpu_R[RRR_T], cpu_R[RRR_S]);
+                        TCGv_i32 t0 = tcg_temp_new_i32();
+
+                        /* if (v & 0x80000000) v = ~v; */
+                        tcg_gen_sari_i32(t0, cpu_R[RRR_S], 31);
+                        tcg_gen_xor_i32(t0, t0, cpu_R[RRR_S]);
+
+                        /* r = (v ? clz(v) : 32) - 1; */
+                        tcg_gen_clzi_i32(t0, t0, 32);
+                        tcg_gen_subi_i32(cpu_R[RRR_T], t0, 1);
+                        tcg_temp_free_i32(t0);
                     }
                     break;
 
                 case 15: /*NSAUu*/
                     HAS_OPTION(XTENSA_OPTION_MISC_OP_NSA);
                     if (gen_window_check2(dc, RRR_S, RRR_T)) {
-                        gen_helper_nsau(cpu_R[RRR_T], cpu_R[RRR_S]);
+                        tcg_gen_clzi_i32(cpu_R[RRR_T], cpu_R[RRR_S], 32);
                     }
                     break;
 
-- 
2.9.3
