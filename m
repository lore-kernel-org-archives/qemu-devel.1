Received: from eggs.gnu.org ([2001:4830:134:3::10]:52722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kH-0007xl-78
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k9-0004H7-Ip
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:23 +1100
Message-Id: <20170202051445.5735-86-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 085/107] ppc: Implement bcdtrunc. instruction
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

bcdtrunc.: Decimal integer truncate. Given a BCD number in vrb and the
number of bytes to truncate in vra, the return register will have vrb
with such bits truncated.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 37 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  5 +++++
 target/ppc/translate/vmx-ops.inc.c  |  4 ++--
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 96d8cae..ddc6a9b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -396,6 +396,7 @@ DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
 DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
+DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xsaddqp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d309059..9f56cff 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3191,6 +3191,43 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
+uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+{
+    uint64_t mask;
+    uint32_t ox_flag = 0;
+#if defined(HOST_WORDS_BIGENDIAN)
+    int i = a->s16[3] + 1;
+#else
+    int i = a->s16[4] + 1;
+#endif
+    ppc_avr_t ret = *b;
+
+    if (bcd_is_valid(b) == false) {
+        return CRF_SO;
+    }
+
+    if (i > 16 && i < 32) {
+        mask = (uint64_t)-1 >> (128 - i * 4);
+        if (ret.u64[HI_IDX] & ~mask) {
+            ox_flag = CRF_SO;
+        }
+
+        ret.u64[HI_IDX] &= mask;
+    } else if (i >= 0 && i <= 16) {
+        mask = (uint64_t)-1 >> (64 - i * 4);
+        if (ret.u64[HI_IDX] || (ret.u64[LO_IDX] & ~mask)) {
+            ox_flag = CRF_SO;
+        }
+
+        ret.u64[LO_IDX] &= mask;
+        ret.u64[HI_IDX] = 0;
+    }
+    bcd_put_digit(&ret, bcd_preferred_sgn(bcd_get_sgn(b), ps), 0);
+    *r = ret;
+
+    return bcd_cmp_zero(&ret) | ox_flag;
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 451abb5..1683f42 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -1019,6 +1019,7 @@ GEN_BCD(bcdcpsgn);
 GEN_BCD(bcds);
 GEN_BCD(bcdus);
 GEN_BCD(bcdsr);
+GEN_BCD(bcdtrunc);
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
@@ -1097,6 +1098,10 @@ GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NONE, \
                 bcds, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_DUAL(vsubuwm, PPC_ALTIVEC, PPC_NONE, \
                 bcdus, PPC_NONE, PPC2_ISA300)
+GEN_VXFORM_DUAL(vsubsbs, PPC_ALTIVEC, PPC_NONE, \
+                bcdtrunc, PPC_NONE, PPC2_ISA300)
+GEN_VXFORM_DUAL(vsubuqm, PPC2_ALTIVEC_207, PPC_NONE, \
+                bcdtrunc, PPC_NONE, PPC2_ISA300)
 
 static void gen_vsbox(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index fa9c996..e6167a4 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -143,14 +143,14 @@ GEN_VXFORM(vaddsws, 0, 14),
 GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vsubuws, 0, 26),
-GEN_VXFORM(vsubsbs, 0, 28),
+GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_NONE, PPC2_ISA300),
 GEN_VXFORM(vsubshs, 0, 29),
 GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_207(vadduqm, 0, 4),
 GEN_VXFORM_207(vaddcuq, 0, 5),
 GEN_VXFORM_DUAL(vaddeuqm, vaddecuq, 30, 0xFF, PPC_NONE, PPC2_ALTIVEC_207),
-GEN_VXFORM_207(vsubuqm, 0, 20),
 GEN_VXFORM_207(vsubcuq, 0, 21),
+GEN_VXFORM_DUAL(vsubuqm, bcdtrunc, 0, 20, PPC2_ALTIVEC_207, PPC2_ISA300),
 GEN_VXFORM_DUAL(vsubeuqm, vsubecuq, 31, 0xFF, PPC_NONE, PPC2_ALTIVEC_207),
 GEN_VXFORM(vrlb, 2, 0),
 GEN_VXFORM(vrlh, 2, 1),
-- 
2.9.3
