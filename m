Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8244DCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC0C21906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmTfV4+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC0C21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJrr-0005kO-Ux
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNJmc-0008PS-S1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNJma-0000Kd-RR
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:46:50 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNJma-0000KQ-Na
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:46:48 -0400
Received: by mail-qt1-x844.google.com with SMTP id u22so33191060qtq.13
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id;
 bh=xuHzog+jgtYpIJtmII9MEywPYX9XQKQHUxgkXOaOldY=;
 b=XmTfV4+RpDdWrj/Y+bFAmZi3uM90+NUbPPhJRztWnNHrvACKhfP+MmjGROfy2Cuj1e
 Jwhb1T200MI4rKvRXckEqVt7P52Ys0Ix7abj7Cl3fuWIJ4kPaTgdpP04NRm9dRLKcPTi
 xlkqs+qN9DpLrv8oVnw0Et2LnEb+CLsrbENCoGBuZJu7fqR1y8Iblr+4J/PC1AnD1L23
 +bw0t1vis1ObX96l2R3qXIp+5FF2jxY+N0et1Sj68qSnJo4KdJYYNh/sDk0bs1xIAMlK
 sgkXJDgigXt7bL60tQi8tAjDwXOfR/RvAqU8U6otpd7KEDUxeTDzqXMYsMbWDQGgk1KL
 5cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=xuHzog+jgtYpIJtmII9MEywPYX9XQKQHUxgkXOaOldY=;
 b=nkWd/cVnsLckUQpDThx8KWB2mUWJBqz1du1qKUtj0t5Gwwkr7ZZmmJvb/+TEi4FIuI
 oP2Z+2hcj32h1pdZ+shm22cwqGmUWnss6/SVH5PmxIImk+F3WTYlIuvg8PBSXHhAbzTI
 VrlRNVgraq09DGpjRjg+AJyuDniBzQ53IVmOC1xW+O7T9u5N33IeYZi0Niwv3l9xb5KV
 djcNdpfuOUEIdJznzCeZN6POqf/72unxM6wJ7tezn/duIYnAV+JI15SMhHAeGw6dTARs
 vcqp6ekZDeZjZVBX4q49TeBGxkgsLqbUQ4I2S4NxJD8it4Epm+nQA4egU8EndTM18Peo
 o9gQ==
X-Gm-Message-State: APjAAAUlF4IHEughe/dOARpYoSEJUvhWuxuu9F4hdnRny8NOi0P+QFbg
 3Wm95XG1Yqu0Se16Wg6LcLYNeNHeUZc=
X-Google-Smtp-Source: APXvYqyZQFzrHyvwZq3lQ88tTW7qiPI/SOraMViRgT5G0MLDzZI6MZ1xNTf6jOVhgAxN+nhX3PrmOA==
X-Received: by 2002:ac8:4149:: with SMTP id e9mr9731924qtm.321.1571849207332; 
 Wed, 23 Oct 2019 09:46:47 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id t13sm8380540qtn.18.2019.10.23.09.46.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 09:46:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] translate-all: Remove tb_alloc
Date: Wed, 23 Oct 2019 12:46:45 -0400
Message-Id: <20191023164645.5518-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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

Since 2ac01d6dafab, this function does only two things: assert a
lock is held, and call tcg_tb_alloc.  It is used exactly once,
and its user has already done the assert.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

I noticed that this function was essentially a stub while
reviewing Clement's tb->orig_tb fix.

Note that the added newline in tb_gen_code both adds the
missing break after the variable declaration block and
also happens to highlight the assert mentioned above.  ;-)


r~

---
 accel/tcg/translate-all.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f9b7ba159d..ae063b53f9 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1156,23 +1156,6 @@ void tcg_exec_init(unsigned long tb_size)
 #endif
 }
 
-/*
- * Allocate a new translation block. Flush the translation buffer if
- * too many translation blocks or too much generated code.
- */
-static TranslationBlock *tb_alloc(target_ulong pc)
-{
-    TranslationBlock *tb;
-
-    assert_memory_lock();
-
-    tb = tcg_tb_alloc(tcg_ctx);
-    if (unlikely(tb == NULL)) {
-        return NULL;
-    }
-    return tb;
-}
-
 /* call with @p->lock held */
 static inline void invalidate_page_bitmap(PageDesc *p)
 {
@@ -1681,6 +1664,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     TCGProfile *prof = &tcg_ctx->prof;
     int64_t ti;
 #endif
+
     assert_memory_lock();
 
     phys_pc = get_page_addr_code(env, pc);
@@ -1706,7 +1690,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 
  buffer_overflow:
-    tb = tb_alloc(pc);
+    tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
         /* flush must be done */
         tb_flush(cpu);
-- 
2.17.1


