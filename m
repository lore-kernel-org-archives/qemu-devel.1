Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F239C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871CB207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVH3yD78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871CB207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLiu-0000ZX-E3
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRLgd-0007H9-6b
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRLgb-00075p-6F
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602362508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lZpMa6xjU/KAtKaQQ9+A7orLKgxzHKmxpQRLMy4ubs=;
 b=HVH3yD78YSKK/jF7KqXghLHY43lR6DFVKIupr2VgkUdu0Qhgud5f4PtMk6N4oich35r52a
 pk312FolvCyT2BC9NWrksQLSyT88jFMWPJzQvHovuMSB75JX8w+hyKdjbCbGoZ3ksNXlYT
 eYe1M/4j3v6+HMhhEnQw3TPn0kntPpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-X7aei5ofOamsw0wpOllCHg-1; Sat, 10 Oct 2020 16:41:46 -0400
X-MC-Unique: X7aei5ofOamsw0wpOllCHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91134107AD28
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 20:41:45 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 564C176665;
 Sat, 10 Oct 2020 20:41:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] console: modify ppm_save to take a pixman image ref
Date: Sun, 11 Oct 2020 00:41:05 +0400
Message-Id: <20201010204106.1368710-3-marcandre.lureau@redhat.com>
In-Reply-To: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
References: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 16:41:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The function is going to be called from a coroutine, and may yields.
Let's ensure our image reference doesn't change over time (due to resize
etc) by keeping a ref.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c    | 15 ++++++++-------
 ui/trace-events |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 54a74c0b16..a56fe0dd26 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -195,7 +195,6 @@ static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
 static void text_console_update_cursor_timer(void);
 static void text_console_update_cursor(void *opaque);
-static bool ppm_save(int fd, DisplaySurface *ds, Error **errp);
 
 static void gui_update(void *opaque)
 {
@@ -311,16 +310,16 @@ void graphic_hw_invalidate(QemuConsole *con)
     }
 }
 
-static bool ppm_save(int fd, DisplaySurface *ds, Error **errp)
+static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
 {
-    int width = pixman_image_get_width(ds->image);
-    int height = pixman_image_get_height(ds->image);
+    int width = pixman_image_get_width(image);
+    int height = pixman_image_get_height(image);
     g_autoptr(Object) ioc = OBJECT(qio_channel_file_new_fd(fd));
     g_autofree char *header = NULL;
     g_autoptr(pixman_image_t) linebuf = NULL;
     int y;
 
-    trace_ppm_save(fd, ds);
+    trace_ppm_save(fd, image);
 
     header = g_strdup_printf("P6\n%d %d\n%d\n", width, height, 255);
     if (qio_channel_write_all(QIO_CHANNEL(ioc),
@@ -330,7 +329,7 @@ static bool ppm_save(int fd, DisplaySurface *ds, Error **errp)
 
     linebuf = qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
     for (y = 0; y < height; y++) {
-        qemu_pixman_linebuf_fill(linebuf, ds->image, width, 0, y);
+        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
         if (qio_channel_write_all(QIO_CHANNEL(ioc),
                                   (char *)pixman_image_get_data(linebuf),
                                   pixman_image_get_stride(linebuf), errp) < 0) {
@@ -344,6 +343,7 @@ static bool ppm_save(int fd, DisplaySurface *ds, Error **errp)
 void qmp_screendump(const char *filename, bool has_device, const char *device,
                     bool has_head, int64_t head, Error **errp)
 {
+    g_autoptr(pixman_image_t) image = NULL;
     QemuConsole *con;
     DisplaySurface *surface;
     int fd;
@@ -372,6 +372,7 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
         error_setg(errp, "no surface");
         return;
     }
+    image = pixman_image_ref(surface->image);
 
     fd = qemu_open_old(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
     if (fd == -1) {
@@ -380,7 +381,7 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
         return;
     }
 
-    if (!ppm_save(fd, surface, errp)) {
+    if (!ppm_save(fd, image, errp)) {
         qemu_unlink(filename);
     }
 }
diff --git a/ui/trace-events b/ui/trace-events
index b7d7270c02..0ffcdb4408 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -15,7 +15,7 @@ displaysurface_create_pixman(void *display_surface) "surface=%p"
 displaysurface_free(void *display_surface) "surface=%p"
 displaychangelistener_register(void *dcl, const char *name) "%p [ %s ]"
 displaychangelistener_unregister(void *dcl, const char *name) "%p [ %s ]"
-ppm_save(int fd, void *display_surface) "fd=%d surface=%p"
+ppm_save(int fd, void *image) "fd=%d image=%p"
 
 # gtk-egl.c
 # gtk-gl-area.c
-- 
2.28.0


