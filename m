Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55BDC2D0DD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 05:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1A1206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 05:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1A1206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imtG1-0006ok-3l
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 00:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata@linux.ibm.com>) id 1imtFK-00064C-U6
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 00:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1imtFJ-0008VP-TG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 00:42:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1imtFJ-0008Uy-MO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 00:42:09 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0025fu3I025503
 for <qemu-devel@nongnu.org>; Thu, 2 Jan 2020 00:42:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x63k00h16-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 00:42:07 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Thu, 2 Jan 2020 05:42:05 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 2 Jan 2020 05:42:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0025g1ja46661744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jan 2020 05:42:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16FFB5204E;
 Thu,  2 Jan 2020 05:42:01 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.85.93.38])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0164652051;
 Thu,  2 Jan 2020 05:41:59 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH ppc-for-5.0 1/1] ppc/spapr: Don't call KVM_SVM_OFF ioctl on TCG
Date: Thu,  2 Jan 2020 11:11:55 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010205-0008-0000-0000-00000345D1B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010205-0009-0000-0000-00004A66072B
Message-Id: <20200102054155.13175-1-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-01_08:2019-12-30,2020-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=29 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020052
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Bharata B Rao <bharata@linux.ibm.com>,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Invoking KVM_SVM_OFF ioctl for TCG guests will lead to a QEMU crash.
Fix this by ensuring that we don't call KVM_SVM_OFF ioctl on TCG.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Fixes: 4930c1966249 ("ppc/spapr: Support reboot of secure pseries guest")
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 target/ppc/kvm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b64916dc37..ae2f3c57c0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2902,9 +2902,12 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 void kvmppc_svm_off(Error **errp)
 {
     int rc;
-    KVMState *s = KVM_STATE(current_machine->accelerator);
 
-    rc = kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    rc = kvm_vm_ioctl(KVM_STATE(current_machine->accelerator), KVM_PPC_SVM_OFF);
     if (rc && rc != -ENOTTY) {
         error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
     }
-- 
2.21.0


