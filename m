Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3768ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0186721D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHyjGqVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0186721D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0om-0008N2-SC
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0To-0005FL-RV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tn-0001h1-ND
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:16 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829]:40736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tn-0001gr-JN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:15 -0400
Received: by mail-qt1-x829.google.com with SMTP id o49so3460174qta.7
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jWCHT8imM+uT8t8z8pCnUo/8+221GMTt3GzK0VnZBfQ=;
 b=iHyjGqVBlWhRCyvOuTKND1TnfPp7qdekqymZ8omiqy0rOsD6qMW3tYMAt6QScTvhgw
 wVNZxFa2fM+X5Qc26r6qIBKAq5KUfPPNZKZIvlmka/ufr2Z0LNfLpVE+DsKh80tsOn37
 viq+35QicC57PHBPGNEoNldEOkm9PTqXONY+nJdd59cxXsCtQxWfbYRvT/4pAlGNMaHr
 A0bdkqDMMeEP6EKv4tBGzWIHLvC4jje46gUXEJZmmlp4x8G/hV2wxDzLkhC8reRBYePv
 LorXMl3iLMBYr01DSym+7R4EW3uKZMZYIOZnR+uDpO3yRv7w+WCv4l9JKQaFfUJHP6kI
 Vn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jWCHT8imM+uT8t8z8pCnUo/8+221GMTt3GzK0VnZBfQ=;
 b=CtfVSmisbaczH/9Ps4xOR0vjhVs94PNnNg/Bc69G+9GdGA6gCjDNDqOocJZk7CkD/C
 fiD0217hnkzNVgn5R8lYITL0rz6/B2r5j/L3yK9dU9F8WK4E8q8gZxGU4M/a+dWIwqld
 TTEkmqbFyJ7yh97H2ZxbxEN5Umnl08ehC/mKk/ulAQ6suRwjWHLSKvPW/P2+NTqZ1Vhj
 9BtaJYWqadgbr7UfH7UMWfUToSl5ew6uTDQZkX6Ez1NaNY4V1mFSAuA1J2CusE0i4yUo
 NgXVRAKqufLQeiF7GrT5d8P6XpH0kKz6AVOn9KnhWEWnHvQ33o9NKckvRnfBxXaqRYOA
 UvQA==
X-Gm-Message-State: APjAAAWIvAkaeBd9Mfw241XVAc6RcZbG5dYjFUusS2jmmSFKXYUlrYYc
 gsVlcDz50XlO3j6rMDhTG0CaIYz9L24=
X-Google-Smtp-Source: APXvYqzWXeIiz3luk5leJS5HD0i/rN+5B9IUti4a3DlT7pAg628VG/RnXEWUZqnCANZYagFv/qLXaA==
X-Received: by 2002:a0c:85e4:: with SMTP id o91mr3472073qva.16.1572013334490; 
 Fri, 25 Oct 2019 07:22:14 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] translate-all: fix uninitialized tb->orig_tb
Date: Fri, 25 Oct 2019 10:21:58 -0400
Message-Id: <20191025142159.12459-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::829
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
Cc: peter.maydell@linaro.org,
 Clement Deschamps <clement.deschamps@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Clement Deschamps <clement.deschamps@greensocs.com>

This fixes a segmentation fault in icount mode when executing
from an IO region.

TB is marked as CF_NOCACHE but tb->orig_tb is not initialized
(equals previous value in code_gen_buffer).

The issue happens in cpu_io_recompile() when it tries to invalidate orig_tb.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
Message-Id: <20191022140016.918371-1-clement.deschamps@greensocs.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 66d4bc4341..f9b7ba159d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1722,6 +1722,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cs_base = cs_base;
     tb->flags = flags;
     tb->cflags = cflags;
+    tb->orig_tb = NULL;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
  tb_overflow:
-- 
2.17.1


