Received: from eggs.gnu.org ([209.51.188.92]:55894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gjkuq-0004ur-08
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gjkuT-0002Jn-V5
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:22 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54220 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gjkuS-0008H4-Vh
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:09 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 16 Jan 2019 14:05:49 +0100
Message-Id: <1547643949-10776-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547643949-10776-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547643949-10776-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/3] target/mips: Rename 'rn' to 'register_name'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, arikalo@wavecomp.com, aurelien@aurel32.net

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename 'rn' to 'register_name' in CP0-related handlers.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 858 ++++++++++++++++++++++++------------------------
 1 file changed, 432 insertions(+), 426 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index b0b926f..ca4e815 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6474,7 +6474,7 @@ static inline void gen_mtc0_store32 (TCGv arg, target_ulong off)
 
 static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
-    const char *rn = "invalid";
+    const char *register_name = "invalid";
 
     switch (reg) {
     case CPO_REGISTER_02:
@@ -6482,7 +6482,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0));
-            rn = "EntryLo0";
+            register_name = "EntryLo0";
             break;
         default:
             goto cp0_unimplemented;
@@ -6493,7 +6493,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1));
-            rn = "EntryLo1";
+            register_name = "EntryLo1";
             break;
         default:
             goto cp0_unimplemented;
@@ -6504,7 +6504,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->saar);
             gen_helper_mfhc0_saar(arg, cpu_env);
-            rn = "SAAR";
+            register_name = "SAAR";
             break;
         default:
             goto cp0_unimplemented;
@@ -6515,12 +6515,12 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             gen_mfhc0_load64(arg, offsetof(CPUMIPSState, lladdr),
                              ctx->CP0_LLAddr_shift);
-            rn = "LLAddr";
+            register_name = "LLAddr";
             break;
         case 1:
             CP0_CHECK(ctx->mrp);
             gen_helper_mfhc0_maar(arg, cpu_env);
-            rn = "MAAR";
+            register_name = "MAAR";
             break;
         default:
             goto cp0_unimplemented;
@@ -6533,7 +6533,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 4:
         case 6:
             gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_TagLo), 0);
-            rn = "TagLo";
+            register_name = "TagLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -6542,17 +6542,18 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-    trace_mips_translate_c0("mfhc0", rn, reg, sel);
+    trace_mips_translate_c0("mfhc0", register_name, reg, sel);
     return;
 
 cp0_unimplemented:
-    qemu_log_mask(LOG_UNIMP, "mfhc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mfhc0 %s (reg %d sel %d)\n",
+                  register_name, reg, sel);
     tcg_gen_movi_tl(arg, 0);
 }
 
 static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
-    const char *rn = "invalid";
+    const char *register_name = "invalid";
     uint64_t mask = ctx->PAMask >> 36;
 
     switch (reg) {
@@ -6562,7 +6563,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             tcg_gen_andi_tl(arg, arg, mask);
             gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0));
-            rn = "EntryLo0";
+            register_name = "EntryLo0";
             break;
         default:
             goto cp0_unimplemented;
@@ -6574,7 +6575,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             tcg_gen_andi_tl(arg, arg, mask);
             gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1));
-            rn = "EntryLo1";
+            register_name = "EntryLo1";
             break;
         default:
             goto cp0_unimplemented;
@@ -6585,7 +6586,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->saar);
             gen_helper_mthc0_saar(cpu_env, arg);
-            rn = "SAAR";
+            register_name = "SAAR";
             break;
         default:
             goto cp0_unimplemented;
@@ -6597,12 +6598,12 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                supported); the CP0_LLAddr_rw_bitmask does not seem to be
                relevant for modern MIPS cores supporting MTHC0, therefore
                treating MTHC0 to LLAddr as NOP. */
-            rn = "LLAddr";
+            register_name = "LLAddr";
             break;
         case 1:
             CP0_CHECK(ctx->mrp);
             gen_helper_mthc0_maar(cpu_env, arg);
-            rn = "MAAR";
+            register_name = "MAAR";
             break;
         default:
             goto cp0_unimplemented;
@@ -6616,7 +6617,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 6:
             tcg_gen_andi_tl(arg, arg, mask);
             gen_mthc0_store64(arg, offsetof(CPUMIPSState, CP0_TagLo));
-            rn = "TagLo";
+            register_name = "TagLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -6625,10 +6626,11 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-    trace_mips_translate_c0("mthc0", rn, reg, sel);
+    trace_mips_translate_c0("mthc0", register_name, reg, sel);
 
 cp0_unimplemented:
-    qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n",
+                  register_name, reg, sel);
 }
 
 static inline void gen_mfc0_unimplemented(DisasContext *ctx, TCGv arg)
@@ -6642,7 +6644,7 @@ static inline void gen_mfc0_unimplemented(DisasContext *ctx, TCGv arg)
 
 static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
-    const char *rn = "invalid";
+    const char *register_name = "invalid";
 
     if (sel != 0)
         check_insn(ctx, ISA_MIPS32);
@@ -6652,27 +6654,27 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
-            rn = "Index";
+            register_name = "Index";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpcontrol(arg, cpu_env);
-            rn = "MVPControl";
+            register_name = "MVPControl";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpconf0(arg, cpu_env);
-            rn = "MVPConf0";
+            register_name = "MVPConf0";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpconf1(arg, cpu_env);
-            rn = "MVPConf1";
+            register_name = "MVPConf1";
             break;
         case 4:
             CP0_CHECK(ctx->vp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPControl));
-            rn = "VPControl";
+            register_name = "VPControl";
             break;
         default:
             goto cp0_unimplemented;
@@ -6683,42 +6685,42 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
             gen_helper_mfc0_random(arg, cpu_env);
-            rn = "Random";
+            register_name = "Random";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEControl));
-            rn = "VPEControl";
+            register_name = "VPEControl";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf0));
-            rn = "VPEConf0";
+            register_name = "VPEConf0";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf1));
-            rn = "VPEConf1";
+            register_name = "VPEConf1";
             break;
         case 4:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_YQMask));
-            rn = "YQMask";
+            register_name = "YQMask";
             break;
         case 5:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_VPESchedule));
-            rn = "VPESchedule";
+            register_name = "VPESchedule";
             break;
         case 6:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load64(arg, offsetof(CPUMIPSState, CP0_VPEScheFBack));
-            rn = "VPEScheFBack";
+            register_name = "VPEScheFBack";
             break;
         case 7:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEOpt));
-            rn = "VPEOpt";
+            register_name = "VPEOpt";
             break;
         default:
             goto cp0_unimplemented;
@@ -6741,42 +6743,42 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_move_low32(arg, tmp);
                 tcg_temp_free_i64(tmp);
             }
-            rn = "EntryLo0";
+            register_name = "EntryLo0";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcstatus(arg, cpu_env);
-            rn = "TCStatus";
+            register_name = "TCStatus";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcbind(arg, cpu_env);
-            rn = "TCBind";
+            register_name = "TCBind";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcrestart(arg, cpu_env);
-            rn = "TCRestart";
+            register_name = "TCRestart";
             break;
         case 4:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tchalt(arg, cpu_env);
-            rn = "TCHalt";
+            register_name = "TCHalt";
             break;
         case 5:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tccontext(arg, cpu_env);
-            rn = "TCContext";
+            register_name = "TCContext";
             break;
         case 6:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcschedule(arg, cpu_env);
-            rn = "TCSchedule";
+            register_name = "TCSchedule";
             break;
         case 7:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcschefback(arg, cpu_env);
-            rn = "TCScheFBack";
+            register_name = "TCScheFBack";
             break;
         default:
             goto cp0_unimplemented;
@@ -6799,12 +6801,12 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_move_low32(arg, tmp);
                 tcg_temp_free_i64(tmp);
             }
-            rn = "EntryLo1";
+            register_name = "EntryLo1";
             break;
         case 1:
             CP0_CHECK(ctx->vp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_GlobalNumber));
