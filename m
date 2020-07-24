Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD482206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD482206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jypsE-0004Wn-0r
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jypnP-0006GY-Fx; Fri, 24 Jul 2020 00:59:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jypnK-0004ex-UY; Fri, 24 Jul 2020 00:58:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06O4WbDe160447; Fri, 24 Jul 2020 00:58:49 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9bpdrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 00:58:49 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O4sb6b025326;
 Fri, 24 Jul 2020 04:58:48 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02dal.us.ibm.com with ESMTP id 32brqa68w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 04:58:48 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06O4wlxK41025880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2020 04:58:47 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D63C928059;
 Fri, 24 Jul 2020 04:58:47 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FB902805C;
 Fri, 24 Jul 2020 04:58:47 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.100.101])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2020 04:58:47 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 david@gibson.dropbear.id.au
Subject: [PATCH v5 3/6] target/ppc: add vmulh{su}w instructions
Date: Thu, 23 Jul 2020 23:58:42 -0500
Message-Id: <20200724045845.89976-4-ljp@linux.ibm.com>
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
 bulkscore=0 mlxscore=0
 mlxlogscore=958 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240032
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ljp@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:58:52
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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

vmulhsw: Vector Multiply High Signed Word
vmulhuw: Vector Multiply High Unsigned Word

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v4/v5: no change
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
v3: inline the helper_vmulh{su}w multiply directly instead of using macro
v2: fix coding style
    use Power ISA 3.1 flag

 target/ppc/helper.h                 |  2 ++
 target/ppc/int_helper.c             | 19 +++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  6 ++++++
 target/ppc/translate/vmx-ops.inc.c  |  4 ++--
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 69416b6d7c..3b3013866a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -184,6 +184,8 @@ DEF_HELPER_3(vmulosw, void, avr, avr, avr)
 DEF_HELPER_3(vmuloub, void, avr, avr, avr)
 DEF_HELPER_3(vmulouh, void, avr, avr, avr)
 DEF_HELPER_3(vmulouw, void, avr, avr, avr)
+DEF_HELPER_3(vmulhsw, void, avr, avr, avr)
+DEF_HELPER_3(vmulhuw, void, avr, avr, avr)
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index bd3e6d7cc7..a3a20821fc 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1086,6 +1086,25 @@ VMUL(uw, u32, VsrW, VsrD, uint64_t)
 #undef VMUL_DO_ODD
 #undef VMUL
 
+void helper_vmulhsw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        r->s32[i] = (int32_t)(((int64_t)a->s32[i] * (int64_t)b->s32[i]) >> 32);
+    }
+}
+
+void helper_vmulhuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        r->u32[i] = (uint32_t)(((uint64_t)a->u32[i] *
+                               (uint64_t)b->u32[i]) >> 32);
+    }
+}
+
 void helper_vperm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b,
                   ppc_avr_t *c)
 {
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 8c89738552..50bac375fc 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -811,9 +811,15 @@ GEN_VXFORM_V(vmulld, MO_64, tcg_gen_gvec_mul, 4, 7);
 GEN_VXFORM(vmuleub, 4, 8);
 GEN_VXFORM(vmuleuh, 4, 9);
 GEN_VXFORM(vmuleuw, 4, 10);
+GEN_VXFORM(vmulhuw, 4, 10);
+GEN_VXFORM_DUAL(vmuleuw, PPC_ALTIVEC, PPC_NONE,
+                vmulhuw, PPC_NONE, PPC2_ISA310);
 GEN_VXFORM(vmulesb, 4, 12);
 GEN_VXFORM(vmulesh, 4, 13);
 GEN_VXFORM(vmulesw, 4, 14);
+GEN_VXFORM(vmulhsw, 4, 14);
+GEN_VXFORM_DUAL(vmulesw, PPC_ALTIVEC, PPC_NONE,
+                vmulhsw, PPC_NONE, PPC2_ISA310);
 GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
 GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
 GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index b49787ac97..29701ad778 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -110,10 +110,10 @@ GEN_VXFORM_207(vmulosw, 4, 6),
 GEN_VXFORM_310(vmulld, 4, 7),
 GEN_VXFORM(vmuleub, 4, 8),
 GEN_VXFORM(vmuleuh, 4, 9),
-GEN_VXFORM_207(vmuleuw, 4, 10),
+GEN_VXFORM_DUAL(vmuleuw, vmulhuw, 4, 10, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vmulesb, 4, 12),
 GEN_VXFORM(vmulesh, 4, 13),
-GEN_VXFORM_207(vmulesw, 4, 14),
+GEN_VXFORM_DUAL(vmulesw, vmulhsw, 4, 14, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vslb, 2, 4),
 GEN_VXFORM(vslh, 2, 5),
 GEN_VXFORM_DUAL(vslw, vrlwnm, 2, 6, PPC_ALTIVEC, PPC_NONE),
-- 
2.23.0


