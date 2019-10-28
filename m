Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C8BCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3657220873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x32Z0Oap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3657220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6eW-0002am-7M
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uq-0007YS-Pp
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uo-000450-09
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Ul-000440-3C
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id o28so10234317wro.7
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f6wua0jwz8W5xKyTZRCAqxHy+Li/vZosjNJ04IUp3Ds=;
 b=x32Z0OapRr7CzGlJrB1N4NVivMQD2LWZSsu2K5ZKBjnxBH8M6+1n9JJNOiAwLnZ947
 NbisNdJb8cCIN1acp2U1f9JG4FgsqkipSnbp5+xpfDKSRjCR16NU8XKaqLQRY9MPOPTJ
 1ARNKiZTOqqP3fHyCyyUeKvoh65sIaAJ+0C5wt+alcZHsew+maxkEd+NBSVXYCtVps1O
 +K6yFo/IH6r0Iwbpz3bNAf/qt/msWlCqCrUjrbBuYrAbqHkOVvb0lWTEaNRql65bUK4u
 rWABMU1Yc1oqJ+KreLmOZ6yyIwbVMO/7LyB+3k6ogXyvENcTHHsHY+Lk3g5grslAWiIz
 sNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f6wua0jwz8W5xKyTZRCAqxHy+Li/vZosjNJ04IUp3Ds=;
 b=kshAT8+zd3mO9pCIDDL8/CWTMYM3CzOk9eiwC2gbNEbObed+Pb56jbiWCjtoOAWbD3
 +5kM9ySn+qWsrUgvEyr0kHwGkSWxwVi6LtqAOrREFtwRsUApF+aIQO7VaNBKdS5yVI8b
 No1Iv+lOo29RO7iNMdZARp5OwM/YaCTWIu0R/S5wIHrJTTAfPVLnlrfEVsqoWxGJZeF1
 gO/o7SSMvp0XmaUpSigZYtJCnbR6dZ8hvysadmy4OMR861n9KNXLtJtA+7JYHiBevqex
 za+B9krLMlZfHBTTOaGosm8IYMPMzW8JNvDf1c1lUTY5H/VCKVHOyEyUw2KzV9sJaqE/
 jinQ==
X-Gm-Message-State: APjAAAUBrSkG7sXqOX7HVgJy4FOSkkhXVgPa+l8GnpQLE+xtyYc5A6hl
 pXlAwi55jCw1G9viQDf4l2k+FZWfoQSEGQ==
X-Google-Smtp-Source: APXvYqz7D7SFaOToNgLi8IZmC+SWNNqlMmPcseK2+NFUpPp/OHQMordLLYmBG4C2DIdhPUBdWrSSZA==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr14702098wrq.208.1572274785663; 
 Mon, 28 Oct 2019 07:59:45 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/12] exec: Restrict TARGET_PAGE_BITS_VARY assert to
 CONFIG_DEBUG_TCG
Date: Mon, 28 Oct 2019 15:59:32 +0100
Message-Id: <20191028145937.10914-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reduces the size of a release build by about 10k.
Noticably, within the tlb miss helpers.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 0b449b98ba..525059970c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -219,8 +219,12 @@ extern const TargetPageBits target_page;
 #else
 extern TargetPageBits target_page;
 #endif
+#ifdef CONFIG_DEBUG_TCG
 #define TARGET_PAGE_BITS   ({ assert(target_page.decided); target_page.bits; })
 #else
+#define TARGET_PAGE_BITS   target_page.bits
+#endif
+#else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #endif
 
-- 
2.17.1


