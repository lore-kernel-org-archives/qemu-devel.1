Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E636FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E7A22B48
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Crrzdt8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E7A22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3ci-0004ZW-FW
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3bQ-0003GY-R8
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3bP-0004Wi-PF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:08:36 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3bN-0004QZ-90; Wed, 11 Dec 2019 10:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1576076913; x=1607612913;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=WqDn93kShKzHI1eWGSSDUcj9wy6ytrLQeVu/AxoQ7gg=;
 b=Crrzdt8ZbW1AJO1G2HcNdbaPOIj1Yzh3QaxTRXbzZUmQIB6+M3GQArVx
 XT44q4iYp16rWQI8miBs/cGSxaVEqciaTEhGXne6Qp3MjWP44xPddsyDj
 Z4Irmj0cm20Ums251MtrlfQOWkbQvxPFcGjqwtrgqcmSYq4JqKLZdLlyC U=;
IronPort-SDR: mOCpLXf60icE7BSEfGXJJ697iu//uRSEzthC8HlKYNWaoBpS6qdcpJkYriiQ7sqYj5lt8PMg6U
 zPqzFN+4GLIA==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="4517821"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 11 Dec 2019 15:08:10 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
 by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS
 id 1922EA265D; Wed, 11 Dec 2019 15:08:08 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xBBF86aj025050; Wed, 11 Dec 2019 16:08:06 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xBBF85m7025048;
 Wed, 11 Dec 2019 16:08:05 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 5/6] hw/arm/smmuv3: Use correct bit positions in
 EVT_SET_ADDR2 macro
Date: Wed, 11 Dec 2019 16:07:39 +0100
Message-Id: <1576076860-24820-3-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576076860-24820-1-git-send-email-sveith@amazon.de>
References: <1576076260-18659-1-git-send-email-sveith@amazon.de>
 <1576076860-24820-1-git-send-email-sveith@amazon.de>
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
Acked-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3-internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 0910e7c..994481d 100644
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


