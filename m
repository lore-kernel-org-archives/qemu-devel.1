Received: from eggs.gnu.org ([2001:4830:134:3::10]:33965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIuH-00016Q-BU
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIuG-0007vp-En
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:09 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIuG-0007us-AY
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:22:08 -0400
Received: by mail-qk0-x243.google.com with SMTP id 91so2758996qkq.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:22:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:49 -1000
Message-Id: <20170707022111.21836-6-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 05/27] target/sh4: Adjust
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
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

Don't leave an unused bit after DELAY_SLOT_MASK.

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
