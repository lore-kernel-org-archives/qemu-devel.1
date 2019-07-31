Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59A8C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C16206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sixXPJUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C16206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrUt-0000fd-Tm
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPm-0004xz-8k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPl-0000Lu-8F
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPl-0000KK-1k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id 207so61496622wma.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2kztZJN5eNMXPYR/yV/k5e4rXASSvPn0RzjkaYHqSic=;
 b=sixXPJUt+07ZX+aqJ0Iamag0fuRCtaFGtRLLI379yh6hh0lEr3NlNM6Huje/cHNt5R
 w0vaO1Eh5HLlUeqq7v7B39sbyO0FBCzMlZJ/D+RMTVpYu19viQeBC7xbePA6yxRQFryF
 HO6TxmIBAU/dXDQvIItN9tklOZDJKCVu3exs9TgGE3SbZ3E8O+LJNVM1agFyqLloPO5D
 bP3dfo46ok0XPo8yjiyFcvnUoarKzTKiF/ZAvkyoAW/7fHXIMnUw3OW9KhO3WJl6kHB6
 tBwX/0t/oOfhbu4bs6PxdtaDS7BW9wN4FQ13OZXicKsX8HZn5QYWSLaMm/JLTs2lQ0qU
 6O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2kztZJN5eNMXPYR/yV/k5e4rXASSvPn0RzjkaYHqSic=;
 b=Yz0GNHR6Mgfeaaof4tF5PQ3p14/BVPQx9rT+bCHK80OSsfR0plftPXVzM76z22Ivy0
 Doxg4+JBAMQzoyzxnndeiAwKmBkavy6nUcVfZxsMJo76aYRGafIt9Boi0dFn2ujjnpq/
 dvnPzzOTOYJ0Fo8ZQVJQCpsS9IXLoDg8SGkrJOGfC/z+N2kJrxaOMG78qANcYTA6o1X2
 G0vDzzsHNAXNGsYHT2/vVwztytGurPQ6qLUrRLW9T8lzsdL6VK08wZEb/DLcwigQnqNv
 Fn+cgt2XFo59VGLamqzhYl4ysr0O9UiJ5yoleiNA4nqWn/DdxWQ8eQ2Ctrtu5re/20zL
 qmGw==
X-Gm-Message-State: APjAAAXfb2DjJzeSsqolAtIBrf+R9YpnniTRCseDn+H66Sqm0EUNCUxD
 QoRuu5cnfyziX9JnT8cg5djq+g==
X-Google-Smtp-Source: APXvYqzcsxWt6zX0whmLEwx4gsxEE3TISt51tyMlNk+NzLuOD8yk7s2AmdDGh6/pHdlIeFK+RlChng==
X-Received: by 2002:a1c:c78d:: with SMTP id
 x135mr104527300wmf.82.1564590318914; 
 Wed, 31 Jul 2019 09:25:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y16sm149475699wrg.85.2019.07.31.09.25.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:16 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C0FC31FFBA;
 Wed, 31 Jul 2019 17:07:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:00 +0100
Message-Id: <20190731160719.11396-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PATCH v4 35/54] target/hppa: fetch code with
 translator_ld
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 aaron@os.amperecomputing.com, cota@braap.org, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 188fe688cbe..36a784e2932 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4217,7 +4217,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+        uint32_t insn = translator_ldl(env, ctx->base.pc_next);
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
-- 
2.20.1


