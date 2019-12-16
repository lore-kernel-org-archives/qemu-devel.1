Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84311C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511532064B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="eanjws3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511532064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsBT-0007w7-F9
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7I-0003TN-Gj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7H-0001TJ-EQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:17:00 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:41002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7E-0001KS-L7; Mon, 16 Dec 2019 10:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1576509417; x=1608045417;
 h=from:to:cc:subject:date:message-id;
 bh=v4g8z2qawcZIAo36aaIgjbmv/2+FuGBGNZSCoPqMp7I=;
 b=eanjws3FCdaf/iNuJine+az7Yy9gKUfZqfdRSuUx/ltX0HnKBPOvU4A7
 vtE6bqpGHlFmoO/Clwrr7v5bEi3ImrhdqUrm+9v6jC2qQB9+AnkguLpnI
 WoGGNkEm/fIC5A28RcGtT1eo+D5sHKmDTRfbBhnyLyBkbz+z5O3gf9aHx M=;
IronPort-SDR: D9EMSQn3Q0b/DY1KDgHleuWVth9wiiJEcGZ1hxYEYLvZzVt8HsRusqPSGasQHL7JYqUrvyX18f
 30DpgP7HYvzQ==
X-IronPort-AV: E=Sophos;i="5.69,322,1571702400"; 
   d="scan'208";a="5381324"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 16 Dec 2019 15:16:42 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
 by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS
 id 7A5DFA2057; Mon, 16 Dec 2019 15:16:41 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xBGFGcwp013847; Mon, 16 Dec 2019 16:16:39 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xBGFGcei013845;
 Mon, 16 Dec 2019 16:16:38 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>
Subject: [PATCH v3 0/6] hw/arm/smmuv3: Correct stream ID and event address
 handling
Date: Mon, 16 Dec 2019 16:15:06 +0100
Message-Id: <1576509312-13083-1-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 207.171.184.25
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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

While working on the Linux SMMUv3 driver, I noticed a few cases where the QEMU
SMMUv3 behavior relating to stream tables was inconsistent with our hardware.

Also, when debugging those differences, I found that the errors reported through
the QEMU SMMUv3 event queue contained the address fields in an incorrect
position.

These patches correct the QEMU SMMUv3 behavior to match the specification (and
the behavior that I observed in our hardware). Linux guests normally will not
notice these issues, but other SMMUv3 driver implementations might.

Changes in v2:

* New patch "hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value" added
* Updated patch "hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE"
* Updated patch "hw/arm/smmuv3: Align stream table base address to table size"

Changes in v3:

* No changes, but sending again to correct a patch submission mishap that
  confused Patchew

Simon Veith (6):
  hw/arm/smmuv3: Apply address mask to linear strtab base address
  hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value
  hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE
  hw/arm/smmuv3: Align stream table base address to table size
  hw/arm/smmuv3: Use correct bit positions in EVT_SET_ADDR2 macro
  hw/arm/smmuv3: Report F_STE_FETCH fault address in correct word
    position

 hw/arm/smmuv3-internal.h |  6 +++---
 hw/arm/smmuv3.c          | 28 +++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.7.4


