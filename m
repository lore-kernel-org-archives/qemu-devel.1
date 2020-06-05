Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D273B2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D273B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh6uJ-000067-3v
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jh4gR-0000Ej-H8; Fri, 05 Jun 2020 01:14:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48910
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jh4gQ-00033T-20; Fri, 05 Jun 2020 01:14:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05552esA012545; Fri, 5 Jun 2020 01:14:19 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31f9dr0qap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2020 01:14:19 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05559XpF013072;
 Fri, 5 Jun 2020 05:14:18 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma04wdc.us.ibm.com with ESMTP id 31bf4991g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2020 05:14:18 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0555EHrT23068990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2020 05:14:17 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 501156A05A;
 Fri,  5 Jun 2020 05:14:17 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E99D96A047;
 Fri,  5 Jun 2020 05:14:15 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.198.47])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2020 05:14:15 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH 1/1] target/ppc: add vmsumudm vmsumcud instructions
Date: Fri,  5 Jun 2020 00:14:15 -0500
Message-Id: <20200605051415.53557-1-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-05_01:2020-06-04,
 2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=764
 clxscore=1011 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 suspectscore=2 impostorscore=0 bulkscore=0
 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 01:14:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Jun 2020 03:35:55 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Lijun Pan <ljp@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned Doubleword Modulo
VA-form.
vmsumcud (Power ISA 3.1) - Vector Multiply-Sum & write Carry-out Unsigned
Doubleword VA-form.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
 disas/ppc.c                         |  2 ++
 include/qemu/host-utils.h           |  2 ++
 target/ppc/helper.h                 |  4 ++-
 target/ppc/int_helper.c             | 47 ++++++++++++++++++++++++++++-
 target/ppc/translate.c              |  1 -
 target/ppc/translate/vmx-impl.inc.c | 39 +++++++++++++-----------
 target/ppc/translate/vmx-ops.inc.c  |  2 ++
 util/host-utils.c                   | 13 ++++++++
 8 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/disas/ppc.c b/disas/ppc.c
