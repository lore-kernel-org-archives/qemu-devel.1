Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C89C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6D8222C2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6D8222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzou-0000vE-EB
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFzn3-00083w-GM
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFzn0-00072Q-VG
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:01:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFzn0-00070O-E0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:00:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x93BvEB8102437
 for <qemu-devel@nongnu.org>; Thu, 3 Oct 2019 08:00:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vdfgsaamy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 08:00:55 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 3 Oct 2019 13:00:52 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 3 Oct 2019 13:00:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x93C0n9s25559270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2019 12:00:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A01A3A407C;
 Thu,  3 Oct 2019 12:00:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7093AA406F;
 Thu,  3 Oct 2019 12:00:49 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Oct 2019 12:00:49 +0000 (GMT)
Subject: [PATCH 0/7] spapr: Use less XIVE HW resources in KVM
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Thu, 03 Oct 2019 14:00:49 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-0012-0000-0000-00000353AB7E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-0013-0000-0000-0000218EB24E
Message-Id: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-03_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=891 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030113
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
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

--
Greg

---

Greg Kurz (7):
      spapr, xics: Get number of servers with a XICSFabricClass method
      spapr, xive: Turn "nr-ends" property into "nr-servers" property
      spapr, xics, xive: Drop nr_servers argument in DT-related functions
      RFC linux-headers: Update against 5.3-rc2
      spapr/xics: Configure number of servers in KVM
      spapr/xive: Configure number of servers in KVM
      spapr: Set VSMT to smp_threads by default


 hw/intc/spapr_xive.c                         |   24 ++++++++++++++++------
 hw/intc/spapr_xive_kvm.c                     |   22 +++++++++++++++++++-
 hw/intc/xics.c                               |    7 +++++++
 hw/intc/xics_kvm.c                           |   24 ++++++++++++++++++++--
 hw/intc/xics_spapr.c                         |    6 +++---
 hw/ppc/spapr.c                               |   18 ++++++++++++++---
 hw/ppc/spapr_irq.c                           |    7 +++----
 include/hw/ppc/spapr.h                       |    1 +
 include/hw/ppc/spapr_irq.h                   |    3 +--
 include/hw/ppc/spapr_xive.h                  |    4 ++--
 include/hw/ppc/xics.h                        |    2 ++
 include/hw/ppc/xics_spapr.h                  |    3 +--
 include/standard-headers/asm-x86/bootparam.h |    2 ++
 include/standard-headers/asm-x86/kvm_para.h  |    1 +
 include/standard-headers/linux/ethtool.h     |    2 ++
 include/standard-headers/linux/pci_regs.h    |    4 ++++
 include/standard-headers/linux/virtio_ids.h  |    1 +
 include/standard-headers/linux/virtio_pmem.h |    6 +++---
 linux-headers/asm-arm/kvm.h                  |   12 +++++++++++
 linux-headers/asm-arm/unistd-common.h        |    2 ++
 linux-headers/asm-arm64/kvm.h                |   17 ++++++++++++++++
 linux-headers/asm-generic/mman-common.h      |   15 ++++++++------
 linux-headers/asm-generic/mman.h             |   10 ++++-----
 linux-headers/asm-generic/unistd.h           |    8 +++++++
 linux-headers/asm-mips/unistd_n32.h          |    1 +
 linux-headers/asm-mips/unistd_n64.h          |    1 +
 linux-headers/asm-mips/unistd_o32.h          |    1 +
 linux-headers/asm-powerpc/kvm.h              |    3 +++
 linux-headers/asm-powerpc/mman.h             |    6 +-----
 linux-headers/asm-powerpc/unistd_32.h        |    2 ++
 linux-headers/asm-powerpc/unistd_64.h        |    2 ++
 linux-headers/asm-s390/unistd_32.h           |    2 ++
 linux-headers/asm-s390/unistd_64.h           |    2 ++
 linux-headers/asm-x86/kvm.h                  |   28 ++++++++++++++++++++------
 linux-headers/asm-x86/unistd_32.h            |    2 ++
 linux-headers/asm-x86/unistd_64.h            |    2 ++
 linux-headers/asm-x86/unistd_x32.h           |    2 ++
 linux-headers/linux/kvm.h                    |    7 +++++--
 linux-headers/linux/psp-sev.h                |    5 +----
 39 files changed, 206 insertions(+), 61 deletions(-)


