Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30AACA9EB7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AED52173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlbSIzeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AED52173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIWr-0003e5-DC
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-00086C-Vf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8q-0001EG-Ul
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8q-0001BV-N4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:40 -0400
Received: by mail-qk1-x743.google.com with SMTP id w2so20045124qkf.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EixSCP/+s4Pul7ok7q0wZeyo8cfwDyotG9VjfWeZAIo=;
 b=GlbSIzeRKSN/EHYUAeDY7EnT8G2ux3tThi7Ui+TJAxomVtmu7TRpeE52UIwqz4aDcr
 469KLYqwpj3BoNTWyfywn0cHwFt2SvViu15RU8ayL4i6KJFRtaYiSYQ7mcfogCzpUvib
 mqLFyGotWK4wklkSCUEsjMaZrOHoVtDra4ZGUgNlGDlEcaby9FsVA2xW+59FE5styI/P
 zWbuM5dF8JWYSZB/zblE3Xv6jBFhcYBXSJlof+R3eRHVXDg1Qrdujt4kxm6p8TJnGYqy
 eIj87hd1XxUL0hlnclvAi6A/WPrYaQofwKUnX7BpJP0e/ViK6xWdYhe6J2ZMEe75oBel
 2ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EixSCP/+s4Pul7ok7q0wZeyo8cfwDyotG9VjfWeZAIo=;
 b=VFsQ3QhxGSJEZF8yHZLtvAJMSbWC5yk3tOYH64l8KMYARLurDyI8uJ5sT6C+stzESd
 l3Y3MQ0eiecxh00/48arl20qYphm8RlHKGcCLZjB4K8Dwf0tDchz9IWNUxZO332tKbdR
 35/TAfdMayvwJ2/i+I4Mre1a41fYnixtSEtVA5qaxoWvG0/kdjp/7QnnDmKjx8yKTRQQ
 AfZ5i7BJxf/mzTlw6mm6bwFkO4zR+Kst0NV2piFmLS0AXUa7h+RkrAPDUoSKCWtJiDdM
 8JFYT3+pIzZuQtWdw0DcuGT1Suej46PXod2hykZvLWZshr2WEXg6WiLV8L9zJbxVklo/
 3Ejg==
X-Gm-Message-State: APjAAAWtnfjbTttfOLV3r5yysaqy9maQm4hz2EKCI2RYulGmJtqFXO1Q
 4ReCa45NF0bdqzJK7LzB6XV61bxkgVA=
X-Google-Smtp-Source: APXvYqwQmtF6+GgcY9RhEJtB9xJKxvUKmTqvnBhoo8B/iDW8C87j/k22/3iAmix5iRLok56JmNLn2w==
X-Received: by 2002:a37:6554:: with SMTP id z81mr3910082qkb.9.1571842893582;
 Wed, 23 Oct 2019 08:01:33 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 23/24] linux-user/arm: Rebuild hflags for
 TARGET_WORDS_BIGENDIAN
Date: Wed, 23 Oct 2019 11:00:56 -0400
Message-Id: <20191023150057.25731-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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

Continue setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index e28c45cd4a..7be4071751 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -440,6 +440,7 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     } else {
         env->cp15.sctlr_el[1] |= SCTLR_B;
     }
+    arm_rebuild_hflags(env);
 #endif
 
     ts->stack_base = info->start_stack;
-- 
2.17.1