-            rn = "GlobalNumber";
+            register_name = "GlobalNumber";
             break;
         default:
             goto cp0_unimplemented;
@@ -6815,18 +6817,18 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "Context";
+            register_name = "Context";
             break;
         case 1:
 //            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
-            rn = "ContextConfig";
+            register_name = "ContextConfig";
             goto cp0_unimplemented;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "UserLocal";
+            register_name = "UserLocal";
             break;
         default:
             goto cp0_unimplemented;
@@ -6836,45 +6838,45 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageMask));
-            rn = "PageMask";
+            register_name = "PageMask";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageGrain));
-            rn = "PageGrain";
+            register_name = "PageGrain";
             break;
         case 2:
             CP0_CHECK(ctx->sc);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl0));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "SegCtl0";
+            register_name = "SegCtl0";
             break;
         case 3:
             CP0_CHECK(ctx->sc);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl1));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "SegCtl1";
+            register_name = "SegCtl1";
             break;
         case 4:
             CP0_CHECK(ctx->sc);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl2));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "SegCtl2";
+            register_name = "SegCtl2";
             break;
         case 5:
             check_pw(ctx);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWBase));
-            rn = "PWBase";
+            register_name = "PWBase";
             break;
         case 6:
             check_pw(ctx);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWField));
-            rn = "PWField";
+            register_name = "PWField";
             break;
         case 7:
             check_pw(ctx);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWSize));
-            rn = "PWSize";
+            register_name = "PWSize";
             break;
         default:
             goto cp0_unimplemented;
@@ -6884,37 +6886,37 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
-            rn = "Wired";
+            register_name = "Wired";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf0));
-            rn = "SRSConf0";
+            register_name = "SRSConf0";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf1));
-            rn = "SRSConf1";
+            register_name = "SRSConf1";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf2));
-            rn = "SRSConf2";
+            register_name = "SRSConf2";
             break;
         case 4:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf3));
-            rn = "SRSConf3";
+            register_name = "SRSConf3";
             break;
         case 5:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf4));
-            rn = "SRSConf4";
+            register_name = "SRSConf4";
             break;
         case 6:
             check_pw(ctx);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWCtl));
-            rn = "PWCtl";
+            register_name = "PWCtl";
             break;
         default:
             goto cp0_unimplemented;
@@ -6925,7 +6927,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_HWREna));
-            rn = "HWREna";
+            register_name = "HWREna";
             break;
         default:
             goto cp0_unimplemented;
@@ -6936,23 +6938,23 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "BadVAddr";
+            register_name = "BadVAddr";
             break;
         case 1:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstr));
-            rn = "BadInstr";
+            register_name = "BadInstr";
             break;
         case 2:
             CP0_CHECK(ctx->bp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
-            rn = "BadInstrP";
+            register_name = "BadInstrP";
             break;
         case 3:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
             tcg_gen_andi_tl(arg, arg, ~0xffff);
-            rn = "BadInstrX";
+            register_name = "BadInstrX";
             break;
        default:
             goto cp0_unimplemented;
@@ -6974,17 +6976,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                ensure we break completely out of translated code.  */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
-            rn = "Count";
+            register_name = "Count";
             break;
         case 6:
             CP0_CHECK(ctx->saar);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
-            rn = "SAARI";
+            register_name = "SAARI";
             break;
         case 7:
             CP0_CHECK(ctx->saar);
             gen_helper_mfc0_saar(arg, cpu_env);
-            rn = "SAAR";
+            register_name = "SAAR";
             break;
         default:
             goto cp0_unimplemented;
@@ -6995,7 +6997,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryHi));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "EntryHi";
+            register_name = "EntryHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -7005,7 +7007,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
-            rn = "Compare";
+            register_name = "Compare";
             break;
         /* 6,7 are implementation dependent */
         default:
@@ -7016,22 +7018,22 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
-            rn = "Status";
+            register_name = "Status";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_IntCtl));
-            rn = "IntCtl";
+            register_name = "IntCtl";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSCtl));
-            rn = "SRSCtl";
+            register_name = "SRSCtl";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
-            rn = "SRSMap";
+            register_name = "SRSMap";
             break;
         default:
             goto cp0_unimplemented;
@@ -7041,7 +7043,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Cause));
-            rn = "Cause";
+            register_name = "Cause";
             break;
         default:
             goto cp0_unimplemented;
@@ -7052,7 +7054,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "EPC";
+            register_name = "EPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -7062,20 +7064,20 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
-            rn = "PRid";
+            register_name = "PRid";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EBase));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "EBase";
+            register_name = "EBase";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             CP0_CHECK(ctx->cmgcr);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_CMGCRBase));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "CMGCRBase";
+            register_name = "CMGCRBase";
             break;
         default:
             goto cp0_unimplemented;
@@ -7085,36 +7087,36 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
-            rn = "Config";
+            register_name = "Config";
             break;
         case 1:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config1));
-            rn = "Config1";
+            register_name = "Config1";
             break;
         case 2:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config2));
-            rn = "Config2";
+            register_name = "Config2";
             break;
         case 3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config3));
-            rn = "Config3";
+            register_name = "Config3";
             break;
         case 4:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config4));
-            rn = "Config4";
+            register_name = "Config4";
             break;
         case 5:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config5));
-            rn = "Config5";
+            register_name = "Config5";
             break;
         /* 6,7 are implementation dependent */
         case 6:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config6));
-            rn = "Config6";
+            register_name = "Config6";
             break;
         case 7:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config7));
-            rn = "Config7";
+            register_name = "Config7";
             break;
         default:
             goto cp0_unimplemented;
@@ -7124,17 +7126,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mfc0_lladdr(arg, cpu_env);
-            rn = "LLAddr";
+            register_name = "LLAddr";
             break;
         case 1:
             CP0_CHECK(ctx->mrp);
             gen_helper_mfc0_maar(arg, cpu_env);
-            rn = "MAAR";
+            register_name = "MAAR";
             break;
         case 2:
             CP0_CHECK(ctx->mrp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MAARI));
-            rn = "MAARI";
+            register_name = "MAARI";
             break;
         default:
             goto cp0_unimplemented;
@@ -7152,7 +7154,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchlo, arg, sel);
-            rn = "WatchLo";
+            register_name = "WatchLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -7170,7 +7172,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
-            rn = "WatchHi";
+            register_name = "WatchHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -7183,7 +7185,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             check_insn(ctx, ISA_MIPS3);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_XContext));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "XContext";
+            register_name = "XContext";
             break;
 #endif
         default:
@@ -7196,7 +7198,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Framemask));
-            rn = "Framemask";
+            register_name = "Framemask";
             break;
         default:
             goto cp0_unimplemented;
@@ -7204,29 +7206,29 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CPO_REGISTER_22:
         tcg_gen_movi_tl(arg, 0); /* unimplemented */
-        rn = "'Diagnostic"; /* implementation dependent */
+        register_name = "'Diagnostic"; /* implementation dependent */
         break;
     case CPO_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mfc0_debug(arg, cpu_env); /* EJTAG support */
-            rn = "Debug";
+            register_name = "Debug";
             break;
         case 1:
 //            gen_helper_mfc0_tracecontrol(arg); /* PDtrace support */
-            rn = "TraceControl";
+            register_name = "TraceControl";
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_mfc0_tracecontrol2(arg); /* PDtrace support */
-            rn = "TraceControl2";
+            register_name = "TraceControl2";
             goto cp0_unimplemented;
         case 3:
 //            gen_helper_mfc0_usertracedata(arg); /* PDtrace support */
-            rn = "UserTraceData";
+            register_name = "UserTraceData";
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_mfc0_tracebpc(arg); /* PDtrace support */
-            rn = "TraceBPC";
+            register_name = "TraceBPC";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -7238,7 +7240,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* EJTAG support */
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_DEPC));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "DEPC";
+            register_name = "DEPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -7248,35 +7250,35 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
-            rn = "Performance0";
+            register_name = "Performance0";
             break;
         case 1:
 //            gen_helper_mfc0_performance1(arg);
