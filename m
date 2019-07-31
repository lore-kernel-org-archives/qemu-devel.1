Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F1EC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A90206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8WF5ked"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A90206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrJ7-0003fW-D7
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42321)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG5-0005pG-Nm
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG1-00046y-OD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrFz-00045S-RN
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id x1so20432580wrr.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iZ2OY4t64w/OXbcRBQzkejkLpoLwcOyY1K+BIeISZRQ=;
 b=B8WF5kedwnmAyRbmvR5+KcOT2SJ+DR9KN1Rk8JrBbkevCjGkGOP8We/aCgdcDSkznJ
 GUKA5PMbnAscXFKm1Vb7eiApdJLh5uLHbp+JVMhyyrusk/Cv74O57XHXQs+5KBaMunkg
 P71HaeE9m5+2tXegJwC+uz5tdYOv59P9UOCmUsFaPXz7uIOGL+GlFqzZ+OD4sBOF7NuB
 9c6cKCPchYRIAPd/1yfAbZ7/yj2xChydosq5blidQYKl9rP6yLHpnM+B8hFl6s6FCyp8
 Mt9IqDZGH/QeUDuXTqd4vJ3H5djZkeUbth6QdcLE4PpsoqobCQJx3xwYyFCBuwAWh5W9
 zGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iZ2OY4t64w/OXbcRBQzkejkLpoLwcOyY1K+BIeISZRQ=;
 b=Q+3gHBRAY6Clp0HDpJhoTT3qIw9RPu1LJFvvwM8lMjYOE1PzEFBCfRyhsOc9xxuETK
 9GDFaNy+uVvQvF9weLVjO9tTUW+uaTlg70ldbp60uNlUbc3QH7T61kYx701LXe3lMF01
 kdx4xbj7NImE+SC9Sm44U0/wYFyAO1dIN8yeAjdYDU62pH8ffpnN328XwDPYjhoIYWwq
 zs0fh1QIrIo5YGCp//0Z+C3yVDxGrTlxraB/qqciICFXgpQvAe+bmA8F/0H3ixvxRivK
 kRYcQvhTY4TaUZYC6GXDfTBBMYe1iPrY7saj9lCqU5/72n6IuDcnqnOWI7U96GM5DSnl
 OgEQ==
X-Gm-Message-State: APjAAAUl2q+epd86VSwvnN+4M2rq6O4R9GqSemw0IBw0IeikyOFzvnkb
 bL3Yw1Refit0w8Qe3S57OP6rSg==
X-Google-Smtp-Source: APXvYqzh/tJtxvypzwg9UvgvObuGjOdn0JpB/DskkMRxmqumBUmYh2tbqyKu3J7yZT/wor2/Rt2Qig==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr81069472wri.334.1564589713784; 
 Wed, 31 Jul 2019 09:15:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g2sm59980886wmh.0.2019.07.31.09.15.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:12 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9726F1FFB7;
 Wed, 31 Jul 2019 17:07:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:58 +0100
Message-Id: <20190731160719.11396-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v4 33/54] target/sh4: fetch code with
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
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

There is a small wrinkle with the gUSA instruction. The translator
effectively treats a (known) gUSA sequence as a single instruction.
For the purposes of the plugin we end up with a long multi-instruction
qemu_plugin_insn.

If the known sequence isn't detected we shall never run this
translation anyway.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sh4/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5a7d8c45355..922785e225e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1917,7 +1917,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 
     /* Read all of the insns for the region.  */
     for (i = 0; i < max_insns; ++i) {
-        insns[i] = cpu_lduw_code(env, pc + i * 2);
+        insns[i] = translator_lduw(env, pc + i * 2);
     }
 
     ld_adr = ld_dst = ld_mop = -1;
@@ -2332,7 +2332,7 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 #endif
 
-    ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+    ctx->opcode = translator_lduw(env, ctx->base.pc_next);
     decode_opc(ctx);
     ctx->base.pc_next += 2;
 }
-- 
2.20.1


