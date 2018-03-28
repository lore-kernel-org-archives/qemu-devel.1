Received: from eggs.gnu.org ([2001:4830:134:3::10]:53876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f1BBZ-0001nL-Dw
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f1BBW-00084g-9D
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:32:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1f1BBW-00084E-5c
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:32:14 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 28 Mar 2018 15:31:52 +0200
Message-Id: <20180328133152.24623-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tcg: fix 16-byte vector operations detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Miroslav Rezanina <mrezanin@redhat.com>, Laurent Vivier <lvivier@redhat.com>

configure tries to detect if the compiler
supports 16-byte vector operations.

As stated in the comment of the detection
program, there is a problem with the system
compiler on GCC on Centos 7.

This program doesn't actually detect the problem
with GCC on RHEL7 on PPC64LE (Red Hat 4.8.5-28).

This patch updates the test to look more like
it is in QEMU helpers, and now detects the problem.

The error reported is:

  CC      ppc64-softmmu/accel/tcg/tcg-runtime-gvec.o
  ..//accel/tcg/tcg-runtime-gvec.c: In function =E2=80=98helper_gvec_shl8=
i=E2=80=99:
  ../accel/tcg/tcg-runtime-gvec.c:558:26: internal compiler error: in emi=
t_move_insn, at expr.c:3495
           *(vec8 *)(d + i) =3D *(vec8 *)(a + i) << shift;
                            ^
Fixes: db43267 "tcg: Add generic vector expanders"
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 configure | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configure b/configure
index 4d0e92c96c..a2301dd0dc 100755
--- a/configure
+++ b/configure
@@ -5054,6 +5054,14 @@ static S2 c2;
 static S4 c4;
 static S8 c8;
 static int i;
+void helper(void *d, void *a, int shift, int i);
+void helper(void *d, void *a, int shift, int i)
+{
+  *(U1 *)(d + i) =3D *(U1 *)(a + i) << shift;
+  *(U2 *)(d + i) =3D *(U2 *)(a + i) << shift;
+  *(U4 *)(d + i) =3D *(U4 *)(a + i) << shift;
+  *(U8 *)(d + i) =3D *(U8 *)(a + i) << shift;
+}
 int main(void)
 {
   a1 +=3D b1; a2 +=3D b2; a4 +=3D b4; a8 +=3D b8;
--=20
2.14.3
