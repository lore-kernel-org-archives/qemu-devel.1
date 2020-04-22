Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B3EC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621A32076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGa5zq6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621A32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFWi-0001CT-Fx
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUL-0006Px-By
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUD-0002iB-H3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFUD-0002de-3B
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVOONsEpk4U6LFttK9TygLseO38jIaZn5oKoHqGQGaQ=;
 b=DGa5zq6/loepDv1SiBtTTiHN5SI2ISvlt4yLBpUwTPmdyhxSGndXMrPSuto+EuHS0TCf3t
 /Mkz73XAGzXoWm7vniFeS7Fv4OmB3AF3dbNOVvS+n67xmBf+ok1K83w+Gn3a94G7EEyVps
 fuGm3uuoR5O1ETy7t7OHfzfDi2OeMAU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-KrUF0xuuNamI_2HKTRkaxw-1; Wed, 22 Apr 2020 09:32:16 -0400
X-MC-Unique: KrUF0xuuNamI_2HKTRkaxw-1
Received: by mail-wm1-f72.google.com with SMTP id n17so807264wmi.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S6WvnF67wihOHFujRWuSLGe59jb6c00JiTbf8Rd3b+M=;
 b=oFChc74oD2vcU6aFmzLdsQg64Sm1niu1D2hERc9QoOcnOUUTwgnUtabvSG/w7PJgA4
 N69vdYDh+4jNVG9pMlOdCmuaodAre1rYQuR7wnMx5wn88tMlKDMOlIgGlAAYVjwFxdH7
 IknpamDCj3sLb3MLI9FHKUWo30L30lCNyI0hfcu+8Uloph/q9YazeOuGa/I3PandOfda
 t3thIkwDFObFQclrWfWL8brHd/xtIg95EtY0tAXYa/NKtH+JSPpdJuIIWW56s6gg+kD4
 2Vaf+a1p53rCd2h2d6sp8jjKiKKUYEPk9SBM05p//nSzHKpQ9t8uNVkO3Jf3USSbBCSZ
 qvRw==
X-Gm-Message-State: AGi0PuYLbexdEOfVpLPjBhq6LtA1n+5LKy+BzZv3toZs8ITZObD/UE49
 Wi93yX1uYm3tZDpM3lx1gBxH3AJj6YHtUnzsZMt/H2sV4oz4urCBTgnaT4k4X7x4Yqn4BOx2TdO
 AafYRixCNtdCLy0g=
X-Received: by 2002:a5d:5304:: with SMTP id e4mr28251639wrv.87.1587562335036; 
 Wed, 22 Apr 2020 06:32:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypKTeUTC6gkp8EoASB2jIwR7sEykaxaGUnt172xGztNTXm45k8P9Url5pwWP/8pb2/MDtjPKRA==
X-Received: by 2002:a5d:5304:: with SMTP id e4mr28251626wrv.87.1587562334830; 
 Wed, 22 Apr 2020 06:32:14 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm7542662wma.47.2020.04.22.06.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:32:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] hw/input/adb-kbd: Remove dead assignment
Date: Wed, 22 Apr 2020 15:31:47 +0200
Message-Id: <20200422133152.16770-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
References: <20200422133152.16770-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "open list:Old World g3beige" <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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


