Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AFEC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843202073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Jb+yjW7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843202073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVAw-0007LO-Eb
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8s-0005Lu-AO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8r-0005RR-7w
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:56:34 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:62079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8o-0005PN-UN; Wed, 04 Dec 2019 08:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1575467791; x=1607003791;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=ZJTN+ohaJEyJa5Mz38YWX2orkNnDr5ayiRkSEay2Bdo=;
 b=Jb+yjW7WmxhOiBvSEB8HwP8Zi/Wdac+eksxvj7s/Wv5AQO12vILGGXg2
 6cSq1q7qci2B/F0pamc4TDE9FNipZcajTaNOkfIQtvii+XZFNDExseP5h
 FvtmEb5lIs5zy03zaLHW0yw0B3aHJtdR05mqPdqaG4NRe/B4s5WVCm0yM 4=;
IronPort-SDR: xAghjvXNYNirL+e0jZsjnDzVKkEodVBF1T9JaUN3H8Slhdwps/MZLMCnBH+oh0CIHOOs/1woY2
 yi3yNajWEnlg==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="7106992"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 04 Dec 2019 13:56:29 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
 by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS
 id DF7E8A1FAE; Wed,  4 Dec 2019 13:56:27 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xB4DuQXE029431; Wed, 4 Dec 2019 14:56:26 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xB4DuQPZ029429;
 Wed, 4 Dec 2019 14:56:26 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 4/5] hw/arm/smmuv3: Use correct bit positions in EVT_SET_ADDR2
 macro
Date: Wed,  4 Dec 2019 14:55:47 +0100
Message-Id: <1575467748-28898-5-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575467748-28898-1-git-send-email-sveith@amazon.de>
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
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

The bit offsets in the EVT_SET_ADDR2 macro do not match those specified
in the ARM SMMUv3 Architecture Specification. In all events that use
this macro, e.g. F_WALK_EABT, the faulting fetch address or IPA actually
occupies the 32-bit words 6 and 7 in the event record contiguously, with
the upper and lower unused bits clear due to alignment or maximum
supported address bits. How many bits are clear depends on the
individual event type.

Update the macro to write to the correct words in the event record so
that guest drivers can obtain accurate address information on events.

ref. ARM IHI 0070C, sections 7.3.12 through 7.3.16.

Signed-off-by: Simon Veith <sveith@amazon.de>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/arm/smmuv3-internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index d190181..eb275e2 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -461,8 +461,8 @@ typedef struct SMMUEventInfo {
     } while (0)
 #define EVT_SET_ADDR2(x, addr)                            \
     do {                                                  \
-            (x)->word[7] = deposit32((x)->word[7], 3, 29, addr >> 16);   \
-            (x)->word[7] = deposit32((x)->word[7], 0, 16, addr & 0xffff);\
+            (x)->word[7] = (uint32_t)(addr >> 32);        \
+            (x)->word[6] = (uint32_t)(addr & 0xffffffff); \
     } while (0)
 
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
-- 
2.7.4


