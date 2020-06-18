Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B895BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 00:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904FB21582
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 00:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904FB21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jliCn-0001S0-S7
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 20:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jli9Z-000492-M4; Wed, 17 Jun 2020 20:11:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jli9W-0006q9-RA; Wed, 17 Jun 2020 20:11:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05I02kPO194882; Wed, 17 Jun 2020 20:11:32 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31q6j18wwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 20:11:32 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I04x5A015534;
 Thu, 18 Jun 2020 00:11:31 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03dal.us.ibm.com with ESMTP id 31q6c5sdqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 00:11:31 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05I0BTjt25166174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2020 00:11:30 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC5826A05A;
 Thu, 18 Jun 2020 00:11:29 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BF666A04D;
 Thu, 18 Jun 2020 00:11:29 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.216.12])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2020 00:11:28 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] target/ppc: Introduce Power ISA 3.1 flag
Date: Wed, 17 Jun 2020 19:11:21 -0500
Message-Id: <20200618001127.34438-2-ljp@linux.ibm.com>
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
 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 cotscore=-2147483648
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 20:11:31
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
Cc: Lijun Pan <ljp@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This flag will be used for Power10 instructions.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v2: add Power ISA 3.1 flag

 target/ppc/cpu.h                | 4 +++-
 target/ppc/translate_init.inc.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1988b436cb..ebb5a0811a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2191,6 +2191,8 @@ enum {
     PPC2_PM_ISA206     = 0x0000000000040000ULL,
     /* POWER ISA 3.0                                                         */
     PPC2_ISA300        = 0x0000000000080000ULL,
+    /* POWER ISA 3.1                                                         */
+    PPC2_ISA310        = 0x0000000000100000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
                         PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 | \
@@ -2199,7 +2201,7 @@ enum {
                         PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
-                        PPC2_ISA300)
+                        PPC2_ISA300 | PPC2_ISA310)
 };
 
 /*****************************************************************************/
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 38cb773ab4..3f72310e60 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9206,7 +9206,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
+                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_HV) |
                     (1ull << MSR_TM) |
-- 
2.23.0


