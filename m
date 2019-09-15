Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C642C4CECC
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 13:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409E4214C6
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 13:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZEt4Ves"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409E4214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Uw6-0004Y0-4M
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 09:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i9UuY-0003cb-Sn
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i9UuX-0003hg-T1
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:38587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i9UuX-0003hS-NE
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 09:49:53 -0400
Received: by mail-ed1-x52d.google.com with SMTP id a23so28568211edv.5
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4kYZic5O2mp1QlkKf7vv5d85MpELl5rJ1Zh6m+8PAlM=;
 b=hZEt4VesGTwc0ewZCuyOoalac1MyMI8xxKSa7E2TpW0XvT468WEMzS+BgTTvsizsSv
 rOX0lhHid1cIkIzCEPK6Hs+u1lfdrwh2KtFH+/TgSNXLacY7nuSeVQIWyZbJkvzYqq+o
 x1/OrcbTWrfVjsKL/NKO6NGNYwpgYYIxcYda7KETEdgY3kJ062qj4jU5bEWD+1sTBNeh
 Xzuo0aWvwPmZd9rZTv+W4TFVVpZ6X43Xl5AIkfJd3C3ENfcSglfHcEdFHfhNJ2SLJ4Lc
 rGKtgaXA7bzI4w2MLYX3XDFODryq/8Gjq0hXJ5PUu7R+Y69JMtHnNoF6UM9+zEy6TF8j
 F5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4kYZic5O2mp1QlkKf7vv5d85MpELl5rJ1Zh6m+8PAlM=;
 b=JAk6zgADImnVxQZkjBzDXCkm0KzALxa2iTzLvr9UWPf+7pgicfdSL/KzlQb2ZVKIor
 YfscwnVtM8/AswJGlHiRPlk5SjshJvVBh61EuPcVd+vTh3qJQemu6m0IuyqmKP29Ns0L
 HJ7YihlmYmv4a1ckipbJqAtLACkwOavel9FNy1K3Td05HT5yCiOSB0RkzOe8EVD0MzPj
 UQPkjr/+BEim0m/Xd7V67Pl3e6q7WZaQhdEIxQAOv+XV4XlQ2mOug3iXD7OU1H2lFCNh
 Dn9R61JKd2zsvQC/xNzRqLTNcG6rYw+t+z88bV8K2s8DHQ83GFtBdvHvbWr5le8MVS7g
 4ETg==
X-Gm-Message-State: APjAAAViHtoN9ifTKFXimcmLZKNaLDylAP7udYUDdt1eBpdHUtircTan
 JrdDwdy1p+wHhMe4bjTjcXuWuX/8wIr6Mw==
X-Google-Smtp-Source: APXvYqwPrJt+/3tGsY3d8aqGvUKDhGg56762oPpc1+iKBKN15qgof2WphXfU4jCgjau+pQuQdJJhYg==
X-Received: by 2002:a50:979b:: with SMTP id e27mr3695083edb.173.1568555392562; 
 Sun, 15 Sep 2019 06:49:52 -0700 (PDT)
Received: from localhost.localdomain ([185.81.138.17])
 by smtp.gmail.com with ESMTPSA id ot24sm123053ejb.59.2019.09.15.06.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 06:49:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 09:49:43 -0400
Message-Id: <20190915134944.2173-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190915134944.2173-1-richard.henderson@linaro.org>
References: <20190915134944.2173-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52d
Subject: [Qemu-devel] [PULL 1/2] target/hppa: prevent trashing of temporary
 in trans_mtctl()
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190913101714.29019-2-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 53e17d8963..b12525d535 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2214,10 +2214,11 @@ static bool trans_mtsp(DisasContext *ctx, arg_mtsp *a)
 static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 {
     unsigned ctl = a->t;
-    TCGv_reg reg = load_gpr(ctx, a->r);
+    TCGv_reg reg;
     TCGv_reg tmp;
 
     if (ctl == CR_SAR) {
+        reg = load_gpr(ctx, a->r);
         tmp = tcg_temp_new();
         tcg_gen_andi_reg(tmp, reg, TARGET_REGISTER_BITS - 1);
         save_or_nullify(ctx, cpu_sar, tmp);
@@ -2232,6 +2233,8 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
 #ifndef CONFIG_USER_ONLY
     nullify_over(ctx);
+    reg = load_gpr(ctx, a->r);
+
     switch (ctl) {
     case CR_IT:
         gen_helper_write_interval_timer(cpu_env, reg);
-- 
2.17.1


