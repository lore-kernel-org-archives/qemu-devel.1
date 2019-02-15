Received: from eggs.gnu.org ([209.51.188.92]:55213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaPb-0002tq-T8
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaPW-0002HB-MM
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:08:03 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:51 +0000
Message-Id: <20190215100058.20015-11-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 10/17] target/ppc: Use helper_mtvscr for reset
 and gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

From: Richard Henderson <richard.henderson@linaro.org>

Not setting flush_to_zero from gdb_set_avr_reg was a bug.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.inc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 59e0b86762..c8b2b760e5 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -601,10 +601,9 @@ static void spr_write_excp_vector(DisasContext *ctx, int sprn, int gprn)
 
 static inline void vscr_init(CPUPPCState *env, uint32_t val)
 {
-    env->vscr = val;
     /* Altivec always uses round-to-nearest */
     set_float_rounding_mode(float_round_nearest_even, &env->vec_status);
-    set_flush_to_zero(vscr_nj, &env->vec_status);
+    helper_mtvscr(env, val);
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -9550,7 +9549,7 @@ static int gdb_set_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     }
     if (n == 32) {
         ppc_maybe_bswap_register(env, mem_buf, 4);
-        env->vscr = ldl_p(mem_buf);
+        helper_mtvscr(env, ldl_p(mem_buf));
         return 4;
     }
     if (n == 33) {
-- 
2.11.0
