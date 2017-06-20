Received: from eggs.gnu.org ([2001:4830:134:3::10]:55428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNQ87-0008EJ-0Q
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNQ82-0004Ff-DG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dNQ82-0004F2-3B
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 16:52:02 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Jun 2017 22:51:17 +0200
Message-Id: <20170620205121.26515-3-laurent@vivier.eu>
In-Reply-To: <20170620205121.26515-1-laurent@vivier.eu>
References: <20170620205121.26515-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 2/6] target-m68k: initialize FPU registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

on reset, set FP registers to NaN and control registers to 0

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f068922..f2e031f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -49,6 +49,8 @@ static void m68k_cpu_reset(CPUState *s)
     M68kCPU *cpu = M68K_CPU(s);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(cpu);
     CPUM68KState *env = &cpu->env;
+    float64 nan = float64_default_nan(NULL);
+    int i;
 
     mcc->parent_reset(s);
 
@@ -57,7 +59,12 @@ static void m68k_cpu_reset(CPUState *s)
     env->sr = 0x2700;
 #endif
     m68k_switch_sp(env);
-    /* ??? FP regs should be initialized to NaN.  */
+    for (i = 0; i < 8; i++) {
+        env->fregs[i] = nan;
+    }
+    env->fpcr = 0;
+    env->fpsr = 0;
+
     cpu_m68k_set_ccr(env, 0);
     /* TODO: We should set PC from the interrupt vector.  */
     env->pc = 0;
-- 
2.9.4
