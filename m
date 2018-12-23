Received: from eggs.gnu.org ([2001:4830:134:3::10]:50491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gb26M-0000jq-0H
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 06:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gb26J-0008Vi-JC
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 06:39:21 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 23 Dec 2018 11:38:56 +0000
Message-Id: <20181223113859.3675-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181223113859.3675-1-mark.cave-ayland@ilande.co.uk>
References: <20181223113859.3675-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/6] target/ppc: rework vmul{e, o}{s, u}{b, h,
 w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

The current implementations make use of the endian-specific macros HI_IDX and
LO_IDX directly to calculate array offsets.

Rework the implementation to use the Vsr* macros so that these per-endian
references can be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/int_helper.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f084a706ee..dc5c9fb8d8 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1118,33 +1118,39 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
-#define VMUL_DO(name, mul_element, prod_element, cast, evenp)           \
+#define VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast)   \
     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
     {                                                                   \
         int i;                                                          \
                                                                         \
-        VECTOR_FOR_INORDER_I(i, prod_element) {                         \
-            if (evenp) {                                                \
-                r->prod_element[i] =                                    \
-                    (cast)a->mul_element[i * 2 + HI_IDX] *              \
-                    (cast)b->mul_element[i * 2 + HI_IDX];               \
-            } else {                                                    \
-                r->prod_element[i] =                                    \
-                    (cast)a->mul_element[i * 2 + LO_IDX] *              \
-                    (cast)b->mul_element[i * 2 + LO_IDX];               \
-            }                                                           \
+        for (i = 0; i < ARRAY_SIZE(r->mul_element); i += 2) {           \
+            r->prod_access(i >> 1) = (cast)a->mul_access(i) *           \
+                                     (cast)b->mul_access(i);            \
+        }                                                               \
+    }
+
+#define VMUL_DO_ODD(name, mul_element, mul_access, prod_access, cast)   \
+    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
+    {                                                                   \
+        int i;                                                          \
+                                                                        \
+        for (i = 0; i < ARRAY_SIZE(r->mul_element); i += 2) {           \
+            r->prod_access(i >> 1) = (cast)a->mul_access(i + 1) *       \
+                                     (cast)b->mul_access(i + 1);        \
         }                                                               \
     }
-#define VMUL(suffix, mul_element, prod_element, cast)            \
-    VMUL_DO(mule##suffix, mul_element, prod_element, cast, 1)    \
-    VMUL_DO(mulo##suffix, mul_element, prod_element, cast, 0)
-VMUL(sb, s8, s16, int16_t)
-VMUL(sh, s16, s32, int32_t)
-VMUL(sw, s32, s64, int64_t)
-VMUL(ub, u8, u16, uint16_t)
-VMUL(uh, u16, u32, uint32_t)
-VMUL(uw, u32, u64, uint64_t)
-#undef VMUL_DO
+
+#define VMUL(suffix, mul_element, mul_access, prod_access, cast)       \
+    VMUL_DO_EVN(mule##suffix, mul_element, mul_access, prod_access, cast)  \
+    VMUL_DO_ODD(mulo##suffix, mul_element, mul_access, prod_access, cast)
+VMUL(sb, s8, VsrSB, VsrSH, int16_t)
+VMUL(sh, s16, VsrSH, VsrSW, int32_t)
+VMUL(sw, s32, VsrSW, VsrSD, int64_t)
+VMUL(ub, u8, VsrB, VsrH, uint16_t)
+VMUL(uh, u16, VsrH, VsrW, uint32_t)
+VMUL(uw, u32, VsrW, VsrD, uint64_t)
+#undef VMUL_DO_EVN
+#undef VMUL_DO_ODD
 #undef VMUL
 
 void helper_vperm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b,
-- 
2.11.0
