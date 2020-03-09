Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32F120828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32F120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGZS-0002bk-59
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBGUh-0000rF-Au
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBGUg-0004wE-Cf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBGUg-0004oS-7h
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:46 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029BLKeU024710
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 07:22:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7aak22j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:22:32 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 9 Mar 2020 11:22:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 11:22:21 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029BMKMk42926220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 11:22:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ACBA4C044;
 Mon,  9 Mar 2020 11:22:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB84E4C050;
 Mon,  9 Mar 2020 11:22:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.87])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 11:22:19 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/15] s390x: protvirt: KVM intercept changes
Date: Mon,  9 Mar 2020 07:21:56 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309112206.20261-1-frankja@linux.ibm.com>
References: <20200309112206.20261-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030911-4275-0000-0000-000003A9C3FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030911-4276-0000-0000-000038BEDA2B
Message-Id: <20200309112206.20261-6-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_02:2020-03-08,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=1
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090079
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Secure guests no longer intercept with code 4 for an instruction
interception. Instead they have codes 104 and 108 for secure
instruction interception and secure instruction notification
respectively.

The 104 mirrors the 4 interception.

The 108 is a notification interception to let KVM and QEMU know that
something changed and we need to update tracking information or
perform specific tasks. It's currently taken for the following
instructions:

* stpx (To inform about the changed prefix location)
* sclp (On incorrect SCCB values, so we can inject a IRQ)
* sigp (All but "stop and store status")
* diag308 (Subcodes 0/1)

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1d6fd6a27b..eec0b92479 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -115,6 +115,8 @@
 #define ICPT_CPU_STOP                   0x28
 #define ICPT_OPEREXC                    0x2c
 #define ICPT_IO                         0x40
+#define ICPT_PV_INSTR                   0x68
+#define ICPT_PV_INSTR_NOTIFICATION      0x6c
 
 #define NR_LOCAL_IRQS 32
 /*
@@ -1693,6 +1695,8 @@ static int handle_intercept(S390CPU *cpu)
             (long)cs->kvm_run->psw_addr);
     switch (icpt_code) {
         case ICPT_INSTRUCTION:
+        case ICPT_PV_INSTR:
+        case ICPT_PV_INSTR_NOTIFICATION:
             r = handle_instruction(cpu, run);
             break;
         case ICPT_PROGRAM:
-- 
2.20.1


