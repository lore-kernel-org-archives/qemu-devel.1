Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F4AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27942072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icWHILUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27942072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9q0v-0004D3-Rh
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ptH-0007bk-LL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ptG-0001mP-M9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ptG-0001mJ-J0
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHjWSXQJGHXqNSVRp2m+ndgaVWWtzd8pKBpNi2noriY=;
 b=icWHILUMfHGiRIMH+8LQ3lLAU9/Eq+mopmOdCsFMeCQwDyF3iD0r9NA/0p5X7xWW6WohBn
 QmvP//+7PpyZQkY0VVqoz4hyjwGe42pdKJkqrdI+GTDsHuu5Ak8hQdeZp5ca1MHtMOJyd8
 c+apTWfqv7zW4T5Lh1GaZmpvCoUAEdw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-9d7VKVjiMzC7hnrtXTy9-g-1; Thu, 05 Mar 2020 07:46:12 -0500
X-MC-Unique: 9d7VKVjiMzC7hnrtXTy9-g-1
Received: by mail-wm1-f69.google.com with SMTP id 7so2033004wmo.7
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=37TekRuQ1Sj7bzipU9xMQGxHx7Oe/Uk9FNfgupkTT1U=;
 b=Ihshiq1QR0i3zYBgCFnTEuNee0aTeqQouZhwysqM10Zt/XxCBA8/u9beoyrHk2blgP
 +ZLuguDDB2RZbm04cN0r6i1H52rvmLWx1qGJ80Vj9ZqTP7xURQwW0di1kBOjNX7P/Kvj
 CewrPGJYSam01yNziVHRJtmWmX0AMlUM5h8EK3wyB7IXjqw0TJd49Ar2w1p1TgTH/HNi
 GdxMabZWnjOGf8cWNn8SCNdmTsg76YTvWWJaVaBRCAYIbCw7XyFer/hWtALni9S6NG6o
 8clMABtLZUMcFS+R5Z7kjg9yvFaag6lmscQtbb7cWPKua0a/YRch9tLVZRQoFj2h+8Oo
 AeFg==
X-Gm-Message-State: ANhLgQ35Tuhqr9egYW61YPzuHtxGKhEUyFhLTDguAWWIqHrUBMI41jkb
 pbhqUPfjB9G1fYdTCrdEIeXynnTmFPjqQwkWOkwg6BCGKw6V0cJzNDxO9n/91/FpTE/GNVxRfsj
 +fzb1CJCEw/FVIhQ=
X-Received: by 2002:a5d:6544:: with SMTP id z4mr9651516wrv.31.1583412371623;
 Thu, 05 Mar 2020 04:46:11 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvVrt/Sswq4FSHm0E1EBtr0g0kjYs6V37K0HOy2fXC7aQIxGtsR2optAa52Vkzx0QP0QDKzXQ==
X-Received: by 2002:a5d:6544:: with SMTP id z4mr9651493wrv.31.1583412371400;
 Thu, 05 Mar 2020 04:46:11 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r12sm9493551wrw.77.2020.03.05.04.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:46:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] ui/curses: Move arrays to .heap to save 74KiB of .bss
Date: Thu,  5 Mar 2020 13:45:24 +0100
Message-Id: <20200305124525.14555-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305124525.14555-1-philmd@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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


