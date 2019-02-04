Received: from eggs.gnu.org ([209.51.188.92]:39181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9q-0001WP-6R
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9n-0000iz-Of
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:17 +1100
Message-Id: <20190204090124.26191-31-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/37] target/ppc: eliminate use of EL_IDX
 macros from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These macros can be eliminated by instead using the relavant Vsr* macros =
in
the few locations where they appear.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 66 +++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 7a9c02d4bb..355b6630a2 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3306,12 +3306,7 @@ void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *=
a, ppc_avr_t *b)
     *r =3D result;
 }
=20
-#define ROTRu32(v, n) (((v) >> (n)) | ((v) << (32-n)))
-#if defined(HOST_WORDS_BIGENDIAN)
-#define EL_IDX(i) (i)
-#else
-#define EL_IDX(i) (3 - (i))
-#endif
+#define ROTRu32(v, n) (((v) >> (n)) | ((v) << (32 - n)))
=20
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
@@ -3319,40 +3314,34 @@ void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *=
a, uint32_t st_six)
     int six =3D st_six & 0xF;
     int i;
=20
-    VECTOR_FOR_INORDER_I(i, u32) {
+    for (i =3D 0; i < ARRAY_SIZE(r->u32); i++) {
         if (st =3D=3D 0) {
             if ((six & (0x8 >> i)) =3D=3D 0) {
-                r->u32[EL_IDX(i)] =3D ROTRu32(a->u32[EL_IDX(i)], 7) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 18) ^
-                                    (a->u32[EL_IDX(i)] >> 3);
+                r->VsrW(i) =3D ROTRu32(a->VsrW(i), 7) ^
+                             ROTRu32(a->VsrW(i), 18) ^
+                             (a->VsrW(i) >> 3);
             } else { /* six.bit[i] =3D=3D 1 */
-                r->u32[EL_IDX(i)] =3D ROTRu32(a->u32[EL_IDX(i)], 17) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 19) ^
-                                    (a->u32[EL_IDX(i)] >> 10);
+                r->VsrW(i) =3D ROTRu32(a->VsrW(i), 17) ^
+                             ROTRu32(a->VsrW(i), 19) ^
+                             (a->VsrW(i) >> 10);
             }
         } else { /* st =3D=3D 1 */
             if ((six & (0x8 >> i)) =3D=3D 0) {
-                r->u32[EL_IDX(i)] =3D ROTRu32(a->u32[EL_IDX(i)], 2) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 13) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 22);
+                r->VsrW(i) =3D ROTRu32(a->VsrW(i), 2) ^
+                             ROTRu32(a->VsrW(i), 13) ^
+                             ROTRu32(a->VsrW(i), 22);
             } else { /* six.bit[i] =3D=3D 1 */
-                r->u32[EL_IDX(i)] =3D ROTRu32(a->u32[EL_IDX(i)], 6) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 11) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 25);
+                r->VsrW(i) =3D ROTRu32(a->VsrW(i), 6) ^
+                             ROTRu32(a->VsrW(i), 11) ^
+                             ROTRu32(a->VsrW(i), 25);
             }
         }
     }
 }
=20
 #undef ROTRu32
-#undef EL_IDX
=20
 #define ROTRu64(v, n) (((v) >> (n)) | ((v) << (64-n)))
-#if defined(HOST_WORDS_BIGENDIAN)
-#define EL_IDX(i) (i)
-#else
-#define EL_IDX(i) (1 - (i))
-#endif
=20
 void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
@@ -3360,33 +3349,32 @@ void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *=
a, uint32_t st_six)
     int six =3D st_six & 0xF;
     int i;
=20
-    VECTOR_FOR_INORDER_I(i, u64) {
+    for (i =3D 0; i < ARRAY_SIZE(r->u64); i++) {
         if (st =3D=3D 0) {
             if ((six & (0x8 >> (2*i))) =3D=3D 0) {
-                r->u64[EL_IDX(i)] =3D ROTRu64(a->u64[EL_IDX(i)], 1) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 8) ^
-                                    (a->u64[EL_IDX(i)] >> 7);
+                r->VsrD(i) =3D ROTRu64(a->VsrD(i), 1) ^
+                             ROTRu64(a->VsrD(i), 8) ^
+                             (a->VsrD(i) >> 7);
             } else { /* six.bit[2*i] =3D=3D 1 */
-                r->u64[EL_IDX(i)] =3D ROTRu64(a->u64[EL_IDX(i)], 19) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 61) ^
-                                    (a->u64[EL_IDX(i)] >> 6);
+                r->VsrD(i) =3D ROTRu64(a->VsrD(i), 19) ^
+                             ROTRu64(a->VsrD(i), 61) ^
+                             (a->VsrD(i) >> 6);
             }
         } else { /* st =3D=3D 1 */
             if ((six & (0x8 >> (2*i))) =3D=3D 0) {
-                r->u64[EL_IDX(i)] =3D ROTRu64(a->u64[EL_IDX(i)], 28) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 34) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 39);
+                r->VsrD(i) =3D ROTRu64(a->VsrD(i), 28) ^
+                             ROTRu64(a->VsrD(i), 34) ^
+                             ROTRu64(a->VsrD(i), 39);
             } else { /* six.bit[2*i] =3D=3D 1 */
-                r->u64[EL_IDX(i)] =3D ROTRu64(a->u64[EL_IDX(i)], 14) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 18) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 41);
+                r->VsrD(i) =3D ROTRu64(a->VsrD(i), 14) ^
+                             ROTRu64(a->VsrD(i), 18) ^
+                             ROTRu64(a->VsrD(i), 41);
             }
         }
     }
 }
=20
 #undef ROTRu64
-#undef EL_IDX
=20
 void helper_vpermxor(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ppc_avr_=
t *c)
 {
--=20
2.20.1
