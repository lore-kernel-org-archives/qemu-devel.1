Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0030BC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18A32072D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alEv05n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18A32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfQq-0007fG-RP
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFfJo-00058A-55
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFfJn-0007On-1T
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44217)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFfJm-0007OP-T0
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584801702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HG9aIClnSQgwbfwrNWlQigZ+p9jo+t2veKUaX85pzII=;
 b=alEv05n2sfcCenreaQ42B7wM3I9K2QyGTYZ/MOk7pImV/CRtija0xP0/vTgOt924/374W/
 hjzjKpX3p9ZcA4DNLwdbhllifUP3ywBB28RsAa8H1xW0BeLH4ckw7OrvOTki6Q1JQJJKos
 aUSHudgDfdfkUbKKzOpK4AOInkioVWg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-gvao1BEFNta2hZ19pTJemg-1; Sat, 21 Mar 2020 10:41:40 -0400
X-MC-Unique: gvao1BEFNta2hZ19pTJemg-1
Received: by mail-wm1-f71.google.com with SMTP id h203so2403826wme.2
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eqn1OJZAYDlLgDc90kBVx1WWSAviOqkIwIwDScG0wiQ=;
 b=T4ixOD9XaNTVwIGkbsAKSe/DCjD8xqtUHmb5B5A8dFcwPurBQep7DSTD5OPNCsgsAX
 DkdYtT1ARv4YNe55xqnbCXYQoDyinZLYWFF0CReMtCIIhvwEmt1fuTEgt1ULw1Vp8fw0
 QzVgE938R7hjDTVHvaX5wlAgdBYkhO3X/q4qJxz4rE9X2KNwsbFHpepL30d3C8Mtg4Cx
 46DxGIlAK+yrYAlX/c8tZC3yAyNCdae4TsoW0Hdb/tebUB99uh3pQeojufjL02kXl3Yj
 KYaaXuCD+xPdQUJ/VxKYRPEf6kXfc5frSnObbUG+ZPDGVexhjwiwKat55bo1eNncHk84
 izIA==
X-Gm-Message-State: ANhLgQ2ZoM3msB59pFjDI63LC2N1lepYfIvxc/pHnIGj+EPffCjd9QEg
 7Xho7CPCSzRYswxIybxk5zrckAyFrqH2jYB+jwI7tvWu0EYqZ6T2YmNXEHGLsr2M5lEHkOpsKZP
 1f9qs1jBOXwCQO+w=
X-Received: by 2002:a05:600c:4145:: with SMTP id
 h5mr16372107wmm.3.1584801699580; 
 Sat, 21 Mar 2020 07:41:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsFAJVC1HBS34XteUQ0Qhlp+mZ6lovZPo5MIfUGGv+y3kPDMfyEF1bRg2/TCyRoOapzMf1fsQ==
X-Received: by 2002:a05:600c:4145:: with SMTP id
 h5mr16372067wmm.3.1584801699378; 
 Sat, 21 Mar 2020 07:41:39 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id a13sm14020382wrh.80.2020.03.21.07.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 07:41:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 04/11] hw/input/adb-kbd: Remove dead assignment
Date: Sat, 21 Mar 2020 15:41:03 +0100
Message-Id: <20200321144110.5010-5-philmd@redhat.com>
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

Since commit 5a1f49718 the 'olen' variable is not really
used. Remove it to fix a warning reported by Clang static
code analyzer:

    CC      hw/input/adb-kbd.o
  hw/input/adb-kbd.c:200:5: warning: Value stored to 'olen' is never read
      olen =3D 0;
      ^      ~

Fixes: 5a1f49718 (adb: add support for QKeyCode)
Reported-by: Clang Static Analyzer
Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Remove 'olen' (Zoltan)
---
 hw/input/adb-kbd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 0ba8207589..a6d5c9b7c9 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -195,9 +195,7 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
 {
     KBDState *s =3D ADB_KEYBOARD(d);
     int keycode;
-    int olen;
=20
-    olen =3D 0;
     if (s->count =3D=3D 0) {
         return 0;
     }
@@ -216,7 +214,6 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
     if (keycode =3D=3D 0x7f) {
         obuf[0] =3D 0x7f;
         obuf[1] =3D 0x7f;
-        olen =3D 2;
     } else {
         obuf[0] =3D keycode;
         /* NOTE: the power key key-up is the two byte sequence 0xff 0xff;
@@ -224,10 +221,9 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
          * byte, but choose not to bother.
          */
         obuf[1] =3D 0xff;
-        olen =3D 2;
     }
=20
-    return olen;
+    return 2;
 }
=20
 static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
--=20
2.21.1


