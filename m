Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F03C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0A6207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ep8FlFS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0A6207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir12a-0003dr-TB
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ir11e-00034L-R2
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ir11c-0000Oy-GK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:49:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ir11c-0000Mq-9K
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578926943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z+3odn98lGZbn5vm1Ja+HRL/VbdKuBpWGFhaN0sKXIw=;
 b=Ep8FlFS/aAxEZa/p3HH3kbB/uX/pIZpcT2sqKyapBqGv3PX0HJ9b0kmSsfZA5Spr+YqL67
 LxSD1X5OwZBPxH7ieuEmGHA3JaqZM0GPn579LX/CQ2FqfDKi9XkE/VhJ/Pu4mbW58qiALm
 AuvusD7xSa6pqvD4dK7vU/2WkcNODMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-86u0fwzhNbaOw9NAA_AC0g-1; Mon, 13 Jan 2020 09:49:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F2FB10BFB67
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 14:49:00 +0000 (UTC)
Received: from localhost (ovpn-112-66.ams2.redhat.com [10.36.112.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD535DA70;
 Mon, 13 Jan 2020 14:48:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] console: make QMP screendump use coroutine
Date: Mon, 13 Jan 2020 18:48:48 +0400
Message-Id: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 86u0fwzhNbaOw9NAA_AC0g-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks to the QMP coroutine support, the screendump handler can
trigger a graphic_hw_update(), yield and let the main loop run until
update is done. Then the handler is resumed, and the ppm_save() will
write the screen image to disk in the coroutine context (thus
non-blocking).

For now, HMP doesn't have coroutine support, so it remains potentially
outdated or glitched.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527

Based-on: <20200109183545.27452-2-kwolf@redhat.com>

Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/ui.json    |  3 ++-
 ui/console.c    | 35 +++++++++++++++++++++++++++--------
 ui/trace-events |  2 +-
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index e04525d8b4..d941202f34 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -96,7 +96,8 @@
 #
 ##
 { 'command': 'screendump',
-  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
+  'data': {'filename': 'str', '*device': 'str', '*head': 'int'},
+  'coroutine': true }
=20
 ##
 # =3D=3D Spice
diff --git a/ui/console.c b/ui/console.c
index ac79d679f5..db184b473f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -167,6 +167,7 @@ struct QemuConsole {
     QEMUFIFO out_fifo;
     uint8_t out_fifo_buf[16];
     QEMUTimer *kbd_timer;
+    Coroutine *screendump_co;
=20
     QTAILQ_ENTRY(QemuConsole) next;
 };
@@ -194,7 +195,6 @@ static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
 static void text_console_update_cursor_timer(void);
 static void text_console_update_cursor(void *opaque);
-static bool ppm_save(int fd, DisplaySurface *ds, Error **errp);
=20
 static void gui_update(void *opaque)
 {
@@ -263,6 +263,9 @@ static void gui_setup_refresh(DisplayState *ds)
=20
 void graphic_hw_update_done(QemuConsole *con)
 {
+    if (con && con->screendump_co) {
+        aio_co_wake(con->screendump_co);
+    }
 }
=20
 void graphic_hw_update(QemuConsole *con)
@@ -310,16 +313,16 @@ void graphic_hw_invalidate(QemuConsole *con)
     }
 }
=20
-static bool ppm_save(int fd, DisplaySurface *ds, Error **errp)
+static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
 {
-    int width =3D pixman_image_get_width(ds->image);
-    int height =3D pixman_image_get_height(ds->image);
+    int width =3D pixman_image_get_width(image);
+    int height =3D pixman_image_get_height(image);
     g_autoptr(Object) ioc =3D OBJECT(qio_channel_file_new_fd(fd));
     g_autofree char *header =3D NULL;
     g_autoptr(pixman_image_t) linebuf =3D NULL;
     int y;
=20
-    trace_ppm_save(fd, ds);
+    trace_ppm_save(fd, image);
=20
     header =3D g_strdup_printf("P6\n%d %d\n%d\n", width, height, 255);
     if (qio_channel_write_all(QIO_CHANNEL(ioc),
@@ -329,7 +332,7 @@ static bool ppm_save(int fd, DisplaySurface *ds, Error =
**errp)
=20
     linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
     for (y =3D 0; y < height; y++) {
-        qemu_pixman_linebuf_fill(linebuf, ds->image, width, 0, y);
+        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
         if (qio_channel_write_all(QIO_CHANNEL(ioc),
                                   (char *)pixman_image_get_data(linebuf),
                                   pixman_image_get_stride(linebuf), errp) =
< 0) {
@@ -340,11 +343,18 @@ static bool ppm_save(int fd, DisplaySurface *ds, Erro=
r **errp)
     return true;
 }
=20
+static void graphic_hw_update_bh(void *con)
+{
+    graphic_hw_update(con);
+}
+
+/* may be called in coroutine context or not */
 void qmp_screendump(const char *filename, bool has_device, const char *dev=
ice,
                     bool has_head, int64_t head, Error **errp)
 {
     QemuConsole *con;
     DisplaySurface *surface;
+    g_autoptr(pixman_image_t) image =3D NULL;
     int fd;
=20
     if (has_device) {
@@ -365,7 +375,15 @@ void qmp_screendump(const char *filename, bool has_dev=
ice, const char *device,
         }
     }
=20
-    graphic_hw_update(con);
+    if (qemu_in_coroutine()) {
+        assert(!con->screendump_co);
+        con->screendump_co =3D qemu_coroutine_self();
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                graphic_hw_update_bh, con);
+        qemu_coroutine_yield();
+        con->screendump_co =3D NULL;
+    }
+
     surface =3D qemu_console_surface(con);
     if (!surface) {
         error_setg(errp, "no surface");
@@ -379,7 +397,8 @@ void qmp_screendump(const char *filename, bool has_devi=
ce, const char *device,
         return;
     }
=20
-    if (!ppm_save(fd, surface, errp)) {
+    image =3D pixman_image_ref(surface->image);
+    if (!ppm_save(fd, image, errp)) {
         qemu_unlink(filename);
     }
 }
diff --git a/ui/trace-events b/ui/trace-events
index 0dcda393c1..e8726fc969 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -15,7 +15,7 @@ displaysurface_create_pixman(void *display_surface) "surf=
ace=3D%p"
 displaysurface_free(void *display_surface) "surface=3D%p"
 displaychangelistener_register(void *dcl, const char *name) "%p [ %s ]"
 displaychangelistener_unregister(void *dcl, const char *name) "%p [ %s ]"
-ppm_save(int fd, void *display_surface) "fd=3D%d surface=3D%p"
+ppm_save(int fd, void *image) "fd=3D%d image=3D%p"
=20
 # gtk.c
 # gtk-gl-area.c
--=20
2.25.0.rc2.1.g09a9a1a997


