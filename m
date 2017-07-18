Received: from eggs.gnu.org ([2001:4830:134:3::10]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYii-00066C-Ha
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYih-0004Vi-Ne
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:48 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYih-0004VI-Iu
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:47 -0400
Received: by mail-qk0-x241.google.com with SMTP id q66so3779676qki.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:03:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:30 -1000
Message-Id: <20170718200255.31647-6-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/30] target/sh4: Adjust
 TB_FLAG_PENDING_MOVCA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Don't leave an unused bit after DELAY_SLOT_MASK.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 6d179a7..da31805 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -96,6 +96,8 @@
 #define DELAY_SLOT_CONDITIONAL (1 << 1)
 #define DELAY_SLOT_RTE         (1 << 2)
 
+#define TB_FLAG_PENDING_MOVCA  (1 << 3)
+
 #define TB_FLAG_ENVFLAGS_MASK  DELAY_SLOT_MASK
 
 typedef struct tlb_t {
@@ -369,8 +371,6 @@ static inline int cpu_ptel_pr (uint32_t ptel)
 #define PTEA_TC        (1 << 3)
 #define cpu_ptea_tc(ptea) (((ptea) & PTEA_TC) >> 3)
 
-#define TB_FLAG_PENDING_MOVCA  (1 << 4)
-
 static inline target_ulong cpu_read_sr(CPUSH4State *env)
 {
     return env->sr | (env->sr_m << SR_M) |
@@ -395,7 +395,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
             | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
             | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
             | (env->sr & (1u << SR_FD))                        /* Bit 15 */
-            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 4 */
+            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
 }
 
 #endif /* SH4_CPU_H */
-- 
2.9.4
