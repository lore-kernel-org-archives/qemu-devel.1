Received: from eggs.gnu.org ([209.51.188.92]:53601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJs-0006n5-5j
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJm-0000On-8u
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:08 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:43 +0000
Message-Id: <20190215100058.20015-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 02/17] target/ppc: convert vaddu[b, h, w,
 d] and vsubu[b, h, w, d] over to use vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  8 --------
 target/ppc/int_helper.c             |  7 -------
 target/ppc/translate/vmx-impl.inc.c | 16 ++++++++--------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index c7de04e068..553ff500c8 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -108,14 +108,6 @@ DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, i32, i64)
 #define dh_ctype_avr ppc_avr_t *
 #define dh_is_signed_avr dh_is_signed_ptr
 
-DEF_HELPER_3(vaddubm, void, avr, avr, avr)
-DEF_HELPER_3(vadduhm, void, avr, avr, avr)
-DEF_HELPER_3(vadduwm, void, avr, avr, avr)
-DEF_HELPER_3(vaddudm, void, avr, avr, avr)
-DEF_HELPER_3(vsububm, void, avr, avr, avr)
-DEF_HELPER_3(vsubuhm, void, avr, avr, avr)
-DEF_HELPER_3(vsubuwm, void, avr, avr, avr)
-DEF_HELPER_3(vsubudm, void, avr, avr, avr)
 DEF_HELPER_3(vavgub, void, avr, avr, avr)
 DEF_HELPER_3(vavguh, void, avr, avr, avr)
 DEF_HELPER_3(vavguw, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 8efc283388..ffccda8b9b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -515,13 +515,6 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
             r->element[i] = a->element[i] op b->element[i];             \
         }                                                               \
     }
-#define VARITH(suffix, element)                 \
-    VARITH_DO(add##suffix, +, element)          \
-    VARITH_DO(sub##suffix, -, element)
-VARITH(ubm, u8)
-VARITH(uhm, u16)
-VARITH(uwm, u32)
-VARITH(udm, u64)
 VARITH_DO(muluwm, *, u32)
 #undef VARITH_DO
 #undef VARITH
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index c74932e5ee..b104c6e38e 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -395,18 +395,18 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
     tcg_temp_free_ptr(rb);                                              \
 }
 
-GEN_VXFORM(vaddubm, 0, 0);
+GEN_VXFORM_V(vaddubm, MO_8, tcg_gen_gvec_add, 0, 0);
 GEN_VXFORM_DUAL_EXT(vaddubm, PPC_ALTIVEC, PPC_NONE, 0,       \
                     vmul10cuq, PPC_NONE, PPC2_ISA300, 0x0000F800)
-GEN_VXFORM(vadduhm, 0, 1);
+GEN_VXFORM_V(vadduhm, MO_16, tcg_gen_gvec_add, 0, 1);
 GEN_VXFORM_DUAL(vadduhm, PPC_ALTIVEC, PPC_NONE,  \
                 vmul10ecuq, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vadduwm, 0, 2);
-GEN_VXFORM(vaddudm, 0, 3);
-GEN_VXFORM(vsububm, 0, 16);
-GEN_VXFORM(vsubuhm, 0, 17);
-GEN_VXFORM(vsubuwm, 0, 18);
-GEN_VXFORM(vsubudm, 0, 19);
+GEN_VXFORM_V(vadduwm, MO_32, tcg_gen_gvec_add, 0, 2);
+GEN_VXFORM_V(vaddudm, MO_64, tcg_gen_gvec_add, 0, 3);
+GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
+GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
+GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
+GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
 GEN_VXFORM(vmaxub, 1, 0);
 GEN_VXFORM(vmaxuh, 1, 1);
 GEN_VXFORM(vmaxuw, 1, 2);
-- 
2.11.0
