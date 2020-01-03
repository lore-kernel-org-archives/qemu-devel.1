Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8347BC00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F27422314
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+OnuVk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F27422314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inJ0A-0004r7-1s
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 04:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1inIxa-0001e0-MG
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1inIxZ-0007yk-Bp
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:09:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1inIxZ-0007xl-7I
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578042572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JY6AQzrDnS+Z1i9WDo6L3HcKsZ6Xsjg4nEeKG37YkrU=;
 b=K+OnuVk7DXKovKe939nF7452wRUKVHUjrhd+/JuZh5Yu0koGEFh0pdoQ9RcOy09+F6TkNn
 dV3fq/aUlsvQzzbtL/SECm9pdmddBqLgmuEGxg7nRqWko8Z/Y7Du+a1f2+eq5N+0qvvTKV
 R+dIMOBTbnILB5BaG21Kr0TtDX5VfM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-vqj7IuGxOAKF9tsLoZ0A1g-1; Fri, 03 Jan 2020 04:09:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6ACA800D48;
 Fri,  3 Jan 2020 09:09:27 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C78F27BFA3;
 Fri,  3 Jan 2020 09:09:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 2/7] ppm-save: pass opened fd
Date: Fri,  3 Jan 2020 13:08:48 +0400
Message-Id: <20200103090853.1014627-3-marcandre.lureau@redhat.com>
In-Reply-To: <20200103090853.1014627-1-marcandre.lureau@redhat.com>
References: <20200103090853.1014627-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vqj7IuGxOAKF9tsLoZ0A1g-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow to pre-open the file before running the async finish
handler and avoid potential monitor fdset races.

(note: this is preliminary work for asynchronous screendump support)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/console.c    | 45 ++++++++++++++++++++++-----------------------
 ui/trace-events |  2 +-
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 3c941528d2..77d62fe76d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -193,6 +193,7 @@ static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
 static void text_console_update_cursor_timer(void);
 static void text_console_update_cursor(void *opaque);
+static bool ppm_save(int fd, DisplaySurface *ds, Error **errp);
=20
 static void gui_update(void *opaque)
 {
@@ -308,29 +309,22 @@ void graphic_hw_invalidate(QemuConsole *con)
     }
 }
=20
-static void ppm_save(const char *filename, DisplaySurface *ds,
-                     Error **errp)
+static bool ppm_save(int fd, DisplaySurface *ds, Error **errp)
 {
     int width =3D pixman_image_get_width(ds->image);
     int height =3D pixman_image_get_height(ds->image);
-    int fd;
     FILE *f;
     int y;
     int ret;
     pixman_image_t *linebuf;
+    bool success =3D false;
=20
-    trace_ppm_save(filename, ds);
-    fd =3D qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 06=
66);
-    if (fd =3D=3D -1) {
-        error_setg(errp, "failed to open file '%s': %s", filename,
-                   strerror(errno));
-        return;
-    }
+    trace_ppm_save(fd, ds);
     f =3D fdopen(fd, "wb");
     ret =3D fprintf(f, "P6\n%d %d\n%d\n", width, height, 255);
     if (ret < 0) {
         linebuf =3D NULL;
-        goto write_err;
+        goto end;
     }
     linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
     for (y =3D 0; y < height; y++) {
@@ -339,21 +333,16 @@ static void ppm_save(const char *filename, DisplaySur=
face *ds,
         ret =3D fwrite(pixman_image_get_data(linebuf), 1,
                      pixman_image_get_stride(linebuf), f);
         (void)ret;
-        if (ferror(f)) {
-            goto write_err;
-        }
+        success =3D !ferror(f);
     }
=20
-out:
+end:
+    if (!success) {
+        error_setg(errp, "failed to write to PPM file: %s", strerror(errno=
));
+    }
     qemu_pixman_image_unref(linebuf);
     fclose(f);
-    return;
-
-write_err:
-    error_setg(errp, "failed to write to file '%s': %s", filename,
-               strerror(errno));
-    unlink(filename);
-    goto out;
+    return success;
 }
=20
 void qmp_screendump(const char *filename, bool has_device, const char *dev=
ice,
@@ -361,6 +350,7 @@ void qmp_screendump(const char *filename, bool has_devi=
ce, const char *device,
 {
     QemuConsole *con;
     DisplaySurface *surface;
+    int fd;
=20
     if (has_device) {
         con =3D qemu_console_lookup_by_device_name(device, has_head ? head=
 : 0,
@@ -387,7 +377,16 @@ void qmp_screendump(const char *filename, bool has_dev=
ice, const char *device,
         return;
     }
=20
-    ppm_save(filename, surface, errp);
+    fd =3D qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 06=
66);
+    if (fd =3D=3D -1) {
+        error_setg(errp, "failed to open file '%s': %s", filename,
+                   strerror(errno));
+        return;
+    }
+
+    if (!ppm_save(fd, surface, errp)) {
+        unlink(filename);
+    }
 }
=20
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
diff --git a/ui/trace-events b/ui/trace-events
index 63de72a798..0dcda393c1 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -15,7 +15,7 @@ displaysurface_create_pixman(void *display_surface) "surf=
ace=3D%p"
 displaysurface_free(void *display_surface) "surface=3D%p"
 displaychangelistener_register(void *dcl, const char *name) "%p [ %s ]"
 displaychangelistener_unregister(void *dcl, const char *name) "%p [ %s ]"
-ppm_save(const char *filename, void *display_surface) "%s surface=3D%p"
+ppm_save(int fd, void *display_surface) "fd=3D%d surface=3D%p"
=20
 # gtk.c
 # gtk-gl-area.c
--=20
2.24.0.308.g228f53135a


