Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A61C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C464920674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsFydWDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C464920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIV5-00079i-VH
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izITZ-00053j-JA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izITY-0000Z9-FL
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42387
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izITX-0000TN-8V
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwUdRd2fQfsOrRbTu7Qwh8J+ZBvLle2DPqjOw4ixKx0=;
 b=NsFydWDpCSD/y/RBPvKOq5LFdNM8upcs3P2DgUFKrhmi3O6ol1OlsQD0eLTA1jp8YX61lz
 /sHW2TF8EaEXEl7gXXbXtYL5HRnWScFWPzerdwljPmEShuiwea/8ppWYtkmcmudbUUQUKR
 +BshP+LQtRE6shHL5aKUE8kmutAL7t0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-_oKXWm2mN_WRcS8-K6d3gw-1; Wed, 05 Feb 2020 06:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6229318C43C5;
 Wed,  5 Feb 2020 11:04:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A5381A7E3;
 Wed,  5 Feb 2020 11:03:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9C26A9C7F; Wed,  5 Feb 2020 12:03:56 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] ui/sdl: implement show-cursor option
Date: Wed,  5 Feb 2020 12:03:54 +0100
Message-Id: <20200205110356.3491-4-kraxel@redhat.com>
In-Reply-To: <20200205110356.3491-1-kraxel@redhat.com>
References: <20200205110356.3491-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _oKXWm2mN_WRcS8-K6d3gw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 jpewhacker@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9030f1c42efb..e18555b10a42 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -161,9 +161,15 @@ static void sdl_update_caption(struct sdl2_console *sc=
on)
     }
 }
=20
-static void sdl_hide_cursor(void)
+static void sdl_hide_cursor(struct sdl2_console *scon)
 {
-    if (!cursor_hide) {
+    bool allow_hide_cursor =3D true;
+
+    if (scon->opts->has_show_cursor && scon->opts->show_cursor) {
+        allow_hide_cursor =3D false;
+    }
+
+    if (!allow_hide_cursor) {
         return;
     }
=20
@@ -175,9 +181,15 @@ static void sdl_hide_cursor(void)
     }
 }
=20
-static void sdl_show_cursor(void)
+static void sdl_show_cursor(struct sdl2_console *scon)
 {
-    if (!cursor_hide) {
+    bool allow_hide_cursor =3D true;
+
+    if (scon->opts->has_show_cursor && scon->opts->show_cursor) {
+        allow_hide_cursor =3D false;
+    }
+
+    if (!allow_hide_cursor) {
         return;
     }
=20
@@ -216,7 +228,7 @@ static void sdl_grab_start(struct sdl2_console *scon)
             SDL_WarpMouseInWindow(scon->real_window, guest_x, guest_y);
         }
     } else {
-        sdl_hide_cursor();
+        sdl_hide_cursor(scon);
     }
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
     gui_grab =3D 1;
@@ -227,7 +239,7 @@ static void sdl_grab_end(struct sdl2_console *scon)
 {
     SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
     gui_grab =3D 0;
-    sdl_show_cursor();
+    sdl_show_cursor(scon);
     sdl_update_caption(scon);
 }
=20
@@ -658,7 +670,7 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
=20
     if (on) {
         if (!guest_cursor) {
-            sdl_show_cursor();
+            sdl_show_cursor(scon);
         }
         if (gui_grab || qemu_input_is_absolute() || absolute_enabled) {
             SDL_SetCursor(guest_sprite);
@@ -667,7 +679,7 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
             }
         }
     } else if (gui_grab) {
-        sdl_hide_cursor();
+        sdl_hide_cursor(scon);
     }
     guest_cursor =3D on;
     guest_x =3D x, guest_y =3D y;
--=20
2.18.1


