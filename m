Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0974CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 03:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAC020663
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 03:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAC020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjxIe-0006zR-4c
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 23:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxHs-0006T5-DW; Fri, 12 Jun 2020 23:56:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxHq-0004KO-3G; Fri, 12 Jun 2020 23:56:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05D3FqR7020413; Fri, 12 Jun 2020 23:56:49 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31mh8a0rj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2020 23:56:49 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05D3iauI031777;
 Sat, 13 Jun 2020 03:56:49 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 31mpe80eqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 03:56:49 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05D3tkwe22086020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2020 03:55:46 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71813BE053;
 Sat, 13 Jun 2020 03:55:47 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1146BE04F;
 Sat, 13 Jun 2020 03:55:46 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.217.131])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2020 03:55:46 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2] target/ppc: add vmsumudm vmsumcud instructions
Date: Fri, 12 Jun 2020 22:55:46 -0500
Message-Id: <20200613035546.22041-1-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-12_17:2020-06-12,
 2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 suspectscore=2 mlxlogscore=896 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006130016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 23:56:50
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
v2: move vmsumcudm() to qemu/int128.h as Richard Henderson suggested,
    also rename addu128() to uint128_add() and include it in qemu/int128.h

 disas/ppc.c                         |  2 +
 include/qemu/int128.h               | 97 +++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  4 +-
 target/ppc/int_helper.c             | 19 +++++-
 target/ppc/translate.c              |  1 -
 target/ppc/translate/vmx-impl.inc.c | 39 ++++++------
 target/ppc/translate/vmx-ops.inc.c  |  2 +
 7 files changed, 143 insertions(+), 21 deletions(-)

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
diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 5c9890db8b..3362973cc5 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -3,6 +3,7 @@
 
 #ifdef CONFIG_INT128
 #include "qemu/bswap.h"
+#include "qemu/host-utils.h"
 
 typedef __int128_t Int128;
 
@@ -143,6 +144,55 @@ static inline Int128 bswap128(Int128 a)
     return int128_make128(bswap64(int128_gethi(a)), bswap64(int128_getlo(a)));
 }
 
+/**
+ * uint128_add - add two 128-bit values (r=a+b, ca=carry-out)
+ * @ah: high 64 bits of a
+ * @al: low 64 bits of a
+ * @bh: high 64 bits of b
+ * @bl: low 64 bits of b
+ * @rh: high 64 bits of r to be returned
+ * @rl: low 64 bits of r to be returned
+ * @ca: carry out to be returned.
+ */
+static inline void uint128_add(uint64_t ah, uint64_t al, uint64_t bh,
+		uint64_t bl, uint64_t *rh, uint64_t *rl, uint64_t *ca)
+{
+	__uint128_t a = (__uint128_t)ah << 64 | (__uint128_t)al;
+	__uint128_t b = (__uint128_t)bh << 64 | (__uint128_t)bl;
+	__uint128_t r = a + b;
+
+	*rh = (uint64_t)(r >> 64);
+	*rl = (uint64_t)r;
+	*ca = (~a < b);
+}
+
+/**
+ * mulsum - (rh, rl) = ah*bh + al*bl + (ch, cl)
+ * @ah: high 64 bits of a
+ * @al: low 64 bits of a
+ * @bh: high 64 bits of b
+ * @bl: low 64 bits of b
+ * @ch: high 64 bits of c
+ * @cl: low 64 bits of c
+ * @rh: high 64 bits of r to be returned
+ * @rl: low 64 bits of r to be returned
+ * @ca: carry-out to be returned.
+ */
+static inline void mulsum(uint64_t ah, uint64_t al, uint64_t bh,
+		uint64_t bl, uint64_t ch, uint64_t cl, uint64_t *rh,
+		uint64_t *rl, uint64_t *ca)
+{
+	__uint128_t prod1, prod2, r;
+	__uint128_t c = (__uint128_t)ch << 64 | (__uint128_t)cl;
+
+	prod1 = (__uint128_t)ah * (__uint128_t)bh;
+	prod2 = (__uint128_t)al * (__uint128_t)bl;
+	r = prod1 + prod2 + c;
+	*rh = (uint64_t)(r >> 64);
+	*rl = (uint64_t)r;
+	*ca = (~prod1 < prod2) + (~c < (prod1 + prod2));
+}
+
 #else /* !CONFIG_INT128 */
 
 typedef struct Int128 Int128;
@@ -301,5 +351,52 @@ static inline void int128_subfrom(Int128 *a, Int128 b)
     *a = int128_sub(*a, b);
 }
 
+/**
+ * uint128_add - add two 128-bit values (r=a+b, ca=carry-out)
+ * @ah: high 64 bits of a
+ * @al: low 64 bits of a
+ * @bh: high 64 bits of b
+ * @bl: low 64 bits of b
+ * @rh: high 64 bits of r to be returned
+ * @rl: low 64 bits of r to be returned
+ * @ca: carry out to be returned.
+ */
+static inline void uint128_add(uint64_t ah, uint64_t al, uint64_t bh,
+		uint64_t bl, uint64_t *rh, uint64_t *rl, uint64_t *ca)
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
+
+/**
+ * mulsum - (rh, rl) = ah*bh + al*bl + (ch, cl)
+ * @ah: high 64 bits of a
+ * @al: low 64 bits of a
+ * @bh: high 64 bits of b
+ * @bl: low 64 bits of b
+ * @ch: high 64 bits of c
+ * @cl: low 64 bits of c
+ * @rh: high 64 bits of r to be returned
+ * @rl: low 64 bits of r to be returned
+ * @ca: carry-out to be returned.
+ */
+static inline void mulsum(uint64_t ah, uint64_t al, uint64_t bh,
+		uint64_t bl, uint64_t ch, uint64_t cl, uint64_t *rh,
+		uint64_t *rl, uint64_t *ca)
+{
+	uint64_t p1h, p1l, p2h, p2l, sh, sl, ca1, ca2;
+	mulu64(&p1l, &p1h ,ah, bh);
+	mulu64(&p2l, &p2h ,al, bl);
+	uint128_add(p1h, p1l, p2h, p2l, &sh, &sl, &ca1);
+	uint128_add(sh, sl, ch, cl, rh, rl, &ca2);
+	*ca = ca1 + ca2;
+}
+
 #endif /* CONFIG_INT128 */
 #endif /* INT128_H */
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
index be53cd6f68..5f257b7b86 100644
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
 
@@ -1064,6 +1065,22 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
+void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+			ppc_avr_t *b, ppc_avr_t *c)
+{
+	uint64_t ca;
+	mulsum(a->VsrD(0), a->VsrD(1), b->VsrD(0), b->VsrD(1), c->VsrD(0), c->VsrD(1),
+		&r->VsrD(0), &r->VsrD(1), &ca);
+}
+void helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+			ppc_avr_t *b, ppc_avr_t *c)
+{
+	uint64_t rh, rl;
+	mulsum(a->VsrD(0), a->VsrD(1), b->VsrD(0), b->VsrD(1), c->VsrD(0), c->VsrD(1),
+		&rh, &rl, &r->VsrD(1));
+	r->VsrD(0) = 0;
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
-- 
2.23.0


