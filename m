Received: from eggs.gnu.org ([2001:4830:134:3::10]:52336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k8-0007mq-Pa
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k2-000482-OF
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:10 +1100
Message-Id: <20170202051445.5735-73-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 072/107] ppc: Implement bcds. instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

bcds.: Decimal shift. Given two registers vra and vrb, this instruction
shift the vrb value by vra bits into the result register.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 40 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  3 +++
 target/ppc/translate/vmx-ops.inc.c  |  3 ++-
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ec0ae8a..26edbf9 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -393,6 +393,7 @@ DEF_HELPER_3(bcdcfsq, i32, avr, avr, i32)
 DEF_HELPER_3(bcdctsq, i32, avr, avr, i32)
 DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
 DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
+DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xsaddqp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 8cf4ee3..5f53710 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3062,6 +3062,46 @@ uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(r);
 }
 
+uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+{
+    int cr;
+#if defined(HOST_WORDS_BIGENDIAN)
+    int i = a->s8[7];
+#else
+    int i = a->s8[8];
+#endif
+    bool ox_flag = false;
+    int sgnb = bcd_get_sgn(b);
+    ppc_avr_t ret = *b;
+    ret.u64[LO_IDX] &= ~0xf;
+
+    if (bcd_is_valid(b) == false) {
+        return CRF_SO;
+    }
+
+    if (unlikely(i > 31)) {
+        i = 31;
+    } else if (unlikely(i < -31)) {
+        i = -31;
+    }
+
+    if (i > 0) {
+        ulshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4, &ox_flag);
+    } else {
+        urshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], -i * 4);
+    }
+    bcd_put_digit(&ret, bcd_preferred_sgn(sgnb, ps), 0);
+
+    *r = ret;
+
+    cr = bcd_cmp_zero(r);
+    if (ox_flag) {
+        cr |= CRF_SO;
+    }
+
+    return cr;
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index e8e527f..84ebb7e 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -1016,6 +1016,7 @@ GEN_BCD2(bcdcfsq)
 GEN_BCD2(bcdctsq)
 GEN_BCD2(bcdsetsgn)
 GEN_BCD(bcdcpsgn);
+GEN_BCD(bcds);
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
@@ -1090,6 +1091,8 @@ GEN_VXFORM_DUAL(vsubuhs, PPC_ALTIVEC, PPC_NONE, \
                 bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
 GEN_VXFORM_DUAL(vaddshs, PPC_ALTIVEC, PPC_NONE, \
                 bcdcpsgn, PPC_NONE, PPC2_ISA300)
+GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NONE, \
+                bcds, PPC_NONE, PPC2_ISA300)
 
 static void gen_vsbox(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 57dce6e..7b4b009 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -62,7 +62,8 @@ GEN_VXFORM_207(vaddudm, 0, 3),
 GEN_VXFORM_DUAL(vsububm, bcdadd, 0, 16, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vsubuwm, 0, 18),
-GEN_VXFORM_207(vsubudm, 0, 19),
+GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
+GEN_VXFORM_300(bcds, 0, 27),
 GEN_VXFORM(vmaxub, 1, 0),
 GEN_VXFORM(vmaxuh, 1, 1),
 GEN_VXFORM(vmaxuw, 1, 2),
-- 
2.9.3
