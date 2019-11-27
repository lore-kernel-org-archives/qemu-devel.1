Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0409C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 11:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC90204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 11:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8iRX7Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC90204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZvtK-0000C2-8o
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 06:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iZvrt-0007XT-2P
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iZvrr-0005Rt-Sv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:52:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iZvrr-0005RY-P5
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574855543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1ucJ6NKYXWH5sQrD20ObkaHhvH2o7eTENB8vIcNSk0=;
 b=h8iRX7YzDT8oYpxzLQRqJLZMKkNqL/usRZv47VoF+iHdpakXMn2AVCsWXees+gN0GynaqK
 iX67Qms2lxX02C2k/xr6oW877SG0uWXr4obJUwjzGBYU/zqCToqByNwBMyG9nI9Y5Ijsvt
 KFPZ04IVcjXFomi1APpu3xhY/Yozn14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-hwVecMjFOaKsyR6zNbdAXA-1; Wed, 27 Nov 2019 06:52:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D5701005516
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 11:52:21 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44D06608EB;
 Wed, 27 Nov 2019 11:52:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] console: add graphic_hw_update_done()
Date: Wed, 27 Nov 2019 15:51:56 +0400
Message-Id: <20191127115202.375107-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191127115202.375107-1-marcandre.lureau@redhat.com>
References: <20191127115202.375107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hwVecMjFOaKsyR6zNbdAXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a function to be called when a graphic update is done.

Declare the QXL renderer as async: render_update_cookie_num counts the
number of outstanding updates, and graphic_hw_update_done() is called
when it reaches none.

(note: this is preliminary work for asynchronous screendump support)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl-render.c | 9 +++++++--
 hw/display/qxl.c        | 1 +
 include/ui/console.h    | 2 ++
 ui/console.c            | 9 +++++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index f7fdc4901e..3ce2e57b8f 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -109,7 +109,7 @@ static void qxl_render_update_area_unlocked(PCIQXLDevic=
e *qxl)
                                                 qxl->guest_primary.surface=
.mem,
                                                 MEMSLOT_GROUP_GUEST);
         if (!qxl->guest_primary.data) {
-            return;
+            goto end;
         }
         qxl_set_rect_to_surface(qxl, &qxl->dirty[0]);
         qxl->num_dirty_rects =3D 1;
@@ -137,7 +137,7 @@ static void qxl_render_update_area_unlocked(PCIQXLDevic=
e *qxl)
     }
=20
     if (!qxl->guest_primary.data) {
-        return;
+        goto end;
     }
     for (i =3D 0; i < qxl->num_dirty_rects; i++) {
         if (qemu_spice_rect_is_empty(qxl->dirty+i)) {
@@ -158,6 +158,11 @@ static void qxl_render_update_area_unlocked(PCIQXLDevi=
ce *qxl)
                        qxl->dirty[i].bottom - qxl->dirty[i].top);
     }
     qxl->num_dirty_rects =3D 0;
+
+end:
+    if (qxl->render_update_cookie_num =3D=3D 0) {
+        graphic_hw_update_done(qxl->ssd.dcl.con);
+    }
 }
=20
 /*
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index cd7eb39d20..6d43b7433c 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1181,6 +1181,7 @@ static const QXLInterface qxl_interface =3D {
=20
 static const GraphicHwOps qxl_ops =3D {
     .gfx_update  =3D qxl_hw_update,
+    .gfx_update_async =3D true,
 };
=20
 static void qxl_enter_vga_mode(PCIQXLDevice *d)
diff --git a/include/ui/console.h b/include/ui/console.h
index f981696848..281f9c145b 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -365,6 +365,7 @@ static inline void console_write_ch(console_ch_t *dest,=
 uint32_t ch)
 typedef struct GraphicHwOps {
     void (*invalidate)(void *opaque);
     void (*gfx_update)(void *opaque);
+    bool gfx_update_async; /* if true, calls graphic_hw_update_done() */
     void (*text_update)(void *opaque, console_ch_t *text);
     void (*update_interval)(void *opaque, uint64_t interval);
     int (*ui_info)(void *opaque, uint32_t head, QemuUIInfo *info);
@@ -380,6 +381,7 @@ void graphic_console_set_hwops(QemuConsole *con,
 void graphic_console_close(QemuConsole *con);
=20
 void graphic_hw_update(QemuConsole *con);
+void graphic_hw_update_done(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
diff --git a/ui/console.c b/ui/console.c
index 82d1ddac9c..3c941528d2 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -259,13 +259,22 @@ static void gui_setup_refresh(DisplayState *ds)
     ds->have_text =3D have_text;
 }
=20
+void graphic_hw_update_done(QemuConsole *con)
+{
+}
+
 void graphic_hw_update(QemuConsole *con)
 {
+    bool async =3D false;
     if (!con) {
         con =3D active_console;
     }
     if (con && con->hw_ops->gfx_update) {
         con->hw_ops->gfx_update(con->hw);
+        async =3D con->hw_ops->gfx_update_async;
+    }
+    if (!async) {
+        graphic_hw_update_done(con);
     }
 }
=20
--=20
2.24.0


