Received: from eggs.gnu.org ([2001:4830:134:3::10]:53454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiA-0005yQ-Dj
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii7-0002EG-6A
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii6-0001Bh-Lw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:51 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:05:03 +0200
Message-Id: <1539770707-7289-12-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/15] qemu/compiler: Wrap
 __attribute__((flatten)) in a macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Older versions of Clang (before 3.5) and GCC (before 4.1) do not
support the "__attribute__((flatten))" yet. We don't care about
such old versions of GCC anymore, but since Clang 3.4 is still
used in EPEL for RHEL7 / CentOS 7, we should not use this attribute
directly but with a wrapper macro instead.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 fpu/softfloat.c         | 39 +++++++++++++++------------------------
 include/qemu/compiler.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 46ae206..e1eef95 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -726,8 +726,7 @@ static FloatParts addsub_floats(FloatParts a, FloatPa=
rts b, bool subtract,
  * IEC/IEEE Standard for Binary Floating-Point Arithmetic.
  */
=20
-float16  __attribute__((flatten)) float16_add(float16 a, float16 b,
-                                              float_status *status)
+float16 QEMU_FLATTEN float16_add(float16 a, float16 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float16_unpack_canonical(a, status);
     FloatParts pb =3D float16_unpack_canonical(b, status);
@@ -736,8 +735,7 @@ float16  __attribute__((flatten)) float16_add(float16=
 a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
=20
-float32 __attribute__((flatten)) float32_add(float32 a, float32 b,
-                                             float_status *status)
+float32 QEMU_FLATTEN float32_add(float32 a, float32 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float32_unpack_canonical(a, status);
     FloatParts pb =3D float32_unpack_canonical(b, status);
@@ -746,8 +744,7 @@ float32 __attribute__((flatten)) float32_add(float32 =
a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
=20
-float64 __attribute__((flatten)) float64_add(float64 a, float64 b,
-                                             float_status *status)
+float64 QEMU_FLATTEN float64_add(float64 a, float64 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float64_unpack_canonical(a, status);
     FloatParts pb =3D float64_unpack_canonical(b, status);
@@ -756,8 +753,7 @@ float64 __attribute__((flatten)) float64_add(float64 =
a, float64 b,
     return float64_round_pack_canonical(pr, status);
 }
=20
-float16 __attribute__((flatten)) float16_sub(float16 a, float16 b,
-                                             float_status *status)
+float16 QEMU_FLATTEN float16_sub(float16 a, float16 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float16_unpack_canonical(a, status);
     FloatParts pb =3D float16_unpack_canonical(b, status);
@@ -766,8 +762,7 @@ float16 __attribute__((flatten)) float16_sub(float16 =
a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
=20
-float32 __attribute__((flatten)) float32_sub(float32 a, float32 b,
-                                             float_status *status)
+float32 QEMU_FLATTEN float32_sub(float32 a, float32 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float32_unpack_canonical(a, status);
     FloatParts pb =3D float32_unpack_canonical(b, status);
@@ -776,8 +771,7 @@ float32 __attribute__((flatten)) float32_sub(float32 =
a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
=20
-float64 __attribute__((flatten)) float64_sub(float64 a, float64 b,
-                                             float_status *status)
+float64 QEMU_FLATTEN float64_sub(float64 a, float64 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float64_unpack_canonical(a, status);
     FloatParts pb =3D float64_unpack_canonical(b, status);
@@ -835,8 +829,7 @@ static FloatParts mul_floats(FloatParts a, FloatParts=
 b, float_status *s)
     g_assert_not_reached();
 }
=20
-float16 __attribute__((flatten)) float16_mul(float16 a, float16 b,
-                                             float_status *status)
+float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float16_unpack_canonical(a, status);
     FloatParts pb =3D float16_unpack_canonical(b, status);
@@ -845,8 +838,7 @@ float16 __attribute__((flatten)) float16_mul(float16 =
a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
=20
-float32 __attribute__((flatten)) float32_mul(float32 a, float32 b,
-                                             float_status *status)
+float32 QEMU_FLATTEN float32_mul(float32 a, float32 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float32_unpack_canonical(a, status);
     FloatParts pb =3D float32_unpack_canonical(b, status);
@@ -855,8 +847,7 @@ float32 __attribute__((flatten)) float32_mul(float32 =
a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
=20
-float64 __attribute__((flatten)) float64_mul(float64 a, float64 b,
-                                             float_status *status)
+float64 QEMU_FLATTEN float64_mul(float64 a, float64 b, float_status *sta=
tus)
 {
     FloatParts pa =3D float64_unpack_canonical(a, status);
     FloatParts pb =3D float64_unpack_canonical(b, status);
@@ -1068,7 +1059,7 @@ static FloatParts muladd_floats(FloatParts a, Float=
Parts b, FloatParts c,
     return a;
 }
=20
-float16 __attribute__((flatten)) float16_muladd(float16 a, float16 b, fl=
oat16 c,
+float16 QEMU_FLATTEN float16_muladd(float16 a, float16 b, float16 c,
                                                 int flags, float_status =
*status)
 {
     FloatParts pa =3D float16_unpack_canonical(a, status);
@@ -1079,7 +1070,7 @@ float16 __attribute__((flatten)) float16_muladd(flo=
at16 a, float16 b, float16 c,
     return float16_round_pack_canonical(pr, status);
 }
=20
-float32 __attribute__((flatten)) float32_muladd(float32 a, float32 b, fl=
oat32 c,
+float32 QEMU_FLATTEN float32_muladd(float32 a, float32 b, float32 c,
                                                 int flags, float_status =
*status)
 {
     FloatParts pa =3D float32_unpack_canonical(a, status);
@@ -1090,7 +1081,7 @@ float32 __attribute__((flatten)) float32_muladd(flo=
at32 a, float32 b, float32 c,
     return float32_round_pack_canonical(pr, status);
 }
=20
-float64 __attribute__((flatten)) float64_muladd(float64 a, float64 b, fl=
oat64 c,
+float64 QEMU_FLATTEN float64_muladd(float64 a, float64 b, float64 c,
                                                 int flags, float_status =
*status)
 {
     FloatParts pa =3D float64_unpack_canonical(a, status);
@@ -2414,21 +2405,21 @@ static FloatParts sqrt_float(FloatParts a, float_=
status *s, const FloatFmt *p)
     return a;
 }
=20
-float16 __attribute__((flatten)) float16_sqrt(float16 a, float_status *s=
tatus)
+float16 QEMU_FLATTEN float16_sqrt(float16 a, float_status *status)
 {
     FloatParts pa =3D float16_unpack_canonical(a, status);
     FloatParts pr =3D sqrt_float(pa, status, &float16_params);
     return float16_round_pack_canonical(pr, status);
 }
=20
-float32 __attribute__((flatten)) float32_sqrt(float32 a, float_status *s=
tatus)
+float32 QEMU_FLATTEN float32_sqrt(float32 a, float_status *status)
 {
     FloatParts pa =3D float32_unpack_canonical(a, status);
     FloatParts pr =3D sqrt_float(pa, status, &float32_params);
     return float32_round_pack_canonical(pr, status);
 }
=20
-float64 __attribute__((flatten)) float64_sqrt(float64 a, float_status *s=
tatus)
+float64 QEMU_FLATTEN float64_sqrt(float64 a, float_status *status)
 {
     FloatParts pa =3D float64_unpack_canonical(a, status);
     FloatParts pr =3D sqrt_float(pa, status, &float64_params);
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index bf47e7b..66f8c24 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -131,6 +131,21 @@
 #define HAS_ASSUME_ALIGNED
 #endif
=20
+#ifndef __has_attribute
+#define __has_attribute(x) 0 /* compatibility with older GCC */
+#endif
+
+/*
+ * GCC doesn't provide __has_attribute() until GCC 5, but we know all th=
e GCC
+ * versions we support have the "flatten" attribute. Clang may not have =
the
+ * "flatten" attribute but always has __has_attribute() to check for it.
+ */
+#if __has_attribute(flatten) || !defined(__clang__)
+# define QEMU_FLATTEN __attribute__((flatten))
+#else
+# define QEMU_FLATTEN
+#endif
+
 /* Implement C11 _Generic via GCC builtins.  Example:
  *
  *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
--=20
1.8.3.1
