Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B2C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CBE20730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PydCvuJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CBE20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfOX-0004w9-HY
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izfLW-0008Ui-GK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izfLV-00023R-DU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izfLV-0001z6-8p
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580988559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IyWKhwRUQwRI8lwf4+TcJFmra3ViPznqxEAADo0NuY=;
 b=PydCvuJq0JxMeVhaM7TRC118/UxEbKlSQTF6BnzdhJ3bwIWGdG1P/NVJXHJtFBcwqtoVFA
 LmmonSxBbOJef8JwRFphhaV45DinWRNw1nuhUOtkXbFq38jQd15X4cVbNMdR5nz2d+NwJQ
 yDssIHtlLDcEzqUltligZOPtLOdBjBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-HhpVB1LMPvCykU-yEPHEeg-1; Thu, 06 Feb 2020 06:29:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EE2B1034B3B;
 Thu,  6 Feb 2020 11:29:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9C7B26FB0;
 Thu,  6 Feb 2020 11:29:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 165769D1E; Thu,  6 Feb 2020 12:29:09 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] ui/sdl: implement show-cursor option
Date: Thu,  6 Feb 2020 12:29:05 +0100
Message-Id: <20200206112908.5002-4-kraxel@redhat.com>
In-Reply-To: <20200206112908.5002-1-kraxel@redhat.com>
References: <20200206112908.5002-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HhpVB1LMPvCykU-yEPHEeg-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jtomko@redhat.com,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 jpewhacker@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
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


