Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA4CC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEE820838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEE820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vn4-0006xM-Fs
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j6vgk-0003BF-4J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j6vgj-0000I3-3r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:21:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3204
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j6vgi-0008Gh-Uk
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:21:17 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QCKttP042842
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:21:06 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yden12brs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:21:06 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 26 Feb 2020 12:21:04 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 12:21:02 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01QCK4Km50069996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 12:20:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AA7311C064;
 Wed, 26 Feb 2020 12:21:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8C2A11C054;
 Wed, 26 Feb 2020 12:21:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.212])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 12:21:00 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 17/18] s390x: Add unpack facility feature to GA1
Date: Wed, 26 Feb 2020 07:20:37 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226122038.61481-1-frankja@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022612-0020-0000-0000-000003ADC03A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022612-0021-0000-0000-00002205DAFD
Message-Id: <20200226122038.61481-18-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_04:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=816 adultscore=0 spamscore=0 suspectscore=1 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260092
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

From: Christian Borntraeger <borntraeger@de.ibm.com>

The unpack facility is an indication that diagnose 308 subcodes 8-10
are available to the guest. That means, that the guest can put itself
into protected mode.

Once it is in protected mode, the hardware stops any attempt of VM
introspection by the hypervisor.

Some features are currently not supported in protected mode:
     * Passthrough devices
     * Migration
     * Huge page backings

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/gen-features.c | 1 +
 target/s390x/kvm.c          | 5 +++++
 2 files changed, 6 insertions(+)

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
index a4cbdc5fc6..bf807793bc 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2396,6 +2396,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
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


