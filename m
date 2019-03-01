Received: from eggs.gnu.org ([209.51.188.92]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPH-0004At-Pq
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzoPF-0001jA-P1
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:19 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzoP9-0001cf-UQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:05:15 -0500
Received: by mail-pg1-x543.google.com with SMTP id m2so11930978pgl.5
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 12:05:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Mar 2019 12:04:53 -0800
Message-Id: <20190301200501.16533-3-richard.henderson@linaro.org>
In-Reply-To: <20190301200501.16533-1-richard.henderson@linaro.org>
References: <20190301200501.16533-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 02/10] target/arm: Implement ARMv8.0-SB
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
index 67b06bfad0..361e51143c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3307,6 +3307,11 @@ static inline bool isar_feature_aa32_fhm(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar6, ID_ISAR6, FHM) != 0;
 }
 
+static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, SB) != 0;
+}
+
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
     /*
@@ -3445,6 +3450,11 @@ static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
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
index b9f7cbbdc1..6cfebe1446 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -604,6 +604,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
     GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
     GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
+    GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
 
 #undef GET_FEATURE_ID
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 54b61f917b..ef069c268d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2021,6 +2021,7 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
             t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
+            t = FIELD_DP32(t, ID_ISAR6, SB, 1);
             cpu->isar.id_isar6 = t;
 
             t = cpu->id_mmfr4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1b0c427277..6788c0f6ff 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -318,6 +318,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
@@ -349,6 +350,7 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
         u = FIELD_DP32(u, ID_ISAR6, FHM, 1);
+        u = FIELD_DP32(u, ID_ISAR6, SB, 1);
         cpu->isar.id_isar6 = u;
 
         /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d3c8eaf089..4aa5a307e4 100644
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
index 8f7f5b95aa..61adefb328 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9282,6 +9282,17 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -11900,6 +11911,17 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
