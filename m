Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41D6C46470
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EBD26076
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NngbI4Kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EBD26076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWDnx-0007jB-HW
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 01:40:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWDm0-0006Xr-EX
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWDlz-000495-FP
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:38:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56369 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hWDlz-00046j-2y; Thu, 30 May 2019 01:38:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DxFl07DQz9s4V; Thu, 30 May 2019 15:38:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559194715;
	bh=PX7L6psk9bxpQ3H09igMIsL59XmwW7RGiPJ/e6qp8EQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NngbI4Kn12EJFzjHBxoaOEU1ZbCjgDV7wf44+hoXsrk+XlSX0Q3HtH9ZscMKBE071
	8ILqFl2golqOq55aZJ0S+2e0hUT2oVLHo2rzli81XTBuo9DknjVY35R5IWfOY+dPUz
	aPGSH7Rwfrtr/7UktVqTyiYX17Kw/uI2nHiIPbhc=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Date: Thu, 30 May 2019 15:38:23 +1000
Message-Id: <20190530053831.22115-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH v2 0/8] pseries: Allow hotplug of P2P bridges
 and devices under P2P bridges
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mdroth@linux.ibm.com, mst@redhat.com, groug@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PAPR has its own PCI hotplug mechanism which we implemented quite a
while ago.  However, we weren't able to hotplug devices under PCI
bridges, because the pci-bridge code would try to handle the hotplug
using SHPC which won't work with PAPR.

We now have the infrastructure in the hotplug core to have the machine
take control of the hotplug before the bus tries to claim it, which
lets us address this.  While we're about it, make a bunch of cleanups
and also allow hot plug of P2P bridges themselves (this turns out to
be quite straightforward once the rest is in place).

For now, we don't support hot unplug of bridges - this seems to cause
problems, at least for a Linux guest.  I suspect the problem is on the
guest side, but for now just prohibit until we have time to
investigate properly.

Changes since v1:
 * Added proper cover letter
 * Addressed some minor comments

David Gibson (8):
  spapr: Clean up device node name generation for PCI devices
  spapr: Clean up device tree construction for PCI devices
  spapr: Clean up dt creation for PCI buses
  spapr: Clean up spapr_drc_populate_dt()
  spapr: Clean up DRC index construction
  spapr: Don't use bus number for building DRC ids
  spapr: Direct all PCI hotplug to host bridge, rather than P2P bridge
  spapr: Allow hot plug/unplug of PCI bridges and devices under PCI
    bridges

 hw/ppc/spapr.c              |  25 +-
 hw/ppc/spapr_drc.c          |  13 +-
 hw/ppc/spapr_pci.c          | 486 ++++++++++++++++++++++--------------
 include/hw/pci-host/spapr.h |   4 +-
 include/hw/ppc/spapr_drc.h  |   3 +-
 5 files changed, 327 insertions(+), 204 deletions(-)

--=20
2.21.0


