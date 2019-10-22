Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12602184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12602184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuiK-0001fb-Sl
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMuRK-0007fY-MY
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMuRJ-0005ke-8A
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:43:10 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:53001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMuRJ-0005jo-1K
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:43:09 -0400
Received: from player761.ha.ovh.net (unknown [10.108.35.119])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id B415C11D206
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 15:43:06 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id DC769B475F18;
 Tue, 22 Oct 2019 13:42:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v4 0/6] ppc: reset the interrupt presenter from the CPU reset
 handler
Date: Tue, 22 Oct 2019 15:42:48 +0200
Message-Id: <20191022134254.28692-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 533958033164962790
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.44.159
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

C=C3=A9dric Le Goater (5):
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
 hw/ppc/pnv_core.c           | 32 ++++++++++++++++------
 hw/ppc/spapr_cpu_core.c     | 42 ++++++++++++++++++++++-------
 hw/ppc/spapr_irq.c          | 14 ++++++++++
 14 files changed, 130 insertions(+), 65 deletions(-)

--=20
2.21.0


