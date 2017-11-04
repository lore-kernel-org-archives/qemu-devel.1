Received: from eggs.gnu.org ([2001:4830:134:3::10]:44928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPa-0006An-P1
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPZ-0000xE-W4
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:22 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:54803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApPZ-0000ve-NC
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:21 -0400
Received: by mail-lf0-x243.google.com with SMTP id a2so5140149lfh.11
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:46:21 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:16 -0700
Message-Id: <1509767121-26925-12-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 11/16] target/xtensa: drop DisasContext::litbase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

It doesn't help much, always-set bit 0 of the LITBASE SR is easy to
compensate with decrement of the l32r immediate argument.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 0460edf61389..fb6a4c979590 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -59,7 +59,6 @@ typedef struct DisasContext {
     int ring;
     uint32_t lbeg;
     uint32_t lend;
-    TCGv_i32 litbase;
     int is_jmp;
     int singlestep_enabled;
 
@@ -266,21 +265,6 @@ static inline bool option_enabled(DisasContext *dc, int opt)
     return xtensa_option_enabled(dc->config, opt);
 }
 
-static void init_litbase(DisasContext *dc)
-{
-    if (dc->tb->flags & XTENSA_TBFLAG_LITBASE) {
-        dc->litbase = tcg_temp_local_new_i32();
-        tcg_gen_andi_i32(dc->litbase, cpu_SR[LITBASE], 0xfffff000);
-    }
-}
-
-static void reset_litbase(DisasContext *dc)
-{
-    if (dc->tb->flags & XTENSA_TBFLAG_LITBASE) {
-        tcg_temp_free(dc->litbase);
-    }
-}
-
 static void init_sar_tracker(DisasContext *dc)
 {
     dc->sar_5bit = false;
@@ -1094,7 +1078,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         dc.slotbuf = xtensa_insnbuf_alloc(dc.config->isa);
     }
 
-    init_litbase(&dc);
     init_sar_tracker(&dc);
     if (dc.icount) {
         dc.next_icount = tcg_temp_local_new_i32();
@@ -1169,7 +1152,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             dc.pc + xtensa_insn_len(env, &dc) <= next_page_start &&
             !tcg_op_buf_full());
 done:
-    reset_litbase(&dc);
     reset_sar_tracker(&dc);
     if (dc.icount) {
         tcg_temp_free(dc.next_icount);
@@ -1672,12 +1654,13 @@ static void translate_l32r(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
     if (gen_window_check1(dc, arg[0])) {
-        TCGv_i32 tmp = (dc->tb->flags & XTENSA_TBFLAG_LITBASE) ?
-                       tcg_const_i32(dc->raw_arg[1] - 1) :
-                       tcg_const_i32(arg[1]);
+        TCGv_i32 tmp;
 
         if (dc->tb->flags & XTENSA_TBFLAG_LITBASE) {
-            tcg_gen_add_i32(tmp, tmp, dc->litbase);
+            tmp = tcg_const_i32(dc->raw_arg[1] - 1);
+            tcg_gen_add_i32(tmp, cpu_SR[LITBASE], tmp);
+        } else {
+            tmp = tcg_const_i32(arg[1]);
         }
         tcg_gen_qemu_ld32u(cpu_R[arg[0]], tmp, dc->cring);
         tcg_temp_free(tmp);
-- 
2.1.4
