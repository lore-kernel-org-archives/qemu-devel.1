Received: from eggs.gnu.org ([2001:4830:134:3::10]:52220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k6-0007jI-1c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jz-00044y-Ks
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:33 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:11 +1100
Message-Id: <20170202051445.5735-74-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 073/107] ppc: Implement bcdus. instruction
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

bcdus.: Decimal unsigned shift. This instruction works like bcds. but
considers only unsigned BCDs (no sign in least meaning 4 bits).

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 41 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  3 +++
 target/ppc/translate/vmx-ops.inc.c  |  2 +-
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 26edbf9..161d537 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -394,6 +394,7 @@ DEF_HELPER_3(bcdctsq, i32, avr, avr, i32)
 DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
 DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
 DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
+DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xsaddqp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 5f53710..9d88352 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3102,6 +3102,47 @@ uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
+uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+{
+    int cr;
+    int i;
+    int invalid = 0;
+    bool ox_flag = false;
+    ppc_avr_t ret = *b;
+
+    for (i = 0; i < 32; i++) {
+        bcd_get_digit(b, i, &invalid);
+
+        if (unlikely(invalid)) {
+            return CRF_SO;
+        }
+    }
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    i = a->s8[7];
+#else
+    i = a->s8[8];
+#endif
+    if (i >= 32) {
+        ox_flag = true;
+        ret.u64[LO_IDX] = ret.u64[HI_IDX] = 0;
+    } else if (i <= -32) {
+        ret.u64[LO_IDX] = ret.u64[HI_IDX] = 0;
+    } else if (i > 0) {
+        ulshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4, &ox_flag);
+    } else {
+        urshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], -i * 4);
+    }
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
index 84ebb7e..fc54881 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -1017,6 +1017,7 @@ GEN_BCD2(bcdctsq)
 GEN_BCD2(bcdsetsgn)
 GEN_BCD(bcdcpsgn);
 GEN_BCD(bcds);
+GEN_BCD(bcdus);
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
@@ -1093,6 +1094,8 @@ GEN_VXFORM_DUAL(vaddshs, PPC_ALTIVEC, PPC_NONE, \
                 bcdcpsgn, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NONE, \
                 bcds, PPC_NONE, PPC2_ISA300)
+GEN_VXFORM_DUAL(vsubuwm, PPC_ALTIVEC, PPC_NONE, \
+                bcdus, PPC_NONE, PPC2_ISA300)
 
 static void gen_vsbox(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 7b4b009..cdd3abe 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -61,7 +61,7 @@ GEN_VXFORM(vadduwm, 0, 2),
 GEN_VXFORM_207(vaddudm, 0, 3),
 GEN_VXFORM_DUAL(vsububm, bcdadd, 0, 16, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM(vsubuwm, 0, 18),
+GEN_VXFORM_DUAL(vsubuwm, bcdus, 0, 18, PPC_ALTIVEC, PPC2_ISA300),
 GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
 GEN_VXFORM_300(bcds, 0, 27),
 GEN_VXFORM(vmaxub, 1, 0),
-- 
2.9.3
