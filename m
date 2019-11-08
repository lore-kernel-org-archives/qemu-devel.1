Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F564FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58527222C4
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhUTyHuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58527222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT62G-000494-7X
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5qL-0007hS-NL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5qK-0006zf-3C
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:06:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5qJ-0006yP-VW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6a3WqY1R8aTdRQZwRQ6BSdOmt8hmHjf7TQvvlhpK+xA=;
 b=LhUTyHuJtQUObRWcGJRd7ecCjw/nLERc7P4KV3n3z0TEZkWIzmWz+XUWbWCUDrO0Ghs8v8
 EFLnp/3hB04V7bXgsnnLhSlG1sRmI+a++WmY2f95YTmGwNaCWgg/Mxlb85XqklvnaJe0EH
 fSXG2p8wG2LAgjdaeKWP9Xca7JlJmRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-7p8TTBpQOJ2NQBvL8aCKOg-1; Fri, 08 Nov 2019 10:06:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67A89180496F
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:06:29 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 288265D6AE;
 Fri,  8 Nov 2019 15:06:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 22/25] console: make screendump asynchronous
Date: Fri,  8 Nov 2019 19:01:20 +0400
Message-Id: <20191108150123.12213-23-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 7p8TTBpQOJ2NQBvL8aCKOg-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make screendump asynchronous to provide correct screendumps.

For now, HMP doesn't have async support, so it has to remain
synchronous and potentially incorrect to avoid races (following
patches will add HMP asynchronous commands)

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |   3 ++
 monitor/hmp-cmds.c   |   2 +-
 qapi/ui.json         |   3 +-
 ui/console.c         | 117 +++++++++++++++++++++++++++++++++++++++----
 4 files changed, 113 insertions(+), 12 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 281f9c145b..a1935557cc 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -74,6 +74,9 @@ typedef struct MouseTransformInfo {
 } MouseTransformInfo;
=20
 void hmp_mouse_set(Monitor *mon, const QDict *qdict);
+void hmp_screendump_sync(const char *filename,
+                         bool has_device, const char *device,
+                         bool has_head, int64_t head, Error **errp);
=20
 /* keysym is a unicode code except for special keys (see QEMU_KEY_xxx
    constants) */
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..c52e78fedf 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2308,7 +2308,7 @@ void hmp_screendump(Monitor *mon, const QDict *qdict)
     int64_t head =3D qdict_get_try_int(qdict, "head", 0);
     Error *err =3D NULL;
=20
-    qmp_screendump(filename, id !=3D NULL, id, id !=3D NULL, head, &err);
+    hmp_screendump_sync(filename, id !=3D NULL, id, id !=3D NULL, head, &e=
rr);
     hmp_handle_error(mon, &err);
 }
=20
diff --git a/qapi/ui.json b/qapi/ui.json
index e04525d8b4..148ae4c062 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -96,7 +96,8 @@
 #
 ##
 { 'command': 'screendump',
-  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
+  'data': {'filename': 'str', '*device': 'str', '*head': 'int'},
+  'async': true }
=20
 ##
 # =3D=3D Spice
diff --git a/ui/console.c b/ui/console.c
index e6ac462aa0..fd87605b7c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -34,6 +34,7 @@
 #include "trace.h"
 #include "exec/memory.h"
 #include "io/channel-file.h"
+#include "monitor/monitor.h"
=20
 #define DEFAULT_BACKSCROLL 512
 #define CONSOLE_CURSOR_PERIOD 500
@@ -118,6 +119,13 @@ typedef enum {
     TEXT_CONSOLE_FIXED_SIZE
 } console_type_t;
=20
+struct qmp_screendump {
+    int fd;
+    gchar *filename;
+    QmpReturn *ret;
+    QLIST_ENTRY(qmp_screendump) link;
+};
+
 struct QemuConsole {
     Object parent;
=20
@@ -168,6 +176,8 @@ struct QemuConsole {
     uint8_t out_fifo_buf[16];
     QEMUTimer *kbd_timer;
=20
+    QLIST_HEAD(, qmp_screendump) qmp_screendumps;
+
     QTAILQ_ENTRY(QemuConsole) next;
 };
=20
@@ -261,8 +271,51 @@ static void gui_setup_refresh(DisplayState *ds)
     ds->have_text =3D have_text;
 }
