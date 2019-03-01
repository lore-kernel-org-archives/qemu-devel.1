Received: from eggs.gnu.org ([209.51.188.92]:54318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gzhvD-0006wA-HU
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gzhvC-0004GP-C9
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:51 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:58448 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gzhvC-0003oG-0i
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:09:50 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Fri,  1 Mar 2019 14:08:37 +0100
Message-Id: <1551445720-19622-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551445720-19622-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551445720-19622-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] target/mips: Optimize support for MSA
 instructions ILVEV.<B|H|W|D>
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

Optimize support for MSA instructions ILVEV.B, ILVEV.H, ILVEV.W, and
ILVEV.D.

Optimization is done by eliminating loops, and explicitly assigning
desired values to individual data elements. Performance measurement
is done by executing the instructions large number of times on a
computer with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

Measured time before optimization:
  ILVEV.B:  119.02 ms
  ILVEV.H:   94.16 ms
  ILVEV.W:  120.97 ms
  ILVEV.D:   42.99 ms

Measured time after optimization:
  ILVEV.B:   61.81 ms
  ILVEV.H:   42.78 ms
  ILVEV.W:   39.47 ms
  ILVEV.D:   39.11 ms

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/msa_helper.c | 60 +++++++++++++++++++++++++++++++++++++++++-=
------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index c74e3cd..49332e6 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1198,14 +1198,6 @@ MSA_FN_DF(ilvl_df)
 MSA_FN_DF(ilvr_df)
 #undef MSA_DO
=20
-#define MSA_DO(DF)                      \
-    do {                                \
-        pwx->DF[2*i]   =3D pwt->DF[2*i];  \
-        pwx->DF[2*i+1] =3D pws->DF[2*i];  \
-    } while (0)
-MSA_FN_DF(ilvev_df)
-#undef MSA_DO
-
 #define MSA_DO(DF)                          \
     do {                                    \
         pwx->DF[2*i]   =3D pwt->DF[2*i+1];    \
@@ -1230,6 +1222,58 @@ MSA_FN_DF(vshf_df)
 #undef MSA_LOOP_COND
 #undef MSA_FN_DF
=20
+
+void helper_msa_ilvev_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                         uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[15] =3D pws->b[14];
+        pwd->b[14] =3D pwt->b[14];
+        pwd->b[13] =3D pws->b[12];
+        pwd->b[12] =3D pwt->b[12];
+        pwd->b[11] =3D pws->b[10];
+        pwd->b[10] =3D pwt->b[10];
+        pwd->b[9]  =3D pws->b[8];
+        pwd->b[8]  =3D pwt->b[8];
+        pwd->b[7]  =3D pws->b[6];
+        pwd->b[6]  =3D pwt->b[6];
+        pwd->b[5]  =3D pws->b[4];
+        pwd->b[4]  =3D pwt->b[4];
+        pwd->b[3]  =3D pws->b[2];
+        pwd->b[2]  =3D pwt->b[2];
+        pwd->b[1]  =3D pws->b[0];
+        pwd->b[0]  =3D pwt->b[0];
+        break;
+    case DF_HALF:
+        pwd->h[7] =3D pws->h[6];
+        pwd->h[6] =3D pwt->h[6];
+        pwd->h[5] =3D pws->h[4];
+        pwd->h[4] =3D pwt->h[4];
+        pwd->h[3] =3D pws->h[2];
+        pwd->h[2] =3D pwt->h[2];
+        pwd->h[1] =3D pws->h[0];
+        pwd->h[0] =3D pwt->h[0];
+        break;
+    case DF_WORD:
+        pwd->w[3] =3D pws->w[2];
+        pwd->w[2] =3D pwt->w[2];
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
