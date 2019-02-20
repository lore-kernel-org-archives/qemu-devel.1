Received: from eggs.gnu.org ([209.51.188.92]:43786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwK45-0003tV-FB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwK44-0004zl-1A
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:05:01 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwK43-0004xX-K1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:04:59 -0500
Received: by mail-pg1-x542.google.com with SMTP id y4so11231762pgc.12
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 21:04:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 21:04:51 -0800
Message-Id: <20190220050451.10939-4-richard.henderson@linaro.org>
In-Reply-To: <20190220050451.10939-1-richard.henderson@linaro.org>
References: <20190220050451.10939-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] target/arm: Implement ARMv8.5-CondM
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
 target/arm/cpu.h           |  5 ++++
 target/arm/translate-a64.c | 58 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 000e778619..0480f9baba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3380,6 +3380,11 @@ static inline bool isar_feature_aa64_condm_4(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) != 0;
 }
 
+static inline bool isar_feature_aa64_condm_5(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) >= 2;
+}
+
 static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b88eccef53..1d9bf81c0e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1644,6 +1644,48 @@ static void handle_sync(DisasContext *s, uint32_t insn,
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
@@ -1663,6 +1705,22 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
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
