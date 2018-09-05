Received: from eggs.gnu.org ([2001:4830:134:3::10]:57824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMs0-0005wM-9D
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMru-0006iO-RJ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:36 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMrp-0006cW-UE
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:28 -0400
Received: by mail-lf1-x144.google.com with SMTP id x207-v6so4599374lff.3
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:25 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:39 -0700
Message-Id: <20180905014352.970-3-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 02/15] target/xtensa: extract test for
 privileged instruction
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

- mark privileged instructions;
- put single privileged instruction check after disassembly loop;
- translate_[di]cache: drop parameter 0, shift parameters one down;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 387 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 294 insertions(+), 93 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 8c6d1e79866c..ebee7bd65e48 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1042,6 +1042,11 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         }
     }
 
+    if ((op_flags & XTENSA_OP_PRIVILEGED) &&
+        !gen_check_privilege(dc)) {
+        return;
+    }
+
     for (slot = 0; slot < slots; ++slot) {
         XtensaOpcodeOps *ops = slot_prop[slot].ops;
 
@@ -1584,12 +1589,11 @@ static void translate_const16(DisasContext *dc, const uint32_t arg[],
     }
 }
 
-/* par[0]: privileged, par[1]: check memory access */
+/* par[0]: check memory access */
 static void translate_dcache(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if ((!par[0] || gen_check_privilege(dc)) &&
-        gen_window_check1(dc, arg[0]) && par[1]) {
+    if (gen_window_check1(dc, arg[0]) && par[0]) {
         TCGv_i32 addr = tcg_temp_new_i32();
         TCGv_i32 res = tcg_temp_new_i32();
 
@@ -1648,12 +1652,11 @@ static void translate_extui(DisasContext *dc, const uint32_t arg[],
     }
 }
 
-/* par[0]: privileged, par[1]: check memory access */
+/* par[0]: check memory access */
 static void translate_icache(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
-    if ((!par[0] || gen_check_privilege(dc)) &&
-        gen_window_check1(dc, arg[0]) && par[1]) {
+    if (gen_window_check1(dc, arg[0]) && par[0]) {
 #ifndef CONFIG_USER_ONLY
         TCGv_i32 addr = tcg_temp_new_i32();
 
@@ -1668,8 +1671,7 @@ static void translate_icache(DisasContext *dc, const uint32_t arg[],
 static void translate_itlb(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_check_privilege(dc) &&
-        gen_window_check1(dc, arg[0])) {
+    if (gen_window_check1(dc, arg[0])) {
 #ifndef CONFIG_USER_ONLY
         TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
@@ -1698,8 +1700,7 @@ static void translate_jx(DisasContext *dc, const uint32_t arg[],
 static void translate_l32e(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_check_privilege(dc) &&
-        gen_window_check2(dc, arg[0], arg[1])) {
+    if (gen_window_check2(dc, arg[0], arg[1])) {
         TCGv_i32 addr = tcg_temp_new_i32();
 
         tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
@@ -2061,8 +2062,7 @@ static void translate_or(DisasContext *dc, const uint32_t arg[],
 static void translate_ptlb(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_check_privilege(dc) &&
-        gen_window_check2(dc, arg[0], arg[1])) {
+    if (gen_window_check2(dc, arg[0], arg[1])) {
 #ifndef CONFIG_USER_ONLY
         TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
@@ -2137,8 +2137,7 @@ static void translate_read_impwire(DisasContext *dc, const uint32_t arg[],
 static void translate_rer(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_check_privilege(dc) &&
-        gen_window_check2(dc, arg[0], arg[1])) {
+    if (gen_window_check2(dc, arg[0], arg[1])) {
         gen_helper_rer(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]]);
     }
 }
@@ -2177,73 +2176,62 @@ static void translate_retw(DisasContext *dc, const uint32_t arg[],
 static void translate_rfde(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_check_privilege(dc)) {
-        gen_jump(dc, cpu_SR[dc->config->ndepc ? DEPC : EPC1]);
-    }
+    gen_jump(dc, cpu_SR[dc->config->ndepc ? DEPC : EPC1]);
 }
 
 static void translate_rfe(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_check_privilege(dc)) {
-        tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
-        gen_check_interrupts(dc);
-        gen_jump(dc, cpu_SR[EPC1]);
-    }
+    tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
+    gen_check_interrupts(dc);
+    gen_jump(dc, cpu_SR[EPC1]);
 }
 
 static void translate_rfi(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_check_privilege(dc)) {
-        tcg_gen_mov_i32(cpu_SR[PS], cpu_SR[EPS2 + arg[0] - 2]);
-        gen_check_interrupts(dc);
-        gen_jump(dc, cpu_SR[EPC1 + arg[0] - 1]);
-    }
+    tcg_gen_mov_i32(cpu_SR[PS], cpu_SR[EPS2 + arg[0] - 2]);
+    gen_check_interrupts(dc);
+    gen_jump(dc, cpu_SR[EPC1 + arg[0] - 1]);
 }
 
 static void translate_rfw(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_check_privilege(dc)) {
-        TCGv_i32 tmp = tcg_const_i32(1);
+    TCGv_i32 tmp = tcg_const_i32(1);
 
-        tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
-        tcg_gen_shl_i32(tmp, tmp, cpu_SR[WINDOW_BASE]);
+    tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
+    tcg_gen_shl_i32(tmp, tmp, cpu_SR[WINDOW_BASE]);
 
-        if (par[0]) {
-            tcg_gen_andc_i32(cpu_SR[WINDOW_START],
-                             cpu_SR[WINDOW_START], tmp);
-        } else {
-            tcg_gen_or_i32(cpu_SR[WINDOW_START],
-                           cpu_SR[WINDOW_START], tmp);
-        }
+    if (par[0]) {
+        tcg_gen_andc_i32(cpu_SR[WINDOW_START],
+                         cpu_SR[WINDOW_START], tmp);
+    } else {
+        tcg_gen_or_i32(cpu_SR[WINDOW_START],
+                       cpu_SR[WINDOW_START], tmp);
+    }
 
-        gen_helper_restore_owb(cpu_env);
-        gen_check_interrupts(dc);
-        gen_jump(dc, cpu_SR[EPC1]);
+    gen_helper_restore_owb(cpu_env);
+    gen_check_interrupts(dc);
+    gen_jump(dc, cpu_SR[EPC1]);
 
-        tcg_temp_free(tmp);
-    }
+    tcg_temp_free(tmp);
 }
 
 static void translate_rotw(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_check_privilege(dc)) {
-        TCGv_i32 tmp = tcg_const_i32(arg[0]);
-        gen_helper_rotw(cpu_env, tmp);
-        tcg_temp_free(tmp);
-        /* This can change tb->flags, so exit tb */
-        gen_jumpi_check_loop_end(dc, -1);
-    }
+    TCGv_i32 tmp = tcg_const_i32(arg[0]);
+    gen_helper_rotw(cpu_env, tmp);
+    tcg_temp_free(tmp);
+    /* This can change tb->flags, so exit tb */
+    gen_jumpi_check_loop_end(dc, -1);
 }
 
 static void translate_rsil(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_check_privilege(dc) &&
-        gen_window_check1(dc, arg[0])) {
+    if (gen_window_check1(dc, arg[0])) {
         tcg_gen_mov_i32(cpu_R[arg[0]], cpu_SR[PS]);
         tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
         tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1]);
@@ -2261,8 +2249,7 @@ static bool test_ill_rsr(DisasContext *dc, const uint32_t arg[],
 static void translate_rsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if ((par[0] < 64 || gen_check_privilege(dc)) &&
-        gen_window_check1(dc, arg[0])) {
+    if (gen_window_check1(dc, arg[0])) {
         if (gen_rsr(dc, cpu_R[arg[0]], par[0])) {
             gen_jumpi_check_loop_end(dc, 0);
         }
@@ -2272,21 +2259,20 @@ static void translate_rsr(DisasContext *dc, const uint32_t arg[],
 static void translate_rtlb(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
+#ifndef CONFIG_USER_ONLY
     static void (* const helper[])(TCGv_i32 r, TCGv_env env, TCGv_i32 a1,
                                    TCGv_i32 a2) = {
-#ifndef CONFIG_USER_ONLY
         gen_helper_rtlb0,
         gen_helper_rtlb1,
-#endif
     };
 
-    if (gen_check_privilege(dc) &&
-        gen_window_check2(dc, arg[0], arg[1])) {
+    if (gen_window_check2(dc, arg[0], arg[1])) {
         TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
         helper[par[1]](cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
         tcg_temp_free(dtlb);
     }
+#endif
 }
 
 static void translate_rur(DisasContext *dc, const uint32_t arg[],
@@ -2343,8 +2329,7 @@ static void translate_s32c1i(DisasContext *dc, const uint32_t arg[],
 static void translate_s32e(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_check_privilege(dc) &&
-        gen_window_check2(dc, arg[0], arg[1])) {
+    if (gen_window_check2(dc, arg[0], arg[1])) {
         TCGv_i32 addr = tcg_temp_new_i32();
 
         tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
@@ -2401,9 +2386,7 @@ static void translate_simcall(DisasContext *dc, const uint32_t arg[],
                               const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
-    if (gen_check_privilege(dc)) {
-        gen_helper_simcall(cpu_env);
-    }
+    gen_helper_simcall(cpu_env);
 #endif
 }
 
@@ -2583,18 +2566,15 @@ static void translate_syscall(DisasContext *dc, const uint32_t arg[],
 static void translate_waiti(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    if (gen_check_privilege(dc)) {
 #ifndef CONFIG_USER_ONLY
-        gen_waiti(dc, arg[0]);
+    gen_waiti(dc, arg[0]);
 #endif
-    }
 }
 
 static void translate_wtlb(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    if (gen_check_privilege(dc) &&
-        gen_window_check2(dc, arg[0], arg[1])) {
+    if (gen_window_check2(dc, arg[0], arg[1])) {
 #ifndef CONFIG_USER_ONLY
         TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
@@ -2609,8 +2589,7 @@ static void translate_wtlb(DisasContext *dc, const uint32_t arg[],
 static void translate_wer(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if (gen_check_privilege(dc) &&
-        gen_window_check2(dc, arg[0], arg[1])) {
+    if (gen_window_check2(dc, arg[0], arg[1])) {
         gen_helper_wer(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]]);
     }
 }
@@ -2633,8 +2612,7 @@ static bool test_ill_wsr(DisasContext *dc, const uint32_t arg[],
 static void translate_wsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if ((par[0] < 64 || gen_check_privilege(dc)) &&
-        gen_window_check1(dc, arg[0])) {
+    if (gen_window_check1(dc, arg[0])) {
         gen_wsr(dc, par[0], cpu_R[arg[0]]);
     }
 }
@@ -2668,8 +2646,7 @@ static bool test_ill_xsr(DisasContext *dc, const uint32_t arg[],
 static void translate_xsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-    if ((par[0] < 64 || gen_check_privilege(dc)) &&
-        gen_window_check1(dc, arg[0])) {
+    if (gen_window_check1(dc, arg[0])) {
         TCGv_i32 tmp = tcg_temp_new_i32();
         bool rsr_end, wsr_end;
 
@@ -2906,55 +2883,62 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "dhi",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true, true},
+        .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "dhu",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true, true},
+        .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "dhwb",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){false, true},
+        .par = (const uint32_t[]){true},
     }, {
         .name = "dhwbi",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){false, true},
+        .par = (const uint32_t[]){true},
     }, {
         .name = "dii",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true, false},
+        .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "diu",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true, false},
+        .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "diwb",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true, false},
+        .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "diwbi",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true, false},
+        .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "dpfl",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){true, true},
+        .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "dpfr",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){false, false},
+        .par = (const uint32_t[]){false},
     }, {
         .name = "dpfro",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){false, false},
+        .par = (const uint32_t[]){false},
     }, {
         .name = "dpfw",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){false, false},
+        .par = (const uint32_t[]){false},
     }, {
         .name = "dpfwo",
         .translate = translate_dcache,
-        .par = (const uint32_t[]){false, false},
+        .par = (const uint32_t[]){false},
     }, {
         .name = "dsync",
         .translate = translate_nop,
@@ -2984,26 +2968,31 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "idtlb",
         .translate = translate_itlb,
         .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "ihi",
         .translate = translate_icache,
-        .par = (const uint32_t[]){false, true},
+        .par = (const uint32_t[]){true},
     }, {
         .name = "ihu",
         .translate = translate_icache,
-        .par = (const uint32_t[]){true, true},
+        .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "iii",
         .translate = translate_icache,
-        .par = (const uint32_t[]){true, false},
+        .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "iitlb",
         .translate = translate_itlb,
         .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "iiu",
         .translate = translate_icache,
-        .par = (const uint32_t[]){true, false},
+        .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "ill",
         .op_flags = XTENSA_OP_ILL,
@@ -3013,11 +3002,12 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "ipf",
         .translate = translate_icache,
-        .par = (const uint32_t[]){false, false},
+        .par = (const uint32_t[]){false},
     }, {
         .name = "ipfl",
         .translate = translate_icache,
-        .par = (const uint32_t[]){true, true},
+        .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "isync",
         .translate = translate_nop,
@@ -3042,6 +3032,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "l32e",
         .translate = translate_l32e,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "l32i",
         .translate = translate_ldst,
@@ -3439,10 +3430,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "pdtlb",
         .translate = translate_ptlb,
         .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "pitlb",
         .translate = translate_ptlb,
         .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "quos",
         .translate = translate_quos,
@@ -3455,10 +3448,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "rdtlb0",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){true, 0},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rdtlb1",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){true, 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "read_impwire",
         .translate = translate_read_impwire,
@@ -3473,6 +3468,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rer",
         .translate = translate_rer,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "ret",
         .translate = translate_ret,
@@ -3493,47 +3489,58 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rfde",
         .translate = translate_rfde,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rfdo",
         .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "rfe",
         .translate = translate_rfe,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rfi",
         .translate = translate_rfi,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rfwo",
         .translate = translate_rfw,
         .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rfwu",
         .translate = translate_rfw,
         .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "ritlb0",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){false, 0},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "ritlb1",
         .translate = translate_rtlb,
         .par = (const uint32_t[]){false, 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rotw",
         .translate = translate_rotw,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsil",
         .translate = translate_rsil,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.176",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){176},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.208",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){208},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.acchi",
         .translate = translate_rsr,
@@ -3549,6 +3556,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ATOMCTL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.br",
         .translate = translate_rsr,
@@ -3559,241 +3567,289 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CACHEATTR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ccompare0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ccompare1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ccompare2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ccount",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CCOUNT},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.configid0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID0},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.configid1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.cpenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CPENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dbreaka0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKA},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dbreaka1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKA + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dbreakc0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dbreakc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DBREAKC + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.debugcause",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.depc",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DEPC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dtlbcfg",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){DTLBCFG},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPC1 + 6},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EPS2 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.exccause",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCCAUSE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave4",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave5",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave6",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave7",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excvaddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){EXCVADDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ibreaka0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKA},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ibreaka1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKA + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ibreakenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){IBREAKENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.icount",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ICOUNT},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.icountlevel",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.intclear",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTCLEAR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.intenable",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.interrupt",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.intset",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){INTSET},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.itlbcfg",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){ITLBCFG},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.lbeg",
         .translate = translate_rsr,
@@ -3839,46 +3895,55 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MEMCTL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.misc0",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.misc1",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.misc2",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.misc3",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MISC + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.prid",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PRID},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ps",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PS},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ptevaddr",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PTEVADDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.rasid",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){RASID},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.sar",
         .translate = translate_rsr,
@@ -3894,16 +3959,19 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){VECBASE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.windowbase",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){WINDOW_BASE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.windowstart",
         .translate = translate_rsr,
         .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){WINDOW_START},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsync",
         .translate = translate_nop,
@@ -3933,6 +4001,7 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "s32e",
         .translate = translate_s32e,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "s32i",
         .translate = translate_ldst,
@@ -3971,6 +4040,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "simcall",
         .translate = translate_simcall,
         .test_ill = test_ill_simcall,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "sll",
         .translate = translate_sll,
@@ -4044,17 +4114,21 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "waiti",
         .translate = translate_waiti,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wdtlb",
         .translate = translate_wtlb,
         .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wer",
         .translate = translate_wer,
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "witlb",
         .translate = translate_wtlb,
         .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wrmsk_expstate",
         .translate = translate_wrmsk_expstate,
@@ -4063,11 +4137,13 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){176},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.208",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){208},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.acchi",
         .translate = translate_wsr,
@@ -4083,6 +4159,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ATOMCTL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.br",
         .translate = translate_wsr,
@@ -4093,241 +4170,289 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CACHEATTR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ccompare0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ccompare1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ccompare2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ccount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CCOUNT},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.configid0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CONFIGID0},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.configid1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CONFIGID1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.cpenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){CPENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dbreaka0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKA},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dbreaka1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKA + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dbreakc0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dbreakc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DBREAKC + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.debugcause",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.depc",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DEPC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dtlbcfg",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){DTLBCFG},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPC1 + 6},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EPS2 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.exccause",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCCAUSE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave4",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave5",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave6",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave7",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excvaddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){EXCVADDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ibreaka0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ibreaka1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKA + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ibreakenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){IBREAKENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.icount",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNT},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.icountlevel",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.intclear",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTCLEAR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.intenable",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.interrupt",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.intset",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){INTSET},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.itlbcfg",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){ITLBCFG},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.lbeg",
         .translate = translate_wsr,
@@ -4373,51 +4498,61 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MEMCTL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.misc0",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.misc1",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.misc2",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.misc3",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MISC + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.mmid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){MMID},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.prid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PRID},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ps",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PS},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ptevaddr",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PTEVADDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.rasid",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){RASID},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.sar",
         .translate = translate_wsr,
