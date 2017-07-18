Received: from eggs.gnu.org ([2001:4830:134:3::10]:48126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaOZ-0004km-9k
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaOY-0003Wa-7r
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Uq-1Q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:28 +0200
Message-Id: <20170718215050.3812-10-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/31] target/sh4: Adjust TB_FLAG_PENDING_MOVCA
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

Don't leave an unused bit after DELAY_SLOT_MASK.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-6-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index a7a6811a8c..319a7555e1 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -96,6 +96,8 @@
 #define DELAY_SLOT_CONDITIONAL (1 << 1)
 #define DELAY_SLOT_RTE         (1 << 2)
 
+#define TB_FLAG_PENDING_MOVCA  (1 << 3)
+
 #define TB_FLAG_ENVFLAGS_MASK  DELAY_SLOT_MASK
 
 typedef struct tlb_t {
@@ -368,8 +370,6 @@ static inline int cpu_ptel_pr (uint32_t ptel)
 #define PTEA_TC        (1 << 3)
 #define cpu_ptea_tc(ptea) (((ptea) & PTEA_TC) >> 3)
 
-#define TB_FLAG_PENDING_MOVCA  (1 << 4)
-
 static inline target_ulong cpu_read_sr(CPUSH4State *env)
 {
     return env->sr | (env->sr_m << SR_M) |
@@ -394,7 +394,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
             | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
             | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
             | (env->sr & (1u << SR_FD))                        /* Bit 15 */
-            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 4 */
+            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
 }
 
 #endif /* SH4_CPU_H */
-- 
2.11.0
