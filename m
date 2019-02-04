Received: from eggs.gnu.org ([209.51.188.92]:38374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8h-0000cN-Vd
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8h-0007kG-2g
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:14 +1100
Message-Id: <20190204090124.26191-28-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/37] target/ppc: rework vmrg{l, h}{b, h,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The current implementations make use of the endian-specific macros MRGLO/=
MRGHI
and also reference HI_IDX and LO_IDX directly to calculate array offsets.

Rework the implementation to use the Vsr* macros so that these per-endian
references can be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 54 +++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 598731d47a..fe418b3393 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -976,43 +976,27 @@ void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, p=
pc_avr_t *b, ppc_avr_t *c)
     }
 }
=20
-#define VMRG_DO(name, element, highp)                                   =
\
-    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       =
\
-    {                                                                   =
\
-        ppc_avr_t result;                                               =
\
-        int i;                                                          =
\
-        size_t n_elems =3D ARRAY_SIZE(r->element);                      =
  \
-                                                                        =
\
-        for (i =3D 0; i < n_elems / 2; i++) {                           =
  \
-            if (highp) {                                                =
\
-                result.element[i*2+HI_IDX] =3D a->element[i];           =
  \
-                result.element[i*2+LO_IDX] =3D b->element[i];           =
  \
-            } else {                                                    =
\
-                result.element[n_elems - i * 2 - (1 + HI_IDX)] =3D      =
  \
-                    b->element[n_elems - i - 1];                        =
\
-                result.element[n_elems - i * 2 - (1 + LO_IDX)] =3D      =
  \
-                    a->element[n_elems - i - 1];                        =
\
-            }                                                           =
\
-        }                                                               =
\
-        *r =3D result;                                                  =
  \
-    }
-#if defined(HOST_WORDS_BIGENDIAN)
-#define MRGHI 0
-#define MRGLO 1
-#else
-#define MRGHI 1
-#define MRGLO 0
-#endif
-#define VMRG(suffix, element)                   \
-    VMRG_DO(mrgl##suffix, element, MRGHI)       \
-    VMRG_DO(mrgh##suffix, element, MRGLO)
-VMRG(b, u8)
-VMRG(h, u16)
-VMRG(w, u32)
+#define VMRG_DO(name, element, access, ofs)                             =
     \
+    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       =
     \
+    {                                                                   =
     \
+        ppc_avr_t result;                                               =
     \
+        int i, half =3D ARRAY_SIZE(r->element) / 2;                     =
       \
+                                                                        =
     \
+        for (i =3D 0; i < half; i++) {                                  =
       \
+            result.access(i * 2 + 0) =3D a->access(i + ofs);            =
       \
+            result.access(i * 2 + 1) =3D b->access(i + ofs);            =
       \
+        }                                                               =
     \
+        *r =3D result;                                                  =
       \
+    }
+
+#define VMRG(suffix, element, access)          \
+    VMRG_DO(mrgl##suffix, element, access, half)   \
+    VMRG_DO(mrgh##suffix, element, access, 0)
+VMRG(b, u8, VsrB)
+VMRG(h, u16, VsrH)
+VMRG(w, u32, VsrW)
 #undef VMRG_DO
 #undef VMRG
-#undef MRGHI
-#undef MRGLO
=20
 void helper_vmsummbm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
                      ppc_avr_t *b, ppc_avr_t *c)
--=20
2.20.1
