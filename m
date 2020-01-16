Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C8C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E40C2072B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHbB57yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E40C2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isESA-0004t6-9Y
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 18:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFV-0002fa-IK
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFU-000834-2y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:25 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isEFT-00081v-SC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:24 -0500
Received: by mail-pj1-x1043.google.com with SMTP id n96so2277576pjc.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 15:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Jxac41ScZ9wklqoaoJ1ujuvSIgK3pa8BvU4q8iE/qg=;
 b=DHbB57ykUvSpDmrZzJBQzelX/Q4mRPA0rkl9wlyr6Dbbn5Swd19bcjKOcquJO5bwMi
 EWZi4us5RfWM3PNg4C5hgS8l2j9x2LESi0HfNVIIDpzfaiqbEpGL+U6rCwH8DZ8LZhhZ
 VCkvemRaQd93b80ZS/f31nSZdwYb3OULptLLd4Zy/UEzNuc9/3olXCAsAT/Ghy3Y1+ek
 vjEcSxFYnbqRCMuTNMsQRUlL/vL4QDnGpsDJVN6G2tX4G6aVofuwWy4oVjq2Ev8exb5W
 yhyVXUdWLidb55BEf28JV/XMXYcp6YlufYxCWI6Gm9Y7aBpanha0hRxHgaa4gdmsKY48
 ieCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Jxac41ScZ9wklqoaoJ1ujuvSIgK3pa8BvU4q8iE/qg=;
 b=VPdo7bmUsFQutVKVE+ZjFH7gTX9jal81i7dMmJexyCMy9lTY/gjORarYOBxHtXhGd7
 LaNH3yNZCWQdFcqACon9GE7tjoXbu7iLVqFYKLNpvBC4l89VMJrvwWcppJ2aP3Cug46i
 PA14GiKYIrWn8dZlt6eGJ9qlomdNbUfPbyTku6qimut3yjME/Oo4u6i9YNSSpRncXAdG
 om89lLb57HbJKJCa3yBEIIql4hs+chqK2lxMzYYqHOtFkpd1TvtMbUdCzQYMML9ixPO9
 zXOmLMea+jWxBOSd+5qnJ5gWGYRPAHM+sJskoi/UzpDHoT9l5L9N2cSNtFg8HvZxWfO7
 O39g==
X-Gm-Message-State: APjAAAVQ6k4I29/CGyXKsJngaIC6X53u6Z99Bw92SeYVju+6tUQa/4yw
 IIIpgSHvAE4g99q9YLkB/SxQ04AUX5c=
X-Google-Smtp-Source: APXvYqxenawD/zo7RWmeGAEuzpcNrQDUOQTMILLR2z+Zg/h+GrnMY0AumNfnwgJahG6Kt1f6i8aIcw==
X-Received: by 2002:a17:90a:950b:: with SMTP id
 t11mr1987656pjo.79.1579216099560; 
 Thu, 16 Jan 2020 15:08:19 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id s7sm5111578pjk.22.2020.01.16.15.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 15:08:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] target/arm: Fix PAuth sbox functions
Date: Thu, 16 Jan 2020 13:08:06 -1000
Message-Id: <20200116230809.19078-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116230809.19078-1-richard.henderson@linaro.org>
References: <20200116230809.19078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: peter.maydell@linaro.org, vincent.dehors@smile.fr, alex.bennee@linaro.org,
 adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vincent Dehors <vincent.dehors@smile.fr>

In the PAC computation, sbox was applied over wrong bits.
As this is a 4-bit sbox, bit index should be incremented by 4 instead of 16.

Test vector from QARMA paper (https://eprint.iacr.org/2016/444.pdf) was
used to verify one computation of the pauth_computepac() function which
uses sbox2.

Launchpad: https://bugs.launchpad.net/bugs/1859713
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Vincent DEHORS <vincent.dehors@smile.fr>
Signed-off-by: Adrien GRASSEIN <adrien.grassein@smile.fr>
---
 target/arm/pauth_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index d3194f2043..0a5f41e10c 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -89,7 +89,7 @@ static uint64_t pac_sub(uint64_t i)
     uint64_t o = 0;
     int b;
 
-    for (b = 0; b < 64; b += 16) {
+    for (b = 0; b < 64; b += 4) {
         o |= (uint64_t)sub[(i >> b) & 0xf] << b;
     }
     return o;
@@ -104,7 +104,7 @@ static uint64_t pac_inv_sub(uint64_t i)
     uint64_t o = 0;
     int b;
 
-    for (b = 0; b < 64; b += 16) {
+    for (b = 0; b < 64; b += 4) {
         o |= (uint64_t)inv_sub[(i >> b) & 0xf] << b;
     }
     return o;
-- 
2.20.1


