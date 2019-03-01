Received: from eggs.gnu.org ([209.51.188.92]:54363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gzhvI-0006yi-An
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gzhvH-0004LX-5B
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:56 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:58446 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gzhvG-0003n1-Qn
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:55 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Fri,  1 Mar 2019 14:08:40 +0100
Message-Id: <1551445720-19622-5-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551445720-19622-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551445720-19622-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/4] target/mips: Optimize support for MSA
 instructions ILVR.<B|H|W|D>
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

Optimize support for MSA instructions ILVR.B, ILVR.H, ILVR.W, and
ILVR.D.

Optimization is done by eliminating loops, and explicitly assigning
desired values to individual data elements. Performance measurement
is done by executing the instructions large number of times on a
computer with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

Measured time before optimization:
  ILVR.B:  115.84 ms
  ILVR.H:   94.20 ms
  ILVR.W:  121.12 ms
  ILVR.D:   41.36 ms

Measured time after optimization:
  ILVR.B:   61.06 ms
  ILVR.H:   43.03 ms
  ILVR.W:   39.21 ms
  ILVR.D:   39.18 ms

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/msa_helper.c | 59 +++++++++++++++++++++++++++++++++++++++++-=
------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index a91f5a6..4c7ec05 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1182,14 +1182,6 @@ MSA_FN_DF(pckev_df)
 MSA_FN_DF(pckod_df)
 #undef MSA_DO
=20
-#define MSA_DO(DF)                      \
-    do {                                \
-        pwx->DF[2*i]   =3D R##DF(pwt, i); \
-        pwx->DF[2*i+1] =3D R##DF(pws, i); \
-    } while (0)
-MSA_FN_DF(ilvr_df)
-#undef MSA_DO
-
 #undef MSA_LOOP_COND
=20
 #define MSA_LOOP_COND(DF) \
@@ -1361,6 +1353,57 @@ void helper_msa_ilvl_df(CPUMIPSState *env, uint32_=
t df, uint32_t wd,
     }
 }
=20
+void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                        uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[15] =3D pws->b[7];
+        pwd->b[14] =3D pwt->b[7];
+        pwd->b[13] =3D pws->b[6];
+        pwd->b[12] =3D pwt->b[6];
+        pwd->b[11] =3D pws->b[5];
+        pwd->b[10] =3D pwt->b[5];
+        pwd->b[9]  =3D pws->b[4];
+        pwd->b[8]  =3D pwt->b[4];
+        pwd->b[7]  =3D pws->b[3];
+        pwd->b[6]  =3D pwt->b[3];
+        pwd->b[5]  =3D pws->b[2];
+        pwd->b[4]  =3D pwt->b[2];
+        pwd->b[3]  =3D pws->b[1];
+        pwd->b[2]  =3D pwt->b[1];
+        pwd->b[1]  =3D pws->b[0];
+        pwd->b[0]  =3D pwt->b[0];
+        break;
+    case DF_HALF:
+        pwd->h[7] =3D pws->h[3];
+        pwd->h[6] =3D pwt->h[3];
+        pwd->h[5] =3D pws->h[2];
+        pwd->h[4] =3D pwt->h[2];
+        pwd->h[3] =3D pws->h[1];
+        pwd->h[2] =3D pwt->h[1];
+        pwd->h[1] =3D pws->h[0];
+        pwd->h[0] =3D pwt->h[0];
+        break;
+    case DF_WORD:
+        pwd->w[3] =3D pws->w[1];
+        pwd->w[2] =3D pwt->w[1];
+        pwd->w[1] =3D pws->w[0];
+        pwd->w[0] =3D pwt->w[0];
+        break;
+    case DF_DOUBLE:
+        pwd->d[1] =3D pws->d[0];
+        pwd->d[0] =3D pwt->d[0];
+        break;
+    default:
+        assert(0);
+    }
+}
+
 void helper_msa_sldi_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t n)
 {
--=20
2.7.4
