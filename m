Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX3-0007YB-Kd
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX2-0004EJ-Mz
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:01 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5JX2-0004Ak-HI
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:00 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  2 May 2017 00:10:35 +0200
Message-Id: <20170501221046.9369-4-aurelien@aurel32.net>
In-Reply-To: <20170501221046.9369-1-aurelien@aurel32.net>
References: <20170501221046.9369-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 03/14] target/sh4: do not include
 DELAY_SLOT_TRUE in the TB state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

DELAY_SLOT_TRUE is used as a dynamic condition for the branch after the
delay slot instruction. It is not used in code generation, so there is
no need to including in the TB state.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 9445cc779f..da8d15f1b9 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -382,8 +382,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = (env->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL
-                    | DELAY_SLOT_TRUE))                        /* Bits  0- 2 */
+    *flags = (env->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) /* Bits 0-1 */
             | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
             | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
             | (env->sr & (1u << SR_FD))                        /* Bit 15 */
-- 
2.11.0
