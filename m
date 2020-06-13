Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 04:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC0B2071A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 04:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC0B2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjxfw-0001Wr-3m
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 00:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxeo-0008Lr-R1; Sat, 13 Jun 2020 00:20:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20838
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxem-0007of-4B; Sat, 13 Jun 2020 00:20:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05D42NM7041069; Sat, 13 Jun 2020 00:20:34 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31mnv3j23p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 00:20:34 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05D4AlsK016924;
 Sat, 13 Jun 2020 04:20:33 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02dal.us.ibm.com with ESMTP id 31mpe8gq4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 04:20:33 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05D4KUXj27132406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2020 04:20:30 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4DE3BE04F;
 Sat, 13 Jun 2020 04:20:31 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E9ECBE053;
 Sat, 13 Jun 2020 04:20:31 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.217.131])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2020 04:20:31 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/ppc: add vmulld instruction
Date: Fri, 12 Jun 2020 23:20:25 -0500
Message-Id: <20200613042029.22321-3-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200613042029.22321-1-ljp@linux.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-12_17:2020-06-12,
 2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 cotscore=-2147483648 lowpriorityscore=0 malwarescore=0 mlxlogscore=726
 adultscore=0 phishscore=0 clxscore=1015 classifier=spam adjust=0
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

vmulld: Vector Multiply Low Doubleword.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
 target/ppc/helper.h                 | 1 +
 target/ppc/int_helper.c             | 1 +
 target/ppc/translate/vmx-impl.inc.c | 1 +
 target/ppc/translate/vmx-ops.inc.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 2dfa1c6942..c3f087ccb3 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -185,6 +185,7 @@ DEF_HELPER_3(vmuloub, void, avr, avr, avr)
 DEF_HELPER_3(vmulouh, void, avr, avr, avr)
 DEF_HELPER_3(vmulouw, void, avr, avr, avr)
 DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
+DEF_HELPER_3(vmulld, void, avr, avr, avr)
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index be53cd6f68..afbcdd05b4 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -533,6 +533,7 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
         }                                                               \
     }
 VARITH_DO(muluwm, *, u32)
+VARITH_DO(mulld, *, s64)
 #undef VARITH_DO
 #undef VARITH
 
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 403ed3a01c..4ee1df48f2 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -807,6 +807,7 @@ GEN_VXFORM_DUAL(vmulouw, PPC_ALTIVEC, PPC_NONE,
 GEN_VXFORM(vmulosb, 4, 4);
 GEN_VXFORM(vmulosh, 4, 5);
 GEN_VXFORM(vmulosw, 4, 6);
+GEN_VXFORM(vmulld,  4, 7);
 GEN_VXFORM(vmuleub, 4, 8);
 GEN_VXFORM(vmuleuh, 4, 9);
 GEN_VXFORM(vmuleuw, 4, 10);
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 84e05fb827..499bed0a44 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -104,6 +104,7 @@ GEN_VXFORM_DUAL(vmulouw, vmuluwm, 4, 2, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vmulosb, 4, 4),
 GEN_VXFORM(vmulosh, 4, 5),
 GEN_VXFORM_207(vmulosw, 4, 6),
+GEN_VXFORM_300(vmulld, 4, 7),
 GEN_VXFORM(vmuleub, 4, 8),
 GEN_VXFORM(vmuleuh, 4, 9),
 GEN_VXFORM_207(vmuleuw, 4, 10),
-- 
2.23.0


