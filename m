Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD212C352BE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB32920656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1fjPHNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB32920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORs9-0002vn-OV
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpe-0006Et-UW
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpd-00061w-Si
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpc-0005zw-Dx
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:53 -0400
Received: by mail-wr1-x42c.google.com with SMTP id a25so16027305wrd.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+h4qF34NYYCpNnzawIFaWBfnQi1AWYOeOfS8Oq1wtAU=;
 b=f1fjPHNHeO6rBOZGjTKY+PgSL6eLEcjGILOtdR0k3GHYzmpRjCOh56QA1C7sSz2pue
 KR8STw3ri3yZp/eM9FKs88g/KYL8FLhqckZFTcKsKRM04Dj2u4Ts5Vbg4CtVdgTqYFcn
 q6xQiKgP8wuSWcBV3gZ2u6sebhhFi2iRH2u48a2z1At46fwxCCZw2nH6+tOu/v+jSskn
 gLLyY77aOeZ2Tk0atiBGxUJ1hp6o92LLgEZEHL48ta9+MRdMDAyemjh31r7kXCR1JBm5
 uXgtI0+y3WjVPKEGuLCHKaIYuZ8h6rjMxlVnnwmcvTeD43GhuKLna+mAPPQId3FYCLmL
 SS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+h4qF34NYYCpNnzawIFaWBfnQi1AWYOeOfS8Oq1wtAU=;
 b=dAGujLH3RMEimKKgiTI9F+c9b1nLyqST/8ibTcjEyvPhHa1x6h93b0EtZnGQ89aFqf
 eaePwtZMcOfvu7FJStuQikkkNZaT0MwSy1swXl+krPEvlM43aHZGPvnQ1nksIOUnR/Tg
 UqPnoIqIRNM3oM6KjurLyhZBoRvIsnpElORUpFBTn4fYjlCJg569u0HjoAhPmL3QmUEx
 zkUwyvY0BZj9tY6Jdag5JV6c697WaYQ2eRqq8jisLvFlY/2XUQVLyl+lwRgaogKW7Jvc
 zZuTQtKr7Edz3dDW8khJqr1wblENdMFsNJcmYWm6sJ8+PtMyvz5M7qIyWco1Atky8PG5
 jMZQ==
X-Gm-Message-State: AGi0PuaLNYgJuzslCErzhduOqvNIw08Z4foiPYRIE+L7St5ncC4URqBz
 UJOFTJiZMG3AlefSik3qwoFg2A==
X-Google-Smtp-Source: APiQypLDiCfPB4TYG7QMiIPHjlE7HT/ubIv6aqH93MebQMXgr2VQ+qxSPmw9IfDvZiRLUs6F9z1vMg==
X-Received: by 2002:adf:82b1:: with SMTP id 46mr18098277wrc.44.1586894810142; 
 Tue, 14 Apr 2020 13:06:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u16sm20153720wro.23.2020.04.14.13.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2ABF91FF99;
 Tue, 14 Apr 2020 21:06:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/17] target/m68k/helper: Fix m68k_fpu_gdb_get_reg() use
 of GByteArray
Date: Tue, 14 Apr 2020 21:06:24 +0100
Message-Id: <20200414200631.12799-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since a010bdbe719 the gdbstub API takes a GByteArray*. Unfortunately
we forgot to update the gdb_get_reg*() calls. Do it now.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200409172509.4078-1-philmd@redhat.com>
---
 target/m68k/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 014657c6372..cad40838956 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -109,8 +109,8 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
         int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
-        len += gdb_get_reg16(mem_buf + len, 0);
-        len += gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
+        len += gdb_get_reg16(mem_buf, 0);
+        len += gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
         return len;
     }
     switch (n) {
-- 
2.20.1


