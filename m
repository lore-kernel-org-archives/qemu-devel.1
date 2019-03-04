Received: from eggs.gnu.org ([209.51.188.92]:52883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0qoR-0005fc-Rp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0qoQ-0007jB-N7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:51:35 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:44291 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h0qoQ-0007hD-Au
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:51:34 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  4 Mar 2019 17:51:22 +0100
Message-Id: <1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/2] target/mips: Improve performance for MSA
 binary operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Eliminate loops for better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/msa_helper.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 4c7ec05..1152fda 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -804,28 +804,45 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);                          \
     wr_t *pwt = &(env->active_fpu.fpr[wt].wr);                          \
-    uint32_t i;                                                         \
                                                                         \
     switch (df) {                                                       \
     case DF_BYTE:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_BYTE); i++) {                    \
-            pwd->b[i] = msa_ ## func ## _df(df, pws->b[i], pwt->b[i]);  \
-        }                                                               \
+        pwd->b[0]  = msa_ ## func ## _df(df, pws->b[0], pwt->b[0]);     \
+        pwd->b[1]  = msa_ ## func ## _df(df, pws->b[1], pwt->b[1]);     \
+        pwd->b[2]  = msa_ ## func ## _df(df, pws->b[2], pwt->b[2]);     \
+        pwd->b[3]  = msa_ ## func ## _df(df, pws->b[3], pwt->b[3]);     \
+        pwd->b[4]  = msa_ ## func ## _df(df, pws->b[4], pwt->b[4]);     \
+        pwd->b[5]  = msa_ ## func ## _df(df, pws->b[5], pwt->b[5]);     \
+        pwd->b[6]  = msa_ ## func ## _df(df, pws->b[6], pwt->b[6]);     \
+        pwd->b[7]  = msa_ ## func ## _df(df, pws->b[7], pwt->b[7]);     \
+        pwd->b[8]  = msa_ ## func ## _df(df, pws->b[8], pwt->b[8]);     \
+        pwd->b[9]  = msa_ ## func ## _df(df, pws->b[9], pwt->b[9]);     \
+        pwd->b[10] = msa_ ## func ## _df(df, pws->b[10], pwt->b[10]);   \
+        pwd->b[11] = msa_ ## func ## _df(df, pws->b[11], pwt->b[11]);   \
+        pwd->b[12] = msa_ ## func ## _df(df, pws->b[12], pwt->b[12]);   \
+        pwd->b[13] = msa_ ## func ## _df(df, pws->b[13], pwt->b[13]);   \
+        pwd->b[14] = msa_ ## func ## _df(df, pws->b[14], pwt->b[14]);   \
+        pwd->b[15] = msa_ ## func ## _df(df, pws->b[15], pwt->b[15]);   \
         break;                                                          \
     case DF_HALF:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_HALF); i++) {                    \
-            pwd->h[i] = msa_ ## func ## _df(df, pws->h[i], pwt->h[i]);  \
-        }                                                               \
+        pwd->h[0] = msa_ ## func ## _df(df, pws->h[0], pwt->h[0]);      \
+        pwd->h[1] = msa_ ## func ## _df(df, pws->h[1], pwt->h[1]);      \
+        pwd->h[2] = msa_ ## func ## _df(df, pws->h[2], pwt->h[2]);      \
+        pwd->h[3] = msa_ ## func ## _df(df, pws->h[3], pwt->h[3]);      \
+        pwd->h[4] = msa_ ## func ## _df(df, pws->h[4], pwt->h[4]);      \
+        pwd->h[5] = msa_ ## func ## _df(df, pws->h[5], pwt->h[5]);      \
+        pwd->h[6] = msa_ ## func ## _df(df, pws->h[6], pwt->h[6]);      \
+        pwd->h[7] = msa_ ## func ## _df(df, pws->h[7], pwt->h[7]);      \
         break;                                                          \
     case DF_WORD:                                                       \
-        for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {                    \
-            pwd->w[i] = msa_ ## func ## _df(df, pws->w[i], pwt->w[i]);  \
-        }                                                               \
+        pwd->w[0] = msa_ ## func ## _df(df, pws->w[0], pwt->w[0]);      \
+        pwd->w[1] = msa_ ## func ## _df(df, pws->w[1], pwt->w[1]);      \
+        pwd->w[2] = msa_ ## func ## _df(df, pws->w[2], pwt->w[2]);      \
+        pwd->w[3] = msa_ ## func ## _df(df, pws->w[3], pwt->w[3]);      \
         break;                                                          \
     case DF_DOUBLE:                                                     \
-        for (i = 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {                  \
-            pwd->d[i] = msa_ ## func ## _df(df, pws->d[i], pwt->d[i]);  \
-        }                                                               \
+        pwd->d[0] = msa_ ## func ## _df(df, pws->d[0], pwt->d[0]);      \
+        pwd->d[1] = msa_ ## func ## _df(df, pws->d[1], pwt->d[1]);      \
         break;                                                          \
     default:                                                            \
         assert(0);                                                      \
-- 
2.7.4
