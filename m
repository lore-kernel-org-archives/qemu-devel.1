Received: from eggs.gnu.org ([2001:4830:134:3::10]:56733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cEo7t-0004FG-Sb
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cEo7p-0006g0-SP
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:08:01 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:49076
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cEo7p-0006fP-J2
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:07:57 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB823cSW098557
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 21:07:54 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276w42cbmg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 21:07:54 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 8 Dec 2016 00:07:51 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Thu,  8 Dec 2016 00:07:06 -0200
In-Reply-To: <1481162828-2295-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1481162828-2295-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1481162828-2295-5-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 4/6] target-ppc: Implement bcdsr. instruction
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

bcdsr.: Decimal shift and round. This instruction works like bcds.
however, when performing right shift, 1 will be added to the
result if the last digit was >= 5.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target-ppc/helper.h                 |  1 +
 target-ppc/int_helper.c             | 45 +++++++++++++++++++++++++++++++++++++
 target-ppc/translate/vmx-impl.inc.c |  1 +
 target-ppc/translate/vmx-ops.inc.c  |  2 ++
 4 files changed, 49 insertions(+)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 386ea67..d9528eb 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -394,6 +394,7 @@ DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
 DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
 DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
+DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
index 342fb41..cfef25f 100644
--- a/target-ppc/int_helper.c
+++ b/target-ppc/int_helper.c
@@ -3124,6 +3124,51 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
+uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+{
+    int cr;
+    int i;
+    int unused = 0;
+    int invalid = 0;
+    bool ox_flag = false;
+    int sgnb = bcd_get_sgn(b);
+    ppc_avr_t ret = *b;
+    ret.u64[LO_IDX] &= ~0xf;
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    ppc_avr_t bcd_one = { .u64 = { 0, 0x10 } };
+    int upper = ARRAY_SIZE(a->s8) - 1;
+#else
+    ppc_avr_t bcd_one = { .u64 = { 0x10, 0 } };
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
+
+        if (bcd_get_digit(&ret, 0, &invalid) >= 5) {
+            bcd_add_mag(&ret, &ret, &bcd_one, &invalid, &unused);
+        }
+    }
+    bcd_put_digit(&ret, bcd_preferred_sgn(sgnb, ps), 0);
+
+    cr = bcd_cmp_zero(&ret);
+    if (unlikely(ox_flag)) {
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
diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/translate/vmx-impl.inc.c
index fc54881..451abb5 100644
--- a/target-ppc/translate/vmx-impl.inc.c
+++ b/target-ppc/translate/vmx-impl.inc.c
@@ -1018,6 +1018,7 @@ GEN_BCD2(bcdsetsgn)
 GEN_BCD(bcdcpsgn);
 GEN_BCD(bcds);
 GEN_BCD(bcdus);
+GEN_BCD(bcdsr);
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translate/vmx-ops.inc.c
index cdd3abe..fa9c996 100644
--- a/target-ppc/translate/vmx-ops.inc.c
+++ b/target-ppc/translate/vmx-ops.inc.c
@@ -132,6 +132,8 @@ GEN_HANDLER_E_2(vprtybd, 0x4, 0x1, 0x18, 9, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E_2(vprtybq, 0x4, 0x1, 0x18, 10, 0, PPC_NONE, PPC2_ISA300),
 
 GEN_VXFORM_DUAL(vsubcuw, xpnd04_1, 0, 22, PPC_ALTIVEC, PPC_NONE),
+GEN_VXFORM_300(bcdsr, 0, 23),
+GEN_VXFORM_300(bcdsr, 0, 31),
 GEN_VXFORM_DUAL(vaddubs, vmul10uq, 0, 8, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vadduhs, vmul10euq, 0, 9, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vadduws, 0, 10),
-- 
2.7.4
