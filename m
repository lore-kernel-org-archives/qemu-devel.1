Received: from eggs.gnu.org ([2001:4830:134:3::10]:60935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHXJF-00025r-IC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHXJB-0000s2-Er
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:56:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gHXJA-0000pv-Vs
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:56:01 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 30 Oct 2018 17:55:54 +0100
Message-Id: <20181030165554.5761-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] target/m68k: use EXCP_ILLEGAL instead of
 EXCP_UNSUPPORTED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Coldfire defines an "Unsupported instruction" exception if execution
of a valid instruction is attempted but the required hardware is not
present in the processor.

We use it with instructions that are in fact undefined or illegal,
and the exception expected in this case by the kernel is the
illegal exception, so this patch fixes that.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/m68k/cpu_loop.c | 1 -
 target/m68k/cpu.h          | 1 -
 target/m68k/translate.c    | 6 +++---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index b4d3d8af3d..30c3332af4 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -55,7 +55,6 @@ void cpu_loop(CPUM68KState *env)
             break;
         case EXCP_LINEA:
         case EXCP_LINEF:
-        case EXCP_UNSUPPORTED:
         do_sigill:
             info.si_signo = TARGET_SIGILL;
             info.si_errno = 0;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 45e87deaef..d3980e5b9a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -70,7 +70,6 @@
 #define EXCP_MMU_CONF       56  /* MMU Configuration Error */
 #define EXCP_MMU_ILLEGAL    57  /* MMU Illegal Operation Error */
 #define EXCP_MMU_ACCESS     58  /* MMU Access Level Violation Error */
-#define EXCP_UNSUPPORTED    61
 
 #define EXCP_RTE            0x100
 #define EXCP_HALT_INSN      0x101
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 795c88e52f..3a00ac36b4 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1552,7 +1552,7 @@ DISAS_INSN(undef)
        but actually illegal for CPU32 or pre-68020.  */
     qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
                   insn, s->base.pc_next);
-    gen_exception(s, s->base.pc_next, EXCP_UNSUPPORTED);
+    gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 }
 
 DISAS_INSN(mulw)
@@ -2799,7 +2799,7 @@ DISAS_INSN(mull)
 
     if (ext & 0x400) {
         if (!m68k_feature(s->env, M68K_FEATURE_QUAD_MULDIV)) {
-            gen_exception(s, s->base.pc_next, EXCP_UNSUPPORTED);
+            gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
             return;
         }
 
@@ -4509,7 +4509,7 @@ DISAS_INSN(strldsr)
     addr = s->pc - 2;
     ext = read_im16(env, s);
     if (ext != 0x46FC) {
-        gen_exception(s, addr, EXCP_UNSUPPORTED);
+        gen_exception(s, addr, EXCP_ILLEGAL);
         return;
     }
     ext = read_im16(env, s);
-- 
2.17.2