-            rn = "Performance1";
+            register_name = "Performance1";
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_mfc0_performance2(arg);
-            rn = "Performance2";
+            register_name = "Performance2";
             goto cp0_unimplemented;
         case 3:
 //            gen_helper_mfc0_performance3(arg);
-            rn = "Performance3";
+            register_name = "Performance3";
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_mfc0_performance4(arg);
-            rn = "Performance4";
+            register_name = "Performance4";
             goto cp0_unimplemented;
         case 5:
 //            gen_helper_mfc0_performance5(arg);
-            rn = "Performance5";
+            register_name = "Performance5";
             goto cp0_unimplemented;
         case 6:
 //            gen_helper_mfc0_performance6(arg);
-            rn = "Performance6";
+            register_name = "Performance6";
             goto cp0_unimplemented;
         case 7:
 //            gen_helper_mfc0_performance7(arg);
-            rn = "Performance7";
+            register_name = "Performance7";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -7286,7 +7288,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_ErrCtl));
-            rn = "ErrCtl";
+            register_name = "ErrCtl";
             break;
         default:
             goto cp0_unimplemented;
@@ -7299,7 +7301,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 2:
         case 3:
             tcg_gen_movi_tl(arg, 0); /* unimplemented */
-            rn = "CacheErr";
+            register_name = "CacheErr";
             break;
         default:
             goto cp0_unimplemented;
@@ -7317,14 +7319,14 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_move_low32(arg, tmp);
                 tcg_temp_free_i64(tmp);
             }
-            rn = "TagLo";
+            register_name = "TagLo";
             break;
         case 1:
         case 3:
         case 5:
         case 7:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DataLo));
-            rn = "DataLo";
+            register_name = "DataLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -7337,14 +7339,14 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 4:
         case 6:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_TagHi));
-            rn = "TagHi";
+            register_name = "TagHi";
             break;
         case 1:
         case 3:
         case 5:
         case 7:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DataHi));
-            rn = "DataHi";
+            register_name = "DataHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -7355,7 +7357,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "ErrorEPC";
+            register_name = "ErrorEPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -7366,7 +7368,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* EJTAG support */
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
-            rn = "DESAVE";
+            register_name = "DESAVE";
             break;
         case 2:
         case 3:
@@ -7378,7 +7380,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
             tcg_gen_ext32s_tl(arg, arg);
-            rn = "KScratch";
+            register_name = "KScratch";
             break;
         default:
             goto cp0_unimplemented;
@@ -7387,17 +7389,18 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
        goto cp0_unimplemented;
     }
-    trace_mips_translate_c0("mfc0", rn, reg, sel);
+    trace_mips_translate_c0("mfc0", register_name, reg, sel);
     return;
 
 cp0_unimplemented:
-    qemu_log_mask(LOG_UNIMP, "mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mfc0 %s (reg %d sel %d)\n",
+                  register_name, reg, sel);
     gen_mfc0_unimplemented(ctx, arg);
 }
 
 static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
-    const char *rn = "invalid";
+    const char *register_name = "invalid";
 
     if (sel != 0)
         check_insn(ctx, ISA_MIPS32);
@@ -7411,27 +7414,27 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_index(cpu_env, arg);
-            rn = "Index";
+            register_name = "Index";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_mvpcontrol(cpu_env, arg);
-            rn = "MVPControl";
+            register_name = "MVPControl";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             /* ignored */
-            rn = "MVPConf0";
+            register_name = "MVPConf0";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             /* ignored */
-            rn = "MVPConf1";
+            register_name = "MVPConf1";
             break;
         case 4:
             CP0_CHECK(ctx->vp);
             /* ignored */
-            rn = "VPControl";
+            register_name = "VPControl";
             break;
         default:
             goto cp0_unimplemented;
@@ -7441,44 +7444,44 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* ignored */
-            rn = "Random";
+            register_name = "Random";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_vpecontrol(cpu_env, arg);
-            rn = "VPEControl";
+            register_name = "VPEControl";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_vpeconf0(cpu_env, arg);
-            rn = "VPEConf0";
+            register_name = "VPEConf0";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_vpeconf1(cpu_env, arg);
-            rn = "VPEConf1";
+            register_name = "VPEConf1";
             break;
         case 4:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_yqmask(cpu_env, arg);
-            rn = "YQMask";
+            register_name = "YQMask";
             break;
         case 5:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_VPESchedule));
-            rn = "VPESchedule";
+            register_name = "VPESchedule";
             break;
         case 6:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_VPEScheFBack));
-            rn = "VPEScheFBack";
+            register_name = "VPEScheFBack";
             break;
         case 7:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_vpeopt(cpu_env, arg);
-            rn = "VPEOpt";
+            register_name = "VPEOpt";
             break;
         default:
             goto cp0_unimplemented;
@@ -7488,42 +7491,42 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_entrylo0(cpu_env, arg);
-            rn = "EntryLo0";
+            register_name = "EntryLo0";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcstatus(cpu_env, arg);
-            rn = "TCStatus";
+            register_name = "TCStatus";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcbind(cpu_env, arg);
-            rn = "TCBind";
+            register_name = "TCBind";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcrestart(cpu_env, arg);
-            rn = "TCRestart";
+            register_name = "TCRestart";
             break;
         case 4:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tchalt(cpu_env, arg);
-            rn = "TCHalt";
+            register_name = "TCHalt";
             break;
         case 5:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tccontext(cpu_env, arg);
-            rn = "TCContext";
+            register_name = "TCContext";
             break;
         case 6:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcschedule(cpu_env, arg);
-            rn = "TCSchedule";
+            register_name = "TCSchedule";
             break;
         case 7:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcschefback(cpu_env, arg);
-            rn = "TCScheFBack";
+            register_name = "TCScheFBack";
             break;
         default:
             goto cp0_unimplemented;
@@ -7533,12 +7536,12 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_entrylo1(cpu_env, arg);
-            rn = "EntryLo1";
+            register_name = "EntryLo1";
             break;
         case 1:
             CP0_CHECK(ctx->vp);
             /* ignored */
-            rn = "GlobalNumber";
+            register_name = "GlobalNumber";
             break;
         default:
             goto cp0_unimplemented;
@@ -7548,17 +7551,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_context(cpu_env, arg);
-            rn = "Context";
+            register_name = "Context";
             break;
         case 1:
 //            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
-            rn = "ContextConfig";
+            register_name = "ContextConfig";
             goto cp0_unimplemented;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
-            rn = "UserLocal";
+            register_name = "UserLocal";
             break;
         default:
             goto cp0_unimplemented;
@@ -7568,43 +7571,43 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_pagemask(cpu_env, arg);
-            rn = "PageMask";
+            register_name = "PageMask";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_pagegrain(cpu_env, arg);
-            rn = "PageGrain";
+            register_name = "PageGrain";
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case 2:
             CP0_CHECK(ctx->sc);
             gen_helper_mtc0_segctl0(cpu_env, arg);
-            rn = "SegCtl0";
+            register_name = "SegCtl0";
             break;
         case 3:
             CP0_CHECK(ctx->sc);
             gen_helper_mtc0_segctl1(cpu_env, arg);
-            rn = "SegCtl1";
+            register_name = "SegCtl1";
             break;
         case 4:
             CP0_CHECK(ctx->sc);
             gen_helper_mtc0_segctl2(cpu_env, arg);
-            rn = "SegCtl2";
+            register_name = "SegCtl2";
             break;
         case 5:
             check_pw(ctx);
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_PWBase));
-            rn = "PWBase";
+            register_name = "PWBase";
             break;
         case 6:
             check_pw(ctx);
             gen_helper_mtc0_pwfield(cpu_env, arg);
-            rn = "PWField";
+            register_name = "PWField";
             break;
         case 7:
             check_pw(ctx);
             gen_helper_mtc0_pwsize(cpu_env, arg);
