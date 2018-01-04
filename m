Received: from eggs.gnu.org ([2001:4830:134:3::10]:58373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWuLU-0000r7-4S
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWuLQ-00077E-FP
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:23 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWuLQ-00075V-4B
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:20 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 02:29:00 +0100
Message-Id: <20180104012913.30763-5-laurent@vivier.eu>
In-Reply-To: <20180104012913.30763-1-laurent@vivier.eu>
References: <20180104012913.30763-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v7 04/17] target/m68k: use insn_pc to generate
 instruction fault address
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

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 1e9fb01252..a1e424e3db 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1509,12 +1509,12 @@ DISAS_INSN(dbcc)
 
 DISAS_INSN(undef_mac)
 {
-    gen_exception(s, s->pc - 2, EXCP_LINEA);
+    gen_exception(s, s->insn_pc, EXCP_LINEA);
 }
 
 DISAS_INSN(undef_fpu)
 {
-    gen_exception(s, s->pc - 2, EXCP_LINEF);
+    gen_exception(s, s->insn_pc, EXCP_LINEF);
 }
 
 DISAS_INSN(undef)
@@ -1523,8 +1523,8 @@ DISAS_INSN(undef)
        for the 680x0 series, as well as those that are implemented
        but actually illegal for CPU32 or pre-68020.  */
     qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x",
-                  insn, s->pc - 2);
-    gen_exception(s, s->pc - 2, EXCP_UNSUPPORTED);
+                  insn, s->insn_pc);
+    gen_exception(s, s->insn_pc, EXCP_UNSUPPORTED);
 }
 
 DISAS_INSN(mulw)
@@ -2583,7 +2583,7 @@ DISAS_INSN(swap)
 
 DISAS_INSN(bkpt)
 {
-    gen_exception(s, s->pc - 2, EXCP_DEBUG);
+    gen_exception(s, s->insn_pc, EXCP_DEBUG);
 }
 
 DISAS_INSN(pea)
@@ -2636,7 +2636,7 @@ DISAS_INSN(pulse)
 
 DISAS_INSN(illegal)
 {
-    gen_exception(s, s->pc - 2, EXCP_ILLEGAL);
+    gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
 }
 
 /* ??? This should be atomic.  */
@@ -2666,7 +2666,7 @@ DISAS_INSN(mull)
 
     if (ext & 0x400) {
         if (!m68k_feature(s->env, M68K_FEATURE_QUAD_MULDIV)) {
-            gen_exception(s, s->pc - 4, EXCP_UNSUPPORTED);
+            gen_exception(s, s->insn_pc, EXCP_UNSUPPORTED);
             return;
         }
 
@@ -4240,7 +4240,7 @@ DISAS_INSN(move_from_sr)
     TCGv sr;
 
     if (IS_USER(s) && !m68k_feature(env, M68K_FEATURE_M68000)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
     sr = gen_get_sr(s);
@@ -4250,7 +4250,7 @@ DISAS_INSN(move_from_sr)
 DISAS_INSN(move_to_sr)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
     gen_set_sr(env, s, insn, 0);
@@ -4260,7 +4260,7 @@ DISAS_INSN(move_to_sr)
 DISAS_INSN(move_from_usp)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
     tcg_gen_ld_i32(AREG(insn, 0), cpu_env,
@@ -4270,7 +4270,7 @@ DISAS_INSN(move_from_usp)
 DISAS_INSN(move_to_usp)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
     tcg_gen_st_i32(AREG(insn, 0), cpu_env,
@@ -4287,7 +4287,7 @@ DISAS_INSN(stop)
     uint16_t ext;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4301,10 +4301,10 @@ DISAS_INSN(stop)
 DISAS_INSN(rte)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
-    gen_exception(s, s->pc - 2, EXCP_RTE);
+    gen_exception(s, s->insn_pc, EXCP_RTE);
 }
 
 DISAS_INSN(movec)
@@ -4313,7 +4313,7 @@ DISAS_INSN(movec)
     TCGv reg;
 
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
 
@@ -4331,7 +4331,7 @@ DISAS_INSN(movec)
 DISAS_INSN(intouch)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
     /* ICache fetch.  Implement as no-op.  */
@@ -4340,7 +4340,7 @@ DISAS_INSN(intouch)
 DISAS_INSN(cpushl)
 {
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
     /* Cache push/invalidate.  Implement as no-op.  */
@@ -4348,7 +4348,7 @@ DISAS_INSN(cpushl)
 
 DISAS_INSN(wddata)
 {
-    gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+    gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
 }
 
 DISAS_INSN(wdebug)
@@ -4356,7 +4356,7 @@ DISAS_INSN(wdebug)
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
     if (IS_USER(s)) {
-        gen_exception(s, s->pc - 2, EXCP_PRIVILEGE);
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
     /* TODO: Implement wdebug.  */
@@ -4365,7 +4365,7 @@ DISAS_INSN(wdebug)
 
 DISAS_INSN(trap)
 {
-    gen_exception(s, s->pc - 2, EXCP_TRAP0 + (insn & 0xf));
+    gen_exception(s, s->insn_pc, EXCP_TRAP0 + (insn & 0xf));
 }
 
 static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
-- 
2.14.3
