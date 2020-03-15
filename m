Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B9C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034B4205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlLN8yVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034B4205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTTx-0008Ob-3g
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJl-00089o-Sx
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJk-0003Wf-NA
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJk-0003Qd-FC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id g62so15117060wme.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rtyy8CX6lQ0m3U8wFWf3AzT/p7YOaZwtAFg++0OM+ps=;
 b=JlLN8yVKsJtkMAokOUasuGG7z7aQ20ngIy//oSRTN2kvpOKeyS/eD0FVATR8ky75mt
 Ui8tyIIm1pBInZysWZnwjJHI6KmZVRZg6EWzhRs9a7IgOV1fooohlNMyHi8YB4L2Pgbm
 zJ9KB8Cvi2gkzZfTzEDFtX4SjI4dqPOh2t5o8zpCDTLe7TySU7JTWTTgjZK5FOe428+5
 YFeU6Fq3MrxBKtVwMMWvLGSS7xubObEULYTbMNyuNO3yUX5xX4gCEzVTlldKc44DX/49
 uc9zQ5aOD8+5T/epO6wO+P4MXbNKKhZEEnS2WevT6U1H0+TpY7ABpkRbxvxelKoSxdSh
 se8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rtyy8CX6lQ0m3U8wFWf3AzT/p7YOaZwtAFg++0OM+ps=;
 b=auL2QYGKD8sv7Bte4cSHnOlhExSsumzrqGI+QG+ruhTCECtzbkejsC123ejlnaLTA4
 bRE29qgqjZ+bw5aukm/8XNTpRy0wgIhCDv3XtSGEJq6BJx7pAQvHMuH0SIQSA0pscPJC
 T4K/QYZsjulSJErSSVkgi7PDcfV4cAGpjii8BZhIBuguCvWZDkFa5YHt36UD1nMyOWsR
 HaiwdQW/fHgwwqxX0RSrXpLSfng689ru2V0UZakx1vqI/Ay7FjEdJG4cKMtaOGJSYdBo
 wn8ZP+DodS0G4UtUoI3hqjAjkMVxKX2g2gdE5FQ6K/P6a8wD5TbRLh94ufpAEI/Ncj3E
 g9/w==
X-Gm-Message-State: ANhLgQ1lp+0xlkmM/jT3vMsb/Q+wQtRbZglTcYt0CpyVhAEvnFDvovB8
 pDOjM/EmIPz9WerpSkq8EGDzyfWQ
X-Google-Smtp-Source: ADFU+vsLx/U8GutidWOVt/8tovGckUYdaIsoOJQsm148Es7icxRBnloOowLC2safGldN+yW5PxNDgw==
X-Received: by 2002:a05:600c:215:: with SMTP id
 21mr22132041wmi.119.1584278913643; 
 Sun, 15 Mar 2020 06:28:33 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] target/rx: Dump bytes for each insn during disassembly
Date: Sun, 15 Mar 2020 14:28:08 +0100
Message-Id: <20200315132810.7022-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

There are so many different forms of each RX instruction
that it will be very useful to be able to look at the bytes
to see on which path a bug may lie.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-24-richard.henderson@linaro.org>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/disas.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index dcfb7baf99..6dee7a0342 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -102,7 +102,21 @@ static int bdsp_s(DisasContext *ctx, int d)
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
 
-#define prt(...) (ctx->dis->fprintf_func)((ctx->dis->stream), __VA_ARGS__)
+static void dump_bytes(DisasContext *ctx)
+{
+    int i, len = ctx->len;
+
+    for (i = 0; i < len; ++i) {
+        ctx->dis->fprintf_func(ctx->dis->stream, "%02x ", ctx->bytes[i]);
+    }
+    ctx->dis->fprintf_func(ctx->dis->stream, "%*c", (8 - i) * 3, '\t');
+}
+
+#define prt(...) \
+    do {                                                        \
+        dump_bytes(ctx);                                        \
+        ctx->dis->fprintf_func(ctx->dis->stream, __VA_ARGS__);  \
+    } while (0)
 
 #define RX_MEMORY_BYTE 0
 #define RX_MEMORY_WORD 1
-- 
2.21.1


