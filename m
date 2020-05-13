Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 22:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EDC2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 22:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EDC2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ0M2-00011T-FH
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 18:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jZ0JR-0004N9-8T; Wed, 13 May 2020 18:57:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34334
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jZ0JQ-00079d-H3; Wed, 13 May 2020 18:57:16 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04DMVZIR155406; Wed, 13 May 2020 18:57:06 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3101kybs98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 18:57:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04DMtlAB016678;
 Wed, 13 May 2020 22:57:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03ams.nl.ibm.com with ESMTP id 3100ubaecc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 22:57:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04DMv1dM59244712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 22:57:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BC044C04A;
 Wed, 13 May 2020 22:57:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 630B34C044;
 Wed, 13 May 2020 22:57:01 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.63.64])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 May 2020 22:57:01 +0000 (GMT)
Subject: [PATCH v2 3/6] target/ppc: Don't initialize some local variables in
 ppc_radix64_xlate()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 May 2020 00:57:00 +0200
Message-ID: <158941062048.240484.9693581559252337111.stgit@bahia.lan>
In-Reply-To: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_09:2020-05-13,
 2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1034 malwarescore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130188
Received-SPF: softfail client-ip=148.163.158.5; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 18:57:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is the job of the ppc_radix64_get_fully_qualified_addr() function
which is called at the beginning of ppc_radix64_xlate() to set both
lpid *and* pid. It doesn't buy us anything to initialize them first.

Worse, a bug in ppc_radix64_get_fully_qualified_addr(), eg. failing to
set either lpid or pid, would be undetectable by static analysis tools
like coverity.

Some recent versions of gcc (eg. gcc-9.3.1-2.fc30) may still think
that lpid or pid is used uninitialized though, so this also adds
default cases in the switch statements to make it clear this cannot
happen.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-radix64.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index c76879f65b78..07f956c9864f 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -50,6 +50,8 @@ static bool ppc_radix64_get_fully_qualified_addr(const CPUPPCState *env,
             *lpid = 0;
             *pid = 0;
             break;
+        default:
+            g_assert_not_reached();
         }
     } else {  /* !MSR[HV] -> Guest */
         switch (eaddr & R_EADDR_QUADRANT) {
@@ -64,6 +66,8 @@ static bool ppc_radix64_get_fully_qualified_addr(const CPUPPCState *env,
             *lpid = env->spr[SPR_LPIDR];
             *pid = 0; /* pid set to 0 -> addresses guest operating system */
             break;
+        default:
+            g_assert_not_reached();
         }
     }
 
@@ -433,7 +437,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                              bool cause_excp)
 {
     CPUPPCState *env = &cpu->env;
-    uint64_t lpid = 0, pid = 0;
+    uint64_t lpid, pid;
     ppc_v3_pate_t pate;
     int psize, prot;
     hwaddr g_raddr;


