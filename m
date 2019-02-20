Received: from eggs.gnu.org ([209.51.188.92]:48859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwbde-000722-Cv
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwbdU-0005b0-SE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:48 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwbdT-00040U-Qs
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:44 -0500
Received: by mail-pf1-x441.google.com with SMTP id v21so9736907pfm.12
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 15:50:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Feb 2019 15:50:16 -0800
Message-Id: <20190220235017.1060-2-richard.henderson@linaro.org>
In-Reply-To: <20190220235017.1060-1-richard.henderson@linaro.org>
References: <20190220235017.1060-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Implement ARMv8.0-SB
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
 target/arm/cpu.h           | 10 ++++++++++
 linux-user/elfload.c       |  1 +
 target/arm/cpu.c           |  1 +
 target/arm/cpu64.c         |  2 ++
 target/arm/translate-a64.c | 14 ++++++++++++++
 target/arm/translate.c     | 22 ++++++++++++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0480f9baba..76d6a73c0e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3302,6 +3302,11 @@ static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
 }
 
+static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, SB) != 0;
+}
+
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
     /*
@@ -3405,6 +3410,11 @@ static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
              FIELD_DP64(0, ID_AA64ISAR1, GPI, 0xf))) != 0;
 }
 
+static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ef7138839d..02ba705e73 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -603,6 +603,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
     GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
+    GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
 
 #undef GET_FEATURE_ID
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a5599ae19f..5cd27f2f64 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2027,6 +2027,7 @@ static void arm_max_initfn(Object *obj)
 
             t = cpu->isar.id_isar6;
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
+            t = FIELD_DP32(t, ID_ISAR6, SB, 1);
             cpu->isar.id_isar6 = t;
 
             t = cpu->id_mmfr4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index fc54734256..95c6ee4cda 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -343,6 +343,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
@@ -373,6 +374,7 @@ static void aarch64_max_initfn(Object *obj)
 
         u = cpu->isar.id_isar6;
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
+        u = FIELD_DP32(u, ID_ISAR6, SB, 1);
         cpu->isar.id_isar6 = u;
 
         /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1d9bf81c0e..40c4f2fe54 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1638,7 +1638,21 @@ static void handle_sync(DisasContext *s, uint32_t insn,
         reset_btype(s);
         gen_goto_tb(s, 0, s->pc);
         return;
+
+    case 7: /* SB */
+        if (crm != 0 || !dc_isar_feature(aa64_sb, s)) {
+            goto do_unallocated;
+        }
+        /*
+         * TODO: There is no speculation barrier opcode for TCG;
+         * MB and end the TB instead.
+         */
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+        s->base.is_jmp = DISAS_TOO_MANY;
+        return;
+
     default:
+    do_unallocated:
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 92f0c8d557..796ba2df43 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9192,6 +9192,17 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  */
                 gen_goto_tb(s, 0, s->pc & ~1);
                 return;
+            case 7: /* sb */
+                if (!dc_isar_feature(aa32_sb, s)) {
+                    goto illegal_op;
+                }
+                /*
+                 * TODO: There is no speculation barrier opcode
+                 * for TCG; MB and end the TB instead.
+                 */
+                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+                s->base.is_jmp = DISAS_TOO_MANY;
+                return;
             default:
                 goto illegal_op;
             }
@@ -11810,6 +11821,17 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              */
                             gen_goto_tb(s, 0, s->pc & ~1);
                             break;
+                        case 7: /* sb */
+                            if (!dc_isar_feature(aa32_sb, s)) {
+                                goto illegal_op;
+                            }
+                            /*
+                             * TODO: There is no speculation barrier opcode
+                             * for TCG; MB and end the TB instead.
+                             */
+                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+                            s->base.is_jmp = DISAS_TOO_MANY;
+                            break;
                         default:
                             goto illegal_op;
                         }
-- 
2.17.2
