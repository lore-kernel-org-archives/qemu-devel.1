Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35935C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F31520659
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F31520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZe17-0007ud-7H
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 11:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iZdyq-0006F1-6V
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iZdyo-0006VF-UL
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iZdyo-0006Ua-MK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:46:22 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAQGKuZY023163
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:46:19 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wfk4nemqv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:46:19 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 26 Nov 2019 16:46:15 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 26 Nov 2019 16:46:13 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAQGkC1L51642466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 16:46:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83028A405F;
 Tue, 26 Nov 2019 16:46:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50412A405C;
 Tue, 26 Nov 2019 16:46:12 +0000 (GMT)
Received: from bahia.tlslab.ibm.com (unknown [9.101.4.41])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 26 Nov 2019 16:46:12 +0000 (GMT)
Subject: [for-5.0 PATCH v2 0/4] spapr: Use less XIVE HW resources in KVM
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Nov 2019 17:46:12 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112616-0012-0000-0000-0000036C9085
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112616-0013-0000-0000-000021A8365F
Message-Id: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_04:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1034
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=507 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260139
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
really needs. Support for this attributes has just reached linux
mainline.

In combination with recent commit 29cb4187497d "spapr: Set VSMT to
smp_threads by default" which makes VCPU ids contiguous, it is
possible to start more than 200 VMs instead of 127 on an AC922
system (two sockets, 144 HW threads).

Changes in v2:
- add an nr_servers argument to the activate() handler instead of
  a QOM property for XIVE and a XICSFabric method for XICS-on-XIVE.
- even if the last two patches haven't changed much, the code base
  itself has, so I've deliberately dropped Cedric's R-b tags

--
Greg

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