@@ -4433,16 +4568,19 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){VECBASE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.windowbase",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_BASE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.windowstart",
         .translate = translate_wsr,
         .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){WINDOW_START},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wur.expstate",
         .translate = translate_wur,
@@ -4471,11 +4609,13 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){176},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.208",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){208},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.acchi",
         .translate = translate_xsr,
@@ -4491,6 +4631,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ATOMCTL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.br",
         .translate = translate_xsr,
@@ -4501,241 +4642,289 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CACHEATTR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ccompare0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ccompare1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ccompare2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOMPARE + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ccount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CCOUNT},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.configid0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CONFIGID0},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.configid1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CONFIGID1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.cpenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){CPENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dbreaka0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKA},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dbreaka1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKA + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dbreakc0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dbreakc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DBREAKC + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.debugcause",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DEBUGCAUSE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.depc",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DEPC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dtlbcfg",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){DTLBCFG},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPC1 + 6},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EPS2 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.exccause",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCCAUSE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave4",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave5",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 4},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave6",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 5},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave7",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCSAVE1 + 6},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excvaddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){EXCVADDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ibreaka0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ibreaka1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKA + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ibreakenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){IBREAKENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.icount",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNT},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.icountlevel",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ICOUNTLEVEL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.intclear",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTCLEAR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.intenable",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTENABLE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.interrupt",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.intset",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){INTSET},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.itlbcfg",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){ITLBCFG},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.lbeg",
         .translate = translate_xsr,
@@ -4781,46 +4970,55 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MEMCTL},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.misc0",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.misc1",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 1},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.misc2",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 2},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.misc3",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){MISC + 3},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.prid",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PRID},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ps",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PS},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ptevaddr",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PTEVADDR},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.rasid",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){RASID},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.sar",
         .translate = translate_xsr,
@@ -4836,16 +5034,19 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){VECBASE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.windowbase",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_BASE},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.windowstart",
         .translate = translate_xsr,
         .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){WINDOW_START},
+        .op_flags = XTENSA_OP_PRIVILEGED,
     },
 };
 
-- 
2.11.0
