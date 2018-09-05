Received: from eggs.gnu.org ([2001:4830:134:3::10]:58064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsN-0006FA-Jx
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsL-0007Fd-Ob
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:59 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMsL-0007BP-9A
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:57 -0400
Received: by mail-lf1-x141.google.com with SMTP id j8-v6so4584942lfb.4
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:54 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:52 -0700
Message-Id: <20180905014352.970-16-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 15/15] target/xtensa: extract
 gen_check_interrupts call
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

- mark instructions that affect active IRQ level;
- put call for gen_check_interrupts right after the instruction
  translation; when FLIX is enabled it will need to appear before
  other exits from the TB as well;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 78 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 19a829286d22..7e4eedca4d34 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -660,7 +660,6 @@ static void gen_wsr_intset(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v,
             dc->config->inttype_mask[INTTYPE_SOFTWARE]);
-    gen_check_interrupts(dc);
 }
 
 static void gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
@@ -673,13 +672,11 @@ static void gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
             dc->config->inttype_mask[INTTYPE_SOFTWARE]);
     tcg_gen_andc_i32(cpu_SR[INTSET], cpu_SR[INTSET], tmp);
     tcg_temp_free(tmp);
-    gen_check_interrupts(dc);
 }
 
 static void gen_wsr_intenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_mov_i32(cpu_SR[sr], v);
-    gen_check_interrupts(dc);
 }
 
 static void gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
@@ -691,7 +688,6 @@ static void gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
         mask |= PS_RING;
     }
     tcg_gen_andi_i32(cpu_SR[sr], v, mask);
-    gen_check_interrupts(dc);
 }
 
 static void gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
@@ -1053,6 +1049,10 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     }
 
     if (dc->base.is_jmp == DISAS_NEXT) {
+        if (op_flags & XTENSA_OP_CHECK_INTERRUPTS) {
+            gen_check_interrupts(dc);
+        }
+
         if (op_flags & XTENSA_OP_EXIT_TB_M1) {
             /* Change in mmu index, memory mapping or tb->flags; exit tb */
             gen_jumpi_check_loop_end(dc, -1);
@@ -2064,7 +2064,6 @@ static void translate_rfe(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
     tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
-    gen_check_interrupts(dc);
     gen_jump(dc, cpu_SR[EPC1]);
 }
 
@@ -2072,7 +2071,6 @@ static void translate_rfi(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
     tcg_gen_mov_i32(cpu_SR[PS], cpu_SR[EPS2 + arg[0] - 2]);
-    gen_check_interrupts(dc);
     gen_jump(dc, cpu_SR[EPC1 + arg[0] - 1]);
 }
 
@@ -2092,11 +2090,9 @@ static void translate_rfw(DisasContext *dc, const uint32_t arg[],
                        cpu_SR[WINDOW_START], tmp);
     }
 
+    tcg_temp_free(tmp);
     gen_helper_restore_owb(cpu_env);
-    gen_check_interrupts(dc);
     gen_jump(dc, cpu_SR[EPC1]);
-
-    tcg_temp_free(tmp);
 }
 
 static void translate_rotw(DisasContext *dc, const uint32_t arg[],
@@ -2113,7 +2109,6 @@ static void translate_rsil(DisasContext *dc, const uint32_t arg[],
     tcg_gen_mov_i32(cpu_R[arg[0]], cpu_SR[PS]);
     tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
     tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1]);
-    gen_check_interrupts(dc);
 }
 
 static bool test_ill_rsr(DisasContext *dc, const uint32_t arg[],
@@ -3464,21 +3459,21 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rfe",
         .translate = translate_rfe,
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "rfi",
         .translate = translate_rfi,
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "rfwo",
         .translate = translate_rfw,
         .par = (const uint32_t[]){true},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "rfwu",
         .translate = translate_rfw,
         .par = (const uint32_t[]){false},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "ritlb0",
         .translate = translate_rtlb,
@@ -3498,7 +3493,10 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsil",
         .translate = translate_rsil,
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "rsr.176",
@@ -4564,28 +4562,40 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTCLEAR},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTENABLE},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.interrupt",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intset",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.itlbcfg",
@@ -4699,7 +4709,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PS},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_M1 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ptevaddr",
@@ -5123,28 +5136,40 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTCLEAR},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTENABLE},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.interrupt",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intset",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_0 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.itlbcfg",
@@ -5251,7 +5276,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PS},
-        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
+        .op_flags =
+            XTENSA_OP_PRIVILEGED |
+            XTENSA_OP_EXIT_TB_M1 |
+            XTENSA_OP_CHECK_INTERRUPTS,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ptevaddr",
-- 
2.11.0
