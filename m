Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76556C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D68A2082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D68A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqmSw-0006IU-HL
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 19:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jqmOj-0000HI-F2; Wed, 01 Jul 2020 19:44:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jqmOd-0002IJ-Gi; Wed, 01 Jul 2020 19:44:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 061NZKxS061490; Wed, 1 Jul 2020 19:43:55 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 320yr4y0rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2020 19:43:55 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061Nf10b018410;
 Wed, 1 Jul 2020 23:43:54 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02wdc.us.ibm.com with ESMTP id 31wwr93yut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2020 23:43:54 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 061NhpH629884752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2020 23:43:52 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51B616E04E;
 Wed,  1 Jul 2020 23:43:53 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A5626E04C;
 Wed,  1 Jul 2020 23:43:52 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.126.23])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2020 23:43:52 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 07/11] target/ppc: add vmulld to INDEX_op_mul_vec case
Date: Wed,  1 Jul 2020 18:43:42 -0500
Message-Id: <20200701234344.91843-8-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200701234344.91843-1-ljp@linux.ibm.com>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-01_15:2020-07-01,
 2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 cotscore=-2147483648 clxscore=1015 spamscore=0 suspectscore=0 adultscore=1
 phishscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010162
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 19:43:54
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

Group vmuluwm and vmulld. Make vmulld-specific
changes since it belongs to new ISA 3.1.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v4: add missing changes, and split to 5/11, 6/11, 7/11
v3: use tcg_gen_gvec_mul()
v2: fix coding style
    use Power ISA 3.1 flag

 tcg/ppc/tcg-target.h     |  2 ++
 tcg/ppc/tcg-target.inc.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

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
index ee1f9227c1..caa8985b46 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -564,6 +564,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VMULOUH    VX4(72)
 #define VMULOUW    VX4(136)       /* v2.07 */
 #define VMULUWM    VX4(137)       /* v2.07 */
+#define VMULLD     VX4(457)       /* v3.10 */
 #define VMSUMUHM   VX4(38)
 
 #define VMRGHB     VX4(12)
@@ -3015,6 +3016,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
             return -1;
         case MO_32:
             return have_isa_2_07 ? 1 : -1;
+        case MO_64:
+            return have_isa_3_10;
         }
         return 0;
     case INDEX_op_bitsel_vec:
@@ -3149,6 +3152,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const uint32_t
         add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
         sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        mul_op[4] = { 0, 0, VMULUWM, VMULLD },
         neg_op[4] = { 0, 0, VNEGW, VNEGD },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
         ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
@@ -3199,8 +3203,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         a1 = 0;
         break;
     case INDEX_op_mul_vec:
-        tcg_debug_assert(vece == MO_32 && have_isa_2_07);
-        insn = VMULUWM;
+        insn = mul_op[vece];
         break;
     case INDEX_op_ssadd_vec:
         insn = ssadd_op[vece];
@@ -3709,6 +3712,11 @@ static void tcg_target_init(TCGContext *s)
         have_isa = tcg_isa_3_00;
     }
 #endif
+#ifdef PPC_FEATURE2_ARCH_3_10
+    if (hwcap2 & PPC_FEATURE2_ARCH_3_10) {
+        have_isa = tcg_isa_3_10;
+    }
+#endif
 
 #ifdef PPC_FEATURE2_HAS_ISEL
     /* Prefer explicit instruction from the kernel. */
-- 
2.23.0


