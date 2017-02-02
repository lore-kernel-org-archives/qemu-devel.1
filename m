Received: from eggs.gnu.org ([2001:4830:134:3::10]:52558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kD-0007tw-RV
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k7-0004EX-Lh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:12 +1100
Message-Id: <20170202051445.5735-75-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 074/107] ppc: Implement bcdsr. instruction
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

bcdsr.: Decimal shift and round. This instruction works like bcds.
however, when performing right shift, 1 will be added to the
result if the last digit was >= 5.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 48 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  1 +
 target/ppc/translate/vmx-ops.inc.c  |  2 ++
 4 files changed, 52 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 161d537..3cac050 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -395,6 +395,7 @@ DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
 DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
 DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
+DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xsaddqp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 9d88352..d309059 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3143,6 +3143,54 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
+uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+{
+    int cr;
+    int unused = 0;
+    int invalid = 0;
+    bool ox_flag = false;
+    int sgnb = bcd_get_sgn(b);
+    ppc_avr_t ret = *b;
+    ret.u64[LO_IDX] &= ~0xf;
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    int i = a->s8[7];
+    ppc_avr_t bcd_one = { .u64 = { 0, 0x10 } };
+#else
+    int i = a->s8[8];
+    ppc_avr_t bcd_one = { .u64 = { 0x10, 0 } };
+#endif
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
+
+        if (bcd_get_digit(&ret, 0, &invalid) >= 5) {
+            bcd_add_mag(&ret, &ret, &bcd_one, &invalid, &unused);
+        }
+    }
+    bcd_put_digit(&ret, bcd_preferred_sgn(sgnb, ps), 0);
+
+    cr = bcd_cmp_zero(&ret);
+    if (ox_flag) {
+        cr |= CRF_SO;
+    }
+    *r = ret;
+
+    return cr;
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index fc54881..451abb5 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -1018,6 +1018,7 @@ GEN_BCD2(bcdsetsgn)
 GEN_BCD(bcdcpsgn);
 GEN_BCD(bcds);
 GEN_BCD(bcdus);
+GEN_BCD(bcdsr);
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index cdd3abe..fa9c996 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -132,6 +132,8 @@ GEN_HANDLER_E_2(vprtybd, 0x4, 0x1, 0x18, 9, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E_2(vprtybq, 0x4, 0x1, 0x18, 10, 0, PPC_NONE, PPC2_ISA300),
 
 GEN_VXFORM_DUAL(vsubcuw, xpnd04_1, 0, 22, PPC_ALTIVEC, PPC_NONE),
+GEN_VXFORM_300(bcdsr, 0, 23),
+GEN_VXFORM_300(bcdsr, 0, 31),
 GEN_VXFORM_DUAL(vaddubs, vmul10uq, 0, 8, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vadduhs, vmul10euq, 0, 9, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vadduws, 0, 10),
-- 
2.9.3
