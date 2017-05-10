Received: from eggs.gnu.org ([2001:4830:134:3::10]:35080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJy-0003Ep-U5
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJx-0000GD-GD
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8WJx-0000Fe-A5
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:45 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 10 May 2017 20:26:24 +0200
Message-Id: <20170510182636.17791-4-aurelien@aurel32.net>
In-Reply-To: <20170510182636.17791-1-aurelien@aurel32.net>
References: <20170510182636.17791-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 03/15] target/sh4: do not include
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
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
