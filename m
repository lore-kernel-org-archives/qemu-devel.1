Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53FC2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 04:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6806121582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 04:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6806121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihR1d-0000Al-Gn
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 23:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata@linux.ibm.com>) id 1ihR0l-0007Yp-1n
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1ihR0i-0007mC-1i
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:32:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14194
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1ihR0g-0007fT-68
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 23:32:30 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBI4WQBH067573
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 23:32:26 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wybsyt7tk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 23:32:26 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Wed, 18 Dec 2019 04:32:23 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Dec 2019 04:32:19 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBI4VZWp26411500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2019 04:31:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA7D452051;
 Wed, 18 Dec 2019 04:32:18 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.85.89.92])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A401F52052;
 Wed, 18 Dec 2019 04:32:17 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 ppc-for-5.0 0/2] ppc/spapr: Support reboot of secure
 pseries guest
Date: Wed, 18 Dec 2019 10:02:06 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121804-0016-0000-0000-000002D60370
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121804-0017-0000-0000-000033383F71
Message-Id: <20191218043208.28613-1-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_05:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 spamscore=0 mlxlogscore=869 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180034
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: paulus@ozlabs.org, linuxram@us.ibm.com,
 Bharata B Rao <bharata@linux.ibm.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset adds KVM_PPC_SVM_OFF ioctl which is required to support
reset of secure guest. This includes linux-headers update so that we get
the newly introduced ioctl.

v2: https://lists.gnu.org/archive/html/qemu-ppc/2019-12/msg00162.html

Changes in v3:
-------------
- Use of error_fatal as David Gibson suggested.
- Updated linux-headers to 5.5.0-rc2

Bharata B Rao (2):
  linux-headers: Update
  ppc/spapr: Support reboot of secure pseries guest

 hw/ppc/spapr.c                                |  1 +
 include/standard-headers/asm-x86/bootparam.h  |  7 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h | 15 +++-
 include/standard-headers/drm/drm_fourcc.h     | 28 ++++++-
 .../linux/input-event-codes.h                 | 77 +++++++++++++++++++
 include/standard-headers/linux/pci_regs.h     |  3 +
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |  5 ++
 linux-headers/linux/kvm.h                     |  1 +
 target/ppc/kvm.c                              | 15 ++++
 target/ppc/kvm_ppc.h                          |  6 ++
 10 files changed, 154 insertions(+), 4 deletions(-)

-- 
2.21.0