index 63e97cfe1d..3ed4d23ed3 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -2261,7 +2261,9 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "vmsumshs",  VXA(4,  41), VXA_MASK,	PPCVEC,		{ VD, VA, VB, VC } },
 { "vmsumubm",  VXA(4,  36), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
 { "vmsumuhm",  VXA(4,  38), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
+{ "vmsumudm",  VXA(4,  35), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
 { "vmsumuhs",  VXA(4,  39), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
+{ "vmsumcud",  VXA(4,  23), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
 { "vmulesb",   VX(4,  776), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
 { "vmulesh",   VX(4,  840), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
 { "vmuleub",   VX(4,  520), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 4cd170e6cd..0a207ae07d 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -81,6 +81,8 @@ void muls64(uint64_t *phigh, uint64_t *plow, int64_t a, int64_t b);
 void mulu64(uint64_t *phigh, uint64_t *plow, uint64_t a, uint64_t b);
 int divu128(uint64_t *plow, uint64_t *phigh, uint64_t divisor);
 int divs128(int64_t *plow, int64_t *phigh, int64_t divisor);
+void addu128(uint64_t ah, uint64_t al, uint64_t bh, uint64_t bl,
+		uint64_t *rh, uint64_t *rl, uint64_t *ca);
 
 static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
 {
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 2dfa1c6942..d540e8f30b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -263,10 +263,12 @@ DEF_HELPER_3(vpkpx, void, avr, avr, avr)
 DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)
+DEF_HELPER_5(vmsumudm, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
-DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
+DEF_HELPER_5(vmsumcud, void, env, avr, avr, avr, avr)
+DEF_HELPER_5(vmladduhm, void, env, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
 DEF_HELPER_3(lvebx, void, env, avr, tl)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index be53cd6f68..037c2785d1 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -926,7 +926,8 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
-void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void helper_vmladduhm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+			ppc_avr_t *b, ppc_avr_t *c)
 {
     int i;
 
@@ -1064,6 +1065,50 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
+static void vmsumcudm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b,
+			ppc_avr_t *c, bool ca)
+{
+#ifdef CONFIG_INT128
+	__uint128_t prod[2];
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		prod[i] = (__uint128_t)(a->VsrD(i)) * (__uint128_t)(b->VsrD(i));
+	}
+	if (ca)
+		r->u128 = (~prod[0] < prod[1]) + (~c->u128 < (prod[0] + prod[1]));
+	else
+		r->u128 = prod[0] + prod[1] + c->u128;
+#else
+	uint64_t ah64, al64, bh64, bl64, ch64, cl64, rh64, rl64, th64, tl64, ca1, ca2;
+
+	ch64 = c->VsrD(0);
+	cl64 = c->VsrD(1);
+	mulu64(&al64, &ah64, a->VsrD(0), b->VsrD(0));
+	mulu64(&bl64, &bh64, a->VsrD(1), b->VsrD(1));
+	addu128(ah64, al64, bh64, bl64, &rh64, &rl64, &ca1);
+	addu128(rh64, rl64, ch64, cl64, &th64, &tl64, &ca2);
+	if (ca) {
+		r->VsrD(0) = 0;
+		r->VsrD(1) = ca1 + ca2;
+	} else {
+		r->VsrD(0) = th64;
+		r->VsrD(1) = tl64;
+	}
+#endif
+}
+
+void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+			ppc_avr_t *b, ppc_avr_t *c)
+{
+	vmsumcudm(r, a, b, c, 0);
+}
+void helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+			ppc_avr_t *b, ppc_avr_t *c)
+{
+	vmsumcudm(r, a, b, c, 1);
+}
+
 #define VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast)   \
     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
     {                                                                   \
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4ce3d664b5..35ff1aa77e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7281,7 +7281,6 @@ GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
 GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
-GEN_HANDLER(vmladduhm, 0x04, 0x11, 0xFF, 0x00000000, PPC_ALTIVEC),
 #if defined(TARGET_PPC64)
 GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
               PPC2_ISA300),
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 403ed3a01c..5c0e44d7fb 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -1248,6 +1248,25 @@ static void gen_vsldoi(DisasContext *ctx)
     tcg_temp_free_i32(sh);
 }
 
+#define GEN_VAFORM(name, opc2)	                                        \
+static void glue(gen_, name)(DisasContext *ctx)                         \
+{                                                                       \
+    TCGv_ptr ra, rb, rc, rd;                                            \
+    if (unlikely(!ctx->altivec_enabled)) {                              \
+        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
+        return;                                                         \
+    }                                                                   \
+    ra = gen_avr_ptr(rA(ctx->opcode));                                  \
+    rb = gen_avr_ptr(rB(ctx->opcode));                                  \
+    rc = gen_avr_ptr(rC(ctx->opcode));                                  \
+    rd = gen_avr_ptr(rD(ctx->opcode));                                  \
+    gen_helper_##name(cpu_env, rd, ra, rb, rc);                         \
+    tcg_temp_free_ptr(ra);                                              \
+    tcg_temp_free_ptr(rb);                                              \
+    tcg_temp_free_ptr(rc);                                              \
+    tcg_temp_free_ptr(rd);                                              \
+}
+
 #define GEN_VAFORM_PAIRED(name0, name1, opc2)                           \
 static void glue(gen_, name0##_##name1)(DisasContext *ctx)              \
     {                                                                   \
@@ -1272,24 +1291,8 @@ static void glue(gen_, name0##_##name1)(DisasContext *ctx)              \
     }
 
 GEN_VAFORM_PAIRED(vmhaddshs, vmhraddshs, 16)
-
-static void gen_vmladduhm(DisasContext *ctx)
-{
-    TCGv_ptr ra, rb, rc, rd;
-    if (unlikely(!ctx->altivec_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VPU);
-        return;
-    }
-    ra = gen_avr_ptr(rA(ctx->opcode));
-    rb = gen_avr_ptr(rB(ctx->opcode));
-    rc = gen_avr_ptr(rC(ctx->opcode));
-    rd = gen_avr_ptr(rD(ctx->opcode));
-    gen_helper_vmladduhm(rd, ra, rb, rc);
-    tcg_temp_free_ptr(ra);
-    tcg_temp_free_ptr(rb);
-    tcg_temp_free_ptr(rc);
-    tcg_temp_free_ptr(rd);
-}
+GEN_VAFORM(vmsumcud, 11)
+GEN_VAFORM_PAIRED(vmladduhm, vmsumudm, 17)
 
 static void gen_vpermr(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 84e05fb827..aee23e31c6 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -276,6 +276,8 @@ GEN_VAFORM_PAIRED(vmsumuhm, vmsumuhs, 19),
 GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20),
 GEN_VAFORM_PAIRED(vsel, vperm, 21),
 GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23),
+GEN_HANDLER(vmsumcud, 0x4, 11, 0xFF, 0x00000000, PPC_ALTIVEC),
+GEN_VAFORM_PAIRED(vmladduhm, vmsumudm, 17),
 
 GEN_VXFORM_DUAL(vclzb, vpopcntb, 1, 28, PPC_NONE, PPC2_ALTIVEC_207),
 GEN_VXFORM_DUAL(vclzh, vpopcnth, 1, 29, PPC_NONE, PPC2_ALTIVEC_207),
diff --git a/util/host-utils.c b/util/host-utils.c
index 7b9322071d..4bc159d2a9 100644
--- a/util/host-utils.c
+++ b/util/host-utils.c
@@ -159,6 +159,19 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
 
     return overflow;
 }
+
+void addu128(uint64_t ah, uint64_t al, uint64_t bh, uint64_t bl,
+		uint64_t *rh, uint64_t *rl, uint64_t *ca)
+{
+	uint64_t lo = al + bl;
+	uint64_t hi = ah + bh + (~al < bl);
+	uint64_t hi_t = ah + bh;
+	uint64_t carry = (~ah < bh) + (~hi_t < (~al < bl));
+
+	*rl = lo;
+	*rh = hi;
+	*ca = carry;
+}
 #endif
 
 /**
-- 
2.23.0


