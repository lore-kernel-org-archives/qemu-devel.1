Received: from eggs.gnu.org ([209.51.188.92]:53450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hAy64-0004ST-5a
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hAy62-0003e7-9R
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:39:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44912 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hAy60-0002pu-C5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:39:33 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  1 Apr 2019 16:38:21 +0200
Message-Id: <1554129501-27175-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] target/mips: MOD_<U|S>.<B|H|W|D> MSA
 insturctions fixed
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

In case of dividing integers by zero, the result is unpredictable [1],
but according to the hardware, the result is not zero, but the dividend.

[1] MIPS=C2=AE Architecture for Programmers
    Volume IV-j: The MIPS64=C2=AE SIMD
    Architecture Module, Revision 1.12

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/msa_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 46a5aac..bdfbc95 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -659,14 +659,14 @@ static inline int64_t msa_mod_s_df(uint32_t df, int=
64_t arg1, int64_t arg2)
     if (arg1 =3D=3D DF_MIN_INT(df) && arg2 =3D=3D -1) {
         return 0;
     }
-    return arg2 ? arg1 % arg2 : 0;
+    return arg2 ? arg1 % arg2 : arg1;
 }
=20
 static inline int64_t msa_mod_u_df(uint32_t df, int64_t arg1, int64_t ar=
g2)
 {
     uint64_t u_arg1 =3D UNSIGNED(arg1, df);
     uint64_t u_arg2 =3D UNSIGNED(arg2, df);
-    return u_arg2 ? u_arg1 % u_arg2 : 0;
+    return u_arg2 ? u_arg1 % u_arg2 : u_arg1;
 }
=20
 #define SIGNED_EVEN(a, df) \
--=20
2.7.4
