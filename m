Received: from eggs.gnu.org ([209.51.188.92]:34573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZD-0000Lp-6E
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZB-0004n9-T8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34601 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hGmZ9-0004lM-Ip
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:41 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Wed, 17 Apr 2019 17:33:26 +0200
Message-Id: <1555515206-9352-7-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 6/6] target/mips: Merge implementation of
 ILVOD.D and ILVL.D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, philmd@redhat.com, richard.henderson@linaro.org, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

The implementation for ILVOD.D and ILVL.D instructions
is equivalent, so use a single handler for both of them.

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 656153a..14aaf98 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29037,19 +29037,6 @@ static inline void gen_ilvl_w(CPUMIPSState *env, uint32_t wd,
 }
 
 /*
- * [MSA] ILVL.D wd, ws, wt
- *
- *   Vector Interleave Left (doubleword data elements)
- *
- */
-static inline void gen_ilvl_d(CPUMIPSState *env, uint32_t wd,
-                              uint32_t ws, uint32_t wt)
-{
-    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2 + 1]);
-    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
-}
-
-/*
  * [MSA] ILVOD.<B|H> wd, ws, wt
  *
  *   Vector Interleave Odd (<byte|halfword> data elements)
@@ -29115,9 +29102,15 @@ static inline void gen_ilvod_w(CPUMIPSState *env, uint32_t wd,
  *
  *   Vector Interleave Odd (doubleword data elements)
  *
+ * [MSA] ILVL.D wd, ws, wt
+ *
+ *   Vector Interleave Left (doubleword data elements)
+ *
+ *  These two instructions are functionally equivalent.
+ *
  */
-static inline void gen_ilvod_d(CPUMIPSState *env, uint32_t wd,
-                               uint32_t ws, uint32_t wt)
+static inline void gen_ilvod_ilvl_d(CPUMIPSState *env, uint32_t wd,
+                                    uint32_t ws, uint32_t wt)
 {
     tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2 + 1]);
     tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
@@ -29330,7 +29323,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvl_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvl_d(env, wd, ws, wt);
+            gen_ilvod_ilvl_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
@@ -29426,7 +29419,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvod_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvod_d(env, wd, ws, wt);
+            gen_ilvod_ilvl_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
-- 
2.7.4
