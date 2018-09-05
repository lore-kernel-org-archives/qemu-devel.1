Received: from eggs.gnu.org ([2001:4830:134:3::10]:57995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsI-0006Aa-L2
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsE-00077E-Ki
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:52 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:44913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMs9-0006xl-F1
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:47 -0400
Received: by mail-lj1-x230.google.com with SMTP id q127-v6so4785886ljq.11
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:43 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:47 -0700
Message-Id: <20180905014352.970-11-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 10/15] target/xtensa: extract unconditional TB
 termination
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

- mark all instructions that exit TB and require dynamic search for the
  next TB;
- put TB termination right after the instruction translation loop;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 67 ++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index f8b9f65f7102..93289fd37f1f 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -572,8 +572,6 @@ static bool gen_wsr_br(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 static bool gen_wsr_litbase(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_andi_i32(cpu_SR[sr], s, 0xfffff001);
-    /* This can change tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     return true;
 }
 
@@ -587,16 +585,12 @@ static bool gen_wsr_acchi(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 static bool gen_wsr_windowbase(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_windowbase(cpu_env, v);
-    /* This can change tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     return true;
 }
 
 static bool gen_wsr_windowstart(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, (1 << dc->config->nareg / 4) - 1);
-    /* This can change tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     return true;
 }
 
@@ -609,8 +603,6 @@ static bool gen_wsr_ptevaddr(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static bool gen_wsr_rasid(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_rasid(cpu_env, v);
-    /* This can change tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     return true;
 }
 
@@ -680,8 +672,6 @@ static bool gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static bool gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0xff);
-    /* This can change tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     return true;
 }
 
@@ -738,8 +728,6 @@ static bool gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     }
     tcg_gen_andi_i32(cpu_SR[sr], v, mask);
     gen_check_interrupts(dc);
-    /* This can change mmu index and tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     return true;
 }
 
@@ -770,8 +758,6 @@ static bool gen_wsr_icount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static bool gen_wsr_icountlevel(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0xf);
-    /* This can change tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     return true;
 }
 
@@ -1115,6 +1101,14 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         dc->raw_arg = slot_prop[slot].raw_arg;
         ops->translate(dc, slot_prop[slot].arg, ops->par);
     }
+
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        if (op_flags & XTENSA_OP_EXIT_TB_M1) {
+            /* Change in mmu index, memory mapping or tb->flags; exit tb */
+            gen_jumpi_check_loop_end(dc, -1);
+        }
+    }
+
     if (dc->base.is_jmp == DISAS_NEXT) {
         gen_check_loop_end(dc, 0);
     }
@@ -1664,8 +1658,6 @@ static void translate_entry(DisasContext *dc, const uint32_t arg[],
     tcg_temp_free(imm);
     tcg_temp_free(s);
     tcg_temp_free(pc);
-    /* This can change tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
 }
 
 static void translate_extui(DisasContext *dc, const uint32_t arg[],
@@ -1699,8 +1691,6 @@ static void translate_itlb(DisasContext *dc, const uint32_t arg[],
     TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
     gen_helper_itlb(cpu_env, cpu_R[arg[0]], dtlb);
-    /* This could change memory mapping, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     tcg_temp_free(dtlb);
 #endif
 }
@@ -2163,8 +2153,6 @@ static void translate_rotw(DisasContext *dc, const uint32_t arg[],
     TCGv_i32 tmp = tcg_const_i32(arg[0]);
     gen_helper_rotw(cpu_env, tmp);
     tcg_temp_free(tmp);
-    /* This can change tb->flags, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
 }
 
 static void translate_rsil(DisasContext *dc, const uint32_t arg[],
@@ -2468,8 +2456,6 @@ static void translate_wtlb(DisasContext *dc, const uint32_t arg[],
     TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
     gen_helper_wtlb(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]], dtlb);
-    /* This could change memory mapping, so exit tb */
-    gen_jumpi_check_loop_end(dc, -1);
     tcg_temp_free(dtlb);
 #endif
 }
@@ -2874,6 +2860,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_entry,
         .test_ill = test_ill_entry,
         .test_overflow = test_overflow_entry,
+        .op_flags = XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "esync",
         .translate = translate_nop,
@@ -2897,7 +2884,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "idtlb",
         .translate = translate_itlb,
         .par = (const uint32_t[]){true},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "ihi",
@@ -2917,7 +2904,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "iitlb",
         .translate = translate_itlb,
         .par = (const uint32_t[]){false},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "iiu",
@@ -3562,7 +3549,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rotw",
         .translate = translate_rotw,
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "rsil",
         .translate = translate_rsil,
@@ -4270,7 +4257,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "wdtlb",
         .translate = translate_wtlb,
         .par = (const uint32_t[]){true},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x3,
     }, {
         .name = "wer",
@@ -4281,7 +4268,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "witlb",
         .translate = translate_wtlb,
         .par = (const uint32_t[]){false},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x3,
     }, {
         .name = "wrmsk_expstate",
@@ -4380,7 +4367,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CPENABLE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.dbreaka0",
@@ -4625,7 +4612,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intclear",
@@ -4685,6 +4672,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LITBASE},
+        .op_flags = XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.m0",
@@ -4764,7 +4752,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PS},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ptevaddr",
@@ -4778,7 +4766,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){RASID},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.sar",
@@ -4804,14 +4792,14 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_BASE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.windowstart",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_START},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "wur.expstate",
@@ -4936,7 +4924,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CPENABLE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.dbreaka0",
@@ -5181,7 +5169,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intclear",
@@ -5241,6 +5229,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LITBASE},
+        .op_flags = XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.m0",
@@ -5313,7 +5302,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PS},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ptevaddr",
@@ -5327,7 +5316,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){RASID},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.sar",
@@ -5353,14 +5342,14 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_BASE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.windowstart",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_START},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
         .windowed_register_op = 0x1,
     },
 };
-- 
2.11.0
