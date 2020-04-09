Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8988C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB882074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cC1P2vPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB882074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMecW-0003MJ-5q
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWY-0002CA-15
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWW-0005p8-1a
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWV-0005nA-Rs
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id d77so272869wmd.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nVauCqAe02ZVV85VxJmPfUpt8hQkj2V7/kcfJf/XgeM=;
 b=cC1P2vPJJVf9RW/DyIIR90z4563W7+d9n5a+q5sh2AmPheKzS/sbazYOi1eQ8q9CEI
 MSD0p5Zi2L/1pqUFdzrLP4LWOnbvMyFYmtBsge+KZ00wQHUhTwWv+rZdx9v5RbVm6hXt
 IYrJ0gU53DYYUg/WKuwJ/HyUXcHBwhahh+wo4R+2uWqa8ViAA59I34TS+fJ8CQxQ42Gk
 77GLAiRdbECed+RPxh6VXq2UW+6R7cMNS++vOe9wEKJdCAZ7TkJjTybZefC93c5aMRe2
 0tb041iYA5CAXqPOAyz2KvJ6owFJAngVxMfku/T7w0D9sDo06DLKVlno6YXfnkEDJY7T
 yn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nVauCqAe02ZVV85VxJmPfUpt8hQkj2V7/kcfJf/XgeM=;
 b=T+dGWtm8mDAvu5Wxo8JPdKKqkupzbBybz8BB2HQvleBY/6t6KIdYu1X6l4UIuS+3ia
 50X/TjsQI/YWGAmPykwRvozhX1bUZgj7MD5gJVWvpucYV0wIOTiMShXC5CdWvO8qlfEs
 DLPiXfpcDUJTA3bsxlnBE4IEaGSKCkaPoYtAZTzcqlBIE598g1he3zfAEY99MpHM86pX
 7TFdEBjW5os8Bm7UrL4cQdhpFR9eovy1Rq45xhlJsRQ6JsZiT/D+FxDzq8R+1Mq9kzMA
 oAGAIpL6qqBtOJUwYn3ymajUOmLuSNWXbIQxkWMjevi6gIAerf2ZkDcu0o5M4VaJettt
 PUZw==
X-Gm-Message-State: AGi0PubzkEuN6Mov1ZEuudUE0tT+hktxesVo1/Y0DdgpBie/wObzBipt
 5aTevF1vLEnTJsl11n2DGauh8Q==
X-Google-Smtp-Source: APiQypJ1otw2P+unA7+Lti4vRM/jxNQoQfbOwzay6uRm0lG1c/7p+SKdWarS1cFyc5A4oPC/Bmhk1A==
X-Received: by 2002:a1c:6787:: with SMTP id b129mr1822353wmc.165.1586466942652; 
 Thu, 09 Apr 2020 14:15:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm4914213wme.17.2020.04.09.14.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D6EF61FF98;
 Thu,  9 Apr 2020 22:15:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/11] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
Date: Thu,  9 Apr 2020 22:15:27 +0100
Message-Id: <20200409211529.5269-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

We should only pass in gdb_get_reg16() with the GByteArray* object
itself, no need to shift.  Without this patch, gdb remote attach will
crash QEMU.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200409164954.36902-3-peterx@redhat.com>
---
 target/i386/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f3d23b614ee..b98a99500ae 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
         floatx80 *fp = (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
         int len = gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
-        len += gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
+        len += gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
         return len;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
-- 
2.20.1


