Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F802C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C77F222C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="gTi1E7VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C77F222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3aB-0001cM-AA
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3ZH-0000hj-Br
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3ZG-00020y-9i
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:06:23 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3ZE-0001vm-3L; Wed, 11 Dec 2019 10:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1576076780; x=1607612780;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=mVMZNzfGgCZy2rnEt7SIpbodq72YKWuf3Om7HpAHf2g=;
 b=gTi1E7VRURq/8F+m3ObZxnpdUDHC2/IfhGJ5AoFwdjT0IPcAMfN/Egxr
 qO9XG7oNgAEC+4qkurtVIE9nptg8FwY/R5mpJKyMl+BffRoaQ+x+lXTxh
 EwCxXcfgfITGMmyKXK0i6tXN9+RcNVm2U3wNK42U59XEqLiqEYQyVDetl M=;
IronPort-SDR: p7UU1YkJwIQ3WP4vdsajOaU54IkE1Csl31l9DnNCzg2gx+MXCq9C6N9DoLk3l3ixomBy+QJ6c8
 61zJL+IGrd6w==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="8108820"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 11 Dec 2019 15:06:18 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
 by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS
 id 1FFECA25EA; Wed, 11 Dec 2019 15:06:15 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xBBF6Ce7024283; Wed, 11 Dec 2019 16:06:12 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xBBF6B5B024260;
 Wed, 11 Dec 2019 16:06:11 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 2/6] hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value
Date: Wed, 11 Dec 2019 16:05:39 +0100
Message-Id: <1576076739-23708-1-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576076260-18659-1-git-send-email-sveith@amazon.de>
References: <1576076260-18659-1-git-send-email-sveith@amazon.de>
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 72.21.196.25
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

There are two issues with the current value of SMMU_BASE_ADDR_MASK:

- At the lower end, we are clearing bits [4:0]. Per the SMMUv3 spec,
  we should also be treating bit 5 as zero in the base address.
- At the upper end, we are clearing bits [63:48]. Per the SMMUv3 spec,
  only bits [63:52] must be explicitly treated as zero.

Update the SMMU_BASE_ADDR_MASK value to mask out bits [63:52] and [5:0].

ref. ARM IHI 0070C, section 6.3.23.

Signed-off-by: Simon Veith <sveith@amazon.de>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/arm/smmuv3-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index d190181..042b435 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -99,7 +99,7 @@ REG32(GERROR_IRQ_CFG2, 0x74)
 
 #define A_STRTAB_BASE      0x80 /* 64b */
 
-#define SMMU_BASE_ADDR_MASK 0xffffffffffe0
+#define SMMU_BASE_ADDR_MASK 0xfffffffffffc0
 
 REG32(STRTAB_BASE_CFG,     0x88)
     FIELD(STRTAB_BASE_CFG, FMT,      16, 2)
-- 
2.7.4


