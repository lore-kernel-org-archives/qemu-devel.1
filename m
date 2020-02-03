Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FDFC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5099420720
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5099420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iykLz-000273-GA
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 17:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iykKO-0000R1-8U
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:36:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iykKJ-0008DZ-DA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:36:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11718
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iykKJ-0007YS-7E
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:36:19 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013MYdHD003724
 for <qemu-devel@nongnu.org>; Mon, 3 Feb 2020 17:36:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xxhf77n7g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 17:36:10 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 3 Feb 2020 22:36:08 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Feb 2020 22:36:06 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 013Ma5v544761532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2020 22:36:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CFD411C08E;
 Mon,  3 Feb 2020 22:36:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0517C11C08D;
 Mon,  3 Feb 2020 22:36:05 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.55.193])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  3 Feb 2020 22:36:04 +0000 (GMT)
Subject: [PATCH 0/3] spapr: Fix device unplug vs CAS or migration
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 03 Feb 2020 23:36:04 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20020322-0028-0000-0000-000003D71A38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020322-0029-0000-0000-0000249B7354
Message-Id: <158076936422.2118610.5626450767672103134.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-03_08:2020-02-02,
 2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1034 mlxlogscore=685 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030163
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While working on getting rid of CAS reboot, I realized that we currently
don't handle device hot unplug properly in the following situations:

1) if the device is unplugged between boot and CAS, SLOF doesn't handle
   the even, which is a known limitation. The device hence stays around
   forever (specifically, until some other event is emitted and the guest
   eventually completes the unplug or a reboot). Until we can teach SLOF
   to correctly process the full FDT at CAS, we should trigger a CAS reboot,
   like we already do for hotplug.

2) if the guest is migrated after the even was emitted but before the
   guest could process it, the destination is unaware of the pending
   unplug operation and doesn't remove the device when the guests
   releases it. The 'unplug_requested' field of the DRC is actually state
   that should be migrated.

--
Greg

---

Greg Kurz (3):
      spapr: Don't use spapr_drc_needed() in CAS code
      spapr: Detect hot unplugged devices during CAS
      spapr: Migrate SpaprDrc::unplug_requested


 hw/ppc/spapr_drc.c         |   30 ++++++++++++++++++++++++++----
 hw/ppc/spapr_hcall.c       |   12 +++++++++---
 include/hw/ppc/spapr_drc.h |    8 +++++++-
 3 files changed, 42 insertions(+), 8 deletions(-)