-            rn = "PWSize";
+            register_name = "PWSize";
             break;
         default:
             goto cp0_unimplemented;
@@ -7614,37 +7617,37 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_wired(cpu_env, arg);
-            rn = "Wired";
+            register_name = "Wired";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf0(cpu_env, arg);
-            rn = "SRSConf0";
+            register_name = "SRSConf0";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf1(cpu_env, arg);
-            rn = "SRSConf1";
+            register_name = "SRSConf1";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf2(cpu_env, arg);
-            rn = "SRSConf2";
+            register_name = "SRSConf2";
             break;
         case 4:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf3(cpu_env, arg);
-            rn = "SRSConf3";
+            register_name = "SRSConf3";
             break;
         case 5:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf4(cpu_env, arg);
-            rn = "SRSConf4";
+            register_name = "SRSConf4";
             break;
         case 6:
             check_pw(ctx);
             gen_helper_mtc0_pwctl(cpu_env, arg);
-            rn = "PWCtl";
+            register_name = "PWCtl";
             break;
         default:
             goto cp0_unimplemented;
@@ -7656,7 +7659,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_hwrena(cpu_env, arg);
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "HWREna";
+            register_name = "HWREna";
             break;
         default:
             goto cp0_unimplemented;
@@ -7666,19 +7669,19 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* ignored */
-            rn = "BadVAddr";
+            register_name = "BadVAddr";
             break;
         case 1:
             /* ignored */
-            rn = "BadInstr";
+            register_name = "BadInstr";
             break;
         case 2:
             /* ignored */
-            rn = "BadInstrP";
+            register_name = "BadInstrP";
             break;
         case 3:
             /* ignored */
-            rn = "BadInstrX";
+            register_name = "BadInstrX";
             break;
         default:
             goto cp0_unimplemented;
@@ -7688,17 +7691,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_count(cpu_env, arg);
-            rn = "Count";
+            register_name = "Count";
             break;
         case 6:
             CP0_CHECK(ctx->saar);
             gen_helper_mtc0_saari(cpu_env, arg);
-            rn = "SAARI";
+            register_name = "SAARI";
             break;
         case 7:
             CP0_CHECK(ctx->saar);
             gen_helper_mtc0_saar(cpu_env, arg);
-            rn = "SAAR";
+            register_name = "SAAR";
             break;
         default:
             goto cp0_unimplemented;
@@ -7708,7 +7711,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_entryhi(cpu_env, arg);
-            rn = "EntryHi";
+            register_name = "EntryHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -7718,7 +7721,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_compare(cpu_env, arg);
-            rn = "Compare";
+            register_name = "Compare";
             break;
         /* 6,7 are implementation dependent */
         default:
@@ -7733,28 +7736,28 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
-            rn = "Status";
+            register_name = "Status";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_intctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "IntCtl";
+            register_name = "IntCtl";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "SRSCtl";
+            register_name = "SRSCtl";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "SRSMap";
+            register_name = "SRSMap";
             break;
         default:
             goto cp0_unimplemented;
@@ -7770,7 +7773,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
              * translated code to check for pending interrupts.  */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
-            rn = "Cause";
+            register_name = "Cause";
             break;
         default:
             goto cp0_unimplemented;
@@ -7780,7 +7783,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
-            rn = "EPC";
+            register_name = "EPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -7790,12 +7793,12 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* ignored */
-            rn = "PRid";
+            register_name = "PRid";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_ebase(cpu_env, arg);
-            rn = "EBase";
+            register_name = "EBase";
             break;
         default:
             goto cp0_unimplemented;
@@ -7805,48 +7808,48 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_config0(cpu_env, arg);
-            rn = "Config";
+            register_name = "Config";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case 1:
             /* ignored, read only */
-            rn = "Config1";
+            register_name = "Config1";
             break;
         case 2:
             gen_helper_mtc0_config2(cpu_env, arg);
-            rn = "Config2";
+            register_name = "Config2";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case 3:
             gen_helper_mtc0_config3(cpu_env, arg);
-            rn = "Config3";
+            register_name = "Config3";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case 4:
             gen_helper_mtc0_config4(cpu_env, arg);
-            rn = "Config4";
+            register_name = "Config4";
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case 5:
             gen_helper_mtc0_config5(cpu_env, arg);
-            rn = "Config5";
+            register_name = "Config5";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         /* 6,7 are implementation dependent */
         case 6:
             /* ignored */
-            rn = "Config6";
+            register_name = "Config6";
             break;
         case 7:
             /* ignored */
-            rn = "Config7";
+            register_name = "Config7";
             break;
         default:
-            rn = "Invalid config selector";
+            register_name = "Invalid config selector";
             goto cp0_unimplemented;
         }
         break;
@@ -7854,17 +7857,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_lladdr(cpu_env, arg);
-            rn = "LLAddr";
+            register_name = "LLAddr";
             break;
         case 1:
             CP0_CHECK(ctx->mrp);
             gen_helper_mtc0_maar(cpu_env, arg);
-            rn = "MAAR";
+            register_name = "MAAR";
             break;
         case 2:
             CP0_CHECK(ctx->mrp);
             gen_helper_mtc0_maari(cpu_env, arg);
-            rn = "MAARI";
+            register_name = "MAARI";
             break;
         default:
             goto cp0_unimplemented;
@@ -7882,7 +7885,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
-            rn = "WatchLo";
+            register_name = "WatchLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -7900,7 +7903,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
-            rn = "WatchHi";
+            register_name = "WatchHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -7912,7 +7915,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 #if defined(TARGET_MIPS64)
             check_insn(ctx, ISA_MIPS3);
             gen_helper_mtc0_xcontext(cpu_env, arg);
-            rn = "XContext";
+            register_name = "XContext";
             break;
 #endif
         default:
@@ -7925,7 +7928,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_framemask(cpu_env, arg);
-            rn = "Framemask";
+            register_name = "Framemask";
             break;
         default:
             goto cp0_unimplemented;
@@ -7933,7 +7936,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CPO_REGISTER_22:
         /* ignored */
-        rn = "Diagnostic"; /* implementation dependent */
+        register_name = "Diagnostic"; /* implementation dependent */
         break;
     case CPO_REGISTER_23:
         switch (sel) {
@@ -7942,17 +7945,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
-            rn = "Debug";
+            register_name = "Debug";
             break;
         case 1:
 //            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
-            rn = "TraceControl";
+            register_name = "TraceControl";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
-            rn = "TraceControl2";
+            register_name = "TraceControl2";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
@@ -7960,7 +7963,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
 //            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
-            rn = "UserTraceData";
+            register_name = "UserTraceData";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
@@ -7968,7 +7971,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 //            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "TraceBPC";
+            register_name = "TraceBPC";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -7979,7 +7982,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* EJTAG support */
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_DEPC));
-            rn = "DEPC";
+            register_name = "DEPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -7989,35 +7992,35 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_performance0(cpu_env, arg);
-            rn = "Performance0";
+            register_name = "Performance0";
             break;
         case 1:
 //            gen_helper_mtc0_performance1(arg);
-            rn = "Performance1";
+            register_name = "Performance1";
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_performance2(arg);
-            rn = "Performance2";
+            register_name = "Performance2";
             goto cp0_unimplemented;
         case 3:
 //            gen_helper_mtc0_performance3(arg);
-            rn = "Performance3";
+            register_name = "Performance3";
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_performance4(arg);
-            rn = "Performance4";
+            register_name = "Performance4";
             goto cp0_unimplemented;
         case 5:
 //            gen_helper_mtc0_performance5(arg);
-            rn = "Performance5";
+            register_name = "Performance5";
             goto cp0_unimplemented;
         case 6:
 //            gen_helper_mtc0_performance6(arg);
-            rn = "Performance6";
+            register_name = "Performance6";
             goto cp0_unimplemented;
         case 7:
 //            gen_helper_mtc0_performance7(arg);
