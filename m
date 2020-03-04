Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D082C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587962073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEJ92Dli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587962073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cOP-0005dh-Ii
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9cLk-0000iH-L5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9cLj-0006zS-H5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9cLj-0006yv-D4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583360323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHjWSXQJGHXqNSVRp2m+ndgaVWWtzd8pKBpNi2noriY=;
 b=fEJ92Dlitq1sDGCjas+WKsHVvXHp2f2xzLAbhmdncoX1GIrjR8ciazgR8L9yZXfZzHwuWR
 CxkIa0Wq/HbScf83UuwBWJUCRo8ZLQB/rerv8omF6GuZyTxdP6CfZcBO7RH4cIBlZd5TKr
 GBszbfbMfyRm0hAJOEBwj3gPFTtHqVw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-2sL06UP2NouvJgmLzdmlWA-1; Wed, 04 Mar 2020 17:18:41 -0500
X-MC-Unique: 2sL06UP2NouvJgmLzdmlWA-1
Received: by mail-wr1-f72.google.com with SMTP id p11so1441706wrn.10
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 14:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=37TekRuQ1Sj7bzipU9xMQGxHx7Oe/Uk9FNfgupkTT1U=;
 b=HpKUMSuiFMeFygA2+EN9hSFXq18QroshhN4W68zS84Oc9RR/EUVBcnGtllBLQ3/USp
 9CjfS+QRB8UuMK8V/WU/YykVufFC315Eld4EhsoeGiCpWTQgW+BTWvFvOvDezLzh6Ud9
 AZQG96s/+0EteUgDD+M/com413flukfd9wDwFFM+T2ba1W/H2Prg51fyto90QbSBUvju
 Pzy+iYLV+g9xW9diKElLvIj4tWmlfKV13WhOQqzWpzAV0j4KnBcJTKClK4PfD9oPYlbo
 BCZvauXANo5+tKm9WzFjR8/ZuafkWOogxYL9kjjIi/RLaAE+Ztb3wlbcp2K3hoAmCTQ2
 5xpA==
X-Gm-Message-State: ANhLgQ1Mr1jlwwCpTlwN9MJB6PsPYNLpgrcS7fdCuDfTxUQ6TD44vezG
 gJ/XGG046gztwnI/2CWJICCejUv05KucCVwYyhqkECmsgRZEaphgx4+c76Zv78ko2lBA63qRR3Y
 2l/8SSHB8qwsDkE4=
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr5809805wma.55.1583360320033; 
 Wed, 04 Mar 2020 14:18:40 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtOyc7p4gYjJFDvQtmH81U0uCFCbPF2K0vdpDiKNOiykLu2BoveuujIYG0oQbz2cnxOnxpr4Q==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr5809777wma.55.1583360319639; 
 Wed, 04 Mar 2020 14:18:39 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b82sm6438319wmb.16.2020.03.04.14.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 14:18:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] ui/curses: Move arrays to .heap to save 74KiB of .bss
Date: Wed,  4 Mar 2020 23:18:07 +0100
Message-Id: <20200304221807.25212-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304221807.25212-1-philmd@redhat.com>
References: <20200304221807.25212-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only need these arrays when using the curses display.
Move them from the .bss to the .heap (sizes reported on
x86_64 host: screen[] is 64KiB, vga_to_curses 7KiB).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 ui/curses.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 3bafc10c1c..a59b23a9cf 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -54,13 +54,13 @@ enum maybe_keycode {
 };
=20
 static DisplayChangeListener *dcl;
-static console_ch_t screen[160 * 100];
+static console_ch_t *screen;
 static WINDOW *screenpad =3D NULL;
 static int width, height, gwidth, gheight, invalidate;
 static int px, py, sminx, sminy, smaxx, smaxy;
=20
 static const char *font_charset =3D "CP437";
-static cchar_t vga_to_curses[256];
+static cchar_t *vga_to_curses;
=20
 static void curses_update(DisplayChangeListener *dcl,
                           int x, int y, int w, int h)
@@ -405,6 +405,8 @@ static void curses_refresh(DisplayChangeListener *dcl)
 static void curses_atexit(void)
 {
     endwin();
+    g_free(vga_to_curses);
+    g_free(screen);
 }
=20
 /*
@@ -783,6 +785,8 @@ static void curses_display_init(DisplayState *ds, Displ=
ayOptions *opts)
     if (opts->u.curses.charset) {
         font_charset =3D opts->u.curses.charset;
     }
+    screen =3D g_new0(console_ch_t, 160 * 100);
+    vga_to_curses =3D g_new0(cchar_t, 256);
     curses_setup();
     curses_keyboard_setup();
     atexit(curses_atexit);
--=20
2.21.1


