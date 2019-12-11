Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A950FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B15214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="CK45ggbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B15214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3SK-0006BS-Ae
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3RS-0005Ja-Cc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3RR-0001QU-B2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:58:18 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:4022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3RO-0001L7-3G; Wed, 11 Dec 2019 09:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1576076294; x=1607612294;
 h=from:to:cc:subject:date:message-id;
 bh=Asgepvkz4JWY1boo1mZHZcuk6CbY2wol3JthUOrMfrc=;
 b=CK45ggbVoS9RhvKxrj2TftDhpII3QTWdj6dq3DyYrCjYySVm5nqzGUPi
 83crgAwk0dvVVyE8NIKR6YnS6/gN/Qy4ngi7c4BOrugM3RxOnbqEJvjKJ
 VqMHZsiuqgCYKEYepLi7eE6vqk9KAnW/m4QE8B1wKNYgjwhNA3Ze/cyZM 8=;
IronPort-SDR: V1DlAf1kmpv5BVH9Sv5ABk2JDoz0+W1WvkC4TXJo1RTRRkil1GcCiqsh1UGUq622yrq55sd4mW
 307Bmn/QaL+w==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="8041226"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 11 Dec 2019 14:58:12 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
 by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS
 id 8AFCE241D29; Wed, 11 Dec 2019 14:58:10 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xBBEw52u018996; Wed, 11 Dec 2019 15:58:06 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xBBEw4fi018992;
 Wed, 11 Dec 2019 15:58:04 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 0/6] hw/arm/smmuv3: Correct stream ID and event address
 handling
Date: Wed, 11 Dec 2019 15:57:34 +0100
Message-Id: <1576076260-18659-1-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 72.21.198.25
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

Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

-- 
2.7.4


