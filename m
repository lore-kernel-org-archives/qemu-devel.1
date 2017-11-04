Received: from eggs.gnu.org ([2001:4830:134:3::10]:44853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPH-0005xl-3K
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPF-0000Yr-Ad
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:03 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApPE-0000YT-VJ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:01 -0400
Received: by mail-lf0-x242.google.com with SMTP id n69so5177619lfn.2
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:46:00 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:09 -0700
Message-Id: <1509767121-26925-5-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 04/16] target/xtensa: extract FPU2000 opcode
 translators
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

FPU2000 implements basic single-precision floating point operations and
can be replaced with a different implementation, like DFPU or HiFi. Move
FPU2000 opcode translators into separate functions and list them in a
separate array.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |   1 +
 target/xtensa/translate.c | 374 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 375 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 8b6fd1ff9695..bd77a68a7aa4 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -349,6 +349,7 @@ typedef struct XtensaOpcodeTranslators {
 } XtensaOpcodeTranslators;
 
 extern const XtensaOpcodeTranslators xtensa_core_opcodes;
+extern const XtensaOpcodeTranslators xtensa_fpu2000_opcodes;
 
 struct XtensaConfig {
     const char *name;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 1c227380a64d..f6a53cdfc28f 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -6433,3 +6433,377 @@ const XtensaOpcodeTranslators xtensa_core_opcodes = {
     .num_opcodes = ARRAY_SIZE(core_ops),
     .opcode = core_ops,
 };
+
+
+static void translate_abs_s(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        gen_helper_abs_s(cpu_FR[arg[0]], cpu_FR[arg[1]]);
+    }
+}
+
+static void translate_add_s(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        gen_helper_add_s(cpu_FR[arg[0]], cpu_env,
+                         cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    }
+}
+
+enum {
+    COMPARE_UN,
+    COMPARE_OEQ,
+    COMPARE_UEQ,
+    COMPARE_OLT,
+    COMPARE_ULT,
+    COMPARE_OLE,
+    COMPARE_ULE,
+};
+
+static void translate_compare_s(DisasContext *dc, const uint32_t arg[],
+                                const uint32_t par[])
+{
+    static void (* const helper[])(TCGv_env env, TCGv_i32 bit,
+                                   TCGv_i32 s, TCGv_i32 t) = {
+        [COMPARE_UN] = gen_helper_un_s,
+        [COMPARE_OEQ] = gen_helper_oeq_s,
+        [COMPARE_UEQ] = gen_helper_ueq_s,
+        [COMPARE_OLT] = gen_helper_olt_s,
+        [COMPARE_ULT] = gen_helper_ult_s,
+        [COMPARE_OLE] = gen_helper_ole_s,
+        [COMPARE_ULE] = gen_helper_ule_s,
+    };
+
+    if (gen_check_cpenable(dc, 0)) {
+        TCGv_i32 bit = tcg_const_i32(1 << arg[0]);
+
+        helper[par[0]](cpu_env, bit, cpu_FR[arg[1]], cpu_FR[arg[2]]);
+        tcg_temp_free(bit);
+    }
+}
+
+static void translate_float_s(DisasContext *dc, const uint32_t arg[],
+                              const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[1]) && gen_check_cpenable(dc, 0)) {
+        TCGv_i32 scale = tcg_const_i32(-arg[2]);
+
+        if (par[0]) {
+            gen_helper_uitof(cpu_FR[arg[0]], cpu_env, cpu_R[arg[1]], scale);
+        } else {
+            gen_helper_itof(cpu_FR[arg[0]], cpu_env, cpu_R[arg[1]], scale);
+        }
+        tcg_temp_free(scale);
+    }
+}
+
+static void translate_ftoi_s(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0]) && gen_check_cpenable(dc, 0)) {
+        TCGv_i32 rounding_mode = tcg_const_i32(par[0]);
+        TCGv_i32 scale = tcg_const_i32(arg[2]);
+
+        if (par[1]) {
+            gen_helper_ftoui(cpu_R[arg[0]], cpu_FR[arg[1]],
+                             rounding_mode, scale);
+        } else {
+            gen_helper_ftoi(cpu_R[arg[0]], cpu_FR[arg[1]],
+                            rounding_mode, scale);
+        }
+        tcg_temp_free(rounding_mode);
+        tcg_temp_free(scale);
+    }
+}
+
+static void translate_ldsti(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[1]) && gen_check_cpenable(dc, 0)) {
+        TCGv_i32 addr = tcg_temp_new_i32();
+
+        tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
+        gen_load_store_alignment(dc, 2, addr, false);
+        if (par[0]) {
+            tcg_gen_qemu_st32(cpu_FR[arg[0]], addr, dc->cring);
+        } else {
+            tcg_gen_qemu_ld32u(cpu_FR[arg[0]], addr, dc->cring);
+        }
+        if (par[1]) {
+            tcg_gen_mov_i32(cpu_R[arg[1]], addr);
+        }
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_ldstx(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[1], arg[2]) && gen_check_cpenable(dc, 0)) {
+        TCGv_i32 addr = tcg_temp_new_i32();
+
+        tcg_gen_add_i32(addr, cpu_R[arg[1]], cpu_R[arg[2]]);
+        gen_load_store_alignment(dc, 2, addr, false);
+        if (par[0]) {
+            tcg_gen_qemu_st32(cpu_FR[arg[0]], addr, dc->cring);
+        } else {
+            tcg_gen_qemu_ld32u(cpu_FR[arg[0]], addr, dc->cring);
+        }
+        if (par[1]) {
+            tcg_gen_mov_i32(cpu_R[arg[1]], addr);
+        }
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_madd_s(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        gen_helper_madd_s(cpu_FR[arg[0]], cpu_env,
+                          cpu_FR[arg[0]], cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    }
+}
+
+static void translate_mov_s(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_FR[arg[1]]);
+    }
+}
+
+static void translate_movcond_s(DisasContext *dc, const uint32_t arg[],
+                                const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[2]) && gen_check_cpenable(dc, 0)) {
+        TCGv_i32 zero = tcg_const_i32(0);
+
+        tcg_gen_movcond_i32(par[0], cpu_FR[arg[0]],
+                            cpu_R[arg[2]], zero,
+                            cpu_FR[arg[1]], cpu_FR[arg[2]]);
+        tcg_temp_free(zero);
+    }
+}
+
+static void translate_movp_s(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        TCGv_i32 zero = tcg_const_i32(0);
+        TCGv_i32 tmp = tcg_temp_new_i32();
+
+        tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2]);
+        tcg_gen_movcond_i32(par[0],
+                            cpu_FR[arg[0]], tmp, zero,
+                            cpu_FR[arg[1]], cpu_FR[arg[0]]);
+        tcg_temp_free(tmp);
+        tcg_temp_free(zero);
+    }
+}
+
+static void translate_mul_s(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        gen_helper_mul_s(cpu_FR[arg[0]], cpu_env,
+                         cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    }
+}
+
+static void translate_msub_s(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        gen_helper_msub_s(cpu_FR[arg[0]], cpu_env,
+                          cpu_FR[arg[0]], cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    }
+}
+
+static void translate_neg_s(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        gen_helper_neg_s(cpu_FR[arg[0]], cpu_FR[arg[1]]);
+    }
+}
+
+static void translate_rfr_s(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0]) &&
+        gen_check_cpenable(dc, 0)) {
+        tcg_gen_mov_i32(cpu_R[arg[0]], cpu_FR[arg[1]]);
+    }
+}
+
+static void translate_sub_s(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_check_cpenable(dc, 0)) {
+        gen_helper_sub_s(cpu_FR[arg[0]], cpu_env,
+                         cpu_FR[arg[1]], cpu_FR[arg[2]]);
+    }
+}
+
+static void translate_wfr_s(DisasContext *dc, const uint32_t arg[],
+                            const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[1]) &&
+        gen_check_cpenable(dc, 0)) {
+        tcg_gen_mov_i32(cpu_FR[arg[0]], cpu_R[arg[1]]);
+    }
+}
+
+static const XtensaOpcodeOps fpu2000_ops[] = {
+    {
+        .name = "abs.s",
+        .translate = translate_abs_s,
+    }, {
+        .name = "add.s",
+        .translate = translate_add_s,
+    }, {
+        .name = "ceil.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_up, false},
+    }, {
+        .name = "float.s",
+        .translate = translate_float_s,
+        .par = (const uint32_t[]){false},
+    }, {
+        .name = "floor.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_down, false},
+    }, {
+        .name = "lsi",
+        .translate = translate_ldsti,
+        .par = (const uint32_t[]){false, false},
+    }, {
+        .name = "lsiu",
+        .translate = translate_ldsti,
+        .par = (const uint32_t[]){false, true},
+    }, {
+        .name = "lsx",
+        .translate = translate_ldstx,
+        .par = (const uint32_t[]){false, false},
+    }, {
+        .name = "lsxu",
+        .translate = translate_ldstx,
+        .par = (const uint32_t[]){false, true},
+    }, {
+        .name = "madd.s",
+        .translate = translate_madd_s,
+    }, {
+        .name = "mov.s",
+        .translate = translate_mov_s,
+    }, {
+        .name = "moveqz.s",
+        .translate = translate_movcond_s,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "movf.s",
+        .translate = translate_movp_s,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+    }, {
+        .name = "movgez.s",
+        .translate = translate_movcond_s,
+        .par = (const uint32_t[]){TCG_COND_GE},
+    }, {
+        .name = "movltz.s",
+        .translate = translate_movcond_s,
+        .par = (const uint32_t[]){TCG_COND_LT},
+    }, {
+        .name = "movnez.s",
+        .translate = translate_movcond_s,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "movt.s",
+        .translate = translate_movp_s,
+        .par = (const uint32_t[]){TCG_COND_NE},
+    }, {
+        .name = "msub.s",
+        .translate = translate_msub_s,
+    }, {
+        .name = "mul.s",
+        .translate = translate_mul_s,
+    }, {
+        .name = "neg.s",
+        .translate = translate_neg_s,
+    }, {
+        .name = "oeq.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_OEQ},
+    }, {
+        .name = "ole.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_OLE},
+    }, {
+        .name = "olt.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_OLT},
+    }, {
+        .name = "rfr.s",
+        .translate = translate_rfr_s,
+    }, {
+        .name = "round.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_nearest_even, false},
+    }, {
+        .name = "ssi",
+        .translate = translate_ldsti,
+        .par = (const uint32_t[]){true, false},
+    }, {
+        .name = "ssiu",
+        .translate = translate_ldsti,
+        .par = (const uint32_t[]){true, true},
+    }, {
+        .name = "ssx",
+        .translate = translate_ldstx,
+        .par = (const uint32_t[]){true, false},
+    }, {
+        .name = "ssxu",
+        .translate = translate_ldstx,
+        .par = (const uint32_t[]){true, true},
+    }, {
+        .name = "sub.s",
+        .translate = translate_sub_s,
+    }, {
+        .name = "trunc.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_to_zero, false},
+    }, {
+        .name = "ueq.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_UEQ},
+    }, {
+        .name = "ufloat.s",
+        .translate = translate_float_s,
+        .par = (const uint32_t[]){true},
+    }, {
+        .name = "ule.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_ULE},
+    }, {
+        .name = "ult.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_ULT},
+    }, {
+        .name = "un.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_UN},
+    }, {
+        .name = "utrunc.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_to_zero, true},
+    }, {
+        .name = "wfr.s",
+        .translate = translate_wfr_s,
+    },
+};
+
+const XtensaOpcodeTranslators xtensa_fpu2000_opcodes = {
+    .num_opcodes = ARRAY_SIZE(fpu2000_ops),
+    .opcode = fpu2000_ops,
+};
-- 
2.1.4
