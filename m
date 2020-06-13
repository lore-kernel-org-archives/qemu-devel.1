Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 04:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27492071A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 04:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27492071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjxgp-0003j5-0q
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 00:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxfo-0001ip-Hx; Sat, 13 Jun 2020 00:21:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42110
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxfm-0007xj-CB; Sat, 13 Jun 2020 00:21:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05D42vpZ026992; Sat, 13 Jun 2020 00:21:37 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31mp6f1jd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 00:21:37 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05D4KawA011683;
 Sat, 13 Jun 2020 04:21:36 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 31mpe80pcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 04:21:36 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05D4KYle61932028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2020 04:20:34 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC87ABE04F;
 Sat, 13 Jun 2020 04:20:34 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 337A7BE05A;
 Sat, 13 Jun 2020 04:20:34 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.217.131])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2020 04:20:34 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/ppc: add vdiv{su}{wd} vmod{su}{wd} instructions
Date: Fri, 12 Jun 2020 23:20:29 -0500
Message-Id: <20200613042029.22321-7-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200613042029.22321-1-ljp@linux.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-13_01:2020-06-12,
 2020-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 cotscore=-2147483648 clxscore=1015 malwarescore=0 phishscore=0
 mlxlogscore=897 suspectscore=2 impostorscore=0 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006130032
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 00:20:34
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
 target/ppc/helper.h                 |  8 ++++++++
 target/ppc/int_helper.c             | 19 +++++++++++++++++++
 target/ppc/translate.c              |  3 +++
 target/ppc/translate/vmx-impl.inc.c | 15 +++++++++++++++
 target/ppc/translate/vmx-ops.inc.c  | 15 +++++++++++++--
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 1aed2087cf..823999a8c2 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -190,6 +190,14 @@ DEF_HELPER_3(vmulhsw, void, avr, avr, avr)
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
index 6c401d41f6..585533ad53 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -575,6 +575,25 @@ VARITH_DO(mulld, *, s64)
 #undef VARITH_DO
 #undef VARITH
 
+#define VDIV_MOD_DO(name, op, element)                                  \
+    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
+    {                                                                   \
+        int i;                                                          \
+                                                                        \
+        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
+            r->element[i] = a->element[i] op b->element[i];             \
+        }                                                               \
+    }
+VDIV_MOD_DO(divsw, /, s32)
+VDIV_MOD_DO(divuw, /, u32)
+VDIV_MOD_DO(divsd, /, s64)
+VDIV_MOD_DO(divud, /, u64)
+VDIV_MOD_DO(modsw, %, s32)
+VDIV_MOD_DO(moduw, %, u32)
+VDIV_MOD_DO(modsd, %, s64)
+VDIV_MOD_DO(modud, %, u64)
+#undef VDIV_MOD_DO
+
 #define VARITHFP(suffix, func)                                          \
     void helper_v##suffix(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, \
                           ppc_avr_t *b)                                 \
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2d48fbc8db..59183b5c7b 100644
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
index a9e7e7c3fe..97ee7cf5eb 100644
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
 		vmulhsw, PPC_NONE, PPC2_ISA300);
 GEN_VXFORM(vmulhsd, 4, 15);
+GEN_VXFORM(vdivuw, 5, 2);
+GEN_VXFORM(vdivud, 5, 3);
+GEN_VXFORM(vdivsw, 5, 6);
+GEN_VXFORM_DUAL_EXT(vexptefp, PPC_ALTIVEC, PPC_NONE, 0x001f0000,
+		vdivsw, PPC_NONE, PPC2_ISA300, 0x00000000);
+GEN_VXFORM(vdivsd, 5, 7);
+GEN_VXFORM_DUAL_EXT(vlogefp, PPC_ALTIVEC, PPC_NONE, 0x001f0000,
+		vdivsd, PPC_NONE, PPC2_ISA300, 0x00000000);
+GEN_VXFORM(vmoduw, 5, 26);
+GEN_VXFORM(vmodud, 5, 27);
+GEN_VXFORM(vmodsw, 5, 30);
+GEN_VXFORM(vmodsd, 5, 31);
 GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
 GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
 GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 719fecbaa3..3425c5156c 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -51,6 +51,9 @@ GEN_HANDLER_E_2(name, 0x04, opc2, opc3, opc4, 0x00000000, PPC_NONE,     \
 #define GEN_VXFORM_DUAL(name0, name1, opc2, opc3, type0, type1) \
 GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, type0, type1)
 
+#define GEN_VXFORM_DUAL_BOTH(name0, name1, opc2, opc3, inval0, inval1, type0, type1) \
+GEN_HANDLER_BOTH(name0##_##name1, 0x4, opc2, opc3, inval0, inval1, type0, type1)
+
 #define GEN_VXRFORM_DUAL(name0, name1, opc2, opc3, tp0, tp1) \
 GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, tp0, tp1), \
 GEN_HANDLER_E(name0##_##name1, 0x4, opc2, (opc3 | 0x10), 0x00000000, tp0, tp1),
@@ -113,6 +116,16 @@ GEN_VXFORM(vmulesb, 4, 12),
 GEN_VXFORM(vmulesh, 4, 13),
 GEN_VXFORM_DUAL(vmulesw, vmulhsw, 4, 14, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_300(vmulhsd, 4, 15),
+GEN_VXFORM_300(vdivuw, 5, 2),
+GEN_VXFORM_300(vdivud, 5, 3),
+GEN_VXFORM_DUAL_BOTH(vexptefp, vdivsw, 5, 6, 0x001f0000, 0x00000000,
+			PPC_ALTIVEC, PPC2_ISA300),
+GEN_VXFORM_DUAL_BOTH(vlogefp, vdivsd, 5, 7, 0x001f0000, 0x00000000,
+			PPC_ALTIVEC, PPC2_ISA300),
+GEN_VXFORM_300(vmoduw, 5, 26),
+GEN_VXFORM_300(vmodud, 5, 27),
+GEN_VXFORM_300(vmodsw, 5, 30),
+GEN_VXFORM_300(vmodsd, 5, 31),
 GEN_VXFORM(vslb, 2, 4),
 GEN_VXFORM(vslh, 2, 5),
 GEN_VXFORM_DUAL(vslw, vrlwnm, 2, 6, PPC_ALTIVEC, PPC_NONE),
@@ -256,8 +269,6 @@ GEN_VXFORM_NOA(vupkhpx, 7, 13),
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