=20
+static void qmp_screendump_finish(QemuConsole *con, struct qmp_screendump =
*dump)
+{
+    Error *err =3D NULL;
+    DisplaySurface *surface;
+
+    if (qmp_return_is_cancelled(dump->ret)) {
+        goto cleanup;
+    }
+
+    surface =3D qemu_console_surface(con);
+    if (!surface) {
+        error_setg(&err, "no surface");
+    } else {
+        /*
+         * FIXME: async save with coroutine? it would have to copy or
+         * lock the surface.
+         */
+        if (!ppm_save(dump->fd, surface, &err)) {
+            qemu_unlink(dump->filename);
+        }
+        dump->fd =3D -1;
+    }
+
+    if (err) {
+        qmp_return_error(dump->ret, err);
+    } else {
+        qmp_screendump_return(dump->ret);
+    }
+
+cleanup:
+    if (dump->fd !=3D -1) {
+        qemu_close(dump->fd);
+    }
+    g_free(dump->filename);
+    QLIST_REMOVE(dump, link);
+    g_free(dump);
+}
+
 void graphic_hw_update_done(QemuConsole *con)
 {
+    struct qmp_screendump *dump, *next;
+
+    QLIST_FOREACH_SAFE(dump, &con->qmp_screendumps, link, next) {
+        qmp_screendump_finish(con, dump);
+    }
 }
=20
 void graphic_hw_update(QemuConsole *con)
@@ -341,31 +394,42 @@ static bool ppm_save(int fd, DisplaySurface *ds, Erro=
r **errp)
     return true;
 }
=20
-void qmp_screendump(const char *filename, bool has_device, const char *dev=
ice,
-                    bool has_head, int64_t head, Error **errp)
+
+static QemuConsole *get_console(bool has_device, const char *device,
+                                bool has_head, int64_t head, Error **errp)
 {
-    QemuConsole *con;
-    DisplaySurface *surface;
-    int fd;
+    QemuConsole *con =3D NULL;
=20
     if (has_device) {
         con =3D qemu_console_lookup_by_device_name(device, has_head ? head=
 : 0,
                                                  errp);
-        if (!con) {
-            return;
-        }
     } else {
         if (has_head) {
             error_setg(errp, "'head' must be specified together with 'devi=
ce'");
-            return;
+            return NULL;
         }
         con =3D qemu_console_lookup_by_index(0);
         if (!con) {
             error_setg(errp, "There is no console to take a screendump fro=
m");
-            return;
         }
     }
=20
+    return con;
+}
+
+void hmp_screendump_sync(const char *filename,
+                         bool has_device, const char *device,
+                         bool has_head, int64_t head, Error **errp)
+{
+    DisplaySurface *surface;
+    QemuConsole *con =3D get_console(has_device, device, has_head, head, e=
rrp);
+    int fd;
+
+    if (!con) {
+        return;
+    }
+    /* This may not complete the drawing with Spice, you may have
+     * glitches or outdated dumps, use qmp instead! */
     graphic_hw_update(con);
     surface =3D qemu_console_surface(con);
     if (!surface) {
@@ -385,6 +449,38 @@ void qmp_screendump(const char *filename, bool has_dev=
ice, const char *device,
     }
 }
=20
+void qmp_screendump(const char *filename,
+                    bool has_device, const char *device,
+                    bool has_head, int64_t head,
+                    QmpReturn *qret)
+{
+    Error *err =3D NULL;
+    struct qmp_screendump *dump =3D NULL;
+    QemuConsole *con =3D get_console(has_device, device, has_head, head, &=
err);
+    int fd;
+
+    if (!con) {
+        qmp_return_error(qret, err);
+        return;
+    }
+
+    fd =3D qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 06=
66);
+    if (fd =3D=3D -1) {
+        error_setg(&err, "failed to open file '%s': %s",
+                   filename, strerror(errno));
+        qmp_return_error(qret, err);
+        return;
+    }
+
+    dump =3D g_new(struct qmp_screendump, 1);
+    dump->fd =3D fd;
+    dump->filename =3D g_strdup(filename);
+    dump->ret =3D qret;
+    QLIST_INSERT_HEAD(&con->qmp_screendumps, dump, link);
+
+    graphic_hw_update(con);
+}
+
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
 {
     if (!con) {
@@ -1295,6 +1391,7 @@ static QemuConsole *new_console(DisplayState *ds, con=
sole_type_t console_type,
     obj =3D object_new(TYPE_QEMU_CONSOLE);
     s =3D QEMU_CONSOLE(obj);
     s->head =3D head;
+    QLIST_INIT(&s->qmp_screendumps);
     object_property_add_link(obj, "device", TYPE_DEVICE,
                              (Object **)&s->device,
                              object_property_allow_set_link,
--=20
2.24.0


