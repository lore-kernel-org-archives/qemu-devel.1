Received: from eggs.gnu.org ([209.51.188.92]:55107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaPW-0002ms-Jx
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaPV-0002FC-Fj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:07:58 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:58 +0000
Message-Id: <20190215100058.20015-18-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 17/17] target/ppc: convert vmin* and vmax* to
 vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 | 16 ----------------
 target/ppc/int_helper.c             | 27 ---------------------------
 target/ppc/translate/vmx-impl.inc.c | 32 ++++++++++++++++----------------
 3 files changed, 16 insertions(+), 59 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3daf6bf863..18910d18a4 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -117,22 +117,6 @@ DEF_HELPER_3(vabsduw, void, avr, avr, avr)
 DEF_HELPER_3(vavgsb, void, avr, avr, avr)
 DEF_HELPER_3(vavgsh, void, avr, avr, avr)
 DEF_HELPER_3(vavgsw, void, avr, avr, avr)
-DEF_HELPER_3(vminsb, void, avr, avr, avr)
-DEF_HELPER_3(vminsh, void, avr, avr, avr)
-DEF_HELPER_3(vminsw, void, avr, avr, avr)
-DEF_HELPER_3(vminsd, void, avr, avr, avr)
-DEF_HELPER_3(vmaxsb, void, avr, avr, avr)
-DEF_HELPER_3(vmaxsh, void, avr, avr, avr)
-DEF_HELPER_3(vmaxsw, void, avr, avr, avr)
-DEF_HELPER_3(vmaxsd, void, avr, avr, avr)
-DEF_HELPER_3(vminub, void, avr, avr, avr)
-DEF_HELPER_3(vminuh, void, avr, avr, avr)
-DEF_HELPER_3(vminuw, void, avr, avr, avr)
-DEF_HELPER_3(vminud, void, avr, avr, avr)
-DEF_HELPER_3(vmaxub, void, avr, avr, avr)
-DEF_HELPER_3(vmaxuh, void, avr, avr, avr)
-DEF_HELPER_3(vmaxuw, void, avr, avr, avr)
-DEF_HELPER_3(vmaxud, void, avr, avr, avr)
 DEF_HELPER_4(vcmpequb, void, env, avr, avr, avr)
 DEF_HELPER_4(vcmpequh, void, env, avr, avr, avr)
 DEF_HELPER_4(vcmpequw, void, env, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 4aeb375edd..162add561e 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -921,33 +921,6 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
-#define VMINMAX_DO(name, compare, element)                              \
-    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
-    {                                                                   \
-        int i;                                                          \
-                                                                        \
-        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            if (a->element[i] compare b->element[i]) {                  \
-                r->element[i] = b->element[i];                          \
-            } else {                                                    \
-                r->element[i] = a->element[i];                          \
-            }                                                           \
-        }                                                               \
-    }
-#define VMINMAX(suffix, element)                \
-    VMINMAX_DO(min##suffix, >, element)         \
-    VMINMAX_DO(max##suffix, <, element)
-VMINMAX(sb, s8)
-VMINMAX(sh, s16)
-VMINMAX(sw, s32)
-VMINMAX(sd, s64)
-VMINMAX(ub, u8)
-VMINMAX(uh, u16)
-VMINMAX(uw, u32)
-VMINMAX(ud, u64)
-#undef VMINMAX_DO
-#undef VMINMAX
-
 void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 62c5578070..f1b15ae2cb 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -416,22 +416,22 @@ GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
 GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
 GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
 GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
-GEN_VXFORM(vmaxub, 1, 0);
-GEN_VXFORM(vmaxuh, 1, 1);
-GEN_VXFORM(vmaxuw, 1, 2);
-GEN_VXFORM(vmaxud, 1, 3);
-GEN_VXFORM(vmaxsb, 1, 4);
-GEN_VXFORM(vmaxsh, 1, 5);
-GEN_VXFORM(vmaxsw, 1, 6);
-GEN_VXFORM(vmaxsd, 1, 7);
-GEN_VXFORM(vminub, 1, 8);
-GEN_VXFORM(vminuh, 1, 9);
-GEN_VXFORM(vminuw, 1, 10);
-GEN_VXFORM(vminud, 1, 11);
-GEN_VXFORM(vminsb, 1, 12);
-GEN_VXFORM(vminsh, 1, 13);
-GEN_VXFORM(vminsw, 1, 14);
-GEN_VXFORM(vminsd, 1, 15);
+GEN_VXFORM_V(vmaxub, MO_8, tcg_gen_gvec_umax, 1, 0);
+GEN_VXFORM_V(vmaxuh, MO_16, tcg_gen_gvec_umax, 1, 1);
+GEN_VXFORM_V(vmaxuw, MO_32, tcg_gen_gvec_umax, 1, 2);
+GEN_VXFORM_V(vmaxud, MO_64, tcg_gen_gvec_umax, 1, 3);
+GEN_VXFORM_V(vmaxsb, MO_8, tcg_gen_gvec_smax, 1, 4);
+GEN_VXFORM_V(vmaxsh, MO_16, tcg_gen_gvec_smax, 1, 5);
+GEN_VXFORM_V(vmaxsw, MO_32, tcg_gen_gvec_smax, 1, 6);
+GEN_VXFORM_V(vmaxsd, MO_64, tcg_gen_gvec_smax, 1, 7);
+GEN_VXFORM_V(vminub, MO_8, tcg_gen_gvec_umin, 1, 8);
+GEN_VXFORM_V(vminuh, MO_16, tcg_gen_gvec_umin, 1, 9);
+GEN_VXFORM_V(vminuw, MO_32, tcg_gen_gvec_umin, 1, 10);
+GEN_VXFORM_V(vminud, MO_64, tcg_gen_gvec_umin, 1, 11);
+GEN_VXFORM_V(vminsb, MO_8, tcg_gen_gvec_smin, 1, 12);
+GEN_VXFORM_V(vminsh, MO_16, tcg_gen_gvec_smin, 1, 13);
+GEN_VXFORM_V(vminsw, MO_32, tcg_gen_gvec_smin, 1, 14);
+GEN_VXFORM_V(vminsd, MO_64, tcg_gen_gvec_smin, 1, 15);
 GEN_VXFORM(vavgub, 1, 16);
 GEN_VXFORM(vabsdub, 1, 16);
 GEN_VXFORM_DUAL(vavgub, PPC_ALTIVEC, PPC_NONE, \
-- 
2.11.0
