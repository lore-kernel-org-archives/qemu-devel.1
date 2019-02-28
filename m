Received: from eggs.gnu.org ([209.51.188.92]:43948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzBN8-0003OJ-JV
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzBN0-00055X-KP
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:23 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzBN0-00054M-Av
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:22 -0500
Received: by mail-pl1-x644.google.com with SMTP id q3so8959335pll.4
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 18:24:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 18:24:14 -0800
Message-Id: <20190228022415.27878-3-richard.henderson@linaro.org>
In-Reply-To: <20190228022415.27878-1-richard.henderson@linaro.org>
References: <20190228022415.27878-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/3] target/arm: Implement ARMv8.0-SB
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
index 9a4c56826a..1a6ca35ea7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3289,6 +3289,11 @@ static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
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
@@ -3387,6 +3392,11 @@ static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
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
index 3a50d587ff..b7484f6d82 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -602,6 +602,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
     GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
     GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
+    GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
 
 #undef GET_FEATURE_ID
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8ea6569088..7940d49c1d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2003,6 +2003,7 @@ static void arm_max_initfn(Object *obj)
             t = cpu->isar.id_isar6;
             t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
+            t = FIELD_DP32(t, ID_ISAR6, SB, 1);
             cpu->isar.id_isar6 = t;
 
             t = cpu->id_mmfr4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 69e4134f79..168aa9e0f1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -317,6 +317,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
@@ -347,6 +348,7 @@ static void aarch64_max_initfn(Object *obj)
         u = cpu->isar.id_isar6;
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
+        u = FIELD_DP32(u, ID_ISAR6, SB, 1);
         cpu->isar.id_isar6 = u;
 
         /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c56e878787..7c00d084ce 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1637,7 +1637,21 @@ static void handle_sync(DisasContext *s, uint32_t insn,
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
+        gen_goto_tb(s, 0, s->pc);
+        return;
+
     default:
+    do_unallocated:
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c1175798ac..b86086ada9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9208,6 +9208,17 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  */
                 gen_goto_tb(s, 0, s->pc & ~1);
                 return;
+            case 7: /* sb */
+                if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
+                    goto illegal_op;
+                }
+                /*
+                 * TODO: There is no speculation barrier opcode
+                 * for TCG; MB and end the TB instead.
+                 */
+                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+                gen_goto_tb(s, 0, s->pc & ~1);
+                return;
             default:
                 goto illegal_op;
             }
@@ -11826,6 +11837,17 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              */
                             gen_goto_tb(s, 0, s->pc & ~1);
                             break;
+                        case 7: /* sb */
+                            if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
+                                goto illegal_op;
+                            }
+                            /*
+                             * TODO: There is no speculation barrier opcode
+                             * for TCG; MB and end the TB instead.
+                             */
+                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+                            gen_goto_tb(s, 0, s->pc & ~1);
+                            break;
                         default:
                             goto illegal_op;
                         }
-- 
2.17.2
