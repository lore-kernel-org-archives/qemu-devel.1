Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjx-0002sQ-7W
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjv-0006RU-Qp
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:32 +1100
Message-Id: <20170112020327.24882-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/67] target-ppc: Implement bcdcpsgn.
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

bcdcpsgn.: Decimal copy sign. Given two registers vra and vrb, it
copies the vra value with vrb sign to the result register vrt.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 23 +++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  3 +++
 target/ppc/translate/vmx-ops.inc.c  |  2 +-
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index d404e0b..2974101 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -384,6 +384,7 @@ DEF_HELPER_3(bcdcfz, i32, avr, avr, i32)
 DEF_HELPER_3(bcdctz, i32, avr, avr, i32)
 DEF_HELPER_3(bcdcfsq, i32, avr, avr, i32)
 DEF_HELPER_3(bcdctsq, i32, avr, avr, i32)
+DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 5a7ceb8..8021c48 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2952,6 +2952,29 @@ uint32_t helper_bcdctsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
+uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+{
+    int i;
+    int invalid = 0;
+
+    if (bcd_get_sgn(a) == 0 || bcd_get_sgn(b) == 0) {
+        return CRF_SO;
+    }
+
+    *r = *a;
+    bcd_put_digit(r, b->u8[BCD_DIG_BYTE(0)] & 0xF, 0);
+
+    for (i = 1; i < 32; i++) {
+        bcd_get_digit(a, i, &invalid);
+        bcd_get_digit(b, i, &invalid);
+        if (unlikely(invalid)) {
+            return CRF_SO;
+        }
+    }
+
+    return bcd_cmp_zero(r);
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 1579b58..c14b666 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -991,6 +991,7 @@ GEN_BCD2(bcdcfz)
 GEN_BCD2(bcdctz)
 GEN_BCD2(bcdcfsq)
 GEN_BCD2(bcdctsq)
+GEN_BCD(bcdcpsgn);
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
@@ -1056,6 +1057,8 @@ GEN_VXFORM_DUAL(vsubuhm, PPC_ALTIVEC, PPC_NONE, \
                 bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
 GEN_VXFORM_DUAL(vsubuhs, PPC_ALTIVEC, PPC_NONE, \
                 bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
+GEN_VXFORM_DUAL(vaddshs, PPC_ALTIVEC, PPC_NONE, \
+                bcdcpsgn, PPC_NONE, PPC2_ISA300)
 
 static void gen_vsbox(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index f02b3be..70d7d2b 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -131,7 +131,7 @@ GEN_VXFORM_DUAL(vaddubs, vmul10uq, 0, 8, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vadduhs, vmul10euq, 0, 9, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vadduws, 0, 10),
 GEN_VXFORM(vaddsbs, 0, 12),
-GEN_VXFORM(vaddshs, 0, 13),
+GEN_VXFORM_DUAL(vaddshs, bcdcpsgn, 0, 13, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vaddsws, 0, 14),
 GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
-- 
2.9.3
