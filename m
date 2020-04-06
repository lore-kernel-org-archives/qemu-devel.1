Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318F1C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18B020719
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9H8A/f1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18B020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW0h-0003xp-Iw
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqp-0001WV-5Z
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqn-0001bp-57
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:58 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVql-0001aM-VA; Mon, 06 Apr 2020 13:47:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id f20so311623wmh.3;
 Mon, 06 Apr 2020 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dxLsxZYXQYEKWKbERHeZOPlL0o3+IfFCX14RzhAQjos=;
 b=t9H8A/f1nGr7g2HQs+8jQ9LgueOGv0KDhedNGjE9nRIHwNQQh4Lfb7Tnopm9NZsH4V
 BqxahXtSkoixGLixzsJaB8FeIRZEQlTuXqwSI4nxhqznAorfTgukwIA/W55kf63hqLyZ
 CjxOr4hplACHOTFohZECAkdFCfvkJh6rMSKoUiWZEskpHMTeCsW78i6HpjNmbo4XgZom
 3yBSY7i/8hhMhTk0q1l4EOlZqQLzqLQgBcMoOJdIZ4Y4kNLw2LWA2r6G+cqTlRZGtZ68
 qiq+KzstFxHlUpneEVZTttMZ3IEpFN0IKcur2SwjB0Ht4SBotX9O8C1xVgmp2Am1E/wl
 rdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dxLsxZYXQYEKWKbERHeZOPlL0o3+IfFCX14RzhAQjos=;
 b=AJz0X1iEGU023GiUlZPsyZPdFuFJ1uhTiH6QH/swwwlhcps7OTaHFMUEw+IxMCF7YX
 4MbFffYZWALtpPaysWCvVQB6/ifsGvtkwNZ7Jf7+UC7bWIRHJdvK4IN6ouqhIxLF7Nf7
 /vpgh+wo4D+OfC1H/dtI0kJWI005DhHCqjC+BbKg9FzVix6x28wQFG99mXFBxjSYjDR4
 pP4AdC53x99iTa7M0OXHvwxtjIaCDsom7Gi/wKXy6xORrfDl3AXYZkqcd0L6lXdVwcHL
 wAlOrF24SBQIKyg7Y5Rf2F0TBErEukHg5jGIJWTv91j348bGFrU44PldtLfCNbH7NaVJ
 O60g==
X-Gm-Message-State: AGi0PuZtKYDtnzh2Wd9I5TImt7M5ps4ra0NxubUhskCHBgXEiC6M4Kiy
 U/oDr1f16oaDREK+KRVknyULHfoOy9M=
X-Google-Smtp-Source: APiQypKQ/5Odm7IxD93WpDCWksFM6mfQBxbMIkr3OmA/utWWIdrgBI1g+Col37N+sheelFtrMkXWBw==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr474112wmi.31.1586195274811;
 Mon, 06 Apr 2020 10:47:54 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 06/54] hw/arm/aspeed_soc: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:46:55 +0200
Message-Id: <20200406174743.16956-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/aspeed_soc.c
  >>> possible moves from aspeed_soc_init() to aspeed_soc_realize() in ./hw/arm/aspeed_soc.c:231

Move the calls using &error_fatal which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed_soc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 696c7fda14..debd7c8faa 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -183,6 +183,7 @@ static void aspeed_soc_init(Object *obj)
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
         sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
                               sizeof(s->spi[i]), typename);
+        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &error_abort);
     }
 
     for (i = 0; i < sc->ehcis_num; i++) {
@@ -360,10 +361,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
-        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
-                                 &local_err);
-        error_propagate(&err, local_err);
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
             return;
-- 
2.21.1


