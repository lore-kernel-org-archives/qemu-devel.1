Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA8C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8116F2087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oAStqL2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8116F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtei-0000YB-Mr
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:32:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVn-0000oA-4W
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVl-0002ho-CX
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVj-0002eC-AI; Tue, 07 May 2019 02:23:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL26D1Cz9sN6; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210202;
	bh=pPDLTn4HhCsXNJrLZlAQvDPs0KX4Isw/JWWhGAXD6GM=;
	h=From:To:Cc:Subject:Date:From;
	b=oAStqL2NBMVNMjZfN0zQ3ZTEshOQQ66AO1Co62aDPQJPEMstsm+yZ77/lyb44VBLR
	662UKjlGOl6RnIjFHud6F1qI17uIoOc/pDP1G9hjg8CLIUIrXE04jsXBD3KT7SwDZo
	XJ9nHTRc5VgDzCmF7whRlz+6j1WpJmgUMX+/j5eo=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Date: Tue,  7 May 2019 16:23:11 +1000
Message-Id: <20190507062316.20916-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v3 0/5] Simplify some not-really-necessary PCI
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Changes since v2:
 * Add some minor additional cleanups (patches 4 & 5)
 * Minor whitespace tweak to patch 3

David Gibson (5):
  pcie: Remove redundant test in pcie_mmcfg_data_{read,write}()
  pci: Simplify pci_bus_is_root()
  pcie: Simplify pci_adjust_config_limit()
  pci: Make is_bridge a bool
  pci: Fold pci_get_bus_devfn() into its sole caller

 hw/pci-bridge/dec.c                 |   4 +-
 hw/pci-bridge/i82801b11.c           |   2 +-
 hw/pci-bridge/pci_bridge_dev.c      |   2 +-
 hw/pci-bridge/pci_expander_bridge.c |   6 --
 hw/pci-bridge/pcie_pci_bridge.c     |   2 +-
 hw/pci-bridge/pcie_root_port.c      |   2 +-
 hw/pci-bridge/simba.c               |   2 +-
 hw/pci-bridge/xio3130_downstream.c  |   2 +-
 hw/pci-bridge/xio3130_upstream.c    |   2 +-
 hw/pci/pci.c                        | 116 +++++++++++++---------------
 hw/pci/pci_host.c                   |  13 +---
 hw/pci/pcie_host.c                  |  10 ---
 hw/ppc/spapr_pci.c                  |  34 +++-----
 hw/virtio/virtio-pci.c              |   1 +
 include/hw/pci/pci.h                |   4 +-
 include/hw/pci/pci_bus.h            |  20 ++++-
 16 files changed, 96 insertions(+), 126 deletions(-)

--=20
2.21.0


