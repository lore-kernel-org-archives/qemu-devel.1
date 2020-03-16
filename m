Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5802C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73259205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiRkIFr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73259205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxdw-0003Hw-L9
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHs-00044E-1F
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHo-0006EL-Uk
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHo-0006BT-Ps
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h648SmwpCvwN1dBwySehpb4Gdc3DelTHBZmWsV2C42c=;
 b=HiRkIFr81c3n4yx03zVrJ2tex/oOIBZTgNMZ0dpgQ+kDXHS5QLYcnO5yKPyiqRM+siWwFI
 WVsp1G89Y30mfYhvnuQi9X20xVHQhKdtefU/hqj3d2mmrpyIvRF7pEnnCUDm2pWKX5oXci
 RnucTxvTCAABdHjnfQQImIwNBe1nMd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-vnpjGgGQOvugPX1o4xtHvw-1; Mon, 16 Mar 2020 17:28:27 -0400
X-MC-Unique: vnpjGgGQOvugPX1o4xtHvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3437C1085936
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:26 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 405AA19C4F;
 Mon, 16 Mar 2020 21:28:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/61] ui/curses: Move arrays to .heap to save 74KiB of .bss
Date: Mon, 16 Mar 2020 22:26:56 +0100
Message-Id: <1584394048-44994-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

We only need these arrays when using the curses display.
Move them from the .bss to the .heap (sizes reported on
x86_64 host: screen[] is 64KiB, vga_to_curses 7KiB).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/curses.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 3bafc10..a59b23a 100644
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
1.8.3.1



