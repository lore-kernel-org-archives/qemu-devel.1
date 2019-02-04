Received: from eggs.gnu.org ([209.51.188.92]:38537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8m-0000gk-TG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8l-0007sI-0e
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:15 +1100
Message-Id: <20190204090124.26191-29-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/37] target/ppc: rework vmul{e, o}{s, u}{b, h,
 w} instructions to use Vsr* macros
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

The current implementations make use of the endian-specific macros HI_IDX=
 and
LO_IDX directly to calculate array offsets.

Rework the implementation to use the Vsr* macros so that these per-endian
references can be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 48 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index fe418b3393..e531af5294 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1104,33 +1104,39 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t =
*r, ppc_avr_t *a,
     }
 }
=20
-#define VMUL_DO(name, mul_element, prod_element, cast, evenp)           =
\
+#define VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast)   =
\
     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       =
\
     {                                                                   =
\
         int i;                                                          =
\
                                                                         =
\
-        VECTOR_FOR_INORDER_I(i, prod_element) {                         =
\
-            if (evenp) {                                                =
\
-                r->prod_element[i] =3D                                  =
  \
-                    (cast)a->mul_element[i * 2 + HI_IDX] *              =
\
-                    (cast)b->mul_element[i * 2 + HI_IDX];               =
\
-            } else {                                                    =
\
-                r->prod_element[i] =3D                                  =
  \
-                    (cast)a->mul_element[i * 2 + LO_IDX] *              =
\
-                    (cast)b->mul_element[i * 2 + LO_IDX];               =
\
-            }                                                           =
\
+        for (i =3D 0; i < ARRAY_SIZE(r->mul_element); i +=3D 2) {       =
    \
+            r->prod_access(i >> 1) =3D (cast)a->mul_access(i) *         =
  \
+                                     (cast)b->mul_access(i);            =
\
+        }                                                               =
\
+    }
+
+#define VMUL_DO_ODD(name, mul_element, mul_access, prod_access, cast)   =
\
+    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       =
\
+    {                                                                   =
\
+        int i;                                                          =
\
+                                                                        =
\
+        for (i =3D 0; i < ARRAY_SIZE(r->mul_element); i +=3D 2) {       =
    \
+            r->prod_access(i >> 1) =3D (cast)a->mul_access(i + 1) *     =
  \
+                                     (cast)b->mul_access(i + 1);        =
\
         }                                                               =
\
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
+    VMUL_DO_EVN(mule##suffix, mul_element, mul_access, prod_access, cast=
)  \
+    VMUL_DO_ODD(mulo##suffix, mul_element, mul_access, prod_access, cast=
)
+VMUL(sb, s8, VsrSB, VsrSH, int16_t)
+VMUL(sh, s16, VsrSH, VsrSW, int32_t)
+VMUL(sw, s32, VsrSW, VsrSD, int64_t)
+VMUL(ub, u8, VsrB, VsrH, uint16_t)
+VMUL(uh, u16, VsrH, VsrW, uint32_t)
+VMUL(uw, u32, VsrW, VsrD, uint64_t)
+#undef VMUL_DO_EVN
+#undef VMUL_DO_ODD
 #undef VMUL
=20
 void helper_vperm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_=
t *b,
--=20
2.20.1
