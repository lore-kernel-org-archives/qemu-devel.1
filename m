Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9BDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A232071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A232071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZdDC-0003YS-Mg
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 10:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iZd79-00051p-Rx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iZd77-00048o-Rd
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:50:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21236
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iZd77-00040Z-GI
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:50:53 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAQFnFFr133145
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 10:50:43 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wh41n0nvw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 10:50:43 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 26 Nov 2019 15:50:41 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 26 Nov 2019 15:50:39 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAQFocOk48824436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 15:50:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEEE04204C;
 Tue, 26 Nov 2019 15:50:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8530242045;
 Tue, 26 Nov 2019 15:50:38 +0000 (GMT)
Received: from bahia.tlslab.ibm.com (unknown [9.101.4.41])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 26 Nov 2019 15:50:38 +0000 (GMT)
Subject: [PATCH for-5.0 0/4] spapr: Use less XIVE HW resources in KVM
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Nov 2019 16:50:38 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112615-0028-0000-0000-000003C043E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112615-0029-0000-0000-0000248346BC
Message-Id: <157478338194.62031.4716158446072147622.stgit@bahia.tlslab.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_04:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=814
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1034 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911260135
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On POWER9 systems, the XICS-on-XIVE and XIVE KVM devices currently
allocate a bunch of VPs in the XIVE HW to accomodate the highest
VCPU id that may be possibly used in a VM. This limits the number
of VMs that can run with an in-kernel interrupt controller to 63
per POWER9 chip, irrespectively of its number of HW threads, eg.
up to 96 on a POWER9 Nimbus socket. This is an unfortunate waste
of scarce HW resources since a typical VM doesn't need that much
VPs to run.

This series exploits new attributes of the XICS-on-XIVE and XIVE
KVM devices that allow userspace to tune the numbers of VPs it
really needs.

Patches 1 to 3 are preliminary work to teach the XICS and XIVE
backends about the range of needed VCPU ids, according to the
maximum number of VCPUs specified in the QEMU command line.

Patch 5 and 6 do the actual work of configuring the KVM devices,
based on new defines brought by a patch 4. RFC since the patches
for KVM are still being discussed on the kvm-ppc list:

https://patchwork.ozlabs.org/project/kvm-ppc/list/?series=132910

As a bonus, patch 7 allows the latest machine type to automatically
set int KVM the guest core stride (VSMT) to be equal to the number
of threads per core (-smp threads=N). This makes VCPU ids contiguous
and allows to reduce the VP consumption even more.

Both KVM and QEMU changes are available here:
https://github.com/gkurz/linux/commits/xive-nr-servers-5.3
https://github.com/gkurz/qemu/commits/xive-nr-servers-for-4.2
---

Greg Kurz (4):
      linux-headers: Update
      spapr: Pass the maximum number of vCPUs to the KVM interrupt controller
      spapr/xics: Configure number of servers in KVM
      spapr/xive: Configure number of servers in KVM


 hw/intc/spapr_xive.c                         |    6 ++++--
 hw/intc/spapr_xive_kvm.c                     |   26 +++++++++++++++++++++++---
 hw/intc/xics_kvm.c                           |   24 +++++++++++++++++++++---
 hw/intc/xics_spapr.c                         |    5 +++--
 hw/ppc/spapr_irq.c                           |    8 +++++---
 include/hw/ppc/spapr_irq.h                   |   10 ++++++++--
 include/hw/ppc/spapr_xive.h                  |    3 ++-
 include/hw/ppc/xics_spapr.h                  |    3 ++-
 include/standard-headers/linux/ethtool.h     |    6 ++++++
 include/standard-headers/linux/virtio_ring.h |    2 +-
 linux-headers/asm-arm/kvm.h                  |    3 ++-
 linux-headers/asm-arm64/kvm.h                |    5 ++++-
 linux-headers/asm-mips/unistd_n32.h          |    1 +
 linux-headers/asm-mips/unistd_n64.h          |    1 +
 linux-headers/asm-mips/unistd_o32.h          |    1 +
 linux-headers/asm-powerpc/kvm.h              |    3 +++
 linux-headers/linux/kvm.h                    |   11 +++++++++++
 linux-headers/linux/psp-sev.h                |    3 +++
 18 files changed, 101 insertions(+), 20 deletions(-)


