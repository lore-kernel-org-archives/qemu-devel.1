Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6992084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6992084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxT3-00053g-Kj
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMxBQ-0000kp-Lm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMxBO-0006hU-Uh
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:38:56 -0400
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:46775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMxBO-0006gh-Nk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:38:54 -0400
Received: from player688.ha.ovh.net (unknown [10.108.35.185])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6E2DF194F67
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 18:38:52 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 70050B32C2DD;
 Tue, 22 Oct 2019 16:38:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v5 0/7] ppc: reset the interrupt presenter from the CPU reset
 handler
Date: Tue, 22 Oct 2019 18:38:05 +0200
Message-Id: <20191022163812.330-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3502393138045684710
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.45.107
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On the sPAPR machine and PowerNV machine, the interrupt presenters are
created by a machine handler at the core level and are reseted
independently. This is not consistent and it raises issues when it
comes to handle hot-plugged CPUs. In that case, the presenters are not
reseted. This is less of an issue in XICS, although a zero MFFR could
be a concern, but in XIVE, the OS CAM line is not set and this breaks
the presenting algorithm. The current code has workarounds which need
a global cleanup.

Extend the sPAPR IRQ backend and the PowerNV Chip class with a new
cpu_intc_reset() handler called by the CPU reset handler and remove
the XiveTCTX reset handler which is now redundant.

Set the OS CAM line when the interrupt presenter of the sPAPR core is
reseted. This will also cover the case of hot-plugged CPUs.

Thanks,

C.

Changes in v5:

 - Removed useless PNV_CHIP() cast
=20
Changes in v4:

 - Introduce a PnvCore reset handler
 - Add PnvChip pointer to PnvCore

Changes in v3:

 - Introduced a DeviceClass::reset for the CPU (Greg)
 - add support for PowerNV
=20
Changes in v2:

 - removed property
 - simplified reset handlers

C=C3=A9dric Le Goater (6):
  spapr: move CPU reset after presenter creation
  ppc/pnv: Introduce a PnvCore reset handler
  ppc/pnv: Add a PnvChip pointer to PnvCore
  ppc: Reset the interrupt presenter from the CPU reset handler
  ppc/pnv: Fix naming of routines realizing the CPUs
  spapr/xive: Set the OS CAM line at reset

Greg Kurz (1):
  spapr_cpu_core: Implement DeviceClass::reset

 include/hw/ppc/pnv.h        |  1 +
 include/hw/ppc/pnv_core.h   |  3 +++
 include/hw/ppc/spapr_irq.h  |  2 ++
 include/hw/ppc/spapr_xive.h |  1 -
 include/hw/ppc/xics.h       |  1 +
 include/hw/ppc/xive.h       |  1 +
 hw/intc/spapr_xive.c        | 53 +++++++++++++++++--------------------
 hw/intc/xics.c              |  8 ++----
 hw/intc/xics_spapr.c        |  7 +++++
 hw/intc/xive.c              | 12 +--------
 hw/ppc/pnv.c                | 18 +++++++++++++
 hw/ppc/pnv_core.c           | 31 ++++++++++++++++------
 hw/ppc/spapr_cpu_core.c     | 44 +++++++++++++++++++++++-------
 hw/ppc/spapr_irq.c          | 14 ++++++++++
 14 files changed, 131 insertions(+), 65 deletions(-)

--=20
2.21.0


