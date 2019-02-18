Received: from eggs.gnu.org ([209.51.188.92]:39915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyY-00078O-AX
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyW-0003YN-80
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:46 +1100
Message-Id: <20190218143049.17142-41-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/43] target/ppc: Add set_vscr_sat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

This is required before changing the representation of the register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215100058.20015-15-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index ec3ef9ff3f..1d8a4b530b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -468,6 +468,11 @@ uint32_t helper_mfvscr(CPUPPCState *env)
     return env->vscr;
 }
=20
+static inline void set_vscr_sat(CPUPPCState *env)
+{
+    env->vscr |=3D 1 << VSCR_SAT;
+}
+
 void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
@@ -581,7 +586,7 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | flo=
at_muladd_negate_c);
             }                                                           =
\
         }                                                               =
\
         if (sat) {                                                      =
\
-            env->vscr |=3D (1 << VSCR_SAT);                             =
  \
+            set_vscr_sat(env);                                          =
\
         }                                                               =
\
     }
 #define VARITHSAT_SIGNED(suffix, element, optype, cvt)          \
@@ -853,7 +858,7 @@ void helper_vcmpbfp_dot(CPUPPCState *env, ppc_avr_t *=
r, ppc_avr_t *a,
             }                                                           =
\
         }                                                               =
\
         if (sat) {                                                      =
\
-            env->vscr |=3D (1 << VSCR_SAT);                             =
  \
+            set_vscr_sat(env);                                          =
\
         }                                                               =
\
     }
 VCT(uxs, cvtsduw, u32)
@@ -900,7 +905,7 @@ void helper_vmhaddshs(CPUPPCState *env, ppc_avr_t *r,=
 ppc_avr_t *a,
     }
=20
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
@@ -917,7 +922,7 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a,
     }
=20
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
@@ -1029,7 +1034,7 @@ void helper_vmsumshs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a,
     }
=20
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
@@ -1082,7 +1087,7 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a,
     }
=20
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
@@ -1599,7 +1604,7 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_a=
vr_t *b)
         }                                                               =
\
         *r =3D result;                                                  =
  \
         if (dosat && sat) {                                             =
\
-            env->vscr |=3D (1 << VSCR_SAT);                             =
  \
+            set_vscr_sat(env);                                          =
\
         }                                                               =
\
     }
 #define I(x, y) (x)
@@ -2043,7 +2048,7 @@ void helper_vsumsws(CPUPPCState *env, ppc_avr_t *r,=
 ppc_avr_t *a, ppc_avr_t *b)
     *r =3D result;
=20
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
@@ -2066,7 +2071,7 @@ void helper_vsum2sws(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
=20
     *r =3D result;
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
@@ -2085,7 +2090,7 @@ void helper_vsum4sbs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
     }
=20
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
@@ -2102,7 +2107,7 @@ void helper_vsum4shs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
     }
=20
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
@@ -2121,7 +2126,7 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
     }
=20
     if (sat) {
-        env->vscr |=3D (1 << VSCR_SAT);
+        set_vscr_sat(env);
     }
 }
=20
--=20
2.20.1
