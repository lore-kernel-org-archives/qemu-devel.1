Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869A2C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4980D222C4
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EermZ3D4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4980D222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5zj-0001tU-Ut
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5pm-0006mC-3n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5pj-0006M2-Ts
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:05:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27781
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5pj-0006Ld-Q1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/mcHvKX7InUGUgT0KSXWZlTMQTnyJjgwdgTbknSH9s=;
 b=EermZ3D4Jz5xl9pUoGmCJmbvNdlG2Z09tAYt8paKJej3kqghZooKD1pCOlQdQxvBQtGtM2
 1+bo23j37M7KrVx2iykm1imivNUa9es6QvuAx69PHtmI9qkfrG6pw6Mi1Q2BHSkF77rGUS
 swnrfuZk80FGq2qjkyB7+mwy+PrcS3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-wHajOuMYMjS7RgWHsoVTeA-1; Fri, 08 Nov 2019 10:05:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 485B61005500
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:05:53 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED49D600CA;
 Fri,  8 Nov 2019 15:05:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 19/25] screendump: replace FILE with QIOChannel and fix
 close()/qemu_close()
Date: Fri,  8 Nov 2019 19:01:17 +0400
Message-Id: <20191108150123.12213-20-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wHajOuMYMjS7RgWHsoVTeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The file opened for ppm_save() may be a /dev/fdset, in which case a
dup fd is added to the fdset. It should be removed by calling
qemu_close(), instead of the implicit close() on fclose().

I don't see a convenient way to solve that with stdio streams, so I
switched the code to QIOChannel which uses qemu_close().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 77d62fe76d..587edf4ed4 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -33,6 +33,7 @@
 #include "chardev/char-fe.h"
 #include "trace.h"
 #include "exec/memory.h"
+#include "io/channel-file.h"
=20
 #define DEFAULT_BACKSCROLL 512
 #define CONSOLE_CURSOR_PERIOD 500
@@ -313,36 +314,31 @@ static bool ppm_save(int fd, DisplaySurface *ds, Erro=
r **errp)
 {
     int width =3D pixman_image_get_width(ds->image);
     int height =3D pixman_image_get_height(ds->image);
-    FILE *f;
+    g_autoptr(Object) ioc =3D OBJECT(qio_channel_file_new_fd(fd));
+    g_autofree char *header =3D NULL;
+    g_autoptr(pixman_image_t) linebuf =3D NULL;
+    g_autoptr(GError) error =3D NULL;
     int y;
-    int ret;
-    pixman_image_t *linebuf;
-    bool success =3D false;
=20
     trace_ppm_save(fd, ds);
-    f =3D fdopen(fd, "wb");
-    ret =3D fprintf(f, "P6\n%d %d\n%d\n", width, height, 255);
-    if (ret < 0) {
-        linebuf =3D NULL;
-        goto end;
+
+    header =3D g_strdup_printf("P6\n%d %d\n%d\n", width, height, 255);
+    if (qio_channel_write_all(QIO_CHANNEL(ioc),
+                              header, strlen(header), errp) < 0) {
+        return false;
     }
+
     linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
     for (y =3D 0; y < height; y++) {
         qemu_pixman_linebuf_fill(linebuf, ds->image, width, 0, y);
-        clearerr(f);
-        ret =3D fwrite(pixman_image_get_data(linebuf), 1,
-                     pixman_image_get_stride(linebuf), f);
-        (void)ret;
-        success =3D !ferror(f);
+        if (qio_channel_write_all(QIO_CHANNEL(ioc),
+                                  (char *)pixman_image_get_data(linebuf),
+                                  pixman_image_get_stride(linebuf), errp) =
< 0) {
+            return false;
+        }
     }
=20
-end:
-    if (!success) {
-        error_setg(errp, "failed to write to PPM file: %s", strerror(errno=
));
-    }
-    qemu_pixman_image_unref(linebuf);
-    fclose(f);
-    return success;
+    return true;
 }
=20
 void qmp_screendump(const char *filename, bool has_device, const char *dev=
ice,
--=20
2.24.0


