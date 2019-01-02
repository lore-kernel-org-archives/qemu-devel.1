Received: from eggs.gnu.org ([208.118.235.92]:41714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1geccO-0006RN-QT
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1geccG-00084V-Vo
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:15:10 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  2 Jan 2019 09:14:23 +0000
Message-Id: <20190102091423.21155-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190102091423.21155-1-mark.cave-ayland@ilande.co.uk>
References: <20190102091423.21155-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v5 9/9] target/ppc: replace AVR* macros with
 Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

Now that the VMX and VSR register sets have been combined, the same macros can
be used to access both AVR and VSR field members.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
 
 #if defined(HOST_WORDS_BIGENDIAN)
@@ -3277,11 +3273,11 @@ void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     int i;
 
     VECTOR_FOR_INORDER_I(i, u32) {
-        result.AVRW(i) = b->AVRW(i) ^
-            (AES_Te0[a->AVRB(AES_shifts[4*i + 0])] ^
-             AES_Te1[a->AVRB(AES_shifts[4*i + 1])] ^
-             AES_Te2[a->AVRB(AES_shifts[4*i + 2])] ^
-             AES_Te3[a->AVRB(AES_shifts[4*i + 3])]);
+        result.VsrW(i) = b->VsrW(i) ^
+            (AES_Te0[a->VsrB(AES_shifts[4 * i + 0])] ^
+             AES_Te1[a->VsrB(AES_shifts[4 * i + 1])] ^
+             AES_Te2[a->VsrB(AES_shifts[4 * i + 2])] ^
+             AES_Te3[a->VsrB(AES_shifts[4 * i + 3])]);
     }
     *r = result;
 }
@@ -3292,7 +3288,7 @@ void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     int i;
 
     VECTOR_FOR_INORDER_I(i, u8) {
-        result.AVRB(i) = b->AVRB(i) ^ (AES_sbox[a->AVRB(AES_shifts[i])]);
+        result.VsrB(i) = b->VsrB(i) ^ (AES_sbox[a->VsrB(AES_shifts[i])]);
     }
     *r = result;
 }
@@ -3305,15 +3301,15 @@ void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     ppc_avr_t tmp;
 
     VECTOR_FOR_INORDER_I(i, u8) {
-        tmp.AVRB(i) = b->AVRB(i) ^ AES_isbox[a->AVRB(AES_ishifts[i])];
+        tmp.VsrB(i) = b->VsrB(i) ^ AES_isbox[a->VsrB(AES_ishifts[i])];
     }
 
     VECTOR_FOR_INORDER_I(i, u32) {
-        r->AVRW(i) =
-            AES_imc[tmp.AVRB(4*i + 0)][0] ^
-            AES_imc[tmp.AVRB(4*i + 1)][1] ^
-            AES_imc[tmp.AVRB(4*i + 2)][2] ^
-            AES_imc[tmp.AVRB(4*i + 3)][3];
+        r->VsrW(i) =
+            AES_imc[tmp.VsrB(4 * i + 0)][0] ^
+            AES_imc[tmp.VsrB(4 * i + 1)][1] ^
+            AES_imc[tmp.VsrB(4 * i + 2)][2] ^
+            AES_imc[tmp.VsrB(4 * i + 3)][3];
     }
 }
 
@@ -3323,7 +3319,7 @@ void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     int i;
 
     VECTOR_FOR_INORDER_I(i, u8) {
-        result.AVRB(i) = b->AVRB(i) ^ (AES_isbox[a->AVRB(AES_ishifts[i])]);
+        result.VsrB(i) = b->VsrB(i) ^ (AES_isbox[a->VsrB(AES_ishifts[i])]);
     }
     *r = result;
 }
-- 
2.11.0
