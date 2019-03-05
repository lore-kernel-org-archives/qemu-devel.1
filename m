Received: from eggs.gnu.org ([209.51.188.92]:54571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHX-0001aH-4k
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHW-0000rN-69
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:07 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHV-0000qe-VB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:06 -0500
Received: by mail-wr1-x42b.google.com with SMTP id w6so10241974wrs.4
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.03
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:38 +0000
Message-Id: <20190305165051.26860-10-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/22] target/arm: Implement ARMv8.5-CondM
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
Message-id: 20190301200501.16533-9-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  5 ++++
 target/arm/cpu64.c         |  2 +-
 target/arm/translate-a64.c | 58 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fc2909ea6dc..a7aaec63d74 100644
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
index fcf79321e2f..9fe0844a828 100644
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
index 3cc9a99a9cb..0cfd07d3abd 100644
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
2.20.1
