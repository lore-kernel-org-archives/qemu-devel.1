Received: from eggs.gnu.org ([2001:4830:134:3::10]:58367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWuLT-0000qS-Hi
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWuLS-0007A9-I2
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:23 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:64521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWuLS-00078D-69
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:22 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 02:29:05 +0100
Message-Id: <20180104012913.30763-10-laurent@vivier.eu>
In-Reply-To: <20180104012913.30763-1-laurent@vivier.eu>
References: <20180104012913.30763-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v7 09/17] target/m68k: softmmu cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

don't compile supervisor only instructions in linux-user mode

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0ef933a545..f77005215f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4391,6 +4391,7 @@ DISAS_INSN(move_from_sr)
     DEST_EA(env, insn, OS_WORD, sr, NULL);
 }
 
+#if defined(CONFIG_SOFTMMU)
 DISAS_INSN(move_to_sr)
 {
     if (IS_USER(s)) {
@@ -4423,6 +4424,11 @@ DISAS_INSN(move_to_usp)
 
 DISAS_INSN(halt)
 {
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+
     gen_exception(s, s->pc, EXCP_HALT_INSN);
 }
 
@@ -4506,6 +4512,7 @@ DISAS_INSN(wdebug)
     /* TODO: Implement wdebug.  */
     cpu_abort(CPU(cpu), "WDEBUG not implemented");
 }
+#endif
 
 DISAS_INSN(trap)
 {
@@ -5063,10 +5070,16 @@ DISAS_INSN(fscc)
     tcg_temp_free(tmp);
 }
 
+#if defined(CONFIG_SOFTMMU)
 DISAS_INSN(frestore)
 {
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+
     /* TODO: Implement frestore.  */
     cpu_abort(CPU(cpu), "FRESTORE not implemented");
 }
@@ -5075,9 +5088,15 @@ DISAS_INSN(fsave)
 {
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+
     /* TODO: Implement fsave.  */
     cpu_abort(CPU(cpu), "FSAVE not implemented");
 }
+#endif
 
 static inline TCGv gen_mac_extract_word(DisasContext *s, TCGv val, int upper)
 {
@@ -5502,7 +5521,9 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(not,       4680, fff8, CF_ISA_A);
     INSN(not,       4600, ff00, M68000);
     INSN(undef,     46c0, ffc0, M68000);
+#if defined(CONFIG_SOFTMMU)
     INSN(move_to_sr, 46c0, ffc0, CF_ISA_A);
+#endif
     INSN(nbcd,      4800, ffc0, M68000);
     INSN(linkl,     4808, fff8, M68000);
     BASE(pea,       4840, ffc0);
@@ -5517,7 +5538,9 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(tst,       4a00, ff00);
     INSN(tas,       4ac0, ffc0, CF_ISA_B);
     INSN(tas,       4ac0, ffc0, M68000);
+#if defined(CONFIG_SOFTMMU)
     INSN(halt,      4ac8, ffff, CF_ISA_A);
+#endif
     INSN(pulse,     4acc, ffff, CF_ISA_A);
     BASE(illegal,   4afc, ffff);
     INSN(mull,      4c00, ffc0, CF_ISA_A);
@@ -5528,14 +5551,16 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(trap,      4e40, fff0);
     BASE(link,      4e50, fff8);
     BASE(unlk,      4e58, fff8);
+#if defined(CONFIG_SOFTMMU)
     INSN(move_to_usp, 4e60, fff8, USP);
     INSN(move_from_usp, 4e68, fff8, USP);
-    BASE(nop,       4e71, ffff);
     BASE(stop,      4e72, ffff);
     BASE(rte,       4e73, ffff);
+    INSN(movec,     4e7b, ffff, CF_ISA_A);
+#endif
+    BASE(nop,       4e71, ffff);
     INSN(rtd,       4e74, ffff, RTD);
     BASE(rts,       4e75, ffff);
-    INSN(movec,     4e7b, ffff, CF_ISA_A);
     BASE(jump,      4e80, ffc0);
     BASE(jump,      4ec0, ffc0);
     INSN(addsubq,   5000, f080, M68000);
@@ -5639,19 +5664,21 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(undef_fpu, f000, f000);
     INSN(fpu,       f200, ffc0, CF_FPU);
     INSN(fbcc,      f280, ffc0, CF_FPU);
-    INSN(frestore,  f340, ffc0, CF_FPU);
-    INSN(fsave,     f300, ffc0, CF_FPU);
     INSN(fpu,       f200, ffc0, FPU);
     INSN(fscc,      f240, ffc0, FPU);
     INSN(fbcc,      f280, ff80, FPU);
+#if defined(CONFIG_SOFTMMU)
+    INSN(frestore,  f340, ffc0, CF_FPU);
+    INSN(fsave,     f300, ffc0, CF_FPU);
     INSN(frestore,  f340, ffc0, FPU);
     INSN(fsave,     f300, ffc0, FPU);
     INSN(intouch,   f340, ffc0, CF_ISA_A);
     INSN(cpushl,    f428, ff38, CF_ISA_A);
-    INSN(move16_mem, f600, ffe0, M68040);
-    INSN(move16_reg, f620, fff8, M68040);
     INSN(wddata,    fb00, ff00, CF_ISA_A);
     INSN(wdebug,    fbc0, ffc0, CF_ISA_A);
+#endif
+    INSN(move16_mem, f600, ffe0, M68040);
+    INSN(move16_reg, f620, fff8, M68040);
 #undef INSN
 }
 
-- 
2.14.3
