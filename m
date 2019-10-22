Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD4ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F4B21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4B21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMusa-0007jo-KG
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMuUn-0003f9-Fc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMuUm-0007ej-AY
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:46:45 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:40189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMuUm-0007cY-2A
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:46:44 -0400
Received: from player772.ha.ovh.net (unknown [10.109.143.201])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 3C6FD195223
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 15:46:42 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 7932AB3F2F13;
 Tue, 22 Oct 2019 13:46:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v4 0/7] ppc: reset the interrupt presenter from the CPU reset
 handler
Date: Tue, 22 Oct 2019 15:46:25 +0200
Message-Id: <20191022134632.29098-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 594756628243778534
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.127.22
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
 hw/ppc/pnv_core.c           | 32 ++++++++++++++++------
 hw/ppc/spapr_cpu_core.c     | 44 +++++++++++++++++++++++-------
 hw/ppc/spapr_irq.c          | 14 ++++++++++
 14 files changed, 132 insertions(+), 65 deletions(-)

--=20
2.21.0


