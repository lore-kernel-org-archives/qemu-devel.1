Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F8C76199
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BE520726
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxe7iddO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BE520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Pqw-0005jz-95
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpU-0003cB-Qs
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3PpT-0005Vz-UO
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:48 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3PpT-0005UY-PS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:47 -0500
Received: by mail-pg1-x541.google.com with SMTP id z7so7889861pgk.7
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o5rb+tTqydiafB3qvUsAq8/vvIee2NCXymu3BNnsCeA=;
 b=cxe7iddOrSkEDv3h8Adzge4QnP2tHnoLUREsspOnGULi2hA4rvwPhdK2yVcFNtYIAM
 2UFCIxdfJOtv6rV07IukYdTNXgbJY6azbMleoBwlHGNlBu1HE+I62wWGTqywFJU/nIhD
 l9CekVxC8I3WDeRZurSNdg2ehK1Bz9AWo3KETOMwiht4fVORzmfEIYBklsLuRK4IRv4S
 uwkHw+Pbt6yGEpw7VFNcfwpaybtKiagOqXHqpGPZgzN4eIz1b/4ow9P0WXKJss7zbvW3
 at4dZbpYmk+FMbcBAU9WyqdPmOWiFWU/YoeYQKypar3JTcLQEYu/kAWBuvTRtXSuZelt
 r1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o5rb+tTqydiafB3qvUsAq8/vvIee2NCXymu3BNnsCeA=;
 b=eAMprY6Qp9EhRMDketksJMsuzRRiZb1sNEIBOrOXeWotqDAkQ1CbNO5PhkXxt3z1vb
 U8gOtYErp4xKnmUJLAfHtnUSiMavATnpm4cZ/Ng5kDInx23LYF0bINBmE7FkBjoZrHXm
 +aRRPhncRgFdFG2Q3fKKX7kI6x43ysTReXGqvC/8rTyQko94/8IJ+kIO1WdxmDtNllqN
 HyJWI31QatQM4jlmkQfS1J6Eecm9+DtdP0xrkDMGSe1yanRHzwcKUymPXwUIzl11L4MM
 5qUVzEq5ObOvkdQxijIMCqMaUtLSZ7Ac7VhGfuOPdigzA5xPz9IfRTXJSQbj2TAZkQq1
 gbxQ==
X-Gm-Message-State: APjAAAVvSvBnFLvbkRPzJEhSnj2iJd6q4zin7EyNSzWzFY//yen/k305
 W1d3760itURH7eILmwtglOIZX2HW178=
X-Google-Smtp-Source: APXvYqxEYXOVmMCGixRNMYX/kud1YkejubOHZqysEUSexJ2d9DEe9HdhOWQYdpkhc+WPHfQL4f7Hog==
X-Received: by 2002:a63:306:: with SMTP id 6mr14143415pgd.337.1581882226497;
 Sun, 16 Feb 2020 11:43:46 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y127sm13945188pfg.22.2020.02.16.11.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 11:43:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] target/arm: Use bit 55 explicitly for pauth
Date: Sun, 16 Feb 2020 11:43:40 -0800
Message-Id: <20200216194343.21331-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216194343.21331-1-richard.henderson@linaro.org>
References: <20200216194343.21331-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The psuedocode in aarch64/functions/pac/auth/Auth and
aarch64/functions/pac/strip/Strip always uses bit 55 for
extfield and do not consider if the current regime has 2 ranges.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 9746e32bf8..b909630317 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -320,7 +320,8 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
 
 static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
 {
-    uint64_t extfield = -param.select;
+    /* Note that bit 55 is used whether or not the regime has 2 ranges. */
+    uint64_t extfield = sextract64(ptr, 55, 1);
     int bot_pac_bit = 64 - param.tsz;
     int top_pac_bit = 64 - 8 * param.tbi;
 
-- 
2.20.1


