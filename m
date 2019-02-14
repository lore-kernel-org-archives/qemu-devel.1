Received: from eggs.gnu.org ([209.51.188.92]:49454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8o-00034j-ET
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ09-0005AV-KU
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:07 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ09-00059I-6o
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:05 -0500
Received: by mail-lf1-x144.google.com with SMTP id q12so5834839lfm.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:01:05 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:57 -0800
Message-Id: <20190214230000.24894-11-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 10/13] target/xtensa: reorganize access to
 MAC16 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

libisa represents MAC16 registers m0..m3 as an MR register file. Add
this register file and reference its registers directly from the
translate_mac16. Drop translator parameter that indicates whether opcode
argument is in ar or in mr.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 186 +++++++++++++++++++++++-----------------------
 1 file changed, 92 insertions(+), 94 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 253777468c29..065e3d01427b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -79,6 +79,7 @@ struct DisasContext {
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_R[16];
 static TCGv_i32 cpu_FR[16];
+static TCGv_i32 cpu_MR[4];
 static TCGv_i32 cpu_SR[256];
 static TCGv_i32 cpu_UR[256];
 static TCGv_i32 cpu_windowbase_next;
@@ -223,6 +224,9 @@ void xtensa_translate_init(void)
         "f8", "f9", "f10", "f11",
         "f12", "f13", "f14", "f15",
     };
+    static const char * const mregnames[] = {
+        "m0", "m1", "m2", "m3",
+    };
     int i;
 
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
@@ -230,14 +234,22 @@ void xtensa_translate_init(void)
 
     for (i = 0; i < 16; i++) {
         cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
-                offsetof(CPUXtensaState, regs[i]),
-                regnames[i]);
+                                          offsetof(CPUXtensaState, regs[i]),
+                                          regnames[i]);
     }
 
     for (i = 0; i < 16; i++) {
         cpu_FR[i] = tcg_global_mem_new_i32(cpu_env,
-                offsetof(CPUXtensaState, fregs[i].f32[FP_F32_LOW]),
-                fregnames[i]);
+                                           offsetof(CPUXtensaState,
+                                                    fregs[i].f32[FP_F32_LOW]),
+                                           fregnames[i]);
+    }
+
+    for (i = 0; i < 4; i++) {
+        cpu_MR[i] = tcg_global_mem_new_i32(cpu_env,
+                                           offsetof(CPUXtensaState,
+                                                    sregs[MR + i]),
+                                           mregnames[i]);
     }
 
     for (i = 0; i < 256; ++i) {
@@ -269,6 +281,8 @@ void **xtensa_get_regfile_by_name(const char *name)
         g_hash_table_insert(xtensa_regfile_table,
                             (void *)"AR", (void *)cpu_R);
         g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"MR", (void *)cpu_MR);
+        g_hash_table_insert(xtensa_regfile_table,
                             (void *)"FR", (void *)cpu_FR);
     }
     return (void **)g_hash_table_lookup(xtensa_regfile_table, (void *)name);
@@ -1943,24 +1957,12 @@ enum {
     MAC16_XH = 0x2,
 };
 
