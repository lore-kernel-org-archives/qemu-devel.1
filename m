Received: from eggs.gnu.org ([209.51.188.92]:54558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHW-0001a1-BF
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHV-0000qY-60
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHU-0000pG-UA
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id q187so3269226wme.5
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.02
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:37 +0000
Message-Id: <20190305165051.26860-9-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/22] target/arm: Implement ARMv8.4-CondM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190301200501.16533-8-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fixed up block comment style]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  5 ++
 linux-user/elfload.c       |  1 +
 target/arm/cpu64.c         |  1 +
 target/arm/translate-a64.c | 99 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c822f94236c..fc2909ea6dc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3431,6 +3431,11 @@ static inline bool isar_feature_aa64_fhm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, FHM) != 0;
 }
 
+static inline bool isar_feature_aa64_condm_4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) != 0;
+}
+
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6cfebe1446d..6e8762b40de 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -605,6 +605,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
     GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
+    GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
 
 #undef GET_FEATURE_ID
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 87337b63855..fcf79321e2f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -309,6 +309,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, TS, 1);
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 12d2649c204..3cc9a99a9cb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1657,6 +1657,14 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
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
@@ -1710,7 +1718,6 @@ static void gen_get_nzcv(TCGv_i64 tcg_rt)
 }
 
 static void gen_set_nzcv(TCGv_i64 tcg_rt)
-
 {
     TCGv_i32 nzcv = tcg_temp_new_i32();
 
@@ -4529,6 +4536,84 @@ static void disas_adc_sbc(DisasContext *s, uint32_t insn)
     }
 }
 
+/*
+ * Rotate right into flags
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
+/*
+ * Evaluate into flags
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
@@ -5195,6 +5280,18 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
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
2.20.1
