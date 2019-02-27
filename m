Received: from eggs.gnu.org ([209.51.188.92]:56985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gz3Dm-0000Xq-OG
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gz3Dl-0001P9-9U
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:42:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53616 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gz3Dk-00006z-Qq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:42:17 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Wed, 27 Feb 2019 18:40:15 +0100
Message-Id: <1551289217-10072-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551289217-10072-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551289217-10072-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] target/mips: Optimize support for MSA
 instructions ILVOD.<B|H|W|D>
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

Optimize support for MSA instructions ILVOD.B, ILVOD.H, ILVOD.W, and
ILVOD.D.

Optimization is done by eliminating loops, and explicitly assigning
desired values to individual data elements. Performance measurement
is done by executing the instructions large number of times on a
computer with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.

Measured time before optimization:
  ILVOD.B:  118.42 ms
  ILVOD.H:   93.45 ms
  ILVOD.W:  119.89 ms
  ILVOD.D:   46.00 ms

Measured time after optimization:
  ILVOD.B:   60.08 ms
  ILVOD.H:   41.52 ms
  ILVOD.W:   36.44 ms
  ILVOD.D:   36.40 ms

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/msa_helper.c | 58 ++++++++++++++++++++++++++++++++++++++++++=
------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 4e6584e..90ae44e 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1198,13 +1198,6 @@ MSA_FN_DF(ilvl_df)
 MSA_FN_DF(ilvr_df)
 #undef MSA_DO
=20
-#define MSA_DO(DF)                          \
-    do {                                    \
-        pwx->DF[2*i]   =3D pwt->DF[2*i+1];    \
-        pwx->DF[2*i+1] =3D pws->DF[2*i+1];    \
-    } while (0)
-MSA_FN_DF(ilvod_df)
-#undef MSA_DO
 #undef MSA_LOOP_COND
=20
 #define MSA_LOOP_COND(DF) \
@@ -1274,6 +1267,57 @@ void helper_msa_ilvev_df(CPUMIPSState *env, uint32=
_t df, uint32_t wd,
     }
 }
=20
+void helper_msa_ilvod_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+                         uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
+
+    switch (df) {
+    case DF_BYTE:
+        pwd->b[0]  =3D pwt->b[1];
+        pwd->b[1]  =3D pws->b[1];
+        pwd->b[2]  =3D pwt->b[3];
+        pwd->b[3]  =3D pws->b[3];
+        pwd->b[4]  =3D pwt->b[5];
+        pwd->b[5]  =3D pws->b[5];
+        pwd->b[6]  =3D pwt->b[7];
+        pwd->b[7]  =3D pws->b[7];
+        pwd->b[8]  =3D pwt->b[9];
+        pwd->b[9]  =3D pws->b[9];
+        pwd->b[10] =3D pwt->b[11];
+        pwd->b[11] =3D pws->b[11];
+        pwd->b[12] =3D pwt->b[13];
+        pwd->b[13] =3D pws->b[13];
+        pwd->b[14] =3D pwt->b[15];
+        pwd->b[15] =3D pws->b[15];
+        break;
+    case DF_HALF:
+        pwd->h[0] =3D pwt->h[1];
+        pwd->h[1] =3D pws->h[1];
+        pwd->h[2] =3D pwt->h[3];
+        pwd->h[3] =3D pws->h[3];
+        pwd->h[4] =3D pwt->h[5];
+        pwd->h[5] =3D pws->h[5];
+        pwd->h[6] =3D pwt->h[7];
+        pwd->h[7] =3D pws->h[7];
+        break;
+    case DF_WORD:
+        pwd->w[0] =3D pwt->w[1];
+        pwd->w[1] =3D pws->w[1];
+        pwd->w[2] =3D pwt->w[3];
+        pwd->w[3] =3D pws->w[3];
+        break;
+    case DF_DOUBLE:
+        pwd->d[0] =3D pwt->d[1];
+        pwd->d[1] =3D pws->d[1];
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
