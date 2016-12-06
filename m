Received: from eggs.gnu.org ([2001:4830:134:3::10]:41382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cELba-0000Nx-3n
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cELbY-0004Sa-NA
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:46 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:40406
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cELbY-0004SH-DG
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6Je6pO055440
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 14:40:43 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2762h4cxvs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 14:40:43 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 17:40:40 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue,  6 Dec 2016 17:40:06 -0200
In-Reply-To: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1481053210-26821-4-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/7] target-ppc: Implement bcds. instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

bcds.: Decimal shift. Given two registers vra and vrb, this instruction
shift the vrb value by vra bits into the result register.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target-ppc/helper.h                 |  1 +
 target-ppc/int_helper.c             | 38 +++++++++++++++++++++++++++++++++++++
 target-ppc/translate/vmx-impl.inc.c |  3 +++
 target-ppc/translate/vmx-ops.inc.c  |  3 ++-
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index bc39efb..471a1da 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -392,6 +392,7 @@ DEF_HELPER_3(bcdcfsq, i32, avr, avr, i32)
 DEF_HELPER_3(bcdctsq, i32, avr, avr, i32)
 DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
 DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
+DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
index 7989b1f..854cf3a 100644
--- a/target-ppc/int_helper.c
+++ b/target-ppc/int_helper.c
@@ -3043,6 +3043,44 @@ uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(r);
 }
 
+uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+{
+    int cr;
+    int i = 0;
+    bool ox_flag = false;
+    int sgnb = bcd_get_sgn(b);
+    ppc_avr_t ret = *b;
+    ret.u64[LO_IDX] &= ~0xf;
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    int upper = ARRAY_SIZE(a->s8) - 1;
+#else
+    int upper = 0;
+#endif
+
+    if (bcd_is_valid(b) == false) {
+        return CRF_SO;
+    }
+
+    if (a->s8[upper] > 0) {
+        i = (a->s8[upper] > 31) ? 31 : a->s8[upper];
+        ulshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4, &ox_flag);
+    } else {
+        i = (a->s8[upper] < -31) ? 31 : -a->s8[upper];
+        urshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4);
+    }
+    bcd_put_digit(&ret, bcd_preferred_sgn(sgnb, ps), 0);
+
+    *r = ret;
+
+    cr = bcd_cmp_zero(r);
+    if (unlikely(ox_flag)) {
+        cr |= CRF_SO;
+    }
+
+    return cr;
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/translate/vmx-impl.inc.c
index e8e527f..84ebb7e 100644
--- a/target-ppc/translate/vmx-impl.inc.c
+++ b/target-ppc/translate/vmx-impl.inc.c
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
diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translate/vmx-ops.inc.c
index 57dce6e..7b4b009 100644
--- a/target-ppc/translate/vmx-ops.inc.c
+++ b/target-ppc/translate/vmx-ops.inc.c
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
2.7.4
