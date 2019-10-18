Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE19CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D814E21D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI0rWgGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D814E21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWag-0000Ds-5Q
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJ9-0006rE-3c
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJ7-0005dw-Vz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:58 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWJ7-0005dQ-Qz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id e13so3750371pga.7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4z2zPWedOviyKqg3qmIWn8g3R8jv2yS1u67ka41eHWc=;
 b=nI0rWgGQzrA9U6zEdQj3b1jl+SAttb9L65Ev0KMFewggAH/JgNkTbBgKH5FUFPaVUk
 yT77aBDq1capTDD5XBJ0kHvzCdLzW6UtviyBLhNXknkCHDTIdwRE8n4wPP/ipPvq42lN
 huTPPuL9IbYNLT2RuvJF2FZm+rZf1BQUIvcsqi+l1ne7UiawUsAaimf2vg27SEVhGf2Y
 +wu4VSTc9ZZovdt++QjjrMcI3FwGjhB9l1KOmwFPGGedB55xqNd0bG3gyY2o/8br/beF
 RsaaHHn7Symv/XgyQANNCF1A4200J3lPZGuMZYYgVaGIvAb3DJl4GBKNwIs0/ZH65EE3
 JFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4z2zPWedOviyKqg3qmIWn8g3R8jv2yS1u67ka41eHWc=;
 b=isAgvnkhVpwRsNGRp77zdYWxQG5oaGtr0p0zrWzJ+9jOLtF9EwXC6Xo56SFZFZxUKj
 53Q31mTPcqkxA8zkYNDcBhtomBDUiWJs2nggl1zMy977UYKB+KPfIAncrLjZ60kXePbt
 h9e4WHoubPL/rf3N6xN2RpZYB8tJZovuedxngDUlv6mVUjo8phX8oItCWQtJ/ay25FfM
 /ozWc7tys9L7FTQ/MYWHFHTm07E43UffD8ztZdnrMycdql56zgT6I5kq3XB0ustK2jCi
 N77HJ2JrU3aHxaxbLiUqJ0R+qUtn1SnWvqSjVKOVXfujMTB2cFZbgoEqWF34gW7Aq3Ag
 lydQ==
X-Gm-Message-State: APjAAAUq+iqxGajxnijP54MR83oYzIi2uIxxNtR91MAgswy6RiCf/7dw
 Dsuxrg98gUM0WNyjLGZmhsM8FUYMch4=
X-Google-Smtp-Source: APXvYqwxy1zRvO52BhYb3sT+8Kuovf6j5LDyQQBtrjSUB7osj1rB9wryaNlqvorPcNxjV43eQGd0HQ==
X-Received: by 2002:a63:ff54:: with SMTP id s20mr9314597pgk.398.1571420696525; 
 Fri, 18 Oct 2019 10:44:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 19/22] target/arm: Rebuild hflags at Xscale SCTLR writes
Date: Fri, 18 Oct 2019 10:44:28 -0700
Message-Id: <20191018174431.1784-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aae7b62458..c55783e540 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4174,6 +4174,16 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* ??? Lots of these bits are not implemented.  */
     /* This may enable/disable the MMU, so do a TLB flush.  */
     tlb_flush(CPU(cpu));
+
+    if (ri->type & ARM_CP_SUPPRESS_TB_END) {
+        /*
+         * Normally we would always end the TB on an SCTLR write; see the
+         * comment in ARMCPRegInfo sctlr initialization below for why Xscale
+         * is special.  Setting ARM_CP_SUPPRESS_TB_END also stops the rebuild
+         * of hflags from the translator, so do it here.
+         */
+        arm_rebuild_hflags(env);
+    }
 }
 
 static CPAccessResult fpexc32_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.17.1


