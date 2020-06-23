Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 04:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E57920706
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 04:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E57920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnaVd-0001Ye-BR
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 00:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jnaUm-0000c2-CW; Tue, 23 Jun 2020 00:25:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jnaUk-0004ZH-Cd; Tue, 23 Jun 2020 00:25:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05N435ua033601; Tue, 23 Jun 2020 00:25:04 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31u60ceepr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 00:25:03 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05N4G0sh030220;
 Tue, 23 Jun 2020 04:25:02 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 31u20ctxp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 04:25:02 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05N4P2cO21365098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 04:25:02 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 230CA12405A;
 Tue, 23 Jun 2020 04:25:02 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88D54124054;
 Tue, 23 Jun 2020 04:25:01 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.252.240])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2020 04:25:01 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3] target/ppc: add vmsumudm vmsumcud instructions
Date: Mon, 22 Jun 2020 23:25:01 -0500
Message-Id: <20200623042501.47065-1-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-22_16:2020-06-22,
 2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=2 priorityscore=1501
 mlxscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=707
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230029
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 00:25:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Lijun Pan <ljp@linux.ibm.com>, richard.henderson@linaro.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned Doubleword Modulo
VA-form.
vmsumcud (Power ISA 3.1) - Vector Multiply-Sum & write Carry-out Unsigned
Doubleword VA-form.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v3: implement vmsumudm/vmsumcud through int128 functions,
    suggested by Richard Henderson.

 disas/ppc.c                         |  2 ++
 target/ppc/helper.h                 |  4 ++-
 target/ppc/int_helper.c             | 49 ++++++++++++++++++++++++++++-
 target/ppc/translate.c              |  1 -
 target/ppc/translate/vmx-impl.inc.c | 39 ++++++++++++-----------
 target/ppc/translate/vmx-ops.inc.c  |  2 ++
 6 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/disas/ppc.c b/disas/ppc.c
index 63e97cfe1d..bd76fae4c4 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -2261,7 +2261,9 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "vmsumshs",  VXA(4,  41), VXA_MASK,	PPCVEC,		{ VD, VA, VB, VC } },
 { "vmsumubm",  VXA(4,  36), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
 { "vmsumuhm",  VXA(4,  38), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
+{ "vmsumudm",  VXA(4,  35), VXA_MASK,   PPCVEC,         { VD, VA, VB, VC } },
 { "vmsumuhs",  VXA(4,  39), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
+{ "vmsumcud",  VXA(4,  23), VXA_MASK,   PPCVEC,         { VD, VA, VB, VC } },
 { "vmulesb",   VX(4,  776), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
 { "vmulesh",   VX(4,  840), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
 { "vmuleub",   VX(4,  520), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
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
index be53cd6f68..37ea343cb3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -926,7 +926,8 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
-void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void helper_vmladduhm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+                      ppc_avr_t *b, ppc_avr_t *c)
 {
     int i;
 
@@ -1064,6 +1065,52 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
+void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r,
+                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+{
+    Int128 sum;
+    uint64_t lo, hi;
+
+    sum = int128_make128(c->VsrD(1), c->VsrD(0));
+
+    mulu64(&lo, &hi, a->VsrD(0), b->VsrD(0));
+    sum = int128_add(sum, int128_make128(lo, hi));
+
+    mulu64(&lo, &hi, a->VsrD(1), b->VsrD(1));
+    sum = int128_add(sum, int128_make128(lo, hi));
+
+    r->VsrD(0) = int128_gethi(sum);
+    r->VsrD(1) = int128_getlo(sum);
+}
+
+void helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r,
+                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+{
+    Int128 sum;
+    uint64_t p1lo, p1hi, p2lo, p2hi;
+
+    mulu64(&p1lo, &p1hi, a->VsrD(0), b->VsrD(0));
+    mulu64(&p2lo, &p2hi, a->VsrD(1), b->VsrD(1));
+
+    /* Sum lowest 64-bit elements.  */
+    sum = int128_make128(c->VsrD(1), 0);
+    sum = int128_add(sum, int128_make128(p1lo, 0));
+    sum = int128_add(sum, int128_make128(p2lo, 0));
+
+    /*
+     * Discard low 64-bits, leaving the carry into bit 64.
+     * Then sum the higher 64-bit elements.
+     */
+    sum = int128_rshift(sum, 64);
+    sum = int128_add(sum, int128_make128(c->VsrD(0), 0));
+    sum = int128_add(sum, int128_make128(p1hi, 0));
+    sum = int128_add(sum, int128_make128(p2hi, 0));
+
+    /* The result is only the carry into bits 64 & 65. */
+    r->VsrD(1) = int128_gethi(sum);
+    r->VsrD(0) = 0;
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
index 403ed3a01c..520b49a773 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -1248,6 +1248,25 @@ static void gen_vsldoi(DisasContext *ctx)
     tcg_temp_free_i32(sh);
 }
 
+#define GEN_VAFORM(name, opc2)                                          \
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
-- 
2.23.0


