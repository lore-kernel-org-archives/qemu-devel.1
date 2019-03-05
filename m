Received: from eggs.gnu.org ([209.51.188.92]:54498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHQ-0001WZ-Fi
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHP-0000iT-FU
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:00 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHP-0000gO-6v
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:59 -0500
Received: by mail-wr1-x433.google.com with SMTP id w2so10237116wrt.11
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:50:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.50.56
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:50:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:32 +0000
Message-Id: <20190305165051.26860-4-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/22] target/arm: Implement ARMv8.0-SB
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190301200501.16533-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           | 10 ++++++++++
 linux-user/elfload.c       |  1 +
 target/arm/cpu.c           |  1 +
 target/arm/cpu64.c         |  2 ++
 target/arm/translate-a64.c | 14 ++++++++++++++
 target/arm/translate.c     | 22 ++++++++++++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 67b06bfad09..361e51143c7 100644
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
index b9f7cbbdc17..6cfebe1446d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -604,6 +604,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
     GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
     GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
+    GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
 
 #undef GET_FEATURE_ID
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 54b61f917be..ef069c268df 100644
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
index 1b0c427277b..6788c0f6ff7 100644
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
index d3c8eaf0893..4aa5a307e41 100644
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
index ad879e3480c..9f71206f857 100644
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
2.20.1
