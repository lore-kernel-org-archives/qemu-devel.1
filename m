Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA5BECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388532054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvwIHcJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388532054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Qt-0000by-KY
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mY-0002N7-IJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mX-0001JI-EF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mX-0001Ir-58
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id a6so2548808wma.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LYziuWTaDyCvsXZWL+7dYTQAPkm19wADCHnlP8tL2bI=;
 b=uvwIHcJVTMPxqYoN2aLnZ1NxqBojTuMg/mGUCpXG86IZunIwoRh+AquVopd4zJF4Qe
 dcKhCqu9ogf5ehBxPpHFMUOYRLHL4PMW9putiUXq9TfNayI+V+DroIEL+jLI5/iV0ss4
 wjl5WHMOR2MIdKuVKgVHQklpcbAnR/rSiKVq6LnPmMG0tGRw9YcfYqHS5z4JNjz8jAWB
 sZEF9kbJTRrAyx8qV0Fcov7B91pYIc599zbCNVh+fyvdRjzh+8bz3/5t789N1McrNVPy
 ssRB71E2CxyIanQ6W96540iIKbWuaDaKZKlwBfl7iHKfmeQPNHYdGtPXWS+/+sin1vqu
 0fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LYziuWTaDyCvsXZWL+7dYTQAPkm19wADCHnlP8tL2bI=;
 b=jeDnOHizWEq1Vq5VU41h/h7LAb3lTs+zFqOQ1VtGdyDspRpn+2bL0dzt9SP1RLrk2C
 TEvYGxWLiuo33wAwjChkWGvnSWM8GlP//CTjc4VjSNmu/Lk11Ml9oETM7/QOKziX56iw
 WLuWEe31ollQLma0fv1G5qd676nmT2Y8lcO7Iz7M+TiKvgFeseH+Qn24Q5XtgY4f1lLn
 kcYxASq64sEvQdPWDi0fRG7EzKX2fRnZQy1olmq647Y17bpRCOS21os0UPfDlH10USwK
 rjcbFg5enDm7CMbazKt4peo+YAJx43nzcMtd/7idFizdp35oE7OYPxSBklPt22qoZlBW
 SH5A==
X-Gm-Message-State: APjAAAX6atEM6XLe+73Ykx9BIZ+8AyUMXVmy0HP6DZND7R2Sb/CAu19X
 utWKLTXDOcNyx/H6qsnT/gnFRw==
X-Google-Smtp-Source: APXvYqxhTr3+FsLlVkBR4WL5JqRtTQWdhnCvNQvBT/Buq6xx8FQnzNNHQ7i/9DeUtURkaXNmG7PytA==
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr2822057wml.58.1571318732081;
 Thu, 17 Oct 2019 06:25:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm2041089wmc.38.2019.10.17.06.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4A0841FFAE;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 25/54] target/sh4: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:46 +0100
Message-Id: <20191017131615.19660-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
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
index 5a7d8c4535..922785e225 100644
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


