Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98371C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A593206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A593206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jypr1-0002fl-MF
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jypnP-0006Gb-Q8; Fri, 24 Jul 2020 00:59:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jypnL-0004fB-Fg; Fri, 24 Jul 2020 00:58:59 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06O4XVaD146180; Fri, 24 Jul 2020 00:58:50 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32facjnkbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 00:58:50 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O4sSuY025261;
 Fri, 24 Jul 2020 04:58:50 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02dal.us.ibm.com with ESMTP id 32brqa68wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 04:58:49 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06O4wnLJ37487006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2020 04:58:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C52828059;
 Fri, 24 Jul 2020 04:58:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BA4E28058;
 Fri, 24 Jul 2020 04:58:48 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.100.101])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2020 04:58:48 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 david@gibson.dropbear.id.au
Subject: [PATCH v5 5/6] target/ppc: add vdiv{su}{wd} vmod{su}{wd} instructions
Date: Thu, 23 Jul 2020 23:58:44 -0500
Message-Id: <20200724045845.89976-6-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200724045845.89976-1-ljp@linux.ibm.com>
References: <20200724045845.89976-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-23_20:2020-07-23,
 2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 phishscore=0 suspectscore=2 bulkscore=0 mlxlogscore=810
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:58:52
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vdivsw: Vector Divide Signed Word
vdivuw: Vector Divide Unsigned Word
vdivsd: Vector Divide Signed Doubleword
vdivud: Vector Divide Unsigned Doubleword
vmodsw: Vector Modulo Signed Word
vmoduw: Vector Modulo Unsigned Word
vmodsd: Vector Modulo Signed Doubleword
vmodud: Vector Modulo Unsigned Doubleword

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v5: no change
v4: add a comment on undefined result of divide operation.
    fix if(){} coding style issue, remove blank line.
v3: add missing divided-by-zero, divided-by-(-1) handling
v2: fix coding style
    use Power ISA 3.1 flag

 target/ppc/helper.h                 |  8 ++++++++
 target/ppc/int_helper.c             | 27 +++++++++++++++++++++++++++
 target/ppc/translate.c              |  3 +++
 target/ppc/translate/vmx-impl.inc.c | 15 +++++++++++++++
 target/ppc/translate/vmx-ops.inc.c  | 17 +++++++++++++++--
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 0036788919..70a14029ca 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -188,6 +188,14 @@ DEF_HELPER_3(vmulhsw, void, avr, avr, avr)
 DEF_HELPER_3(vmulhuw, void, avr, avr, avr)
 DEF_HELPER_3(vmulhsd, void, avr, avr, avr)
 DEF_HELPER_3(vmulhud, void, avr, avr, avr)
+DEF_HELPER_3(vdivsw, void, avr, avr, avr)
+DEF_HELPER_3(vdivuw, void, avr, avr, avr)
+DEF_HELPER_3(vdivsd, void, avr, avr, avr)
+DEF_HELPER_3(vdivud, void, avr, avr, avr)
+DEF_HELPER_3(vmodsw, void, avr, avr, avr)
+DEF_HELPER_3(vmoduw, void, avr, avr, avr)
+DEF_HELPER_3(vmodsd, void, avr, avr, avr)
+DEF_HELPER_3(vmodud, void, avr, avr, avr)
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 57d6767f60..62b93b4568 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1121,6 +1121,33 @@ void helper_vmulhud(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     mulu64(&discard, &r->u64[1], a->u64[1], b->u64[1]);
 }
 
