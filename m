Received: from eggs.gnu.org ([2001:4830:134:3::10]:55427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cQltk-0001yr-7i
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cQlth-0008TL-1c
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35485
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cQltg-0008T6-Sa
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:48 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A28v8G084844
	for <qemu-devel@nongnu.org>; Mon, 9 Jan 2017 21:10:48 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27vmewv6y2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 21:10:48 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 00:10:46 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 00:10:12 -0200
In-Reply-To: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1484014214-32533-6-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 5/7] ppc: Implement bcdsr. instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, eblake@redhat.com

bcdsr.: Decimal shift and round. This instruction works like bcds.
however, when performing right shift, 1 will be added to the
result if the last digit was >= 5.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 48 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  1 +
 target/ppc/translate/vmx-ops.inc.c  |  2 ++
 4 files changed, 52 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 065eb66..d1db462 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -400,6 +400,7 @@ DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
 DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
 DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
+DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xsaddqp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 91ae89f..b184063 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -3175,6 +3175,54 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
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
2.7.4
