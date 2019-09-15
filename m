Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BBBC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 13:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95582214C6
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 13:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1ru8zBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95582214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Uyx-0006mv-QJ
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 09:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i9Uub-0003cr-1v
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i9Uua-0003iI-1p
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:56 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:38589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i9UuZ-0003i7-S2
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:56 -0400
Received: by mail-ed1-x52f.google.com with SMTP id a23so28568248edv.5
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YAOhFzzxz8Wer64d+m0cXxodZOyQ32EAoZ5iMqeSp6A=;
 b=A1ru8zBW65YkdBpXOmkxIDGN0XMsbpUfPuGVw3zI1YYY9bNA5t/k36Okg+4vgnWBNQ
 vmh86tTzT1gVR5AtXvuuJhqWlG5FSusg3+yA2ATNpjQ2LNebskgnSUy6mq7hmiiJSvVi
 qVANW/HXDNhBtnJENeEoAVNzkeHfv56KX4NaQoGQNuqZfleCm62BgX9u56opNFoz8eXn
 orpUBTpICFOk6LU++u5dAQqF5ItWiySaEUnJCUZFyPpKlXh81IifJuDw+qYE7FZlHIuR
 nM6bFKGc9+7/0zfxisyUpCAdC3xxrrwEkVzFLGsfvACsa2HGXyXAav7BycLFPbtoY7tJ
 wneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YAOhFzzxz8Wer64d+m0cXxodZOyQ32EAoZ5iMqeSp6A=;
 b=Ut8BR7qOvXL/TI4igOmlqz5Yt5NeBHyBJTrI3ZsoTMIL+tx05CiQwTeLWyV4Kapmua
 xoIDhZ3ulXG4k9AmP7pAkBe915/ynEixhPiOsrBBFR62S4eYV8VPiItTLFAW0cPlquR1
 WdHzsSdGa2yWrFaLoBnvjLQqEZfoNCEFAgtZe9GDpFCm8XuboBZxCX2h+wse3KxRpDJh
 vDvCw7iNKlb431Y/YlnQKOdHdo6AMwaH1MA8ayMUgWmJ4hlLIPj3JeCsRqUJOMkSVFcP
 bHV4Lk/tgPP4bRLjfo1GysWHhDW+ycwlsWHUbLRPsDFjqGAJ/k8rYerwTs4PpSh+8/9l
 VXVg==
X-Gm-Message-State: APjAAAUHI7jNHH3KLSmiVeKPdDroALg+BasIS0chbzQXNG1xzWWWrqgv
 c5MZFf7UKWPFgR+pvW5qpuzp0GnIpWPYaA==
X-Google-Smtp-Source: APXvYqxDotemGHcvgXw0JcQwMq55Nfj9B4D2MTNCbBmLovBCmABVFGJIvwORbCXSeZPCt+BgjDzeMg==
X-Received: by 2002:a50:9625:: with SMTP id y34mr20450366eda.72.1568555394667; 
 Sun, 15 Sep 2019 06:49:54 -0700 (PDT)
Received: from localhost.localdomain ([185.81.138.17])
 by smtp.gmail.com with ESMTPSA id ot24sm123053ejb.59.2019.09.15.06.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 06:49:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 09:49:44 -0400
Message-Id: <20190915134944.2173-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190915134944.2173-1-richard.henderson@linaro.org>
References: <20190915134944.2173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52f
Subject: [Qemu-devel] [PULL 2/2] target/hppa: prevent trashing of temporary
 in do_depw_sar()
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
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sven Schnelle <svens@stackframe.org>

nullify_over() calls brcond which destroys all temporaries.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190913101714.29019-3-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b12525d535..c1b2822f60 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3404,10 +3404,6 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
     TCGv_reg mask, tmp, shift, dest;
     unsigned msb = 1U << (len - 1);
 
-    if (c) {
-        nullify_over(ctx);
-    }
-
     dest = dest_gpr(ctx, rt);
     shift = tcg_temp_new();
     tmp = tcg_temp_new();
@@ -3440,11 +3436,17 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
 
 static bool trans_depw_sar(DisasContext *ctx, arg_depw_sar *a)
 {
+    if (a->c) {
+        nullify_over(ctx);
+    }
     return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_gpr(ctx, a->r));
 }
 
 static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
 {
+    if (a->c) {
+        nullify_over(ctx);
+    }
     return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(ctx, a->i));
 }
 
-- 
2.17.1