-            rn = "Performance7";
+            register_name = "Performance7";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -8028,7 +8031,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "ErrCtl";
+            register_name = "ErrCtl";
             break;
         default:
             goto cp0_unimplemented;
@@ -8041,7 +8044,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 2:
         case 3:
             /* ignored */
-            rn = "CacheErr";
+            register_name = "CacheErr";
             break;
         default:
             goto cp0_unimplemented;
@@ -8054,14 +8057,14 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 4:
         case 6:
             gen_helper_mtc0_taglo(cpu_env, arg);
-            rn = "TagLo";
+            register_name = "TagLo";
             break;
         case 1:
         case 3:
         case 5:
         case 7:
             gen_helper_mtc0_datalo(cpu_env, arg);
-            rn = "DataLo";
+            register_name = "DataLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -8074,17 +8077,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 4:
         case 6:
             gen_helper_mtc0_taghi(cpu_env, arg);
-            rn = "TagHi";
+            register_name = "TagHi";
             break;
         case 1:
         case 3:
         case 5:
         case 7:
             gen_helper_mtc0_datahi(cpu_env, arg);
-            rn = "DataHi";
+            register_name = "DataHi";
             break;
         default:
-            rn = "invalid sel";
+            register_name = "invalid sel";
             goto cp0_unimplemented;
         }
        break;
@@ -8092,7 +8095,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
-            rn = "ErrorEPC";
+            register_name = "ErrorEPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -8103,7 +8106,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* EJTAG support */
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
-            rn = "DESAVE";
+            register_name = "DESAVE";
             break;
         case 2:
         case 3:
@@ -8114,7 +8117,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
-            rn = "KScratch";
+            register_name = "KScratch";
             break;
         default:
             goto cp0_unimplemented;
@@ -8123,7 +8126,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
        goto cp0_unimplemented;
     }
-    trace_mips_translate_c0("mtc0", rn, reg, sel);
+    trace_mips_translate_c0("mtc0", register_name, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
@@ -8136,13 +8139,14 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     return;
 
 cp0_unimplemented:
-    qemu_log_mask(LOG_UNIMP, "mtc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mtc0 %s (reg %d sel %d)\n",
+                  register_name, reg, sel);
 }
 
 #if defined(TARGET_MIPS64)
 static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
-    const char *rn = "invalid";
+    const char *register_name = "invalid";
 
     if (sel != 0)
         check_insn(ctx, ISA_MIPS64);
@@ -8152,27 +8156,27 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
-            rn = "Index";
+            register_name = "Index";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpcontrol(arg, cpu_env);
-            rn = "MVPControl";
+            register_name = "MVPControl";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpconf0(arg, cpu_env);
-            rn = "MVPConf0";
+            register_name = "MVPConf0";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_mvpconf1(arg, cpu_env);
-            rn = "MVPConf1";
+            register_name = "MVPConf1";
             break;
         case 4:
             CP0_CHECK(ctx->vp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPControl));
-            rn = "VPControl";
+            register_name = "VPControl";
             break;
         default:
             goto cp0_unimplemented;
@@ -8183,42 +8187,42 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
             gen_helper_mfc0_random(arg, cpu_env);
-            rn = "Random";
+            register_name = "Random";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEControl));
-            rn = "VPEControl";
+            register_name = "VPEControl";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf0));
-            rn = "VPEConf0";
+            register_name = "VPEConf0";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEConf1));
-            rn = "VPEConf1";
+            register_name = "VPEConf1";
             break;
         case 4:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_YQMask));
-            rn = "YQMask";
+            register_name = "YQMask";
             break;
         case 5:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_VPESchedule));
-            rn = "VPESchedule";
+            register_name = "VPESchedule";
             break;
         case 6:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_VPEScheFBack));
-            rn = "VPEScheFBack";
+            register_name = "VPEScheFBack";
             break;
         case 7:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_VPEOpt));
-            rn = "VPEOpt";
+            register_name = "VPEOpt";
             break;
         default:
             goto cp0_unimplemented;
@@ -8228,42 +8232,42 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo0));
-            rn = "EntryLo0";
+            register_name = "EntryLo0";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcstatus(arg, cpu_env);
-            rn = "TCStatus";
+            register_name = "TCStatus";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcbind(arg, cpu_env);
-            rn = "TCBind";
+            register_name = "TCBind";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tcrestart(arg, cpu_env);
-            rn = "TCRestart";
+            register_name = "TCRestart";
             break;
         case 4:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tchalt(arg, cpu_env);
-            rn = "TCHalt";
+            register_name = "TCHalt";
             break;
         case 5:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tccontext(arg, cpu_env);
-            rn = "TCContext";
+            register_name = "TCContext";
             break;
         case 6:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tcschedule(arg, cpu_env);
-            rn = "TCSchedule";
+            register_name = "TCSchedule";
             break;
         case 7:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tcschefback(arg, cpu_env);
-            rn = "TCScheFBack";
+            register_name = "TCScheFBack";
             break;
         default:
             goto cp0_unimplemented;
@@ -8273,12 +8277,12 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo1));
-            rn = "EntryLo1";
+            register_name = "EntryLo1";
             break;
         case 1:
             CP0_CHECK(ctx->vp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_GlobalNumber));
-            rn = "GlobalNumber";
+            register_name = "GlobalNumber";
             break;
         default:
             goto cp0_unimplemented;
@@ -8288,17 +8292,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
-            rn = "Context";
+            register_name = "Context";
             break;
         case 1:
 //            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
-            rn = "ContextConfig";
+            register_name = "ContextConfig";
             goto cp0_unimplemented;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
-            rn = "UserLocal";
+            register_name = "UserLocal";
             break;
         default:
             goto cp0_unimplemented;
@@ -8308,42 +8312,42 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageMask));
-            rn = "PageMask";
+            register_name = "PageMask";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageGrain));
-            rn = "PageGrain";
+            register_name = "PageGrain";
             break;
         case 2:
             CP0_CHECK(ctx->sc);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl0));
-            rn = "SegCtl0";
+            register_name = "SegCtl0";
             break;
         case 3:
             CP0_CHECK(ctx->sc);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl1));
-            rn = "SegCtl1";
+            register_name = "SegCtl1";
             break;
         case 4:
             CP0_CHECK(ctx->sc);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_SegCtl2));
-            rn = "SegCtl2";
+            register_name = "SegCtl2";
             break;
         case 5:
             check_pw(ctx);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWBase));
-            rn = "PWBase";
+            register_name = "PWBase";
             break;
         case 6:
             check_pw(ctx);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWField));
-            rn = "PWField";
+            register_name = "PWField";
             break;
         case 7:
             check_pw(ctx);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWSize));
-            rn = "PWSize";
+            register_name = "PWSize";
             break;
         default:
             goto cp0_unimplemented;
@@ -8353,37 +8357,37 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
-            rn = "Wired";
+            register_name = "Wired";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf0));
-            rn = "SRSConf0";
+            register_name = "SRSConf0";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf1));
-            rn = "SRSConf1";
+            register_name = "SRSConf1";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf2));
-            rn = "SRSConf2";
+            register_name = "SRSConf2";
             break;
         case 4:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf3));
-            rn = "SRSConf3";
+            register_name = "SRSConf3";
             break;
         case 5:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf4));
-            rn = "SRSConf4";
+            register_name = "SRSConf4";
             break;
         case 6:
             check_pw(ctx);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWCtl));
-            rn = "PWCtl";
+            register_name = "PWCtl";
             break;
         default:
             goto cp0_unimplemented;
@@ -8394,7 +8398,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_HWREna));
-            rn = "HWREna";
+            register_name = "HWREna";
             break;
         default:
             goto cp0_unimplemented;
@@ -8404,23 +8408,23 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
-            rn = "BadVAddr";
+            register_name = "BadVAddr";
             break;
         case 1:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstr));
