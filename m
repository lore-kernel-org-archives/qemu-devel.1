Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6542C2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9403721D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgGbRcOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9403721D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJLY-0005RX-3M
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF9-0004xc-Vv
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF8-0007ZW-GB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:03 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJF8-0007Rj-6B
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id q9so9139266wmj.5
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Lo7PUw1ERbHRyrus/NtQMRXglB5e3q+im5wQRdibHpo=;
 b=jgGbRcOUMiW7l8/UU/fw/TiMf/wyeqYA6yPJmKQLMpmauK3e0oWWa4ppOFgDKh7bZ5
 V3rzZbYmD9474kGA2YQzRebe9pEEiWTiXRrSYwKdn8y7Z9kzB+b7FgdIHHXzqWeE41Py
 bb7oGXddS6bp/UOMXxpl1vhmM0mBzKXuesfZDNVXIpkakQ3jfxYxdOQRPGUzI4+gyIGA
 iqzim2Q/iT4zj1YAyAgE+CNkWOgPNiV7miKRTShDbN1j7QdZ3E10lkH7cwVSzhfQOsVv
 bYi9WYyQ4d5ZIjjxY54D9HoQRWcbYDRLxsGAsYY8SPZ9PLI8IH14TKxSBZUg7eEPGqCj
 9jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lo7PUw1ERbHRyrus/NtQMRXglB5e3q+im5wQRdibHpo=;
 b=evuFTFVsAE8kYRLkvdz4zUagByVUWP6Ug8mC6vrMPf2iACUymUX1qtWaqTMgPbvUCu
 jUpA3wj/0hP8mUFNuRtSyJ8a2UMKbkugfNaaRwST0/elCX/lqACbFTCaH9UBCJExWUSS
 lC5aBeSqEx2ndTJttPdSqXqAydsrX2BtfGxcs+/ffZBu+ATziUuB+y1QyEYJUJi1Nq/5
 Sk18S7E6GjpZgfavOBQm7iSW5d/C8Ene1Mvq5jMMangJcIpQIHuaez/UEUmth9ZG9Hi2
 BDFotra7exb2la6+0kmuhRL4q5Ser1RWMMwwrqanDrFrhULNTRfJTGW49kzKDtCZwFQE
 DvXQ==
X-Gm-Message-State: APjAAAU//HeBp43/5Vf/Lo/cfoDLdoG4WVuP9hdogK4pwJtAjgBb/pBG
 /TXlD0YHsqUcD7Ra6UoWAUXc1IUlo1YDtg==
X-Google-Smtp-Source: APXvYqy3PVMRLCOdt8JGn+/z7DMPTiFGVV+UzXPIL3JmX10hrxH7l9ly0XRoaUmEMq1B2P9SAlOSrA==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr15737180wme.121.1576852019796; 
 Fri, 20 Dec 2019 06:26:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] hw/arm/smmuv3: Use correct bit positions in
 EVT_SET_ADDR2 macro
Date: Fri, 20 Dec 2019 14:26:41 +0000
Message-Id: <20191220142644.31076-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

From: Simon Veith <sveith@amazon.de>

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
Acked-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1576509312-13083-6-git-send-email-sveith@amazon.de
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Acked-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 042b4358084..4112394129e 100644
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
2.20.1


