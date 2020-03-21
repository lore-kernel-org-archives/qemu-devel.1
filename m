Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F9C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D1620714
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANdBkhE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D1620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcfp-0003TY-Vp
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcb1-00021y-Te
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcb0-0006rJ-Oz
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcb0-0006qs-KS
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yg/uPhRkx9OjPcaTO9vlYALUXN3pIoYxovXY5zX2+JQ=;
 b=ANdBkhE71Ysnxc3IpXx1C31x3TUFRrWyb5W/vYjjlLg/lnLmm154AzmAU2OSfDBsVLIcw1
 AcRYKl9fXXczbM+VhuUorGKSZDjOASbmptmkxdXAAFHmWgDyVq3GNeOMCxVLNuYW1cHAMs
 K41Xy1Afg49MQv+FbcPpDnyKjN0GQnw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-qAmtlP0ZNf2O8sk9dlfF5g-1; Sat, 21 Mar 2020 07:47:16 -0400
X-MC-Unique: qAmtlP0ZNf2O8sk9dlfF5g-1
Received: by mail-wr1-f70.google.com with SMTP id q18so4181114wrw.5
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8CJ+9lz/G6rwsxDBjnubfjrbrfbpIvcJrGa1k2G4+/Y=;
 b=rYNrtugX3Kob5TXb4dF78sACYjI5NkKoScMMM4VtcU5cGzE9nLbtqGJz7StkeWmHh3
 ZPu1bsmfd46DsYEESRrfvKFFA8xeC3zEEFiVFnx06u3zMyYPtXQXPWJ4yP1VVPgghw4Z
 9J2LpyXlFwo5bzrwydV6A38rdFXJ0Vng6KIpynMaof4w/v3fcZzxbjITnkGv9fgwweNv
 KFJLRPxVqc9MtkDOLdtfCKWPyGWfwjx4yLJnzNdMcyaPzmgKOF2GfwSpPHvlTckFf57N
 LhKiiuFGKgNpBd5K5Q0TxwUrNDpgIgN+l+A93ooOft7/ZNU0VP3IcP2K+p45yQe2pSnr
 7aqQ==
X-Gm-Message-State: ANhLgQ2Bf/V20588RoKc7V6S0PocEI6BphW0I6ukMwbC/9l5BO0/oyd0
 aOzM/NiCGmk9jfd4DTxeu6EwpRyujJ3O8POybFXn46M5R6NR0GVgZTTYSxXRzDbwpwkiEDewv+Z
 xO183FvwIK2SMdNU=
X-Received: by 2002:a05:600c:10ce:: with SMTP id
 l14mr576577wmd.161.1584791235498; 
 Sat, 21 Mar 2020 04:47:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv3kYG0GXzyCiOia7dq8AGBTEPkdgA9K0YR3lk8tgmzZM3dgpvC+FSCqi8gMIeK6PeKsjCiPg==
X-Received: by 2002:a05:600c:10ce:: with SMTP id
 l14mr576530wmd.161.1584791235271; 
 Sat, 21 Mar 2020 04:47:15 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id y187sm2407206wmd.0.2020.03.21.04.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:47:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 07/11] hw/gpio/aspeed_gpio: Remove dead assignment
Date: Sat, 21 Mar 2020 12:46:11 +0100
Message-Id: <20200321114615.5360-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200321114615.5360-1-philmd@redhat.com>
References: <20200321114615.5360-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

  hw/gpio/aspeed_gpio.c:717:18: warning: Value stored to 'g_idx' during its=
 initialization is never read
      int set_idx, g_idx =3D *group_idx;
                   ^~~~~   ~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/gpio/aspeed_gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 41e11ea9b0..cc07ab9866 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -714,11 +714,11 @@ static void aspeed_gpio_write(void *opaque, hwaddr of=
fset, uint64_t data,
 static int get_set_idx(AspeedGPIOState *s, const char *group, int *group_i=
dx)
 {
     AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
-    int set_idx, g_idx =3D *group_idx;
+    int set_idx;
=20
     for (set_idx =3D 0; set_idx < agc->nr_gpio_sets; set_idx++) {
         const GPIOSetProperties *set_props =3D &agc->props[set_idx];
-        for (g_idx =3D 0; g_idx < ASPEED_GROUPS_PER_SET; g_idx++) {
+        for (int g_idx =3D 0; g_idx < ASPEED_GROUPS_PER_SET; g_idx++) {
             if (!strncmp(group, set_props->group_label[g_idx], strlen(grou=
p))) {
                 *group_idx =3D g_idx;
                 return set_idx;
--=20
2.21.1


