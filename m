Received: from eggs.gnu.org ([209.51.188.92]:53587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH5Sg-0003DM-8E
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH5Se-0006ap-Bv
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:14 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50796 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hH5Sa-0006NR-KU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:10 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Thu, 18 Apr 2019 13:42:45 +0200
Message-Id: <1555587766-985-6-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1555587766-985-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555587766-985-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 5/6] target/mips: Merge implementation of
 ILVEV.D and ILVR.D
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

The implementation for ILVEV.D and ILVR.D instructions
is equivalent, so use a single handler for both of them.

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d4bbfc3..c6aa995 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28078,20 +28078,6 @@ static inline void gen_ilvr_w(CPUMIPSState *env, uint32_t wd,
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
@@ -28314,11 +28300,17 @@ static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
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
-                               uint32_t ws, uint32_t wt)
+static inline void gen_ilvev_ilvr_d(CPUMIPSState *env, uint32_t wd,
+                                    uint32_t ws, uint32_t wt)
 {
     tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
     tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
@@ -28491,7 +28483,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvr_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvr_d(env, wd, ws, wt);
+            gen_ilvev_ilvr_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
@@ -28521,7 +28513,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
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
