Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B918DC5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610EE21707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foDapy6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610EE21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPNj-00061n-IF
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kXPA8-00054n-Lc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kXPA6-0001ND-M3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603805838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ef1BaD9fgkOh6duaZmupycqxuCeyxF336AjpXmD4zR8=;
 b=foDapy6r1VpCxYfh2f03r1673iPoMoVfwWEKkF6sOHLWY/fF/fyP9cPtGf9KO+CjOFwjEv
 JXvNhvwZsZPRzGDlKAe58RdgEofqzAhmXGVkYQsc/Q4DUhWL4baj1zOeog+ZmO1HXWeY9L
 SA4EyXENpSs30sKOnRAW58/FAt2eCTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-xbQxPeI9MQivpwbTv0Ia8A-1; Tue, 27 Oct 2020 09:37:16 -0400
X-MC-Unique: xbQxPeI9MQivpwbTv0Ia8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42BAC18B9EC3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:37:15 +0000 (UTC)
Received: from localhost (unknown [10.36.110.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB6575D9DD;
 Tue, 27 Oct 2020 13:36:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] console: make QMP/HMP screendump run in coroutine
Date: Tue, 27 Oct 2020 17:36:02 +0400
Message-Id: <20201027133602.3038018-4-marcandre.lureau@redhat.com>
In-Reply-To: <20201027133602.3038018-1-marcandre.lureau@redhat.com>
References: <20201027133602.3038018-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kraxel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Thanks to the monitors' coroutine support (merge commit b7092cda1b3),
the screendump handler can trigger a graphic_hw_update(), yield and let
the main loop run until update is done. Then the handler is resumed, and
ppm_save() will write the screen image to disk in the coroutine context.

The IO is still blocking though, as the file is set blocking so far,
this could be addressed by some future change (with other caveats).

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=1230527

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hmp-commands.hx    |  1 +
 monitor/hmp-cmds.c |  3 ++-
 qapi/ui.json       |  3 ++-
 ui/console.c       | 32 +++++++++++++++++++++++++++++---
 4 files changed, 34 insertions(+), 5 deletions(-)

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
index 96dd212a5d..e8e59707d3 100644
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
@@ -366,7 +375,18 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
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
+    /*
+     * All pending coroutines are woken up, while the BQL is held.  No
+     * further graphic update are possible until it is released.  Take
+     * an image ref before that.
+     */
     surface = qemu_console_surface(con);
     if (!surface) {
         error_setg(errp, "no surface");
@@ -381,6 +401,11 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
         return;
     }
 
+    /*
+     * The image content could potentially be updated as the coroutine
+     * yields and releases the BQL. It could produce corrupted dump, but
+     * it should be otherwise safe.
+     */
     if (!ppm_save(fd, image, errp)) {
         qemu_unlink(filename);
     }
@@ -1297,6 +1322,7 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
 
     obj = object_new(TYPE_QEMU_CONSOLE);
     s = QEMU_CONSOLE(obj);
+    qemu_co_queue_init(&s->dump_queue);
     s->head = head;
     object_property_add_link(obj, "device", TYPE_DEVICE,
                              (Object **)&s->device,
-- 
2.29.0


