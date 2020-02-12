Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F9EC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F47C20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSxL7o6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F47C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ujy-0003Qr-5w
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1uiz-0001jX-Nd
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1uiy-0004by-CA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1uiy-0004bQ-86
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581524331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44B7xvdFL9drjnEYHmM0Jft6hxwGiV7s0cphZbAJGac=;
 b=iSxL7o6NO0h6VXLmZkWOWZ9WOSRd2dMq2l7NlIxIfeK65sBGY8cTCdFCvUcmOp5hcoMWiG
 Ay5O8XPInLxbJdWmKiy0CYTMQop71hPjaRnE6ZGjkPK571It/kKPdE1dFMvM1gddUuFKpt
 knIFp09FE23YBBs44ZpXhohIgaPJACo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-uPiQqPSjNvuDKSWV3XhifQ-1; Wed, 12 Feb 2020 11:18:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75447101FC6A;
 Wed, 12 Feb 2020 16:18:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55B3F5C1C3;
 Wed, 12 Feb 2020 16:18:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F41DD31E30; Wed, 12 Feb 2020 17:18:35 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] ui/sdl: switch to new show-cursor option
Date: Wed, 12 Feb 2020 17:18:30 +0100
Message-Id: <20200212161835.28576-6-kraxel@redhat.com>
In-Reply-To: <20200212161835.28576-1-kraxel@redhat.com>
References: <20200212161835.28576-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: uPiQqPSjNvuDKSWV3XhifQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use DisplayOpts settings instead of cursor_hide global variable.
Also make "-display sdl,show-cursor=3Don" work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
---
 ui/sdl2.c | 16 ++++++++--------
 vl.c      | 10 ++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9030f1c42efb..3c9424eb42c3 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -161,9 +161,9 @@ static void sdl_update_caption(struct sdl2_console *sco=
n)
     }
 }
=20
-static void sdl_hide_cursor(void)
+static void sdl_hide_cursor(struct sdl2_console *scon)
 {
-    if (!cursor_hide) {
+    if (scon->opts->has_show_cursor && scon->opts->show_cursor) {
         return;
     }
=20
@@ -175,9 +175,9 @@ static void sdl_hide_cursor(void)
     }
 }
=20
-static void sdl_show_cursor(void)
+static void sdl_show_cursor(struct sdl2_console *scon)
 {
-    if (!cursor_hide) {
+    if (scon->opts->has_show_cursor && scon->opts->show_cursor) {
         return;
     }
=20
@@ -216,7 +216,7 @@ static void sdl_grab_start(struct sdl2_console *scon)
             SDL_WarpMouseInWindow(scon->real_window, guest_x, guest_y);
         }
     } else {
-        sdl_hide_cursor();
+        sdl_hide_cursor(scon);
     }
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
     gui_grab =3D 1;
@@ -227,7 +227,7 @@ static void sdl_grab_end(struct sdl2_console *scon)
 {
     SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
     gui_grab =3D 0;
-    sdl_show_cursor();
+    sdl_show_cursor(scon);
     sdl_update_caption(scon);
 }
=20
@@ -658,7 +658,7 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
=20
     if (on) {
         if (!guest_cursor) {
-            sdl_show_cursor();
+            sdl_show_cursor(scon);
         }
         if (gui_grab || qemu_input_is_absolute() || absolute_enabled) {
             SDL_SetCursor(guest_sprite);
@@ -667,7 +667,7 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
             }
         }
     } else if (gui_grab) {
-        sdl_hide_cursor();
+        sdl_hide_cursor(scon);
     }
     guest_cursor =3D on;
     guest_x =3D x, guest_y =3D y;
diff --git a/vl.c b/vl.c
index 5419b3d68200..0a13cf2b1724 100644
--- a/vl.c
+++ b/vl.c
@@ -1931,6 +1931,16 @@ static void parse_display(const char *p)
                 } else {
                     goto invalid_sdl_args;
                 }
+            } else if (strstart(opts, ",show-cursor=3D", &nextopt)) {
+                opts =3D nextopt;
+                dpy.has_show_cursor =3D true;
+                if (strstart(opts, "on", &nextopt)) {
+                    dpy.show_cursor =3D true;
+                } else if (strstart(opts, "off", &nextopt)) {
+                    dpy.show_cursor =3D false;
+                } else {
+                    goto invalid_sdl_args;
+                }
             } else if (strstart(opts, ",gl=3D", &nextopt)) {
                 opts =3D nextopt;
                 dpy.has_gl =3D true;
--=20
2.18.2


