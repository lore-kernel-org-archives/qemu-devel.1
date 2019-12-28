Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5544C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDF820838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZ3JmEQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDF820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLWF-0001aK-LJ
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFw-0005IC-6a
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFv-0007XF-6C
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:24 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFu-0007TO-W0
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:23 -0500
Received: by mail-pg1-x543.google.com with SMTP id r11so16286385pgf.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AQUbSMGriz8m3G7gAjD+hihq1leqiu0aK6HEuqeV1mk=;
 b=tZ3JmEQr/BYenwK6UKlj//RD2Nm3xW1m03v1iQDuDOtKloDT4vGhYyti2Uk3gQZaDj
 734yVM404GJGVxz+HusUH/LU7QLgWfylLtTVofb70VibS1TDAtbLsnwl9EMZamEP5Lga
 ETUacQ9+BSpv520g58AF4bti9sowLLiO8O4ySPjsXuluOSMthnxipW5BG7XbNkfgeXRF
 WaF7zqRaDVLSjZ2+t91TG0p8laWFWf8DNO0dALA+6c5Rmg2kVjFocJmb/ZW7deiEpHFI
 wX2hfkH8+/wNaWYEKAkNysXiyeoKXIgdm1wciqed8v27GIM7q4nCvmaOJmhdO5E0bRvi
 Mgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQUbSMGriz8m3G7gAjD+hihq1leqiu0aK6HEuqeV1mk=;
 b=OYjZ7nH5eTElQqCu17jew+jUANq7+jOWnJbJkwLhqrRRT69y2DVRk5S+UiVk1rKEDu
 /HJpTNurSIpL+6JYLB6jwBCBk++s14CESTzYicZJ2NYBopKVDxpjfI/PabNp965JcmPP
 cw4ZbHLU1eRrxt8lbBZNwFgC6OAYPl04VkfF+Q2Bk/jfANInMiarWGv8HbfuR++gJL3K
 2EzuyFoKqIfzoXlpmuZ84so9fikzGxJDsOUL71LToky/9ThETfQR423Xdnq/yRe90oRW
 WUoSAS3+BymJkLNh0uAqbZU0KGpbv8tEr9L0NMwPXqjpaW+2hv7q6x1Zt0tpsQkm/0pp
 8JIA==
X-Gm-Message-State: APjAAAU7Y5Xwcem0hQ1iReicgE/IrtIsc0JF8a8g8Fwu8CD/kJp1gW+/
 8n6j7eUwVCvgFVK3GTE0M5Vc2r/qbMw=
X-Google-Smtp-Source: APXvYqzo+6/sD3iiixf5J/POGeavB5CT9afGND5e2Uxqrk5l5DvSa1kLF+N8XGGMl0rwuoQHT2soaA==
X-Received: by 2002:a63:6c82:: with SMTP id
 h124mr62496782pgc.328.1577574741794; 
 Sat, 28 Dec 2019 15:12:21 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/29] target/alpha: Remove MMU_MODE{0,1}_SUFFIX
Date: Sun, 29 Dec 2019 10:11:12 +1100
Message-Id: <20191228231124.18307-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index a530249a5b..3f782c0efe 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -193,8 +193,6 @@ enum {
    PALcode cheats and usees the KSEG mapping for its code+data rather than
    physical addresses.  */
 
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_KERNEL_IDX   0
 #define MMU_USER_IDX     1
 #define MMU_PHYS_IDX     2
-- 
2.20.1


