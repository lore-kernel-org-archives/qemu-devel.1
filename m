Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D90CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9FC22419
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9FC22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXObi-0001z0-2h
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOP1-0003I8-6i
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOP0-0003Vy-54
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXOOz-0003UZ-Tl
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:06 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKBftON048542
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:44:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wadmy9s3n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:44:04 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 20 Nov 2019 11:44:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 11:43:59 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAKBhvlX55705628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 11:43:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99E824C050;
 Wed, 20 Nov 2019 11:43:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B0484C046;
 Wed, 20 Nov 2019 11:43:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.205])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 11:43:56 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/15] s390x: protvirt: KVM intercept changes
Date: Wed, 20 Nov 2019 06:43:27 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120114334.2287-1-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112011-0008-0000-0000-000003352741
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112011-0009-0000-0000-00004A544B74
Message-Id: <20191120114334.2287-9-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 mlxlogscore=938 impostorscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=1 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911200107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Secure guests no longer intercept with code 4 for an instruction
interception. Instead they have codes 104 and 108 for secure
instruction interception and secure instruction notification
respectively.

The 104 mirrors the 4, but the 108 is a notification, that something
happened and the hypervisor might need to adjust its tracking data to
that fact. An example for that is the set prefix notification
interception, where KVM only reads the new prefix, but does not update
the prefix in the state description.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 418154ccfe..58251c0229 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -115,6 +115,8 @@
 #define ICPT_CPU_STOP                   0x28
 #define ICPT_OPEREXC                    0x2c
 #define ICPT_IO                         0x40
+#define ICPT_PV_INSTR                   0x68
+#define ICPT_PV_INSTR_NOT               0x6c
 
 #define NR_LOCAL_IRQS 32
 /*
@@ -151,6 +153,7 @@ static int cap_s390_irq;
 static int cap_ri;
 static int cap_gs;
 static int cap_hpage_1m;
+static int cap_protvirt;
 
 static int active_cmma;
 
@@ -336,6 +339,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
+    cap_protvirt = kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
 
     if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
         || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
@@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
             (long)cs->kvm_run->psw_addr);
     switch (icpt_code) {
         case ICPT_INSTRUCTION:
+        case ICPT_PV_INSTR:
+        case ICPT_PV_INSTR_NOT:
             r = handle_instruction(cpu, run);
             break;
         case ICPT_PROGRAM:
-- 
2.20.1


