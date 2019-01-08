Received: from eggs.gnu.org ([209.51.188.92]:57884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08q-0005wm-Bc
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08o-0006fG-EZ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:44 +1100
Message-Id: <20190108224600.23125-14-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/29] target/ppc: replace AVR* macros with Vsr*
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Now that the VMX and VSR register sets have been combined, the same macro=
s can
be used to access both AVR and VSR field members.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 9d715be25c..598731d47a 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -391,13 +391,9 @@ target_ulong helper_602_mfrom(target_ulong arg)
 #if defined(HOST_WORDS_BIGENDIAN)
 #define HI_IDX 0
 #define LO_IDX 1
-#define AVRB(i) u8[i]
-#define AVRW(i) u32[i]
 #else
 #define HI_IDX 1
 #define LO_IDX 0
-#define AVRB(i) u8[15-(i)]
-#define AVRW(i) u32[3-(i)]
 #endif
=20
 #if defined(HOST_WORDS_BIGENDIAN)
@@ -3277,11 +3273,11 @@ void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, p=
pc_avr_t *b)
     int i;
=20
     VECTOR_FOR_INORDER_I(i, u32) {
-        result.AVRW(i) =3D b->AVRW(i) ^
-            (AES_Te0[a->AVRB(AES_shifts[4*i + 0])] ^
-             AES_Te1[a->AVRB(AES_shifts[4*i + 1])] ^
-             AES_Te2[a->AVRB(AES_shifts[4*i + 2])] ^
-             AES_Te3[a->AVRB(AES_shifts[4*i + 3])]);
+        result.VsrW(i) =3D b->VsrW(i) ^
+            (AES_Te0[a->VsrB(AES_shifts[4 * i + 0])] ^
+             AES_Te1[a->VsrB(AES_shifts[4 * i + 1])] ^
+             AES_Te2[a->VsrB(AES_shifts[4 * i + 2])] ^
+             AES_Te3[a->VsrB(AES_shifts[4 * i + 3])]);
     }
     *r =3D result;
 }
@@ -3292,7 +3288,7 @@ void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a,=
 ppc_avr_t *b)
     int i;
=20
     VECTOR_FOR_INORDER_I(i, u8) {
-        result.AVRB(i) =3D b->AVRB(i) ^ (AES_sbox[a->AVRB(AES_shifts[i])=
]);
+        result.VsrB(i) =3D b->VsrB(i) ^ (AES_sbox[a->VsrB(AES_shifts[i])=
]);
     }
     *r =3D result;
 }
@@ -3305,15 +3301,15 @@ void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b)
     ppc_avr_t tmp;
=20
     VECTOR_FOR_INORDER_I(i, u8) {
-        tmp.AVRB(i) =3D b->AVRB(i) ^ AES_isbox[a->AVRB(AES_ishifts[i])];
+        tmp.VsrB(i) =3D b->VsrB(i) ^ AES_isbox[a->VsrB(AES_ishifts[i])];
     }
=20
     VECTOR_FOR_INORDER_I(i, u32) {
-        r->AVRW(i) =3D
-            AES_imc[tmp.AVRB(4*i + 0)][0] ^
-            AES_imc[tmp.AVRB(4*i + 1)][1] ^
-            AES_imc[tmp.AVRB(4*i + 2)][2] ^
-            AES_imc[tmp.AVRB(4*i + 3)][3];
+        r->VsrW(i) =3D
+            AES_imc[tmp.VsrB(4 * i + 0)][0] ^
+            AES_imc[tmp.VsrB(4 * i + 1)][1] ^
+            AES_imc[tmp.VsrB(4 * i + 2)][2] ^
+            AES_imc[tmp.VsrB(4 * i + 3)][3];
     }
 }
=20
@@ -3323,7 +3319,7 @@ void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a=
, ppc_avr_t *b)
     int i;
=20
     VECTOR_FOR_INORDER_I(i, u8) {
-        result.AVRB(i) =3D b->AVRB(i) ^ (AES_isbox[a->AVRB(AES_ishifts[i=
])]);
+        result.VsrB(i) =3D b->VsrB(i) ^ (AES_isbox[a->VsrB(AES_ishifts[i=
])]);
     }
     *r =3D result;
 }
--=20
2.20.1
