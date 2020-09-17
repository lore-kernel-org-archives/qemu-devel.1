Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3A2C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C3320789
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u54oCRdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C3320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ3rY-0001hj-5p
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 20:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mS-0003xs-Rz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mO-0006fI-KQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:36 -0400
Received: by mail-pf1-x444.google.com with SMTP id z18so2270815pfg.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h5z7SnNwk2VZk90FP96rDl2asHH4IwwqX+odhVzyeAE=;
 b=u54oCRdb12zlUkempGW1AxdiSN2pSg1PSBh1rCI3G1NjR3JRw6HK4NyL2kLlzR5rIe
 p+OIXh1zGPj8eWjBtKVUW+fCTRVBYbCAC9y9an378tf0W5g+vDKrWDDnP22/YM41+Dkv
 b/qdr2x88/l/GHG/pg1s+WfzYhBX+aPqPDfqQz6x6oqlp3VBUqdwcs0nQPiTf64DCxYz
 /sDNl8QaLCJ+FhLvuw0mfnMrF6g0TD8vBdn53smjOOT0k2EWzUjCv7Tjp9lbJ5uSLTfx
 WFuDRGCdn0XhRpkIt9ipIRVBukaAiMYBZ0mCdhDYR4arz6lrFX4eAuuiZxEd+ZpvJLRK
 8EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h5z7SnNwk2VZk90FP96rDl2asHH4IwwqX+odhVzyeAE=;
 b=WSpYogewiPvLwU0swDDz6PHsAkOAE4Wpw1m4lg0JdIqyIyhr96jjwMfCAYk0PGxquu
 VRKQOdrpGNFX1M4xHMRAWqgpM9p6J4AoukWJ09loeJsRVREzEAQMWbv1aG7x2fa6qgwy
 zNGGLTgMAgXbeOvT0QKvlDItFO9jcM7y7kbsSfWNBE5x7eFW+x0+80cGtWTYr6kxCWw9
 26Ll070viGJNJv9vVtTlBUnfXAbe1/bTbc5ttuz7+XtrMm9MBAn6CuM8S52lB0lUQqnG
 Up8I8fnae5xZtEAdImI+2+pa5sU06oLeAUoZ/diHHx45QsdcRBEQRc8B2+9W/GdsG0bk
 I6Dg==
X-Gm-Message-State: AOAM530qLvuoYSGriEqb4hcFFW5BVASWs9Xqvuu9jQGBTiT8dAZMn8T9
 LFnuQr+IEZdQcDtZTFwh1sbK/xVGL8DxJw==
X-Google-Smtp-Source: ABdhPJxpEDz8hu+pBn67n3wiHPzgeo0r4/ZB0J5lDchrLUnvgVTTlH/A1t7r9pQZSYk+FuaBowlyug==
X-Received: by 2002:a63:205d:: with SMTP id r29mr23638143pgm.278.1600387050898; 
 Thu, 17 Sep 2020 16:57:30 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm772699pfk.103.2020.09.17.16.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 16:57:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/10] disas: Configure capstone for aarch64 host without
 libvixl
Date: Thu, 17 Sep 2020 16:57:17 -0700
Message-Id: <20200917235720.2685978-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917235720.2685978-1-richard.henderson@linaro.org>
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ifdef tangle failed to set cap_arch if libvixl itself
was not configured (e.g. due to lack of c++ compiler).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas.c b/disas.c
index d0ccd4b727..01c8bc6c9e 100644
--- a/disas.c
+++ b/disas.c
@@ -428,9 +428,11 @@ static void initialize_debug_host(CPUDebug *s)
 #else
 #error unsupported RISC-V ABI
 #endif
-#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
-    s->info.print_insn = print_insn_arm_a64;
+#elif defined(__aarch64__)
     s->info.cap_arch = CS_ARCH_ARM64;
+# ifdef CONFIG_ARM_A64_DIS
+    s->info.print_insn = print_insn_arm_a64;
+# endif
 #elif defined(__alpha__)
     s->info.print_insn = print_insn_alpha;
 #elif defined(__sparc__)
-- 
2.25.1


