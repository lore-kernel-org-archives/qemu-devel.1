Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C3CC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2B62074A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="vO/ejEia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2B62074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECaw-0004DM-Cc
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECZx-0002Pm-BC; Fri, 04 Sep 2020 10:20:38 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECZu-0002gK-Q6; Fri, 04 Sep 2020 10:20:36 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 9CA36BF7D3;
 Fri,  4 Sep 2020 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229231;
 bh=sg8j1Lw4RkDyoHhHij7ZJKJB71sOgqsXaCMoO5jFpuE=;
 h=From:To:Cc:Subject:Date:From;
 b=vO/ejEiaKgmXt3LHV1RsuW+y4RIc1Tc4pJCBN1k5YhFxpJfRQPpyc8M7zuWmauwLX
 v8prygYA/MRBw72zShPK/60zlbpC+XxCuxrX9suKFrwTIA139oDZjMr1Hun4EZ9o5T
 meKPAm5eBrtTMBZey28uXXXWvA3TDkIpB1OkggvO15RjJ7DjNu5NupM+XYuGrkj4po
 13EEdgUS7OdCGm2VvC1zJ8TihEy/cdyu7LkqU7U8kL28X8llAZB85SUm0ml4Pv0XWD
 I3lIy9sApmmhosPNSU5IMCUq5LbDVpnFaNn79V8JxrdmBAX0k7QuPgXEKPPT34EPMv
 aQAKS+oAyIHJA==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/17] hw/block/nvme: multiple namespaces support
Date: Fri,  4 Sep 2020 16:19:39 +0200
Message-Id: <20200904141956.576630-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

This is the next round of my patches for the nvme device.=0D
=0D
This includes a bit of cleanup and three new features:=0D
=0D
  * refactored aio submission=0D
    This also adds support for multiple parallel AIOs per request which is =
in=0D
    preparation for DULBE, ZNS and metadata support. If it is found=0D
    controversial, it can easily be dropped from this series.=0D
=0D
  * support for scatter/gather lists=0D
=0D
  * multiple namespaces support through a new nvme-ns device=0D
=0D
Finally, the series ends with changing the PCI vendor and device ID to get =
rid=0D
of the internal Intel id and as a side-effect get rid of some Linux kernel=
=0D
quirks that no longer applies.=0D
=0D
"pci: pass along the return value of dma_memory_rw" has already been posted=
 by=0D
Philippe in another series, but since it is not applied yet, I am including=
 it=0D
here.=0D
=0D
Gollu Appalanaidu (1):=0D
  hw/block/nvme: add support for sgl bit bucket descriptor=0D
=0D
Klaus Jensen (16):=0D
  pci: pass along the return value of dma_memory_rw=0D
  hw/block/nvme: handle dma errors=0D
  hw/block/nvme: commonize nvme_rw error handling=0D
  hw/block/nvme: alignment style fixes=0D
  hw/block/nvme: add a lba to bytes helper=0D
  hw/block/nvme: fix endian conversion=0D
  hw/block/nvme: add symbolic command name to trace events=0D
  hw/block/nvme: refactor aio submission=0D
  hw/block/nvme: default request status to success=0D
  hw/block/nvme: support multiple parallel aios per request=0D
  hw/block/nvme: harden cmb access=0D
  hw/block/nvme: add support for scatter gather lists=0D
  hw/block/nvme: refactor identify active namespace id list=0D
  hw/block/nvme: support multiple namespaces=0D
  pci: allocate pci id for nvme=0D
  hw/block/nvme: change controller pci id=0D
=0D
 MAINTAINERS            |   1 +=0D
 docs/specs/nvme.txt    |  23 +=0D
 docs/specs/pci-ids.txt |   1 +=0D
 hw/block/meson.build   |   2 +-=0D
 hw/block/nvme-ns.c     | 185 +++++++++=0D
 hw/block/nvme-ns.h     |  74 ++++=0D
 hw/block/nvme.c        | 923 +++++++++++++++++++++++++++++++----------=0D
 hw/block/nvme.h        | 126 +++++-=0D
 hw/block/trace-events  |  21 +-=0D
 hw/core/machine.c      |   1 +=0D
 include/block/nvme.h   |   8 +-=0D
 include/hw/pci/pci.h   |   4 +-=0D
 12 files changed, 1108 insertions(+), 261 deletions(-)=0D
 create mode 100644 docs/specs/nvme.txt=0D
 create mode 100644 hw/block/nvme-ns.c=0D
 create mode 100644 hw/block/nvme-ns.h=0D
=0D
-- =0D
2.28.0=0D
=0D

