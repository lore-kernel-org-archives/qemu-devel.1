Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5E5C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7380820878
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ol91lT1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7380820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ9Pi-0007aO-OY
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 00:21:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OI-0006JP-G0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OH-0008Lr-9L
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:14 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39565 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJ9OG-0007tS-HS; Wed, 24 Apr 2019 00:20:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44pnCj5N50z9s4Y; Wed, 24 Apr 2019 14:20:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556079601;
	bh=STDMGfFkL5fib/rCnL9SkoN6ej3NDCatisGnW7vlRb0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ol91lT1LMbSKWDaRHT6kg6NKXew4g8NXBu1ldT8g1Dwe0mSzCGmIjJKKtpuk6ko49
	5BbjiGjkpO52mcJPfNLTusIqCJYy85X8ASE4MMBuKhQvkDPOjLPeeHPsMnEFLjP6QP
	XErxJNsnSFLtS+rBnxo5zPboUUdxVafm1/vCDN9w=
From: David Gibson <david@gibson.dropbear.id.au>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, Greg Kurz <groug@kaod.org>
Date: Wed, 24 Apr 2019 14:19:56 +1000
Message-Id: <20190424041959.4087-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v2 0/3] Simplify some not-really-necessary PCI
 bus callbacks
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
Cc: qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424041956.Br_9zxNixYjEtAZMdAKURj-ZCTvNCm8iVcUbT9VpXOI@z>

c2077e2c "pci: Adjust PCI config limit based on bus topology"
introduced checking the availability of extended config space for
PCI-E devices which are in a bus topology that doesn't permit extended
config space access (e.g. under PCI-E to PCI then PCI to PCI-E
bridges).

This caused some problems for the spapr para-virtual PCI bus which
_does_ allow extended config space access, despite acting in most ways
like a vanilla PCI bus.

Greg Kurz made a fix for that which was merged as 1c685a90263 "pci:
Allow PCI bus subtypes to support extended config space accesses".
While that was an appropriate minimal fix for the 4.0 hard freeze, it
was kind of a hack longer term.

This series implements a simpler way of handling the extended config
space permission, which works for both the normal and weird-PAPR
cases.  While we're there, we also make other small cleanups to the
PCI code.

David Gibson (3):
  pcie: Remove redundant test in pcie_mmcfg_data_{read,write}()
  pci: Simplify pci_bus_is_root()
  pcie: Simplify pci_adjust_config_limit()

 hw/pci-bridge/pci_expander_bridge.c |  6 ----
 hw/pci/pci.c                        | 55 +++++++++++++----------------
 hw/pci/pci_host.c                   | 13 ++-----
 hw/pci/pcie_host.c                  | 10 ------
 hw/ppc/spapr_pci.c                  | 34 ++++++------------
 hw/virtio/virtio-pci.c              |  1 +
 include/hw/pci/pci.h                |  2 --
 include/hw/pci/pci_bus.h            | 21 +++++++++--
 8 files changed, 58 insertions(+), 84 deletions(-)

--=20
2.20.1


