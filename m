Received: from eggs.gnu.org ([2001:4830:134:3::10]:55823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEaM-0000ST-TY
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEaL-00023A-PX
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:06 -0400
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:45841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkEaL-000233-KZ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:05 -0400
Received: by mail-ua0-x236.google.com with SMTP id k8-v6so8730485uaq.12
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:16:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 30 Jul 2018 16:15:52 -0400
Message-Id: <20180730201553.32423-4-richard.henderson@linaro.org>
In-Reply-To: <20180730201553.32423-1-richard.henderson@linaro.org>
References: <20180730201553.32423-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] linux-user/sparc: Fix cpu_clone_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

We failed to set the secondary return value in %o1
we failed to advance the PC past the syscall, and
we failed to adjust regwptr into the new structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_cpu.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index a92748cae3..c223f865e9 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -23,11 +23,21 @@
 static inline void cpu_clone_regs(CPUSPARCState *env, CPUSPARCState *old_env,
                                   target_ulong newsp)
 {
+    /*
+     * After cpu_copy, env->regwptr is pointing into old_env.
+     * Update the new cpu to use its own register window.
+     */
+    env->regwptr = env->regbase + (env->cwp * 16);
+
+    /* Set a new stack, if requested.  */
     if (newsp) {
         env->regwptr[22] = newsp;
     }
-    /* syscall return for clone child: 0, and clear CF since
-     * this counts as a success return value.
+
+    /*
+     * Syscall return for clone child: %o0 = 0 and clear CF since
+     * this counts as a success return value.  %o1 = 1 to indicate
+     * this is the child.  Advance the PC past the syscall.
      */
     env->regwptr[0] = 0;
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
@@ -35,6 +45,12 @@ static inline void cpu_clone_regs(CPUSPARCState *env, CPUSPARCState *old_env,
 #else
     env->psr &= ~PSR_CARRY;
 #endif
+    env->regwptr[1] = 1;
+    env->pc = env->npc;
+    env->npc = env->npc + 4;
+
+    /* Set the second return value for the parent: %o1 = 0.  */
+    old_env->regwptr[1] = 0;
 }
 
 static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
-- 
2.17.1
