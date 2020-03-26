Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9AAC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 10:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F312070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQQDaNvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F312070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQ9l-0000K6-EX
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 06:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHQ97-0008HL-2d
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 06:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHQ95-00082Q-MF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 06:53:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHQ95-00081y-GX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 06:53:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id a25so7208846wrd.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DVJOfw7eQi6NV3rlU7rRKdmfQ7n+eT2ZHzUHZHDEz8Q=;
 b=BQQDaNvIyCBovGlXf8NnL7xZrygmWPkqhj/HnqijrUiN3n7ToWQN/tic6kW3QCdPPN
 pJ+up30CDjXOT3b6bZdyjMyg0KPQ/u4Tea1/WL7yzt3z2FVEQOOJilzK8J1dCgXSPAhx
 CkGb5muw2POvK3vK47d+2UZlXipk/eb0XaRZsyPrqK0/K1Y/2XyQeBKFeJnEroUw6UNK
 FR4AaytsOIJir4A07K7FtRdyFJ+2KmnA5tUyHXuOVOXTSFxGo/1Xp9YAQvYGK8qvdWHO
 o16N3k+H2gaR17cyzOQEbLoLbZCjH0D4jWbR9EdWR+poTsWGbDUqdhaQXmVM1MbLZ2t9
 veNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DVJOfw7eQi6NV3rlU7rRKdmfQ7n+eT2ZHzUHZHDEz8Q=;
 b=jhz/6Id/oihsQ1U9ThZqlpVQ1/A4skgg8GNYl8PJ4e7LhzsEV+lFGz82gj6P/8QU2Q
 OxFXFesMmG+CCts0J0n91zwIO3MVeiAapk188fR385tZo9EoYo+oyPHaZBU8PNjb6SXB
 JWkG/93klZjsxAG4F/I9TlsigB32ItyrKOcoK/zHDVAziTYE/69JIMwvbEu107tJ3Brz
 W+OnM5Kpsa646kmliWmd1vnXMIgWqRfqQiReEKrQxSifUd+XKLYhfHJ7dX7MdnQtZAdq
 93pzqU2hlDAPs33mVx8R2jKRMeK6FJDZekwKHhxNzsPC8fV9VQUxIlV0iCt8e0nNwjsI
 WS3Q==
X-Gm-Message-State: ANhLgQ3BpFvg+tLw7ErlugJnR/Hd8FuTnsji1/31ow2F2ccFV1O6V+El
 2UC4k+ww7StU4QCwrI8ZrnRa8RT2pTktKA==
X-Google-Smtp-Source: ADFU+vvrALYNzcs+Q/9UFUtGoriXmkjHM7WJS7DGWxRwKabpNTItg4MSVo4q253hjIttgvdGwhhReg==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr8505034wre.167.1585220033489; 
 Thu, 26 Mar 2020 03:53:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m19sm3019626wml.48.2020.03.26.03.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 03:53:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] hw/i386/amd_iommu.c: Fix corruption of log events
 passed to guest
Date: Thu, 26 Mar 2020 10:53:49 +0000
Message-Id: <20200326105349.24588-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the function amdvi_log_event(), we write an event log buffer
entry into guest ram, whose contents are passed to the function
via the "uint64_t *evt" argument. Unfortunately, a spurious
'&' in the call to dma_memory_write() meant that instead of
writing the event to the guest we would write the literal value
of the pointer, plus whatever was in the following 8 bytes
on the stack. This error was spotted by Coverity.

Fix the bug by removing the '&'.

Fixes: CID 1421945
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: only tested with 'make check' and 'make check-acceptance'
which probably don't exercise this corner of the code.
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index b1175e52c7d..fd75cae0243 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -181,7 +181,7 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
     }
 
     if (dma_memory_write(&address_space_memory, s->evtlog + s->evtlog_tail,
-        &evt, AMDVI_EVENT_LEN)) {
+                         evt, AMDVI_EVENT_LEN)) {
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
 
-- 
2.20.1


