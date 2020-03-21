Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65933C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC1420732
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZaZT9Kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC1420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfRP-0008Mz-Bl
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFfK6-0005jT-KE
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFfK5-0007cm-Fk
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFfK5-0007cW-Be
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584801721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wabz9ShZfSLuxIv0MTXDbxATC0FT6q8THWUJCXN/WkY=;
 b=XZaZT9Kv1kzu7sGM8bfJcaa0BGUWav1tr2dRp9uLV4k/w2LxoFp5hsF5HStBV99vEw6Wey
 7Z0joxoWn/asczC6AsCzFO4rhYt+3TdWJu/HOoSGJqJGms7rfH7frlBgT67M4u5H8lEje7
 /2sw0Z5cBo1y5knW3KG6F/PbA6qa/9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-kPHGW_RPPMSK83UAxrRCVQ-1; Sat, 21 Mar 2020 10:41:59 -0400
X-MC-Unique: kPHGW_RPPMSK83UAxrRCVQ-1
Received: by mail-wr1-f71.google.com with SMTP id w11so4360004wrp.20
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eDep/UAh9LxMQ+p+ZbiwORp8mGO979hnIy8cu0Ibo6A=;
 b=Xm6VtI2hdnrze/8QtMlErKhf8eGAtuTk7+ubMBdcocH0hYeODVp/PKmiuOFmonJr9V
 yhoO7HM/enVtyFwqO7F49yjV3PL0pc3ex5gsdMuatOpfJO3iJR8blrBLvHbQJjM5zQtd
 tMFfKROtoO5RNb+/WgQPCmhSwJivDVrgqqcJUinz6xVOXfhKh0yIjBbrtpC5zueuoBDi
 LeQxc1qPjE/E2s4NjEYwPKzRCmYO6Nwh2smiijN3MjXdNZbvp0GC7sROqFsK4BaZWYKR
 980UTTI6sVWFvF8PAOWbYa/Rcx/nNO4yhKga9ZAPQ8wel06G6P6XWyGvKx+mdm8tdreX
 8C6Q==
X-Gm-Message-State: ANhLgQ3+MKXvUV3KGmkzM4y0q6FulobEM6K6TRwIiuPTgjahNSQDr6hs
 OdUVJe3PiCrWChhVIefnrhhKQYDdS8xe58tBvSgdvGmuEbv4ebeo1mRomWzF7FtB3mlyC9PmRFI
 /RQNzQgI/n/b4WVQ=
X-Received: by 2002:adf:b307:: with SMTP id j7mr18622715wrd.128.1584801718379; 
 Sat, 21 Mar 2020 07:41:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtfnFMlK5o2AUliKihnwwfvHrClOE3oeCNEnuVDhJ9fRMly5LXyQNqsh5zSzzZ49D+7xGs/WA==
X-Received: by 2002:adf:b307:: with SMTP id j7mr18622686wrd.128.1584801718221; 
 Sat, 21 Mar 2020 07:41:58 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id l8sm12553155wmj.2.2020.03.21.07.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 07:41:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 07/11] hw/gpio/aspeed_gpio: Remove dead assignment
Date: Sat, 21 Mar 2020 15:41:06 +0100
Message-Id: <20200321144110.5010-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200321144110.5010-1-philmd@redhat.com>
References: <20200321144110.5010-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
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
v2: Do not declare g_idx in for() (Zoltan)
---
 hw/gpio/aspeed_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 41e11ea9b0..bd19db31f4 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -714,7 +714,7 @@ static void aspeed_gpio_write(void *opaque, hwaddr offs=
et, uint64_t data,
 static int get_set_idx(AspeedGPIOState *s, const char *group, int *group_i=
dx)
 {
     AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
-    int set_idx, g_idx =3D *group_idx;
+    int set_idx, g_idx;
=20
     for (set_idx =3D 0; set_idx < agc->nr_gpio_sets; set_idx++) {
         const GPIOSetProperties *set_props =3D &agc->props[set_idx];
--=20
2.21.1


