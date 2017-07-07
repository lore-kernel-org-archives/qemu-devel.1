Received: from eggs.gnu.org ([2001:4830:134:3::10]:33940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIuD-00013B-GU
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIuA-0007qC-Ce
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:05 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIuA-0007pq-8D
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:02 -0400
Received: by mail-qk0-x244.google.com with SMTP id p21so2754640qke.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:22:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:48 -1000
Message-Id: <20170707022111.21836-5-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 04/27] target/sh4: Keep env->flags clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

If we mask off any out-of-band bits before we assign to the
variable, then we don't need to clean it up when reading.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/cpu.h | 2 +-
 target/sh4/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 240ed36..6d179a7 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -391,7 +391,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = (env->flags & TB_FLAG_ENVFLAGS_MASK) /* Bits  0-2 */
+    *flags = env->flags                                        /* Bits  0-2 */
             | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
             | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
             | (env->sr & (1u << SR_FD))                        /* Bit 15 */
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 9da7e1e..8536f6d 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -39,7 +39,7 @@ static void superh_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
     SuperHCPU *cpu = SUPERH_CPU(cs);
 
     cpu->env.pc = tb->pc;
-    cpu->env.flags = tb->flags;
+    cpu->env.flags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
 }
 
 static bool superh_cpu_has_work(CPUState *cs)
-- 
2.9.4
