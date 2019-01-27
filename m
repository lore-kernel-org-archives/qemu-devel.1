Received: from eggs.gnu.org ([209.51.188.92]:53732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gngLp-0004Pl-1f
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gngLm-0008Eg-Uk
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:03:36 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 27 Jan 2019 09:03:03 +0000
Message-Id: <20190127090306.30826-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v3 5/8] target/ppc: eliminate use of EL_IDX
 macros from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

These macros can be eliminated by instead using the relavant Vsr* macros in
the few locations where they appear.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 66 ++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index addbe54c21..4cc7fdfd25 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3320,12 +3320,7 @@ void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     *r = result;
 }
 
-#define ROTRu32(v, n) (((v) >> (n)) | ((v) << (32-n)))
-#if defined(HOST_WORDS_BIGENDIAN)
-#define EL_IDX(i) (i)
-#else
-#define EL_IDX(i) (3 - (i))
-#endif
+#define ROTRu32(v, n) (((v) >> (n)) | ((v) << (32 - n)))
 
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
@@ -3333,40 +3328,34 @@ void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
     int six = st_six & 0xF;
     int i;
 
-    VECTOR_FOR_INORDER_I(i, u32) {
+    for (i = 0; i < ARRAY_SIZE(r->u32); i++) {
         if (st == 0) {
             if ((six & (0x8 >> i)) == 0) {
-                r->u32[EL_IDX(i)] = ROTRu32(a->u32[EL_IDX(i)], 7) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 18) ^
-                                    (a->u32[EL_IDX(i)] >> 3);
+                r->VsrW(i) = ROTRu32(a->VsrW(i), 7) ^
+                             ROTRu32(a->VsrW(i), 18) ^
+                             (a->VsrW(i) >> 3);
             } else { /* six.bit[i] == 1 */
-                r->u32[EL_IDX(i)] = ROTRu32(a->u32[EL_IDX(i)], 17) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 19) ^
-                                    (a->u32[EL_IDX(i)] >> 10);
+                r->VsrW(i) = ROTRu32(a->VsrW(i), 17) ^
+                             ROTRu32(a->VsrW(i), 19) ^
+                             (a->VsrW(i) >> 10);
             }
         } else { /* st == 1 */
             if ((six & (0x8 >> i)) == 0) {
-                r->u32[EL_IDX(i)] = ROTRu32(a->u32[EL_IDX(i)], 2) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 13) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 22);
+                r->VsrW(i) = ROTRu32(a->VsrW(i), 2) ^
+                             ROTRu32(a->VsrW(i), 13) ^
+                             ROTRu32(a->VsrW(i), 22);
             } else { /* six.bit[i] == 1 */
-                r->u32[EL_IDX(i)] = ROTRu32(a->u32[EL_IDX(i)], 6) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 11) ^
-                                    ROTRu32(a->u32[EL_IDX(i)], 25);
+                r->VsrW(i) = ROTRu32(a->VsrW(i), 6) ^
+                             ROTRu32(a->VsrW(i), 11) ^
+                             ROTRu32(a->VsrW(i), 25);
             }
         }
     }
 }
 
 #undef ROTRu32
-#undef EL_IDX
 
 #define ROTRu64(v, n) (((v) >> (n)) | ((v) << (64-n)))
-#if defined(HOST_WORDS_BIGENDIAN)
-#define EL_IDX(i) (i)
-#else
-#define EL_IDX(i) (1 - (i))
-#endif
 
 void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
@@ -3374,33 +3363,32 @@ void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
     int six = st_six & 0xF;
     int i;
 
-    VECTOR_FOR_INORDER_I(i, u64) {
+    for (i = 0; i < ARRAY_SIZE(r->u64); i++) {
         if (st == 0) {
             if ((six & (0x8 >> (2*i))) == 0) {
-                r->u64[EL_IDX(i)] = ROTRu64(a->u64[EL_IDX(i)], 1) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 8) ^
-                                    (a->u64[EL_IDX(i)] >> 7);
+                r->VsrD(i) = ROTRu64(a->VsrD(i), 1) ^
+                             ROTRu64(a->VsrD(i), 8) ^
+                             (a->VsrD(i) >> 7);
             } else { /* six.bit[2*i] == 1 */
-                r->u64[EL_IDX(i)] = ROTRu64(a->u64[EL_IDX(i)], 19) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 61) ^
-                                    (a->u64[EL_IDX(i)] >> 6);
+                r->VsrD(i) = ROTRu64(a->VsrD(i), 19) ^
+                             ROTRu64(a->VsrD(i), 61) ^
+                             (a->VsrD(i) >> 6);
             }
         } else { /* st == 1 */
             if ((six & (0x8 >> (2*i))) == 0) {
-                r->u64[EL_IDX(i)] = ROTRu64(a->u64[EL_IDX(i)], 28) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 34) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 39);
+                r->VsrD(i) = ROTRu64(a->VsrD(i), 28) ^
+                             ROTRu64(a->VsrD(i), 34) ^
+                             ROTRu64(a->VsrD(i), 39);
             } else { /* six.bit[2*i] == 1 */
-                r->u64[EL_IDX(i)] = ROTRu64(a->u64[EL_IDX(i)], 14) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 18) ^
-                                    ROTRu64(a->u64[EL_IDX(i)], 41);
+                r->VsrD(i) = ROTRu64(a->VsrD(i), 14) ^
+                             ROTRu64(a->VsrD(i), 18) ^
+                             ROTRu64(a->VsrD(i), 41);
             }
         }
     }
 }
 
 #undef ROTRu64
-#undef EL_IDX
 
 void helper_vpermxor(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
-- 
2.11.0
