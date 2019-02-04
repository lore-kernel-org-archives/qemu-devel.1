Received: from eggs.gnu.org ([209.51.188.92]:38917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9V-0001FB-OO
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9N-0000H7-IY
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:47 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:19 +1100
Message-Id: <20190204090124.26191-33-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/37] target/ppc: remove ROTRu32 and ROTRu64
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

Richard points out that these macros suffer from a -fsanitize=3Dshift bug=
 in that
they improperly handle n =3D=3D 0 turning it into a shift by 32/64 respec=
tively.
Replace them with QEMU's existing ror32() and ror64() functions instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 48 +++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index ffc9cbc4ed..916d10c25b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3306,8 +3306,6 @@ void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a=
, ppc_avr_t *b)
     *r =3D result;
 }
=20
-#define ROTRu32(v, n) (((v) >> (n)) | ((v) << (32 - n)))
-
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
     int st =3D (st_six & 0x10) !=3D 0;
@@ -3317,32 +3315,28 @@ void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *=
a, uint32_t st_six)
     for (i =3D 0; i < ARRAY_SIZE(r->u32); i++) {
         if (st =3D=3D 0) {
             if ((six & (0x8 >> i)) =3D=3D 0) {
-                r->VsrW(i) =3D ROTRu32(a->VsrW(i), 7) ^
-                             ROTRu32(a->VsrW(i), 18) ^
+                r->VsrW(i) =3D ror32(a->VsrW(i), 7) ^
+                             ror32(a->VsrW(i), 18) ^
                              (a->VsrW(i) >> 3);
             } else { /* six.bit[i] =3D=3D 1 */
-                r->VsrW(i) =3D ROTRu32(a->VsrW(i), 17) ^
-                             ROTRu32(a->VsrW(i), 19) ^
+                r->VsrW(i) =3D ror32(a->VsrW(i), 17) ^
+                             ror32(a->VsrW(i), 19) ^
                              (a->VsrW(i) >> 10);
             }
         } else { /* st =3D=3D 1 */
             if ((six & (0x8 >> i)) =3D=3D 0) {
-                r->VsrW(i) =3D ROTRu32(a->VsrW(i), 2) ^
-                             ROTRu32(a->VsrW(i), 13) ^
-                             ROTRu32(a->VsrW(i), 22);
+                r->VsrW(i) =3D ror32(a->VsrW(i), 2) ^
+                             ror32(a->VsrW(i), 13) ^
+                             ror32(a->VsrW(i), 22);
             } else { /* six.bit[i] =3D=3D 1 */
-                r->VsrW(i) =3D ROTRu32(a->VsrW(i), 6) ^
-                             ROTRu32(a->VsrW(i), 11) ^
-                             ROTRu32(a->VsrW(i), 25);
+                r->VsrW(i) =3D ror32(a->VsrW(i), 6) ^
+                             ror32(a->VsrW(i), 11) ^
+                             ror32(a->VsrW(i), 25);
             }
         }
     }
 }
=20
-#undef ROTRu32
-
-#define ROTRu64(v, n) (((v) >> (n)) | ((v) << (64-n)))
-
 void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
     int st =3D (st_six & 0x10) !=3D 0;
@@ -3352,30 +3346,28 @@ void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *=
a, uint32_t st_six)
     for (i =3D 0; i < ARRAY_SIZE(r->u64); i++) {
         if (st =3D=3D 0) {
             if ((six & (0x8 >> (2*i))) =3D=3D 0) {
-                r->VsrD(i) =3D ROTRu64(a->VsrD(i), 1) ^
-                             ROTRu64(a->VsrD(i), 8) ^
+                r->VsrD(i) =3D ror64(a->VsrD(i), 1) ^
+                             ror64(a->VsrD(i), 8) ^
                              (a->VsrD(i) >> 7);
             } else { /* six.bit[2*i] =3D=3D 1 */
-                r->VsrD(i) =3D ROTRu64(a->VsrD(i), 19) ^
-                             ROTRu64(a->VsrD(i), 61) ^
+                r->VsrD(i) =3D ror64(a->VsrD(i), 19) ^
+                             ror64(a->VsrD(i), 61) ^
                              (a->VsrD(i) >> 6);
             }
         } else { /* st =3D=3D 1 */
             if ((six & (0x8 >> (2*i))) =3D=3D 0) {
-                r->VsrD(i) =3D ROTRu64(a->VsrD(i), 28) ^
-                             ROTRu64(a->VsrD(i), 34) ^
-                             ROTRu64(a->VsrD(i), 39);
+                r->VsrD(i) =3D ror64(a->VsrD(i), 28) ^
+                             ror64(a->VsrD(i), 34) ^
+                             ror64(a->VsrD(i), 39);
             } else { /* six.bit[2*i] =3D=3D 1 */
-                r->VsrD(i) =3D ROTRu64(a->VsrD(i), 14) ^
-                             ROTRu64(a->VsrD(i), 18) ^
-                             ROTRu64(a->VsrD(i), 41);
+                r->VsrD(i) =3D ror64(a->VsrD(i), 14) ^
+                             ror64(a->VsrD(i), 18) ^
+                             ror64(a->VsrD(i), 41);
             }
         }
     }
 }
=20
-#undef ROTRu64
-
 void helper_vpermxor(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ppc_avr_=
t *c)
 {
     ppc_avr_t result;
--=20
2.20.1