+#define VDIV_MOD_DO(name, op, element, sign, bit)                       \
+    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
+    {                                                                   \
+        int i;                                                          \
+                                                                        \
+        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
+            if (unlikely((b->element[i] == 0) ||                        \
+                (sign &&                                                \
+                (b->element[i] == UINT##bit##_MAX) &&                   \
+                (a->element[i] == INT##bit##_MIN)))) {                  \
+                /* Undefined, No Special Registers Altered */           \
+                continue;                                               \
+            }                                                           \
+            r->element[i] = a->element[i] op b->element[i];             \
+        }                                                               \
+    }
+VDIV_MOD_DO(divsw, /, s32, 1, 32)
+VDIV_MOD_DO(divuw, /, u32, 0, 32)
+VDIV_MOD_DO(divsd, /, s64, 1, 64)
+VDIV_MOD_DO(divud, /, u64, 0, 64)
+VDIV_MOD_DO(modsw, %, s32, 1, 32)
+VDIV_MOD_DO(moduw, %, u32, 0, 32)
+VDIV_MOD_DO(modsd, %, s64, 1, 64)
+VDIV_MOD_DO(modud, %, u64, 0, 64)
+#undef VDIV_MOD_DO
+
+
 void helper_vperm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b,
                   ppc_avr_t *c)
 {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 590c3e3bc7..55f0e1a01d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -388,6 +388,9 @@ GEN_OPCODE3(name, opc1, opc2, opc3, opc4, inval, type, type2)
 #define GEN_HANDLER2_E_2(name, onam, opc1, opc2, opc3, opc4, inval, typ, typ2) \
 GEN_OPCODE4(name, onam, opc1, opc2, opc3, opc4, inval, typ, typ2)
 
+#define GEN_HANDLER_BOTH(name, opc1, opc2, opc3, inval0, inval1, type0, type1) \
+GEN_OPCODE_DUAL(name, opc1, opc2, opc3, inval0, inval1, type0, type1)
+
 typedef struct opcode_t {
     unsigned char opc1, opc2, opc3, opc4;
 #if HOST_LONG_BITS == 64 /* Explicitly align to 64 bits */
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 0910807232..ac5e820541 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -798,6 +798,9 @@ static void trans_vclzd(DisasContext *ctx)
     tcg_temp_free_i64(avr);
 }
 
+static void gen_vexptefp(DisasContext *ctx);
+static void gen_vlogefp(DisasContext *ctx);
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -822,6 +825,18 @@ GEN_VXFORM(vmulhsw, 4, 14);
 GEN_VXFORM_DUAL(vmulesw, PPC_ALTIVEC, PPC_NONE,
                 vmulhsw, PPC_NONE, PPC2_ISA310);
 GEN_VXFORM(vmulhsd, 4, 15);
+GEN_VXFORM(vdivuw, 5, 2);
+GEN_VXFORM(vdivud, 5, 3);
+GEN_VXFORM(vdivsw, 5, 6);
+GEN_VXFORM_DUAL_EXT(vexptefp, PPC_ALTIVEC, PPC_NONE, 0x001f0000,
+                    vdivsw, PPC_NONE, PPC2_ISA310, 0x00000000);
+GEN_VXFORM(vdivsd, 5, 7);
+GEN_VXFORM_DUAL_EXT(vlogefp, PPC_ALTIVEC, PPC_NONE, 0x001f0000,
+                    vdivsd, PPC_NONE, PPC2_ISA310, 0x00000000);
+GEN_VXFORM(vmoduw, 5, 26);
+GEN_VXFORM(vmodud, 5, 27);
+GEN_VXFORM(vmodsw, 5, 30);
+GEN_VXFORM(vmodsd, 5, 31);
 GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
 GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
 GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index f3f4855111..528458cb25 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -54,6 +54,11 @@ GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ISA310)
 #define GEN_VXFORM_DUAL(name0, name1, opc2, opc3, type0, type1) \
 GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, type0, type1)
 
+#define GEN_VXFORM_DUAL_BOTH(name0, name1, opc2, opc3, inval0, \
+                             inval1, type0, type1)             \
+GEN_HANDLER_BOTH(name0##_##name1, 0x4, opc2, opc3, inval0,     \
+                 inval1, type0, type1)
+
 #define GEN_VXRFORM_DUAL(name0, name1, opc2, opc3, tp0, tp1) \
 GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, tp0, tp1), \
 GEN_HANDLER_E(name0##_##name1, 0x4, opc2, (opc3 | 0x10), 0x00000000, tp0, tp1),
@@ -116,6 +121,16 @@ GEN_VXFORM(vmulesb, 4, 12),
 GEN_VXFORM(vmulesh, 4, 13),
 GEN_VXFORM_DUAL(vmulesw, vmulhsw, 4, 14, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_310(vmulhsd, 4, 15),
+GEN_VXFORM_310(vdivuw, 5, 2),
+GEN_VXFORM_310(vdivud, 5, 3),
+GEN_VXFORM_DUAL_BOTH(vexptefp, vdivsw, 5, 6, 0x001f0000, 0x00000000,
+                     PPC_ALTIVEC, PPC2_ISA310),
+GEN_VXFORM_DUAL_BOTH(vlogefp, vdivsd, 5, 7, 0x001f0000, 0x00000000,
+                     PPC_ALTIVEC, PPC2_ISA310),
+GEN_VXFORM_310(vmoduw, 5, 26),
+GEN_VXFORM_310(vmodud, 5, 27),
+GEN_VXFORM_310(vmodsw, 5, 30),
+GEN_VXFORM_310(vmodsd, 5, 31),
 GEN_VXFORM(vslb, 2, 4),
 GEN_VXFORM(vslh, 2, 5),
 GEN_VXFORM_DUAL(vslw, vrlwnm, 2, 6, PPC_ALTIVEC, PPC_NONE),
@@ -259,8 +274,6 @@ GEN_VXFORM_NOA(vupkhpx, 7, 13),
 GEN_VXFORM_NOA(vupklpx, 7, 15),
 GEN_VXFORM_NOA(vrefp, 5, 4),
 GEN_VXFORM_NOA(vrsqrtefp, 5, 5),
-GEN_VXFORM_NOA(vexptefp, 5, 6),
-GEN_VXFORM_NOA(vlogefp, 5, 7),
 GEN_VXFORM_NOA(vrfim, 5, 11),
 GEN_VXFORM_NOA(vrfin, 5, 8),
 GEN_VXFORM_NOA(vrfip, 5, 10),
-- 
2.23.0


