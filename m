Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA62EC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3292F207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giZ8f4Lf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3292F207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLp4-0007dG-8V
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRLgt-0007JV-KF
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRLgr-00076W-4K
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602362521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R81R33Ib68eNCgLZeHZeBVsKMvrOc3EQF+Kl6MO1nEY=;
 b=giZ8f4LfAzAtCQXpTbZZc055XsFeDzAIX6Pj2oU/oI+fPlgpsug+f2GCq74qPbVVOEqsY1
 USewsbYddpGw0mhZx3aAohgAi70bEYclLY+1YkcgiEg9G4AcD0E5KFhPkMJ/sduo9JbM6Y
 FBGFf6aYFdfkpBUiFXqQUzjPZfDogjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-VEaQBX43M6eA1BGUp6Aspw-1; Sat, 10 Oct 2020 16:42:00 -0400
X-MC-Unique: VEaQBX43M6eA1BGUp6Aspw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 130B0107ACF8
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 20:41:59 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 280115C1D7;
 Sat, 10 Oct 2020 20:41:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] console: make QMP/HMP screendump run in coroutine
Date: Sun, 11 Oct 2020 00:41:06 +0400
Message-Id: <20201010204106.1368710-4-marcandre.lureau@redhat.com>
In-Reply-To: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
References: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 16:30:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thanks to the monitors coroutine support, the screendump handler can
trigger a graphic_hw_update(), yield and let the main loop run until
update is done. Then the handler is resumed, and ppm_save() will write
the screen image to disk in the coroutine context (thus non-blocking).

Potentially, during non-blocking write, some new graphic update could
happen, and thus the image may have some glitches. Whether that
behaviour is acceptable is discutable. Allocating new memory may not be
a good idea, as framebuffers can be quite large. Even then, QEMU may
become less responsive as it requires paging in etc.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=1230527

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands.hx    |  1 +
 monitor/hmp-cmds.c |  3 ++-
 qapi/ui.json       |  3 ++-
 ui/console.c       | 27 ++++++++++++++++++++++++---
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index cd068389de..ff2d7aa8f3 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -254,6 +254,7 @@ ERST
         .help       = "save screen from head 'head' of display device 'device' "
                       "into PPM image 'filename'",
         .cmd        = hmp_screendump,
+        .coroutine  = true,
     },
 
 SRST
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9789f4277f..91608bac6d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1756,7 +1756,8 @@ err_out:
     goto out;
 }
 
-void hmp_screendump(Monitor *mon, const QDict *qdict)
+void coroutine_fn
+hmp_screendump(Monitor *mon, const QDict *qdict)
 {
     const char *filename = qdict_get_str(qdict, "filename");
     const char *id = qdict_get_try_str(qdict, "device");
diff --git a/qapi/ui.json b/qapi/ui.json
index 9d6721037f..6c7b33cb72 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -98,7 +98,8 @@
 #
 ##
 { 'command': 'screendump',
-  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
+  'data': {'filename': 'str', '*device': 'str', '*head': 'int'},
+  'coroutine': true }
 
 ##
 # == Spice
diff --git a/ui/console.c b/ui/console.c
index a56fe0dd26..0118f70d9a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -168,6 +168,7 @@ struct QemuConsole {
     QEMUFIFO out_fifo;
     uint8_t out_fifo_buf[16];
     QEMUTimer *kbd_timer;
+    CoQueue dump_queue;
 
     QTAILQ_ENTRY(QemuConsole) next;
 };
@@ -263,6 +264,7 @@ static void gui_setup_refresh(DisplayState *ds)
 
 void graphic_hw_update_done(QemuConsole *con)
 {
+    qemu_co_queue_restart_all(&con->dump_queue);
 }
 
 void graphic_hw_update(QemuConsole *con)
@@ -340,8 +342,15 @@ static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
     return true;
 }
 
-void qmp_screendump(const char *filename, bool has_device, const char *device,
-                    bool has_head, int64_t head, Error **errp)
+static void graphic_hw_update_bh(void *con)
+{
+    graphic_hw_update(con);
+}
+
+/* Safety: coroutine-only, concurrent-coroutine safe, main thread only */
+void coroutine_fn
+qmp_screendump(const char *filename, bool has_device, const char *device,
+               bool has_head, int64_t head, Error **errp)
 {
     g_autoptr(pixman_image_t) image = NULL;
     QemuConsole *con;
@@ -366,7 +375,15 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
         }
     }
 
-    graphic_hw_update(con);
+    if (qemu_co_queue_empty(&con->dump_queue)) {
+        /* Defer the update, it will restart the pending coroutines */
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                graphic_hw_update_bh, con);
+    }
+    qemu_co_queue_wait(&con->dump_queue, NULL);
+
+    /* All pending coroutines are woken up, while BQL taken, no further graphic
+     * update are possible until it is released, take an image ref before that. */
     surface = qemu_console_surface(con);
     if (!surface) {
         error_setg(errp, "no surface");
@@ -381,6 +398,9 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
         return;
     }
 
+    /* The image content could potentially be updated as the coroutine yields
+     * and releases the BQL. It could produce corrupted dump, but it should be
+     * otherwise safe. */
     if (!ppm_save(fd, image, errp)) {
         qemu_unlink(filename);
     }
@@ -1297,6 +1317,7 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
 
     obj = object_new(TYPE_QEMU_CONSOLE);
     s = QEMU_CONSOLE(obj);
+    qemu_co_queue_init(&s->dump_queue);
     s->head = head;
     object_property_add_link(obj, "device", TYPE_DEVICE,
                              (Object **)&s->device,
-- 
2.28.0


