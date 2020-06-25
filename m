Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233B8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77E920707
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77E920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVKf-0001dH-Nz
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1joVEn-00013y-Rk; Thu, 25 Jun 2020 13:00:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1joVEl-0007Pk-R7; Thu, 25 Jun 2020 13:00:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PGYXRB077017; Thu, 25 Jun 2020 13:00:27 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vbmuaxqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 13:00:27 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PH03Mo001279;
 Thu, 25 Jun 2020 17:00:26 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 31uurw100c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 17:00:26 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PH0OhJ9109974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 17:00:24 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C837136051;
 Thu, 25 Jun 2020 17:00:25 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82190136055;
 Thu, 25 Jun 2020 17:00:24 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.117.167])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2020 17:00:24 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] target/ppc: add vmulh{su}w instructions
Date: Thu, 25 Jun 2020 12:00:15 -0500
Message-Id: <20200625170018.64265-6-ljp@linux.ibm.com>
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
 mlxscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 cotscore=-2147483648 mlxlogscore=700
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 13:00:27
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

vmulhsw: Vector Multiply High Signed Word
vmulhuw: Vector Multiply High Unsigned Word

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v3: inline the helper_vmulh{su}w multiply directly instead of using macro

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