-            rn = "BadInstr";
+            register_name = "BadInstr";
             break;
         case 2:
             CP0_CHECK(ctx->bp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
-            rn = "BadInstrP";
+            register_name = "BadInstrP";
             break;
         case 3:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
             tcg_gen_andi_tl(arg, arg, ~0xffff);
-            rn = "BadInstrX";
+            register_name = "BadInstrX";
             break;
         default:
             goto cp0_unimplemented;
@@ -8442,17 +8446,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                ensure we break completely out of translated code.  */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
-            rn = "Count";
+            register_name = "Count";
             break;
         case 6:
             CP0_CHECK(ctx->saar);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
-            rn = "SAARI";
+            register_name = "SAARI";
             break;
         case 7:
             CP0_CHECK(ctx->saar);
             gen_helper_dmfc0_saar(arg, cpu_env);
-            rn = "SAAR";
+            register_name = "SAAR";
             break;
         default:
             goto cp0_unimplemented;
@@ -8462,7 +8466,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryHi));
-            rn = "EntryHi";
+            register_name = "EntryHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -8472,7 +8476,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
-            rn = "Compare";
+            register_name = "Compare";
             break;
         /* 6,7 are implementation dependent */
         default:
@@ -8483,22 +8487,22 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
-            rn = "Status";
+            register_name = "Status";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_IntCtl));
-            rn = "IntCtl";
+            register_name = "IntCtl";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSCtl));
-            rn = "SRSCtl";
+            register_name = "SRSCtl";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
-            rn = "SRSMap";
+            register_name = "SRSMap";
             break;
         default:
             goto cp0_unimplemented;
@@ -8508,7 +8512,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Cause));
-            rn = "Cause";
+            register_name = "Cause";
             break;
         default:
             goto cp0_unimplemented;
@@ -8518,7 +8522,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
-            rn = "EPC";
+            register_name = "EPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -8528,18 +8532,18 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
-            rn = "PRid";
+            register_name = "PRid";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EBase));
-            rn = "EBase";
+            register_name = "EBase";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             CP0_CHECK(ctx->cmgcr);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_CMGCRBase));
-            rn = "CMGCRBase";
+            register_name = "CMGCRBase";
             break;
         default:
             goto cp0_unimplemented;
@@ -8549,36 +8553,36 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
-            rn = "Config";
+            register_name = "Config";
             break;
         case 1:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config1));
-            rn = "Config1";
+            register_name = "Config1";
             break;
         case 2:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config2));
-            rn = "Config2";
+            register_name = "Config2";
             break;
         case 3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config3));
-            rn = "Config3";
+            register_name = "Config3";
             break;
         case 4:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config4));
-            rn = "Config4";
+            register_name = "Config4";
             break;
         case 5:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config5));
-            rn = "Config5";
+            register_name = "Config5";
             break;
        /* 6,7 are implementation dependent */
         case 6:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config6));
-            rn = "Config6";
+            register_name = "Config6";
             break;
         case 7:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config7));
-            rn = "Config7";
+            register_name = "Config7";
             break;
         default:
             goto cp0_unimplemented;
@@ -8588,17 +8592,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_dmfc0_lladdr(arg, cpu_env);
-            rn = "LLAddr";
+            register_name = "LLAddr";
             break;
         case 1:
             CP0_CHECK(ctx->mrp);
             gen_helper_dmfc0_maar(arg, cpu_env);
-            rn = "MAAR";
+            register_name = "MAAR";
             break;
         case 2:
             CP0_CHECK(ctx->mrp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MAARI));
-            rn = "MAARI";
+            register_name = "MAARI";
             break;
         default:
             goto cp0_unimplemented;
@@ -8616,7 +8620,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(dmfc0_watchlo, arg, sel);
-            rn = "WatchLo";
+            register_name = "WatchLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -8634,7 +8638,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
-            rn = "WatchHi";
+            register_name = "WatchHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -8645,7 +8649,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             check_insn(ctx, ISA_MIPS3);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_XContext));
-            rn = "XContext";
+            register_name = "XContext";
             break;
         default:
             goto cp0_unimplemented;
@@ -8657,7 +8661,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Framemask));
-            rn = "Framemask";
+            register_name = "Framemask";
             break;
         default:
             goto cp0_unimplemented;
@@ -8665,29 +8669,29 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CPO_REGISTER_22:
         tcg_gen_movi_tl(arg, 0); /* unimplemented */
-        rn = "'Diagnostic"; /* implementation dependent */
+        register_name = "'Diagnostic"; /* implementation dependent */
         break;
     case CPO_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mfc0_debug(arg, cpu_env); /* EJTAG support */
-            rn = "Debug";
+            register_name = "Debug";
             break;
         case 1:
 //            gen_helper_dmfc0_tracecontrol(arg, cpu_env); /* PDtrace support */
-            rn = "TraceControl";
+            register_name = "TraceControl";
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_dmfc0_tracecontrol2(arg, cpu_env); /* PDtrace support */
-            rn = "TraceControl2";
+            register_name = "TraceControl2";
             goto cp0_unimplemented;
         case 3:
 //            gen_helper_dmfc0_usertracedata(arg, cpu_env); /* PDtrace support */
-            rn = "UserTraceData";
+            register_name = "UserTraceData";
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_dmfc0_tracebpc(arg, cpu_env); /* PDtrace support */
-            rn = "TraceBPC";
+            register_name = "TraceBPC";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -8698,7 +8702,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* EJTAG support */
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_DEPC));
-            rn = "DEPC";
+            register_name = "DEPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -8708,35 +8712,35 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
-            rn = "Performance0";
+            register_name = "Performance0";
             break;
         case 1:
 //            gen_helper_dmfc0_performance1(arg);
-            rn = "Performance1";
+            register_name = "Performance1";
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_dmfc0_performance2(arg);
-            rn = "Performance2";
+            register_name = "Performance2";
             goto cp0_unimplemented;
         case 3:
 //            gen_helper_dmfc0_performance3(arg);
-            rn = "Performance3";
+            register_name = "Performance3";
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_dmfc0_performance4(arg);
-            rn = "Performance4";
+            register_name = "Performance4";
             goto cp0_unimplemented;
         case 5:
 //            gen_helper_dmfc0_performance5(arg);
-            rn = "Performance5";
+            register_name = "Performance5";
             goto cp0_unimplemented;
         case 6:
 //            gen_helper_dmfc0_performance6(arg);
-            rn = "Performance6";
+            register_name = "Performance6";
             goto cp0_unimplemented;
         case 7:
 //            gen_helper_dmfc0_performance7(arg);
-            rn = "Performance7";
+            register_name = "Performance7";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -8746,7 +8750,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_ErrCtl));
-            rn = "ErrCtl";
+            register_name = "ErrCtl";
             break;
         default:
             goto cp0_unimplemented;
@@ -8760,7 +8764,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 2:
         case 3:
             tcg_gen_movi_tl(arg, 0); /* unimplemented */
-            rn = "CacheErr";
+            register_name = "CacheErr";
             break;
         default:
             goto cp0_unimplemented;
@@ -8773,14 +8777,14 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 4:
         case 6:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_TagLo));
-            rn = "TagLo";
+            register_name = "TagLo";
             break;
         case 1:
         case 3:
         case 5:
         case 7:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DataLo));
-            rn = "DataLo";
+            register_name = "DataLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -8793,14 +8797,14 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 4:
         case 6:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_TagHi));
-            rn = "TagHi";
+            register_name = "TagHi";
             break;
         case 1:
         case 3:
         case 5:
         case 7:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DataHi));
-            rn = "DataHi";
+            register_name = "DataHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -8810,7 +8814,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
-            rn = "ErrorEPC";
+            register_name = "ErrorEPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -8821,7 +8825,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* EJTAG support */
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
-            rn = "DESAVE";
+            register_name = "DESAVE";
             break;
         case 2:
         case 3:
@@ -8832,7 +8836,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
-            rn = "KScratch";
+            register_name = "KScratch";
             break;
         default:
             goto cp0_unimplemented;
