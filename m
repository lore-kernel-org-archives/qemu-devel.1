Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F3DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A3720760
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A3720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq1eu-0000Gc-EY
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1jq1de-0007IW-Ih
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 17:48:30 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1jq1dc-00084s-84
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 17:48:30 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 861E3BF450
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 21:48:26 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] hw/block/nvme: support multiple namespaces
Date: Mon, 29 Jun 2020 23:48:21 +0200
Message-Id: <20200629214825.1283673-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 14:26:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

v2: bummer, v1 didn't apply cleanly to master (it applied to Kevin's
block tree); rebased to make patchew happy


This adds a new 'nvme-ns' device that attaches to the nvme device
through a bus. This decouples the nvme controller and nvme namespaces
such that multiple namespaces may be attached to the controller.

With this in place, we can allocate a fresh pci vendor/device id and get
rid of the Intel id pair that causes the Linux kernel to apply a bunch
of quirks that the device no longer has.

Based-on: <20200629203155.1236860-1-its@irrelevant.dk>
("[PATCH 0/3] hw/block/nvme: support scatter gather lists")

Klaus Jensen (4):
  hw/block/nvme: refactor identify active namespace id list
  hw/block/nvme: support multiple namespaces
  pci: allocate pci id for nvme
  hw/block/nvme: change controller pci id

 MAINTAINERS            |   1 +
 docs/specs/nvme.txt    |  23 ++++
 docs/specs/pci-ids.txt |   1 +
 hw/block/Makefile.objs |   2 +-
 hw/block/nvme-ns.c     | 172 ++++++++++++++++++++++++++
 hw/block/nvme-ns.h     |  66 ++++++++++
 hw/block/nvme.c        | 273 +++++++++++++++++++++++++++--------------
 hw/block/nvme.h        |  45 +++----
 hw/block/trace-events  |   8 +-
 hw/core/machine.c      |   1 +
 include/hw/pci/pci.h   |   1 +
 11 files changed, 472 insertions(+), 121 deletions(-)
 create mode 100644 docs/specs/nvme.txt
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

-- 
2.27.0


