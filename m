Received: from eggs.gnu.org ([209.51.188.92]:53758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gngLq-0004RH-UZ
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gngLo-0008Fm-SD
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:03:38 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 27 Jan 2019 09:03:05 +0000
Message-Id: <20190127090306.30826-8-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v3 7/8] target/ppc: remove ROTRu32 and ROTRu64
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

Richard points out that these macros suffer from a -fsanitize=shift bug in that
they improperly handle n == 0 turning it into a shift by 32/64 respectively.
Replace them with QEMU's existing ror32() and ror64() functions instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 39f6c96543..c3eba9ed41 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3320,8 +3320,6 @@ void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     *r = result;
 }
 
-#define ROTRu32(v, n) (((v) >> (n)) | ((v) << (32 - n)))
-
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
     int st = (st_six & 0x10) != 0;
@@ -3331,32 +3329,28 @@ void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
     for (i = 0; i < ARRAY_SIZE(r->u32); i++) {
         if (st == 0) {
             if ((six & (0x8 >> i)) == 0) {
-                r->VsrW(i) = ROTRu32(a->VsrW(i), 7) ^
-                             ROTRu32(a->VsrW(i), 18) ^
+                r->VsrW(i) = ror32(a->VsrW(i), 7) ^
+                             ror32(a->VsrW(i), 18) ^
                              (a->VsrW(i) >> 3);
             } else { /* six.bit[i] == 1 */
-                r->VsrW(i) = ROTRu32(a->VsrW(i), 17) ^
-                             ROTRu32(a->VsrW(i), 19) ^
+                r->VsrW(i) = ror32(a->VsrW(i), 17) ^
+                             ror32(a->VsrW(i), 19) ^
                              (a->VsrW(i) >> 10);
             }
         } else { /* st == 1 */
             if ((six & (0x8 >> i)) == 0) {
-                r->VsrW(i) = ROTRu32(a->VsrW(i), 2) ^
-                             ROTRu32(a->VsrW(i), 13) ^
-                             ROTRu32(a->VsrW(i), 22);
+                r->VsrW(i) = ror32(a->VsrW(i), 2) ^
+                             ror32(a->VsrW(i), 13) ^
+                             ror32(a->VsrW(i), 22);
             } else { /* six.bit[i] == 1 */
-                r->VsrW(i) = ROTRu32(a->VsrW(i), 6) ^
-                             ROTRu32(a->VsrW(i), 11) ^
-                             ROTRu32(a->VsrW(i), 25);
+                r->VsrW(i) = ror32(a->VsrW(i), 6) ^
+                             ror32(a->VsrW(i), 11) ^
+                             ror32(a->VsrW(i), 25);
             }
         }
     }
 }
 
-#undef ROTRu32
-
-#define ROTRu64(v, n) (((v) >> (n)) | ((v) << (64-n)))
-
 void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
     int st = (st_six & 0x10) != 0;
@@ -3366,30 +3360,28 @@ void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
     for (i = 0; i < ARRAY_SIZE(r->u64); i++) {
         if (st == 0) {
             if ((six & (0x8 >> (2*i))) == 0) {
-                r->VsrD(i) = ROTRu64(a->VsrD(i), 1) ^
-                             ROTRu64(a->VsrD(i), 8) ^
+                r->VsrD(i) = ror64(a->VsrD(i), 1) ^
+                             ror64(a->VsrD(i), 8) ^
                              (a->VsrD(i) >> 7);
             } else { /* six.bit[2*i] == 1 */
-                r->VsrD(i) = ROTRu64(a->VsrD(i), 19) ^
-                             ROTRu64(a->VsrD(i), 61) ^
+                r->VsrD(i) = ror64(a->VsrD(i), 19) ^
+                             ror64(a->VsrD(i), 61) ^
                              (a->VsrD(i) >> 6);
             }
         } else { /* st == 1 */
             if ((six & (0x8 >> (2*i))) == 0) {
-                r->VsrD(i) = ROTRu64(a->VsrD(i), 28) ^
-                             ROTRu64(a->VsrD(i), 34) ^
-                             ROTRu64(a->VsrD(i), 39);
+                r->VsrD(i) = ror64(a->VsrD(i), 28) ^
+                             ror64(a->VsrD(i), 34) ^
+                             ror64(a->VsrD(i), 39);
             } else { /* six.bit[2*i] == 1 */
-                r->VsrD(i) = ROTRu64(a->VsrD(i), 14) ^
-                             ROTRu64(a->VsrD(i), 18) ^
-                             ROTRu64(a->VsrD(i), 41);
+                r->VsrD(i) = ror64(a->VsrD(i), 14) ^
+                             ror64(a->VsrD(i), 18) ^
+                             ror64(a->VsrD(i), 41);
             }
         }
     }
 }
 
-#undef ROTRu64
-
 void helper_vpermxor(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     ppc_avr_t result;
-- 
2.11.0