@@ -8841,17 +8845,18 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-    trace_mips_translate_c0("dmfc0", rn, reg, sel);
+    trace_mips_translate_c0("dmfc0", register_name, reg, sel);
     return;
 
 cp0_unimplemented:
-    qemu_log_mask(LOG_UNIMP, "dmfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "dmfc0 %s (reg %d sel %d)\n",
+                  register_name, reg, sel);
     gen_mfc0_unimplemented(ctx, arg);
 }
 
 static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
-    const char *rn = "invalid";
+    const char *register_name = "invalid";
 
     if (sel != 0)
         check_insn(ctx, ISA_MIPS64);
@@ -8865,27 +8870,27 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_index(cpu_env, arg);
-            rn = "Index";
+            register_name = "Index";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_mvpcontrol(cpu_env, arg);
-            rn = "MVPControl";
+            register_name = "MVPControl";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             /* ignored */
-            rn = "MVPConf0";
+            register_name = "MVPConf0";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             /* ignored */
-            rn = "MVPConf1";
+            register_name = "MVPConf1";
             break;
         case 4:
             CP0_CHECK(ctx->vp);
             /* ignored */
-            rn = "VPControl";
+            register_name = "VPControl";
             break;
         default:
             goto cp0_unimplemented;
@@ -8895,42 +8900,42 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* ignored */
-            rn = "Random";
+            register_name = "Random";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_vpecontrol(cpu_env, arg);
-            rn = "VPEControl";
+            register_name = "VPEControl";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_vpeconf0(cpu_env, arg);
-            rn = "VPEConf0";
+            register_name = "VPEConf0";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_vpeconf1(cpu_env, arg);
-            rn = "VPEConf1";
+            register_name = "VPEConf1";
             break;
         case 4:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_yqmask(cpu_env, arg);
-            rn = "YQMask";
+            register_name = "YQMask";
             break;
         case 5:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_VPESchedule));
-            rn = "VPESchedule";
+            register_name = "VPESchedule";
             break;
         case 6:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_VPEScheFBack));
-            rn = "VPEScheFBack";
+            register_name = "VPEScheFBack";
             break;
         case 7:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_vpeopt(cpu_env, arg);
-            rn = "VPEOpt";
+            register_name = "VPEOpt";
             break;
         default:
             goto cp0_unimplemented;
@@ -8940,42 +8945,42 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_dmtc0_entrylo0(cpu_env, arg);
-            rn = "EntryLo0";
+            register_name = "EntryLo0";
             break;
         case 1:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcstatus(cpu_env, arg);
-            rn = "TCStatus";
+            register_name = "TCStatus";
             break;
         case 2:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcbind(cpu_env, arg);
-            rn = "TCBind";
+            register_name = "TCBind";
             break;
         case 3:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcrestart(cpu_env, arg);
-            rn = "TCRestart";
+            register_name = "TCRestart";
             break;
         case 4:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tchalt(cpu_env, arg);
-            rn = "TCHalt";
+            register_name = "TCHalt";
             break;
         case 5:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tccontext(cpu_env, arg);
-            rn = "TCContext";
+            register_name = "TCContext";
             break;
         case 6:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcschedule(cpu_env, arg);
-            rn = "TCSchedule";
+            register_name = "TCSchedule";
             break;
         case 7:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcschefback(cpu_env, arg);
-            rn = "TCScheFBack";
+            register_name = "TCScheFBack";
             break;
         default:
             goto cp0_unimplemented;
@@ -8985,12 +8990,12 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_dmtc0_entrylo1(cpu_env, arg);
-            rn = "EntryLo1";
+            register_name = "EntryLo1";
             break;
         case 1:
             CP0_CHECK(ctx->vp);
             /* ignored */
-            rn = "GlobalNumber";
+            register_name = "GlobalNumber";
             break;
         default:
             goto cp0_unimplemented;
@@ -9000,17 +9005,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_context(cpu_env, arg);
-            rn = "Context";
+            register_name = "Context";
             break;
         case 1:
 //           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
-            rn = "ContextConfig";
+            register_name = "ContextConfig";
             goto cp0_unimplemented;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
-            rn = "UserLocal";
+            register_name = "UserLocal";
             break;
         default:
             goto cp0_unimplemented;
@@ -9020,42 +9025,42 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_pagemask(cpu_env, arg);
-            rn = "PageMask";
+            register_name = "PageMask";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_pagegrain(cpu_env, arg);
-            rn = "PageGrain";
+            register_name = "PageGrain";
             break;
         case 2:
             CP0_CHECK(ctx->sc);
             gen_helper_mtc0_segctl0(cpu_env, arg);
-            rn = "SegCtl0";
+            register_name = "SegCtl0";
             break;
         case 3:
             CP0_CHECK(ctx->sc);
             gen_helper_mtc0_segctl1(cpu_env, arg);
-            rn = "SegCtl1";
+            register_name = "SegCtl1";
             break;
         case 4:
             CP0_CHECK(ctx->sc);
             gen_helper_mtc0_segctl2(cpu_env, arg);
-            rn = "SegCtl2";
+            register_name = "SegCtl2";
             break;
         case 5:
             check_pw(ctx);
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_PWBase));
-            rn = "PWBase";
+            register_name = "PWBase";
             break;
         case 6:
             check_pw(ctx);
             gen_helper_mtc0_pwfield(cpu_env, arg);
-            rn = "PWField";
+            register_name = "PWField";
             break;
         case 7:
             check_pw(ctx);
             gen_helper_mtc0_pwsize(cpu_env, arg);
-            rn = "PWSize";
+            register_name = "PWSize";
             break;
         default:
             goto cp0_unimplemented;
@@ -9065,37 +9070,37 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_wired(cpu_env, arg);
-            rn = "Wired";
+            register_name = "Wired";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf0(cpu_env, arg);
-            rn = "SRSConf0";
+            register_name = "SRSConf0";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf1(cpu_env, arg);
-            rn = "SRSConf1";
+            register_name = "SRSConf1";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf2(cpu_env, arg);
-            rn = "SRSConf2";
+            register_name = "SRSConf2";
             break;
         case 4:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf3(cpu_env, arg);
-            rn = "SRSConf3";
+            register_name = "SRSConf3";
             break;
         case 5:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf4(cpu_env, arg);
-            rn = "SRSConf4";
+            register_name = "SRSConf4";
             break;
         case 6:
             check_pw(ctx);
             gen_helper_mtc0_pwctl(cpu_env, arg);
-            rn = "PWCtl";
+            register_name = "PWCtl";
             break;
         default:
             goto cp0_unimplemented;
@@ -9107,7 +9112,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_hwrena(cpu_env, arg);
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "HWREna";
+            register_name = "HWREna";
             break;
         default:
             goto cp0_unimplemented;
@@ -9117,19 +9122,19 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* ignored */
-            rn = "BadVAddr";
+            register_name = "BadVAddr";
             break;
         case 1:
             /* ignored */
-            rn = "BadInstr";
+            register_name = "BadInstr";
             break;
         case 2:
             /* ignored */
-            rn = "BadInstrP";
+            register_name = "BadInstrP";
             break;
         case 3:
             /* ignored */
-            rn = "BadInstrX";
+            register_name = "BadInstrX";
             break;
         default:
             goto cp0_unimplemented;
@@ -9139,17 +9144,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_count(cpu_env, arg);
-            rn = "Count";
+            register_name = "Count";
             break;
         case 6:
             CP0_CHECK(ctx->saar);
             gen_helper_mtc0_saari(cpu_env, arg);
-            rn = "SAARI";
+            register_name = "SAARI";
             break;
         case 7:
             CP0_CHECK(ctx->saar);
             gen_helper_mtc0_saar(cpu_env, arg);
-            rn = "SAAR";
+            register_name = "SAAR";
             break;
         default:
             goto cp0_unimplemented;
