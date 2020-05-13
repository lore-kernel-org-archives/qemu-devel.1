Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC71C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D638C20690
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D638C20690
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYt3c-0003y5-O1
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt2j-0002fv-4c
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:11:33 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:41897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt2h-0005Hc-UV
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:11:32 -0400
Received: from player791.ha.ovh.net (unknown [10.108.42.167])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6EFFF15FFD2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 17:11:21 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id A5F971244BAEF;
 Wed, 13 May 2020 15:11:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/9] ppc/pnv: Introduce the XIVE2 and PHB5 controllers for the
 POWER10 chip
Date: Wed, 13 May 2020 17:11:00 +0200
Message-Id: <20200513151109.453530-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1015843192003922918
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieekkeelffetgeelveevjeehteduvdeivdeljeevvdeuvedtgfeiudeiveeiudfgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.72.216; envelope-from=clg@kaod.org;
 helo=16.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 11:11:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This series completes the PowerNV POWER10 machine with the XIVE2
interrupt controller and the PHB5 PCI host bridge controller.

The XIVE2 interrupt controller of the POWER10 processor follows the
same logic than on POWER9 but the HW interface has been largely
reviewed. To avoid adding too much complexity in the P9 XIVE models,
a new XIVE2 core framework is introduced.

The PHB5 and PHB4 controllers are very similar. Not much changes there
apart from the mapping addresses and ids. There is more to come on
PHB5 regarding interrupt offload on the interrupt controller, but this
is for another round.

This series also adds basic OCC and CPU Quad models which are not very
much exercised by the firmware.

Thanks,

C.

Cédric Le Goater (9):
  ppc/xive: Export PQ get/set routines
  ppc/xive: Export xive_presenter_notify()
  ppc/xive2: Introduce a XIVE2 core framework
  ppc/xive2: Introduce a presenter matching routine
  ppc/pnv: Add a XIVE2 controller to the POWER10 chip.
  ppc/pnv: Add a OCC model for POWER10
  ppc/pnv: Add POWER10 quads
  ppc/pnv: Add model for POWER9 PHB5 PCIe Host bridge
  ppc/psi: Add support for StoreEOI and 64k ESB pages (POWER10)

 hw/intc/pnv_xive2_regs.h       |  428 +++++++
 include/hw/pci-host/pnv_phb4.h |   11 +
 include/hw/ppc/pnv.h           |   30 +
 include/hw/ppc/pnv_occ.h       |    2 +
 include/hw/ppc/pnv_xive.h      |   71 ++
 include/hw/ppc/pnv_xscom.h     |   12 +
 include/hw/ppc/xive.h          |    8 +
 include/hw/ppc/xive2.h         |   93 ++
 include/hw/ppc/xive2_regs.h    |  198 ++++
 hw/intc/pnv_xive2.c            | 2026 ++++++++++++++++++++++++++++++++
 hw/intc/spapr_xive_kvm.c       |    8 +-
 hw/intc/xive.c                 |   14 +-
 hw/intc/xive2.c                |  756 ++++++++++++
 hw/pci-host/pnv_phb4_pec.c     |   44 +
 hw/ppc/pnv.c                   |  243 +++-
 hw/ppc/pnv_occ.c               |   17 +
 hw/ppc/pnv_psi.c               |   32 +-
 hw/intc/Makefile.objs          |    4 +-
 18 files changed, 3974 insertions(+), 23 deletions(-)
 create mode 100644 hw/intc/pnv_xive2_regs.h
 create mode 100644 include/hw/ppc/xive2.h
 create mode 100644 include/hw/ppc/xive2_regs.h
 create mode 100644 hw/intc/pnv_xive2.c
 create mode 100644 hw/intc/xive2.c

-- 
2.25.4


