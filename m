Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F6C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C61820658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C61820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lWx-0003zc-F3
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j4lP8-0006gp-MN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j4lP6-0006jm-Im
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:58:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j4lP6-0006dw-8J
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:58:08 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01KCs4S0009966
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:57:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubb8d08-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:57:57 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 20 Feb 2020 12:57:55 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Feb 2020 12:57:52 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01KCvpxF54984810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 12:57:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67570AE04D;
 Thu, 20 Feb 2020 12:57:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F81BAE051;
 Thu, 20 Feb 2020 12:57:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.185.143])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2020 12:57:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/16] s390x: Add unpack feature to GA1
Date: Thu, 20 Feb 2020 07:56:37 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220125638.7241-1-frankja@linux.ibm.com>
References: <20200220125638.7241-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022012-0028-0000-0000-000003DCC0B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022012-0029-0000-0000-000024A1D0A8
Message-Id: <20200220125638.7241-16-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-20_03:2020-02-19,
 2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=924 suspectscore=1
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200097
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/gen-features.c | 1 +
 target/s390x/kvm.c          | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6278845b12..8ddeebc544 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -562,6 +562,7 @@ static uint16_t full_GEN15_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_9,
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
     S390_FEAT_ETOKEN,
+    S390_FEAT_UNPACK,
 };
 
 /* Default features (in order of release)
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 31dd49729b..5b6a7ca466 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -154,6 +154,7 @@ static int cap_ri;
 static int cap_gs;
 static int cap_hpage_1m;
 static int cap_vcpu_resets;
+static int cap_protected;
 
 static int active_cmma;
 
@@ -346,6 +347,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
     cap_vcpu_resets = kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
+    cap_protected = kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
 
     if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
         || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
@@ -2394,6 +2396,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         clear_bit(S390_FEAT_BPB, model->features);
     }
 
+    /* we do have the IPL enhancements */
+    if (cap_protected) {
+        set_bit(S390_FEAT_UNPACK, model->features);
+    }
+
     /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
     set_bit(S390_FEAT_ZPCI, model->features);
     set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
-- 
2.20.1


