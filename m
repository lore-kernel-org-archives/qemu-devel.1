Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E15FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 00:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4728121582
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 00:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4728121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jliCp-0001YF-GV
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 20:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jliAD-0005tn-BU; Wed, 17 Jun 2020 20:12:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20260
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jliAB-0006tL-Kt; Wed, 17 Jun 2020 20:12:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05I05JBL186733; Wed, 17 Jun 2020 20:12:14 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31q6j5p3gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 20:12:12 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I05o7h022800;
 Thu, 18 Jun 2020 00:11:34 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma05wdc.us.ibm.com with ESMTP id 31qu27gw1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 00:11:34 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05I0BVOw20447538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2020 00:11:31 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FB6F6A061;
 Thu, 18 Jun 2020 00:11:32 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C8B46A051;
 Thu, 18 Jun 2020 00:11:31 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.216.12])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2020 00:11:31 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] target/ppc: add vmulh{su}w instructions
Date: Wed, 17 Jun 2020 19:11:24 -0500
Message-Id: <20200618001127.34438-5-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200618001127.34438-1-ljp@linux.ibm.com>
References: <20200618001127.34438-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-17_12:2020-06-17,
 2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=900 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 cotscore=-2147483648 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170180
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 19:56:49
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

vmulhsw: Vector Multiply High Signed Word
vmulhuw: Vector Multiply High Unsigned Word

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v2: fix coding style
    use Power ISA 3.1 flag

 target/ppc/helper.h                 |  2 ++
 target/ppc/int_helper.c             | 14 ++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  6 ++++++
 target/ppc/translate/vmx-ops.inc.c  |  4 ++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index c3f087ccb3..6d4a3536eb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -186,6 +186,8 @@ DEF_HELPER_3(vmulouh, void, avr, avr, avr)
 DEF_HELPER_3(vmulouw, void, avr, avr, avr)
 DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
 DEF_HELPER_3(vmulld, void, avr, avr, avr)
+DEF_HELPER_3(vmulhsw, void, avr, avr, avr)
+DEF_HELPER_3(vmulhuw, void, avr, avr, avr)
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index afbcdd05b4..7a3219887d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -523,6 +523,20 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
     r->VsrD(0) = 0;
 }
 
+#define VMULH_DO(name, op, element, cast_orig, cast_temp)               \
+    void helper_vmulh##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
+    {                                                                   \
+        int i;                                                          \
+                                                                        \
+        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
+            r->element[i] = (cast_orig)(((cast_temp)a->element[i] op    \
+                            (cast_temp)b->element[i]) >> 32);           \
+        }                                                               \
+    }
+VMULH_DO(sw, *, s32, int32_t, int64_t)
+VMULH_DO(uw, *, u32, uint32_t, uint64_t)
+#undef VMULH_DO
+
 #define VARITH_DO(name, op, element)                                    \
     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
     {                                                                   \
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 4ee1df48f2..03b5712d01 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -811,9 +811,15 @@ GEN_VXFORM(vmulld,  4, 7);
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


