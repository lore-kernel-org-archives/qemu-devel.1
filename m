Received: from eggs.gnu.org ([209.51.188.92]:44660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPM-0004Ic-Dn
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPJ-0001nm-TP
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:23 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzoPH-0001iJ-Pe
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:20 -0500
Received: by mail-pg1-x542.google.com with SMTP id u9so11929339pgo.7
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 12:05:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Mar 2019 12:04:59 -0800
Message-Id: <20190301200501.16533-9-richard.henderson@linaro.org>
In-Reply-To: <20190301200501.16533-1-richard.henderson@linaro.org>
References: <20190301200501.16533-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 08/10] target/arm: Implement ARMv8.5-CondM
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

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Update ID_AA64ISAR0.TS.
---
 target/arm/cpu.h           |  5 ++++
 target/arm/cpu64.c         |  2 +-
 target/arm/translate-a64.c | 58 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fc2909ea6d..a7aaec63d7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3436,6 +3436,11 @@ static inline bool isar_feature_aa64_condm_4(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) != 0;
 }
 
+static inline bool isar_feature_aa64_condm_5(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) >= 2;
+}
+
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index fcf79321e2..9fe0844a82 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -309,7 +309,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);
-        t = FIELD_DP64(t, ID_AA64ISAR0, TS, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2); /* v8.5-CondM */
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 49a09b58e3..c2b9e800c8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1646,6 +1646,48 @@ static void handle_sync(DisasContext *s, uint32_t insn,
     }
 }
 
+static void gen_xaflag(void)
+{
+    TCGv_i32 z = tcg_temp_new_i32();
+
+    tcg_gen_setcondi_i32(TCG_COND_EQ, z, cpu_ZF, 0);
+
+    /*
+     * (!C & !Z) << 31
+     * (!(C | Z)) << 31
+     * ~((C | Z) << 31)
+     * ~-(C | Z)
+     * (C | Z) - 1
+     */
+    tcg_gen_or_i32(cpu_NF, cpu_CF, z);
+    tcg_gen_subi_i32(cpu_NF, cpu_NF, 1);
+
+    /* !(Z & C) */
+    tcg_gen_and_i32(cpu_ZF, z, cpu_CF);
+    tcg_gen_xori_i32(cpu_ZF, cpu_ZF, 1);
+
+    /* (!C & Z) << 31 -> -(Z & ~C) */
+    tcg_gen_andc_i32(cpu_VF, z, cpu_CF);
+    tcg_gen_neg_i32(cpu_VF, cpu_VF);
+
+    /* C | Z */
+    tcg_gen_or_i32(cpu_CF, cpu_CF, z);
+
+    tcg_temp_free_i32(z);
+}
+
+static void gen_axflag(void)
+{
+    tcg_gen_sari_i32(cpu_VF, cpu_VF, 31);         /* V ? -1 : 0 */
+    tcg_gen_andc_i32(cpu_CF, cpu_CF, cpu_VF);     /* C & !V */
+
+    /* !(Z | V) -> !(!ZF | V) -> ZF & !V -> ZF & ~VF */
+    tcg_gen_andc_i32(cpu_ZF, cpu_ZF, cpu_VF);
+
+    tcg_gen_movi_i32(cpu_NF, 0);
+    tcg_gen_movi_i32(cpu_VF, 0);
+}
+
 /* MSR (immediate) - move immediate to processor state field */
 static void handle_msr_i(DisasContext *s, uint32_t insn,
                          unsigned int op1, unsigned int op2, unsigned int crm)
@@ -1665,6 +1707,22 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         s->base.is_jmp = DISAS_NEXT;
         break;
 
+    case 0x01: /* XAFlag */
+        if (crm != 0 || !dc_isar_feature(aa64_condm_5, s)) {
+            goto do_unallocated;
+        }
+        gen_xaflag();
+        s->base.is_jmp = DISAS_NEXT;
+        break;
+
+    case 0x02: /* AXFlag */
+        if (crm != 0 || !dc_isar_feature(aa64_condm_5, s)) {
+            goto do_unallocated;
+        }
+        gen_axflag();
+        s->base.is_jmp = DISAS_NEXT;
+        break;
+
     case 0x05: /* SPSel */
         if (s->current_el == 0) {
             goto do_unallocated;
-- 
2.17.2
