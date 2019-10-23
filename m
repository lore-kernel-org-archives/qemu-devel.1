Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14326CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABC02086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABC02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNI2v-0002UH-FE
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNHzb-0000eA-FT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNHzZ-0003we-On
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNHzZ-0003uE-Gg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9NElilI087518
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vtrxdr6rk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:00 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 23 Oct 2019 15:51:58 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Oct 2019 15:51:55 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9NEpsLn38862892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2019 14:51:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51EB211C064;
 Wed, 23 Oct 2019 14:51:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2402411C05B;
 Wed, 23 Oct 2019 14:51:54 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2019 14:51:54 +0000 (GMT)
Subject: [PATCH 0/6] ppc: Reparent the interrupt presenter
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Oct 2019 16:51:53 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
x-cbid: 19102314-0028-0000-0000-000003AE25F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102314-0029-0000-0000-0000247054E0
Message-Id: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-23_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=774 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230148
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9NElilI087518
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The interrupt presenters are currently parented to their associated
VCPU, and we rely on CPU_FOREACH() when we need to perform a specific
task with them. Like exposing their state with 'info pic', or finding
the target VCPU for an interrupt when using the XIVE controller.

We recently realized that the latter could crash QEMU because CPU_FOREACH=
()
can race with CPU hotplug. This got fixed by checking the presenter point=
er
under the CPU was set (commit 627fa61746f7) but this is still fragile. An=
d
we still can crash QEMU with 'info pic' while doing CPU hotplug/unplug:

With XIVE:

Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
0x00000001003d2848 in xive_tctx_pic_print_info (tctx=3D0x101ae5280,=20
    mon=3D0x7fffffffe180) at /home/greg/Work/qemu/qemu-spapr/hw/intc/xive=
.c:526
526         int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
(gdb) p tctx
$1 =3D (XiveTCTX *) 0x101ae5280
(gdb) p tctx->cs
$2 =3D (CPUState *) 0x2057512020203a5d
(gdb) p tctx->cs->cpu_index
Cannot access memory at address 0x205751202020bead

With XICS:

Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
0x00000001003cc39c in icp_pic_print_info (icp=3D0x10244ccf0, mon=3D0x7fff=
ffffe940)
    at /home/greg/Work/qemu/qemu-spapr/hw/intc/xics.c:47
47          int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
(gdb) p icp
$1 =3D (ICPState *) 0x10244ccf0
(gdb) p icp->cs
$2 =3D (CPUState *) 0x524958203220
(gdb) p icp->cs->cpu_index
Cannot access memory at address 0x52495820b670


This series fixes the issue globally by moving the presenter objects unde=
r
the interrupt controller and to loop on them with object_child_foreach()
instead of CPU_FOREACH().

It is based on C=C3=A9dric Le Goater's series:

[v5,0/7] ppc: reset the interrupt presenter from the CPU reset handler

https://patchwork.ozlabs.org/cover/1181522/

--
Greg

---

Greg Kurz (6):
      ppc: Add intc_destroy() handlers to SpaprInterruptController/PnvChi=
p
      xive, xics: Fix reference counting on CPU objects
      ppc: Reparent presenter objects to the interrupt controller object
      qom: Add object_child_foreach_type() helper function
      spapr: Don't use CPU_FOREACH() in 'info pic'
      xive: Don't use CPU_FOREACH() to perform CAM line matching


 hw/intc/spapr_xive.c       |   19 ++++---
 hw/intc/xics.c             |   30 ++++++++++-
 hw/intc/xics_spapr.c       |   21 +++++--
 hw/intc/xive.c             |  125 ++++++++++++++++++++++++++++++--------=
------
 hw/ppc/pnv.c               |   28 +++++++++-
 hw/ppc/pnv_core.c          |    7 +-
 hw/ppc/spapr_cpu_core.c    |    7 --
 hw/ppc/spapr_irq.c         |   14 +++++
 include/hw/ppc/pnv.h       |    1=20
 include/hw/ppc/spapr_irq.h |    2 +
 include/hw/ppc/xics.h      |    4 +
 include/hw/ppc/xive.h      |    3 +
 include/qom/object.h       |   35 ++++++++++++
 qom/object.c               |   30 ++++++++---
 14 files changed, 251 insertions(+), 75 deletions(-)


