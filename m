Received: from eggs.gnu.org ([2001:4830:134:3::10]:33484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cJ16x-0007A7-1V
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cJ16t-00044D-UE
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59643
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cJ16t-000449-PG
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJGiVx3067966
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 11:48:23 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27efv569vf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 11:48:23 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 19 Dec 2016 14:48:21 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 14:47:44 -0200
In-Reply-To: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1482166064-18121-7-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 6/6] target-ppc: Implement bcdutrunc.
 instruction
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

bcdutrunc. Decimal unsigned truncate. Works like bcdtrunc. with
unsigned BCD numbers.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target-ppc/helper.h                 |  1 +
 target-ppc/int_helper.c             | 51 +++++++++++++++++++++++++++++++++++++
 target-ppc/translate/vmx-impl.inc.c |  4 +++
 target-ppc/translate/vmx-ops.inc.c  |  2 +-
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 7f053d8..38e5246 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -402,6 +402,7 @@ DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
+DEF_HELPER_4(bcdutrunc, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
index edcaa12..77f8c13 100644
--- a/target-ppc/int_helper.c
+++ b/target-ppc/int_helper.c
@@ -3209,6 +3209,57 @@ uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(&ret) | ox_flag;
 }
 
+uint32_t helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+{
+    int i;
+    uint64_t mask;
+    uint32_t ox_flag = 0;
+    int invalid = 0;
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
+    i = a->s16[3];
+#else
+    i = a->s16[4];
+#endif
+    if (i > 16 && i < 33) {
+        if (ret.u64[HI_IDX] >> (i * 4 - 64)) {
+            ox_flag = CRF_SO;
+        }
+
+        mask = (uint64_t)-1 >> (128 - i * 4);
+        ret.u64[HI_IDX] &= mask;
+    } else if (i > 0 && i <= 16) {
+        if (ret.u64[HI_IDX] || (i < 16 && ret.u64[LO_IDX] >> (i * 4))) {
+            ox_flag = CRF_SO;
+        }
+
+        mask = (uint64_t)-1 >> (64 - i * 4);
+        ret.u64[LO_IDX] &= mask;
+        ret.u64[HI_IDX] = 0;
+    } else if (i == 0) {
+        if (ret.u64[HI_IDX] || ret.u64[LO_IDX]) {
+            ox_flag = CRF_SO;
+        }
+        ret.u64[HI_IDX] = ret.u64[LO_IDX] = 0;
+    }
+
+    *r = ret;
+    if (r->u64[HI_IDX] == 0 && r->u64[LO_IDX] == 0) {
+        return ox_flag | CRF_EQ;
+    }
+
+    return ox_flag | CRF_GT;
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/translate/vmx-impl.inc.c
index 1683f42..3cb6fc2 100644
--- a/target-ppc/translate/vmx-impl.inc.c
+++ b/target-ppc/translate/vmx-impl.inc.c
@@ -1020,6 +1020,7 @@ GEN_BCD(bcds);
 GEN_BCD(bcdus);
 GEN_BCD(bcdsr);
 GEN_BCD(bcdtrunc);
+GEN_BCD(bcdutrunc);
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
@@ -1102,6 +1103,9 @@ GEN_VXFORM_DUAL(vsubsbs, PPC_ALTIVEC, PPC_NONE, \
                 bcdtrunc, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_DUAL(vsubuqm, PPC2_ALTIVEC_207, PPC_NONE, \
                 bcdtrunc, PPC_NONE, PPC2_ISA300)
+GEN_VXFORM_DUAL(vsubcuq, PPC2_ALTIVEC_207, PPC_NONE, \
+                bcdutrunc, PPC_NONE, PPC2_ISA300)
+
 
 static void gen_vsbox(DisasContext *ctx)
 {
diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translate/vmx-ops.inc.c
index e6167a4..139f80c 100644
--- a/target-ppc/translate/vmx-ops.inc.c
+++ b/target-ppc/translate/vmx-ops.inc.c
@@ -149,8 +149,8 @@ GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_207(vadduqm, 0, 4),
 GEN_VXFORM_207(vaddcuq, 0, 5),
 GEN_VXFORM_DUAL(vaddeuqm, vaddecuq, 30, 0xFF, PPC_NONE, PPC2_ALTIVEC_207),
-GEN_VXFORM_207(vsubcuq, 0, 21),
 GEN_VXFORM_DUAL(vsubuqm, bcdtrunc, 0, 20, PPC2_ALTIVEC_207, PPC2_ISA300),
+GEN_VXFORM_DUAL(vsubcuq, bcdutrunc, 0, 21, PPC2_ALTIVEC_207, PPC2_ISA300),
 GEN_VXFORM_DUAL(vsubeuqm, vsubecuq, 31, 0xFF, PPC_NONE, PPC2_ALTIVEC_207),
 GEN_VXFORM(vrlb, 2, 0),
 GEN_VXFORM(vrlh, 2, 1),
-- 
2.7.4
