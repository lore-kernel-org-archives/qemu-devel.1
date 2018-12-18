Received: from eggs.gnu.org ([2001:4830:134:3::10]:53164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ931-0001mk-Ev
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92u-0002wE-DO
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:07 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:37998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92u-0002jg-2B
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:00 -0500
Received: by mail-pf1-x434.google.com with SMTP id q1so7651546pfi.5
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:04 -0800
Message-Id: <20181218063911.2112-28-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 27/34] target/ppc: Use helper_mtvscr for reset
 and gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Not setting flush_to_zero from gdb_set_avr_reg was a bug.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate_init.inc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index b83097141c..292b1df700 100644
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
@@ -9556,7 +9555,7 @@ static int gdb_set_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     }
     if (n == 32) {
         ppc_maybe_bswap_register(env, mem_buf, 4);
-        env->vscr = ldl_p(mem_buf);
+        helper_mtvscr(env, ldl_p(mem_buf));
         return 4;
     }
     if (n == 33) {
-- 
2.17.2
