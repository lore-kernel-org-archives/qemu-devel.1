Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FC5C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F5520730
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EyVBCYXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F5520730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXapX-0002tn-Uh
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 20:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXao5-0001Qe-Lb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXao4-0001rk-90
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:58:49 -0500
Received: from ozlabs.org ([203.11.71.1]:47185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXao3-0001ql-5Q; Wed, 20 Nov 2019 19:58:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47JLm40WNcz9sPL; Thu, 21 Nov 2019 11:58:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574297924;
 bh=tCEjjjB7GWqDoKkmTHHtPfHvbR0elnZvywA0y/9MLo0=;
 h=From:To:Cc:Subject:Date:From;
 b=EyVBCYXMbgL/PZAgLOTtz0gX0pXijPuX9pUZJRgcHWhLB/w4oLX2BSi4I/VPlBnOC
 q0FYGB73r6i3IDHdz26veT6iTYIPVJLENM+xVShNbLHYT6ymE19SLFyXyQA/XjtblG
 dqtn6WBoa1baAQuibNkZrG2Ez5v4xLF3w4mfR4fA=
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>,
	clg@kaod.org
Subject: [PATCH 0/5] vfio/spapr: Handle changes of master irq chip for VFIO
 devices
Date: Thu, 21 Nov 2019 11:56:02 +1100
Message-Id: <20191121005607.274347-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Due to the way feature negotiation works in PAPR (which is a
paravirtualized platform), we can end up changing the global irq chip
at runtime, including it's KVM accelerate model.  That causes
complications for VFIO devices with INTx, which wire themselves up
directly to the KVM irqchip for performance.

This series introduces a new notifier to let VFIO devices (and
anything else that needs to in the future) know about changes to the
master irqchip.  It modifies VFIO to respond to the notifier,
reconnecting itself to the new KVM irqchip as necessary.

In particular this removes a misleading (though not wholly inaccurate)
warning that occurs when using VFIO devices on a pseries machine type
guest.

Open question: should this go into qemu-4.2 or wait until 5.0?  It's
has medium complexity / intrusiveness, but it *is* a bugfix that I
can't see a simpler way to fix.  It's effectively a regression from
qemu-4.0 to qemu-4.1 (because that introduced XIVE support by
default), although not from 4.1 to 4.2.

Changes since RFC:
 * Fixed some incorrect error paths pointed by aw in 3/5
 * 5/5 had some problems previously, but they have been obsoleted by
   other changes merged in the meantime

David Gibson (5):
  kvm: Introduce KVM irqchip change notifier
  vfio/pci: Split vfio_intx_update()
  vfio/pci: Respond to KVM irqchip change notifier
  spapr: Handle irq backend changes with VFIO PCI devices
  spapr: Work around spurious warnings from vfio INTx initialization

 accel/kvm/kvm-all.c    | 18 ++++++++++++
 accel/stubs/kvm-stub.c | 12 ++++++++
 hw/ppc/spapr_irq.c     | 17 +++++++++++-
 hw/vfio/pci.c          | 62 +++++++++++++++++++++++++++---------------
 hw/vfio/pci.h          |  1 +
 include/sysemu/kvm.h   |  5 ++++
 6 files changed, 92 insertions(+), 23 deletions(-)

--=20
2.23.0