@@ -9161,7 +9166,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_entryhi(cpu_env, arg);
-            rn = "EntryHi";
+            register_name = "EntryHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -9171,7 +9176,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_compare(cpu_env, arg);
-            rn = "Compare";
+            register_name = "Compare";
             break;
         /* 6,7 are implementation dependent */
         default:
@@ -9188,28 +9193,28 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
-            rn = "Status";
+            register_name = "Status";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_intctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "IntCtl";
+            register_name = "IntCtl";
             break;
         case 2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "SRSCtl";
+            register_name = "SRSCtl";
             break;
         case 3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "SRSMap";
+            register_name = "SRSMap";
             break;
         default:
             goto cp0_unimplemented;
@@ -9225,7 +9230,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
              * translated code to check for pending interrupts.  */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
-            rn = "Cause";
+            register_name = "Cause";
             break;
         default:
             goto cp0_unimplemented;
@@ -9235,7 +9240,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
-            rn = "EPC";
+            register_name = "EPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -9245,12 +9250,12 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* ignored */
-            rn = "PRid";
+            register_name = "PRid";
             break;
         case 1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_ebase(cpu_env, arg);
-            rn = "EBase";
+            register_name = "EBase";
             break;
         default:
             goto cp0_unimplemented;
@@ -9260,39 +9265,39 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_config0(cpu_env, arg);
-            rn = "Config";
+            register_name = "Config";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case 1:
             /* ignored, read only */
-            rn = "Config1";
+            register_name = "Config1";
             break;
         case 2:
             gen_helper_mtc0_config2(cpu_env, arg);
-            rn = "Config2";
+            register_name = "Config2";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case 3:
             gen_helper_mtc0_config3(cpu_env, arg);
-            rn = "Config3";
+            register_name = "Config3";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         case 4:
             /* currently ignored */
-            rn = "Config4";
+            register_name = "Config4";
             break;
         case 5:
             gen_helper_mtc0_config5(cpu_env, arg);
-            rn = "Config5";
+            register_name = "Config5";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         /* 6,7 are implementation dependent */
         default:
-            rn = "Invalid config selector";
+            register_name = "Invalid config selector";
             goto cp0_unimplemented;
         }
         break;
@@ -9300,17 +9305,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_lladdr(cpu_env, arg);
-            rn = "LLAddr";
+            register_name = "LLAddr";
             break;
         case 1:
             CP0_CHECK(ctx->mrp);
             gen_helper_mtc0_maar(cpu_env, arg);
-            rn = "MAAR";
+            register_name = "MAAR";
             break;
         case 2:
             CP0_CHECK(ctx->mrp);
             gen_helper_mtc0_maari(cpu_env, arg);
-            rn = "MAARI";
+            register_name = "MAARI";
             break;
         default:
             goto cp0_unimplemented;
@@ -9328,7 +9333,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
-            rn = "WatchLo";
+            register_name = "WatchLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -9346,7 +9351,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
-            rn = "WatchHi";
+            register_name = "WatchHi";
             break;
         default:
             goto cp0_unimplemented;
@@ -9357,7 +9362,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             check_insn(ctx, ISA_MIPS3);
             gen_helper_mtc0_xcontext(cpu_env, arg);
-            rn = "XContext";
+            register_name = "XContext";
             break;
         default:
             goto cp0_unimplemented;
@@ -9369,7 +9374,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_framemask(cpu_env, arg);
-            rn = "Framemask";
+            register_name = "Framemask";
             break;
         default:
             goto cp0_unimplemented;
@@ -9377,7 +9382,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CPO_REGISTER_22:
         /* ignored */
-        rn = "Diagnostic"; /* implementation dependent */
+        register_name = "Diagnostic"; /* implementation dependent */
         break;
     case CPO_REGISTER_23:
         switch (sel) {
@@ -9386,31 +9391,31 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
-            rn = "Debug";
+            register_name = "Debug";
             break;
         case 1:
 //            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "TraceControl";
+            register_name = "TraceControl";
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "TraceControl2";
+            register_name = "TraceControl2";
             goto cp0_unimplemented;
         case 3:
 //            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "UserTraceData";
+            register_name = "UserTraceData";
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "TraceBPC";
+            register_name = "TraceBPC";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -9421,7 +9426,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* EJTAG support */
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_DEPC));
-            rn = "DEPC";
+            register_name = "DEPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -9431,35 +9436,35 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             gen_helper_mtc0_performance0(cpu_env, arg);
-            rn = "Performance0";
+            register_name = "Performance0";
             break;
         case 1:
 //            gen_helper_mtc0_performance1(cpu_env, arg);
-            rn = "Performance1";
+            register_name = "Performance1";
             goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_performance2(cpu_env, arg);
-            rn = "Performance2";
+            register_name = "Performance2";
             goto cp0_unimplemented;
         case 3:
 //            gen_helper_mtc0_performance3(cpu_env, arg);
-            rn = "Performance3";
+            register_name = "Performance3";
             goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_performance4(cpu_env, arg);
-            rn = "Performance4";
+            register_name = "Performance4";
             goto cp0_unimplemented;
         case 5:
 //            gen_helper_mtc0_performance5(cpu_env, arg);
-            rn = "Performance5";
+            register_name = "Performance5";
             goto cp0_unimplemented;
         case 6:
 //            gen_helper_mtc0_performance6(cpu_env, arg);
-            rn = "Performance6";
+            register_name = "Performance6";
             goto cp0_unimplemented;
         case 7:
 //            gen_helper_mtc0_performance7(cpu_env, arg);
-            rn = "Performance7";
+            register_name = "Performance7";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -9470,7 +9475,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
             ctx->base.is_jmp = DISAS_STOP;
-            rn = "ErrCtl";
+            register_name = "ErrCtl";
             break;
         default:
             goto cp0_unimplemented;
@@ -9483,7 +9488,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 2:
         case 3:
             /* ignored */
-            rn = "CacheErr";
+            register_name = "CacheErr";
             break;
         default:
             goto cp0_unimplemented;
@@ -9496,14 +9501,14 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 4:
         case 6:
             gen_helper_mtc0_taglo(cpu_env, arg);
-            rn = "TagLo";
+            register_name = "TagLo";
             break;
         case 1:
         case 3:
         case 5:
         case 7:
             gen_helper_mtc0_datalo(cpu_env, arg);
-            rn = "DataLo";
+            register_name = "DataLo";
             break;
         default:
             goto cp0_unimplemented;
@@ -9516,17 +9521,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 4:
         case 6:
             gen_helper_mtc0_taghi(cpu_env, arg);
-            rn = "TagHi";
+            register_name = "TagHi";
             break;
         case 1:
         case 3:
         case 5:
         case 7:
             gen_helper_mtc0_datahi(cpu_env, arg);
-            rn = "DataHi";
+            register_name = "DataHi";
             break;
         default:
-            rn = "invalid sel";
+            register_name = "invalid sel";
             goto cp0_unimplemented;
         }
         break;
@@ -9534,7 +9539,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
-            rn = "ErrorEPC";
+            register_name = "ErrorEPC";
             break;
         default:
             goto cp0_unimplemented;
@@ -9545,7 +9550,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* EJTAG support */
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
-            rn = "DESAVE";
+            register_name = "DESAVE";
             break;
         case 2:
         case 3:
@@ -9556,7 +9561,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
-            rn = "KScratch";
+            register_name = "KScratch";
             break;
         default:
             goto cp0_unimplemented;
@@ -9565,7 +9570,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-    trace_mips_translate_c0("dmtc0", rn, reg, sel);
+    trace_mips_translate_c0("dmtc0", register_name, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
@@ -9578,7 +9583,8 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     return;
 
 cp0_unimplemented:
-    qemu_log_mask(LOG_UNIMP, "dmtc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "dmtc0 %s (reg %d sel %d)\n",
+                  register_name, reg, sel);
 }
 #endif /* TARGET_MIPS64 */
 
-- 
2.7.4
