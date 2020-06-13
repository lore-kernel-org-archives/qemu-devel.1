Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79385C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 04:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD2F2071A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 04:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD2F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjxhQ-0004wk-IM
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 00:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxeq-0008M9-7r; Sat, 13 Jun 2020 00:20:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1804
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxem-0007op-Ch; Sat, 13 Jun 2020 00:20:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05D42vfj153696; Sat, 13 Jun 2020 00:20:35 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31mjdtxf9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 00:20:35 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05D4AZeM031486;
 Sat, 13 Jun 2020 04:20:34 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04dal.us.ibm.com with ESMTP id 31mpe80p69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 04:20:34 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05D4KVAl11534612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2020 04:20:31 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7670EBE056;
 Sat, 13 Jun 2020 04:20:32 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3155BE04F;
 Sat, 13 Jun 2020 04:20:31 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.217.131])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2020 04:20:31 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 3/6] targetc/ppc: add vmulh{su}w instructions
Date: Fri, 12 Jun 2020 23:20:26 -0500
Message-Id: <20200613042029.22321-4-ljp@linux.ibm.com>
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
 bulkscore=0 mlxscore=0
 clxscore=1015 adultscore=0 cotscore=-2147483648 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=765 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006130032
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

vmulhsw: Vector Multiply High Signed Word
vmulhuw: Vector Multiply High Unsigned Word

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
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
index afbcdd05b4..4bb3b7e928 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -523,6 +523,20 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
     r->VsrD(0) = 0;
 }
 
+#define VMULH_DO(name, op, element, cast_orig, cast_temp)		\
+    void helper_vmulh##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)	\
+    {									\
+	int i;								\
+									\
+	for (i = 0; i < ARRAY_SIZE(r->element); i++) {			\
+		r->element[i] = (cast_orig)(((cast_temp)a->element[i] op \
+				(cast_temp)b->element[i]) >> 32);	\
+	}								\
+    }
+VMULH_DO(sw, *, s32, int32_t, int64_t)
+VMULH_DO(uw, *, u32, uint32_t, uint64_t)
+#undef VMULH_DO
+
 #define VARITH_DO(name, op, element)                                    \
     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
     {                                                                   \
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 4ee1df48f2..2c35559c52 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -811,9 +811,15 @@ GEN_VXFORM(vmulld,  4, 7);
 GEN_VXFORM(vmuleub, 4, 8);
 GEN_VXFORM(vmuleuh, 4, 9);
 GEN_VXFORM(vmuleuw, 4, 10);
+GEN_VXFORM(vmulhuw, 4, 10);
+GEN_VXFORM_DUAL(vmuleuw, PPC_ALTIVEC, PPC_NONE,
+		vmulhuw, PPC_NONE, PPC2_ISA300);
 GEN_VXFORM(vmulesb, 4, 12);
 GEN_VXFORM(vmulesh, 4, 13);
 GEN_VXFORM(vmulesw, 4, 14);
+GEN_VXFORM(vmulhsw, 4, 14);
+GEN_VXFORM_DUAL(vmulesw, PPC_ALTIVEC, PPC_NONE,
+		vmulhsw, PPC_NONE, PPC2_ISA300);
 GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
 GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
 GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 499bed0a44..1d8238a718 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -107,10 +107,10 @@ GEN_VXFORM_207(vmulosw, 4, 6),
 GEN_VXFORM_300(vmulld, 4, 7),
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


