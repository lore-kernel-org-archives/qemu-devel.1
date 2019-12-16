Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E345C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D044A206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="DdQXvSKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D044A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsBn-0008KI-W2
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7f-0003uA-7o
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7e-0001zs-5g
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:17:23 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:28350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7b-0001l9-Tf; Mon, 16 Dec 2019 10:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1576509440; x=1608045440;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=Z0g33k0fJJlh3np7I7IZdcyVyzV2EJT6J7A5HaBP1Jc=;
 b=DdQXvSKhl1V1Io4wkW879gc70VYua6X1AQQX1wvqDzEzaUxgvBtCcym2
 +pVKbLx7DUeH78UH38X6XNNjkrB28HAbMlJmgYROPCqnkB9eV3BQBQ/i7
 7bfY/5089iyGEjLfgBifrb2h5uOCUZ9Og0WHcGm9uyrztUEqZsckaEgSf I=;
IronPort-SDR: fw3ADRrLN+ng2QTpfC/KOk7ikWLls4Hna//RYlheOYRyO2E025gTqCHfcvS2suqr9aiNJiFeDx
 nUvjaVQR7u+g==
X-IronPort-AV: E=Sophos;i="5.69,322,1571702400"; 
   d="scan'208";a="9275773"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 16 Dec 2019 15:17:20 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
 by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS
 id 3CCE3A2197; Mon, 16 Dec 2019 15:17:18 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xBGFHGdw014168; Mon, 16 Dec 2019 16:17:16 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xBGFHFLS014143;
 Mon, 16 Dec 2019 16:17:15 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v3 6/6] hw/arm/smmuv3: Report F_STE_FETCH fault address in
 correct word position
Date: Mon, 16 Dec 2019 16:15:12 +0100
Message-Id: <1576509312-13083-7-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576509312-13083-1-git-send-email-sveith@amazon.de>
References: <1576509312-13083-1-git-send-email-sveith@amazon.de>
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 52.95.48.154
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

The smmuv3_record_event() function that generates the F_STE_FETCH error
uses the EVT_SET_ADDR macro to record the fetch address, placing it in
32-bit words 4 and 5.

The correct position for this address is in words 6 and 7, per the
SMMUv3 Architecture Specification.

Update the function to use the EVT_SET_ADDR2 macro instead, which is the
macro intended for writing to these words.

ref. ARM IHI 0070C, section 7.3.4.

Signed-off-by: Simon Veith <sveith@amazon.de>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Acked-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 31ac3ca..8b5f157 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -172,7 +172,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     case SMMU_EVT_F_STE_FETCH:
         EVT_SET_SSID(&evt, info->u.f_ste_fetch.ssid);
         EVT_SET_SSV(&evt,  info->u.f_ste_fetch.ssv);
-        EVT_SET_ADDR(&evt, info->u.f_ste_fetch.addr);
+        EVT_SET_ADDR2(&evt, info->u.f_ste_fetch.addr);
         break;
     case SMMU_EVT_C_BAD_STE:
         EVT_SET_SSID(&evt, info->u.c_bad_ste.ssid);
-- 
2.7.4


