Received: from eggs.gnu.org ([209.51.188.92]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZD-0000Lo-5z
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZB-0004nR-Uk
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34600 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hGmZB-0004lK-2C
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:41 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Wed, 17 Apr 2019 17:33:25 +0200
Message-Id: <1555515206-9352-6-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 4/6] target/mips: Optimize ILVR.<B|H|W|D>
 MSA instructions
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

>From 55e222d8139e3dd034069fb512b83fd2541ec067 Mon Sep 17 00:00:00 2001
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Date: Wed, 17 Apr 2019 14:50:55 +0200
Subject: [PATCH v7 5/6] target/mips: Merge implementation of ILVEV.D and ILVR.D

The implementation for ILVEV.D and ILVR.D instructions
is equivalent, so use a single handler for both of them.

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4c7b076..656153a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28961,20 +28961,6 @@ static inline void gen_ilvr_w(CPUMIPSState *env, uint32_t wd,
 }
 
 /*
- * [MSA] ILVR.D wd, ws, wt
- *
- *   Vector Interleave Right (doubleword data elements)
- *
- */
-static inline void gen_ilvr_d(CPUMIPSState *env, uint32_t wd,
-                              uint32_t ws, uint32_t wt)
-{
-    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
-    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
-}
-
-
-/*
  * [MSA] ILVL.H wd, ws, wt
  *
  *   Vector Interleave Left (halfword data elements)
@@ -29197,10 +29183,16 @@ static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
 /*
  * [MSA] ILVEV.D wd, ws, wt
  *
- *   Vector Interleave Even (Doubleword data elements)
+ *   Vector Interleave Even (doubleword data elements)
+ *
+ * [MSA] ILVR.D wd, ws, wt
+ *
+ *   Vector Interleave Right (doubleword data elements)
+ *
+ *  These two instructions are functionally equivalent.
  *
  */
-static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
+static inline void gen_ilvev_ilvr_d(CPUMIPSState *env, uint32_t wd,
                                     uint32_t ws, uint32_t wt)
 {
     tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
@@ -29374,7 +29366,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvr_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvr_d(env, wd, ws, wt);
+            gen_ilvev_ilvr_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
@@ -29404,7 +29396,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvev_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvev_d(env, wd, ws, wt);
+            gen_ilvev_ilvr_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
-- 
2.7.4
