Received: from eggs.gnu.org ([2001:4830:134:3::10]:48704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPn-0005mO-Ln
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-00041J-JH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:23 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Uu-4i
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:27 +0200
Message-Id: <20170718215050.3812-9-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/31] target/sh4: Keep env->flags clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

If we mask off any out-of-band bits before we assign to the
variable, then we don't need to clean it up when reading.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-5-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.c | 2 +-
 target/sh4/cpu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 9da7e1ed38..8536f6d002 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -39,7 +39,7 @@ static void superh_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
     SuperHCPU *cpu = SUPERH_CPU(cs);
 
     cpu->env.pc = tb->pc;
-    cpu->env.flags = tb->flags;
+    cpu->env.flags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
 }
 
 static bool superh_cpu_has_work(CPUState *cs)
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 4aa92d5f30..a7a6811a8c 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -390,7 +390,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = (env->flags & TB_FLAG_ENVFLAGS_MASK) /* Bits  0-2 */
+    *flags = env->flags                                        /* Bits  0-2 */
             | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
             | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
             | (env->sr & (1u << SR_FD))                        /* Bit 15 */
-- 
2.11.0
