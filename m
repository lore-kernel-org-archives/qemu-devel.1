Received: from eggs.gnu.org ([209.51.188.92]:43782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwK44-0003tM-QQ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwK43-0004y1-9Q
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:05:00 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwK42-0004x7-UD
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:04:59 -0500
Received: by mail-pg1-x544.google.com with SMTP id m1so11228768pgq.8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 21:04:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 21:04:50 -0800
Message-Id: <20190220050451.10939-3-richard.henderson@linaro.org>
In-Reply-To: <20190220050451.10939-1-richard.henderson@linaro.org>
References: <20190220050451.10939-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/3] target/arm: Implement ARMv8.4-CondM
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 ++
 linux-user/elfload.c       |  1 +
 target/arm/cpu64.c         |  1 +
 target/arm/translate-a64.c | 97 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f8ff795dcf..000e778619 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3375,6 +3375,11 @@ static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
 }
 
+static inline bool isar_feature_aa64_condm_4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) != 0;
+}
+
 static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3a50d587ff..ef7138839d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -602,6 +602,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
     GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
     GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
+    GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
 
 #undef GET_FEATURE_ID
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7bd761b8f5..27b95ef787 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -334,6 +334,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, TS, 1);
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0e16487be0..b88eccef53 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1655,6 +1655,14 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
     s->base.is_jmp = DISAS_TOO_MANY;
 
     switch (op) {
+    case 0x00: /* CFINV */
+        if (crm != 0 || !dc_isar_feature(aa64_condm_4, s)) {
+            goto do_unallocated;
+        }
+        tcg_gen_xori_i32(cpu_CF, cpu_CF, 1);
+        s->base.is_jmp = DISAS_NEXT;
+        break;
+
     case 0x05: /* SPSel */
         if (s->current_el == 0) {
             goto do_unallocated;
@@ -1719,7 +1727,6 @@ static void gen_get_nzcv(TCGv_i64 tcg_rt)
 }
 
 static void gen_set_nzcv(TCGv_i64 tcg_rt)
-
 {
     TCGv_i32 nzcv = tcg_temp_new_i32();
 
@@ -4729,6 +4736,82 @@ static void disas_adc_sbc(DisasContext *s, uint32_t insn)
     }
 }
 
+/* Rotate right into flags
+ *  31 30 29                21       15          10      5  4      0
+ * +--+--+--+-----------------+--------+-----------+------+--+------+
+ * |sf|op| S| 1 1 0 1 0 0 0 0 |  imm6  | 0 0 0 0 1 |  Rn  |o2| mask |
+ * +--+--+--+-----------------+--------+-----------+------+--+------+
+ */
+static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
+{
+    int mask = extract32(insn, 0, 4);
+    int o2 = extract32(insn, 4, 1);
+    int rn = extract32(insn, 5, 5);
+    int imm6 = extract32(insn, 15, 6);
+    int sf_op_s = extract32(insn, 29, 3);
+    TCGv_i64 tcg_rn;
+    TCGv_i32 nzcv;
+
+    if (sf_op_s != 5 || o2 != 0 || !dc_isar_feature(aa64_condm_4, s)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    tcg_rn = read_cpu_reg(s, rn, 1);
+    tcg_gen_rotri_i64(tcg_rn, tcg_rn, imm6);
+
+    nzcv = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(nzcv, tcg_rn);
+
+    if (mask & 8) { /* N */
+        tcg_gen_shli_i32(cpu_NF, nzcv, 31 - 3);
+    }
+    if (mask & 4) { /* Z */
+        tcg_gen_not_i32(cpu_ZF, nzcv);
+        tcg_gen_andi_i32(cpu_ZF, cpu_ZF, 4);
+    }
+    if (mask & 2) { /* C */
+        tcg_gen_extract_i32(cpu_CF, nzcv, 1, 1);
+    }
+    if (mask & 1) { /* V */
+        tcg_gen_shli_i32(cpu_VF, nzcv, 31 - 0);
+    }
+
+    tcg_temp_free_i32(nzcv);
+}
+
+/* Evaluate into flags
+ *  31 30 29                21        15   14        10      5  4      0
+ * +--+--+--+-----------------+---------+----+---------+------+--+------+
+ * |sf|op| S| 1 1 0 1 0 0 0 0 | opcode2 | sz | 0 0 1 0 |  Rn  |o3| mask |
+ * +--+--+--+-----------------+---------+----+---------+------+--+------+
+ */
+static void disas_evaluate_into_flags(DisasContext *s, uint32_t insn)
+{
+    int o3_mask = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    int o2 = extract32(insn, 15, 6);
+    int sz = extract32(insn, 14, 1);
+    int sf_op_s = extract32(insn, 29, 3);
+    TCGv_i32 tmp;
+    int shift;
+
+    if (sf_op_s != 1 || o2 != 0 || o3_mask != 0xd ||
+        !dc_isar_feature(aa64_condm_4, s)) {
+        unallocated_encoding(s);
+        return;
+    }
+    shift = sz ? 16 : 24;  /* SETF16 or SETF8 */
+
+    tmp = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(tmp, cpu_reg(s, rn));
+    tcg_gen_shli_i32(cpu_NF, tmp, shift);
+    tcg_gen_shli_i32(cpu_VF, tmp, shift - 1);
+    tcg_gen_mov_i32(cpu_ZF, cpu_NF);
+    tcg_gen_xor_i32(cpu_VF, cpu_VF, cpu_NF);
+    tcg_temp_free_i32(tmp);
+}
+
 /* Conditional compare (immediate / register)
  *  31 30 29 28 27 26 25 24 23 22 21  20    16 15  12  11  10  9   5  4 3   0
  * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
@@ -5428,6 +5511,18 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
             disas_adc_sbc(s, insn);
             break;
 
+        case 0x01: /* Rotate right into flags */
+        case 0x21:
+            disas_rotate_right_into_flags(s, insn);
+            break;
+
+        case 0x02: /* Evaluate into flags */
+        case 0x12:
+        case 0x22:
+        case 0x32:
+            disas_evaluate_into_flags(s, insn);
+            break;
+
         default:
             goto do_unallocated;
         }
-- 
2.17.2
