Received: from eggs.gnu.org ([2001:4830:134:3::10]:58016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsL-0006D2-Bs
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsJ-0007DN-BN
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:57 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMsH-00075s-43
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:55 -0400
Received: by mail-lf1-x144.google.com with SMTP id g6-v6so4553052lfb.11
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:50 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:50 -0700
Message-Id: <20180905014352.970-14-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 13/15] target/xtensa: extract unconditional TB
 termination via slot 0
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

- mark instructions that require TB termination via slot 0;
- put TB termination right after the instruction translation loop, if
  termination w/o TB linking wasn't requested;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 83 ++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 47 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 028b4d4c8652..77ee3162b2a3 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -540,14 +540,12 @@ static bool gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 static bool gen_wsr_lbeg(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     gen_helper_wsr_lbeg(cpu_env, s);
-    gen_jumpi_check_loop_end(dc, 0);
     return false;
 }
 
 static bool gen_wsr_lend(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     gen_helper_wsr_lend(cpu_env, s);
-    gen_jumpi_check_loop_end(dc, 0);
     return false;
 }
 
@@ -614,7 +612,6 @@ static bool gen_wsr_tlbcfg(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static bool gen_wsr_ibreakenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_ibreakenable(cpu_env, v);
-    gen_jumpi_check_loop_end(dc, 0);
     return true;
 }
 
@@ -638,7 +635,6 @@ static bool gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     assert(id < dc->config->nibreak);
     gen_helper_wsr_ibreaka(cpu_env, tmp, v);
     tcg_temp_free(tmp);
-    gen_jumpi_check_loop_end(dc, 0);
     return true;
 }
 
@@ -686,7 +682,6 @@ static bool gen_wsr_intset(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     tcg_gen_andi_i32(cpu_SR[sr], v,
             dc->config->inttype_mask[INTTYPE_SOFTWARE]);
     gen_check_interrupts(dc);
-    gen_jumpi_check_loop_end(dc, 0);
     return true;
 }
 
@@ -701,7 +696,6 @@ static bool gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     tcg_gen_andc_i32(cpu_SR[INTSET], cpu_SR[INTSET], tmp);
     tcg_temp_free(tmp);
     gen_check_interrupts(dc);
-    gen_jumpi_check_loop_end(dc, 0);
     return true;
 }
 
@@ -709,7 +703,6 @@ static bool gen_wsr_intenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_mov_i32(cpu_SR[sr], v);
     gen_check_interrupts(dc);
-    gen_jumpi_check_loop_end(dc, 0);
     return true;
 }
 
@@ -735,7 +728,6 @@ static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
-    gen_jumpi_check_loop_end(dc, 0);
     return true;
 }
 
@@ -772,7 +764,6 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
-    gen_jumpi_check_loop_end(dc, 0);
     return true;
 }
 #else
@@ -878,7 +869,6 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
     }
     tcg_temp_free(pc);
     tcg_temp_free(intlevel);
-    gen_jumpi_check_loop_end(dc, 0);
 }
 #endif
 
@@ -1096,6 +1086,8 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         if (op_flags & XTENSA_OP_EXIT_TB_M1) {
             /* Change in mmu index, memory mapping or tb->flags; exit tb */
             gen_jumpi_check_loop_end(dc, -1);
+        } else if (op_flags & XTENSA_OP_EXIT_TB_0) {
+            gen_jumpi_check_loop_end(dc, 0);
         }
     }
 
@@ -2152,7 +2144,6 @@ static void translate_rsil(DisasContext *dc, const uint32_t arg[],
     tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
     tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1]);
     gen_check_interrupts(dc);
-    gen_jumpi_check_loop_end(dc, 0);
 }
 
 static bool test_ill_rsr(DisasContext *dc, const uint32_t arg[],
@@ -2164,9 +2155,7 @@ static bool test_ill_rsr(DisasContext *dc, const uint32_t arg[],
 static void translate_rsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_rsr(dc, cpu_R[arg[0]], par[0])) {
-        gen_jumpi_check_loop_end(dc, 0);
-    }
+    gen_rsr(dc, cpu_R[arg[0]], par[0]);
 }
 
 static void translate_rtlb(DisasContext *dc, const uint32_t arg[],
@@ -2501,15 +2490,11 @@ static void translate_xsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    bool rsr_end, wsr_end;
 
     tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-    rsr_end = gen_rsr(dc, cpu_R[arg[0]], par[0]);
-    wsr_end = gen_wsr(dc, par[0], tmp);
+    gen_rsr(dc, cpu_R[arg[0]], par[0]);
+    gen_wsr(dc, par[0], tmp);
     tcg_temp_free(tmp);
-    if (rsr_end && !wsr_end) {
-        gen_jumpi_check_loop_end(dc, 0);
-    }
 }
 
 static const XtensaOpcodeOps core_ops[] = {
@@ -3543,7 +3528,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsil",
         .translate = translate_rsil,
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "rsr.176",
@@ -3617,7 +3602,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOUNT},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "rsr.configid0",
@@ -3904,14 +3889,14 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "rsr.intset",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "rsr.itlbcfg",
@@ -4242,7 +4227,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "waiti",
         .translate = translate_waiti,
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "wdtlb",
         .translate = translate_wtlb,
@@ -4315,28 +4300,28 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccompare1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccompare2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ccount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOUNT},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.configid0",
@@ -4574,21 +4559,21 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ibreaka1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA + 1},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.ibreakenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKENABLE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.icount",
@@ -4609,28 +4594,28 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTCLEAR},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTENABLE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.interrupt",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.intset",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.itlbcfg",
@@ -4644,6 +4629,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LBEG},
+        .op_flags = XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.lcount",
@@ -4656,6 +4642,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){LEND},
+        .op_flags = XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "wsr.litbase",
@@ -4872,28 +4859,28 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccompare1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccompare2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ccount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOUNT},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.configid0",
@@ -5131,21 +5118,21 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ibreaka1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA + 1},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.ibreakenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKENABLE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.icount",
@@ -5166,28 +5153,28 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTCLEAR},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTENABLE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.interrupt",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.intset",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.itlbcfg",
@@ -5201,6 +5188,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LBEG},
+        .op_flags = XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.lcount",
@@ -5213,6 +5201,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){LEND},
+        .op_flags = XTENSA_OP_EXIT_TB_0,
         .windowed_register_op = 0x1,
     }, {
         .name = "xsr.litbase",
-- 
2.11.0