-enum {
-    MAC16_AA,
-    MAC16_AD,
-    MAC16_DA,
-    MAC16_DD,
-
-    MAC16_XD = 0x1,
-    MAC16_DX = 0x2,
-};
-
 static void translate_mac16(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
     int op = par[0];
-    bool is_m1_sr = par[1] & MAC16_DX;
-    bool is_m2_sr = par[1] & MAC16_XD;
-    unsigned half = par[2];
-    uint32_t ld_offset = par[3];
+    unsigned half = par[1];
+    uint32_t ld_offset = par[2];
     unsigned off = ld_offset ? 2 : 0;
     TCGv_i32 vaddr = tcg_temp_new_i32();
     TCGv_i32 mem32 = tcg_temp_new_i32();
@@ -1971,13 +1973,9 @@ static void translate_mac16(DisasContext *dc, const OpcodeArg arg[],
         tcg_gen_qemu_ld32u(mem32, vaddr, dc->cring);
     }
     if (op != MAC16_NONE) {
-        TCGv_i32 m1 = gen_mac16_m(is_m1_sr ?
-                                  cpu_SR[MR + arg[off].imm] :
-                                  arg[off].in,
+        TCGv_i32 m1 = gen_mac16_m(arg[off].in,
                                   half & MAC16_HX, op == MAC16_UMUL);
-        TCGv_i32 m2 = gen_mac16_m(is_m2_sr ?
-                                  cpu_SR[MR + arg[off + 1].imm] :
-                                  arg[off + 1].in,
+        TCGv_i32 m2 = gen_mac16_m(arg[off + 1].in,
                                   half & MAC16_XH, op == MAC16_UMUL);
 
         if (op == MAC16_MUL || op == MAC16_UMUL) {
@@ -3100,11 +3098,11 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_NONE, 0, 0, -4},
+        .par = (const uint32_t[]){MAC16_NONE, 0, -4},
     }, {
         .name = "ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_NONE, 0, 0, 4},
+        .par = (const uint32_t[]){MAC16_NONE, 0, 4},
     }, {
         .name = "ldpte",
         .op_flags = XTENSA_OP_ILL,
@@ -3187,67 +3185,67 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "mul.aa.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_HH, 0},
     }, {
         .name = "mul.aa.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_HL, 0},
     }, {
         .name = "mul.aa.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_LH, 0},
     }, {
         .name = "mul.aa.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_AA, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_LL, 0},
     }, {
         .name = "mul.ad.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_HH, 0},
     }, {
         .name = "mul.ad.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_HL, 0},
     }, {
         .name = "mul.ad.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_LH, 0},
     }, {
         .name = "mul.ad.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_AD, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_LL, 0},
     }, {
         .name = "mul.da.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_HH, 0},
     }, {
         .name = "mul.da.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_HL, 0},
     }, {
         .name = "mul.da.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_LH, 0},
     }, {
         .name = "mul.da.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_DA, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_LL, 0},
     }, {
         .name = "mul.dd.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_DD, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_HH, 0},
     }, {
         .name = "mul.dd.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_DD, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_HL, 0},
     }, {
         .name = "mul.dd.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_DD, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_LH, 0},
     }, {
         .name = "mul.dd.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MUL, MAC16_DD, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MUL, MAC16_LL, 0},
     }, {
         .name = "mul16s",
         .translate = translate_mul16,
@@ -3259,198 +3257,198 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "mula.aa.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HH, 0},
     }, {
         .name = "mula.aa.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HL, 0},
     }, {
         .name = "mula.aa.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LH, 0},
     }, {
         .name = "mula.aa.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_AA, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LL, 0},
     }, {
         .name = "mula.ad.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HH, 0},
     }, {
         .name = "mula.ad.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HL, 0},
     }, {
         .name = "mula.ad.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LH, 0},
     }, {
         .name = "mula.ad.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_AD, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LL, 0},
     }, {
         .name = "mula.da.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HH, 0},
     }, {
         .name = "mula.da.hh.lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, -4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HH, -4},
     }, {
         .name = "mula.da.hh.ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HH, 4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HH, 4},
     }, {
         .name = "mula.da.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HL, 0},
     }, {
         .name = "mula.da.hl.lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, -4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HL, -4},
     }, {
         .name = "mula.da.hl.ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_HL, 4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HL, 4},
     }, {
         .name = "mula.da.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LH, 0},
     }, {
         .name = "mula.da.lh.lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, -4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LH, -4},
     }, {
         .name = "mula.da.lh.ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LH, 4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LH, 4},
     }, {
         .name = "mula.da.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LL, 0},
     }, {
         .name = "mula.da.ll.lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, -4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LL, -4},
     }, {
         .name = "mula.da.ll.ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DA, MAC16_LL, 4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LL, 4},
     }, {
         .name = "mula.dd.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HH, 0},
     }, {
         .name = "mula.dd.hh.lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, -4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HH, -4},
     }, {
         .name = "mula.dd.hh.ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HH, 4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HH, 4},
     }, {
         .name = "mula.dd.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HL, 0},
     }, {
         .name = "mula.dd.hl.lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, -4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HL, -4},
     }, {
         .name = "mula.dd.hl.ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_HL, 4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_HL, 4},
     }, {
         .name = "mula.dd.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LH, 0},
     }, {
         .name = "mula.dd.lh.lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, -4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LH, -4},
     }, {
         .name = "mula.dd.lh.ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LH, 4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LH, 4},
     }, {
         .name = "mula.dd.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LL, 0},
     }, {
         .name = "mula.dd.ll.lddec",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, -4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LL, -4},
     }, {
         .name = "mula.dd.ll.ldinc",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULA, MAC16_DD, MAC16_LL, 4},
+        .par = (const uint32_t[]){MAC16_MULA, MAC16_LL, 4},
     }, {
         .name = "mull",
         .translate = translate_mull,
     }, {
         .name = "muls.aa.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_HH, 0},
     }, {
         .name = "muls.aa.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_HL, 0},
     }, {
         .name = "muls.aa.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_LH, 0},
     }, {
         .name = "muls.aa.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_AA, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_LL, 0},
     }, {
         .name = "muls.ad.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_HH, 0},
     }, {
         .name = "muls.ad.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_HL, 0},
     }, {
         .name = "muls.ad.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_LH, 0},
     }, {
         .name = "muls.ad.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_AD, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_LL, 0},
     }, {
         .name = "muls.da.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_HH, 0},
     }, {
         .name = "muls.da.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_HL, 0},
     }, {
         .name = "muls.da.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_LH, 0},
     }, {
         .name = "muls.da.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_DA, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_LL, 0},
     }, {
         .name = "muls.dd.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_DD, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_HH, 0},
     }, {
         .name = "muls.dd.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_DD, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_HL, 0},
     }, {
         .name = "muls.dd.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_DD, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_LH, 0},
     }, {
         .name = "muls.dd.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_MULS, MAC16_DD, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_MULS, MAC16_LL, 0},
     }, {
         .name = "mulsh",
         .translate = translate_mulh,
@@ -4160,19 +4158,19 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "umul.aa.hh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_HH, 0},
+        .par = (const uint32_t[]){MAC16_UMUL, MAC16_HH, 0},
     }, {
         .name = "umul.aa.hl",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_HL, 0},
+        .par = (const uint32_t[]){MAC16_UMUL, MAC16_HL, 0},
     }, {
         .name = "umul.aa.lh",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_LH, 0},
+        .par = (const uint32_t[]){MAC16_UMUL, MAC16_LH, 0},
     }, {
         .name = "umul.aa.ll",
         .translate = translate_mac16,
-        .par = (const uint32_t[]){MAC16_UMUL, MAC16_AA, MAC16_LL, 0},
+        .par = (const uint32_t[]){MAC16_UMUL, MAC16_LL, 0},
     }, {
         .name = "waiti",
         .translate = translate_waiti,
-- 
2.11.0
