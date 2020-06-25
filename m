Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1095E206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1095E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVGU-0003Eg-72
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1joVEl-00011D-V3; Thu, 25 Jun 2020 13:00:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1460
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1joVEk-0007Ol-6G; Thu, 25 Jun 2020 13:00:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PGVZUX143331; Thu, 25 Jun 2020 13:00:26 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31ux00gdvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 13:00:25 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PH0A9m009650;
 Thu, 25 Jun 2020 17:00:25 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma05wdc.us.ibm.com with ESMTP id 31uus1dkqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 17:00:25 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PH0ORf38273290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 17:00:24 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FAED136063;
 Thu, 25 Jun 2020 17:00:24 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AD8B136055;
 Thu, 25 Jun 2020 17:00:23 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.117.167])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2020 17:00:23 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] target/ppc: add vmulld instruction
Date: Thu, 25 Jun 2020 12:00:14 -0500
Message-Id: <20200625170018.64265-5-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200625170018.64265-1-ljp@linux.ibm.com>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_11:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 cotscore=-2147483648 mlxlogscore=960
 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 13:00:26
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
Cc: Lijun Pan <ljp@linux.ibm.com>, richard.henderson@linaro.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vmulld: Vector Multiply Low Doubleword.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v3: use tcg_gen_gvec_mul()

 target/ppc/translate/vmx-impl.inc.c | 1 +
 target/ppc/translate/vmx-ops.inc.c  | 4 ++++
 tcg/ppc/tcg-target.h                | 2 ++
 tcg/ppc/tcg-target.inc.c            | 7 +++++--
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 6e79ffa650..8c89738552 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -807,6 +807,7 @@ GEN_VXFORM_DUAL(vmulouw, PPC_ALTIVEC, PPC_NONE,
 GEN_VXFORM(vmulosb, 4, 4);
 GEN_VXFORM(vmulosh, 4, 5);
 GEN_VXFORM(vmulosw, 4, 6);
+GEN_VXFORM_V(vmulld, MO_64, tcg_gen_gvec_mul, 4, 7);
 GEN_VXFORM(vmuleub, 4, 8);
 GEN_VXFORM(vmuleuh, 4, 9);
 GEN_VXFORM(vmuleuw, 4, 10);
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 84e05fb827..b49787ac97 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -48,6 +48,9 @@ GEN_HANDLER_E(name, 0x04, opc2, opc3, inval, PPC_NONE, PPC2_ISA300)
 GEN_HANDLER_E_2(name, 0x04, opc2, opc3, opc4, 0x00000000, PPC_NONE,     \
                                                        PPC2_ISA300)
 
+#define GEN_VXFORM_310(name, opc2, opc3)                                \
+GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ISA310)
+
 #define GEN_VXFORM_DUAL(name0, name1, opc2, opc3, type0, type1) \
 GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, type0, type1)
 
@@ -104,6 +107,7 @@ GEN_VXFORM_DUAL(vmulouw, vmuluwm, 4, 2, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vmulosb, 4, 4),
 GEN_VXFORM(vmulosh, 4, 5),
 GEN_VXFORM_207(vmulosw, 4, 6),
+GEN_VXFORM_310(vmulld, 4, 7),
 GEN_VXFORM(vmuleub, 4, 8),
 GEN_VXFORM(vmuleuh, 4, 9),
 GEN_VXFORM_207(vmuleuw, 4, 10),
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 4fa21f0e71..ff1249ef8e 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -63,6 +63,7 @@ typedef enum {
     tcg_isa_2_06,
     tcg_isa_2_07,
     tcg_isa_3_00,
+    tcg_isa_3_10,
 } TCGPowerISA;
 
 extern TCGPowerISA have_isa;
@@ -72,6 +73,7 @@ extern bool have_vsx;
 #define have_isa_2_06  (have_isa >= tcg_isa_2_06)
 #define have_isa_2_07  (have_isa >= tcg_isa_2_07)
 #define have_isa_3_00  (have_isa >= tcg_isa_3_00)
+#define have_isa_3_10  (have_isa >= tcg_isa_3_10)
 
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index ee1f9227c1..de0feaf7a8 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -564,6 +564,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VMULOUH    VX4(72)
 #define VMULOUW    VX4(136)       /* v2.07 */
 #define VMULUWM    VX4(137)       /* v2.07 */
+#define VMULLD     VX4(457)       /* v3.10 */
 #define VMSUMUHM   VX4(38)
 
 #define VMRGHB     VX4(12)
@@ -3149,6 +3150,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const uint32_t
         add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
         sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        mul_op[4] = { 0, 0, VMULUWM, VMULLD },
         neg_op[4] = { 0, 0, VNEGW, VNEGD },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
         ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
@@ -3199,8 +3201,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         a1 = 0;
         break;
     case INDEX_op_mul_vec:
-        tcg_debug_assert(vece == MO_32 && have_isa_2_07);
-        insn = VMULUWM;
+        tcg_debug_assert((vece == MO_32 && have_isa_2_07) ||
+                         (vece == MO_64 && have_isa_3_10));
+        insn = mul_op[vece];
         break;
     case INDEX_op_ssadd_vec:
         insn = ssadd_op[vece];
-- 
2.23.0


