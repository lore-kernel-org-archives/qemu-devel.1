Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B5AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6E3206B7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6E3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqmXN-0004Sm-2u
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 19:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jqmRr-0005Kp-Lx; Wed, 01 Jul 2020 19:47:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jqmRp-00061n-Dv; Wed, 01 Jul 2020 19:47:27 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 061NVqpV107286; Wed, 1 Jul 2020 19:47:19 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 320sk03e3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2020 19:47:19 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061NdxPX029615;
 Wed, 1 Jul 2020 23:47:18 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 31wwr9d1mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2020 23:47:18 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 061NlF1I22872550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2020 23:47:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F7F86E052;
 Wed,  1 Jul 2020 23:47:17 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 701326E04E;
 Wed,  1 Jul 2020 23:47:16 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.126.23])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2020 23:47:16 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 10/11] target/ppc: add vmulh{su}d instructions
Date: Wed,  1 Jul 2020 18:47:14 -0500
Message-Id: <20200701234715.91893-1-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-01_15:2020-07-01,
 2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 clxscore=1015 impostorscore=0 mlxlogscore=870 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010161
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

vmulhsd: Vector Multiply High Signed Doubleword
vmulhud: Vector Multiply High Unsigned Doubleword

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
v3: simplify helper_vmulh{su}d 
v2: fix coding style
    use Power ISA 3.1 flag

 target/ppc/helper.h                 |  2 ++
 target/ppc/int_helper.c             | 16 ++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  2 ++
 target/ppc/translate/vmx-ops.inc.c  |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3b3013866a..0036788919 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -186,6 +186,8 @@ DEF_HELPER_3(vmulouh, void, avr, avr, avr)
 DEF_HELPER_3(vmulouw, void, avr, avr, avr)
 DEF_HELPER_3(vmulhsw, void, avr, avr, avr)
 DEF_HELPER_3(vmulhuw, void, avr, avr, avr)
+DEF_HELPER_3(vmulhsd, void, avr, avr, avr)
+DEF_HELPER_3(vmulhud, void, avr, avr, avr)
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index a3a20821fc..57d6767f60 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1105,6 +1105,22 @@ void helper_vmulhuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
+void helper_vmulhsd(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    uint64_t discard;
+
+    muls64(&discard, &r->u64[0], a->s64[0], b->s64[0]);
+    muls64(&discard, &r->u64[1], a->s64[1], b->s64[1]);
+}
+
+void helper_vmulhud(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    uint64_t discard;
+
+    mulu64(&discard, &r->u64[0], a->u64[0], b->u64[0]);
+    mulu64(&discard, &r->u64[1], a->u64[1], b->u64[1]);
+}
+
 void helper_vperm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b,
                   ppc_avr_t *c)
 {
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 50bac375fc..0910807232 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -812,6 +812,7 @@ GEN_VXFORM(vmuleub, 4, 8);
 GEN_VXFORM(vmuleuh, 4, 9);
 GEN_VXFORM(vmuleuw, 4, 10);
 GEN_VXFORM(vmulhuw, 4, 10);
+GEN_VXFORM(vmulhud, 4, 11);
 GEN_VXFORM_DUAL(vmuleuw, PPC_ALTIVEC, PPC_NONE,
                 vmulhuw, PPC_NONE, PPC2_ISA310);
 GEN_VXFORM(vmulesb, 4, 12);
@@ -820,6 +821,7 @@ GEN_VXFORM(vmulesw, 4, 14);
 GEN_VXFORM(vmulhsw, 4, 14);
 GEN_VXFORM_DUAL(vmulesw, PPC_ALTIVEC, PPC_NONE,
                 vmulhsw, PPC_NONE, PPC2_ISA310);
+GEN_VXFORM(vmulhsd, 4, 15);
 GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
 GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
 GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 29701ad778..f3f4855111 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -111,9 +111,11 @@ GEN_VXFORM_310(vmulld, 4, 7),
 GEN_VXFORM(vmuleub, 4, 8),
 GEN_VXFORM(vmuleuh, 4, 9),
 GEN_VXFORM_DUAL(vmuleuw, vmulhuw, 4, 10, PPC_ALTIVEC, PPC_NONE),
+GEN_VXFORM_310(vmulhud, 4, 11),
 GEN_VXFORM(vmulesb, 4, 12),
 GEN_VXFORM(vmulesh, 4, 13),
 GEN_VXFORM_DUAL(vmulesw, vmulhsw, 4, 14, PPC_ALTIVEC, PPC_NONE),
+GEN_VXFORM_310(vmulhsd, 4, 15),
 GEN_VXFORM(vslb, 2, 4),
 GEN_VXFORM(vslh, 2, 5),
 GEN_VXFORM_DUAL(vslw, vrlwnm, 2, 6, PPC_ALTIVEC, PPC_NONE),
-- 
2.23.0


