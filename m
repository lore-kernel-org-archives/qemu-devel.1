Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060C3C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FA220665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FA220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn6Qb-0002gP-27
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 15:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Pz-0008J5-4g
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Pv-00048M-Ur
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hn6Pv-00047u-NC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BB0883F51;
 Mon, 15 Jul 2019 19:13:42 +0000 (UTC)
Received: from localhost (ovpn-112-18.ams2.redhat.com [10.36.112.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4F24F676;
 Mon, 15 Jul 2019 19:13:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 23:10:01 +0400
Message-Id: <20190715191001.1188-21-marcandre.lureau@redhat.com>
In-Reply-To: <20190715191001.1188-1-marcandre.lureau@redhat.com>
References: <20190715191001.1188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 15 Jul 2019 19:13:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 20/20] hmp: call the asynchronous QMP
 screendump to fix outdated/glitches
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to fix the bad screendumps (same as rhbz#1230527), call into
the asynchonous version of the QMP command.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands.hx      |  3 ++-
 include/ui/console.h |  5 ++---
 monitor/hmp-cmds.c   |  6 ++----
 ui/console.c         | 24 +-----------------------
 4 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index bfa5681dd2..fa559d6a4e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -278,7 +278,8 @@ ETEXI
         .params     =3D "filename [device [head]]",
         .help       =3D "save screen from head 'head' of display device =
'device' "
                       "into PPM image 'filename'",
-        .cmd        =3D hmp_screendump,
+        .async_cmd  =3D hmp_screendump_async,
+        .async      =3D true,
     },
=20
 STEXI
diff --git a/include/ui/console.h b/include/ui/console.h
index a1935557cc..d0a2a2066f 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -6,6 +6,7 @@
 #include "qemu/notify.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-types-ui.h"
+#include "qapi/qmp/dispatch.h"
=20
 #ifdef CONFIG_OPENGL
 # include <epoxy/gl.h>
@@ -74,9 +75,7 @@ typedef struct MouseTransformInfo {
 } MouseTransformInfo;
=20
 void hmp_mouse_set(Monitor *mon, const QDict *qdict);
-void hmp_screendump_sync(const char *filename,
-                         bool has_device, const char *device,
-                         bool has_head, int64_t head, Error **errp);
+void hmp_screendump_async(Monitor *mon, const QDict *qdict, QmpReturn *q=
ret);
=20
 /* keysym is a unicode code except for special keys (see QEMU_KEY_xxx
    constants) */
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 50a25a1ddc..e2af0e6307 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2334,15 +2334,13 @@ err_out:
     goto out;
 }
=20
-void hmp_screendump(Monitor *mon, const QDict *qdict)
+void hmp_screendump_async(Monitor *mon, const QDict *qdict, QmpReturn *q=
ret)
 {
     const char *filename =3D qdict_get_str(qdict, "filename");
     const char *id =3D qdict_get_try_str(qdict, "device");
     int64_t head =3D qdict_get_try_int(qdict, "head", 0);
-    Error *err =3D NULL;
=20
-    hmp_screendump_sync(filename, id !=3D NULL, id, id !=3D NULL, head, =
&err);
-    hmp_handle_error(mon, &err);
+    qmp_screendump(filename, id !=3D NULL, id, id !=3D NULL, head, qret)=
;
 }
=20
 void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
diff --git a/ui/console.c b/ui/console.c
index 29c850c31c..7436b153b9 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -280,7 +280,7 @@ static void qmp_screendump_finish(QemuConsole *con, s=
truct qmp_screendump *dump)
         goto cleanup;
     }
=20
-    cur_mon =3D qmp_return_get_monitor(dump->ret);
+    cur_mon =3D qmp_return_get_monitor(dump->ret, true);
     surface =3D qemu_console_surface(con);
     if (!surface) {
         error_setg(&err, "no surface");
@@ -430,28 +430,6 @@ static QemuConsole *get_console(bool has_device, con=
st char *device,
     return con;
 }
=20
-void hmp_screendump_sync(const char *filename,
-                         bool has_device, const char *device,
-                         bool has_head, int64_t head, Error **errp)
-{
-    DisplaySurface *surface;
-    QemuConsole *con =3D get_console(has_device, device, has_head, head,=
 errp);
-
-    if (!con) {
-        return;
-    }
-    /* This may not complete the drawing with Spice, you may have
-     * glitches or outdated dumps, use qmp instead! */
-    graphic_hw_update(con);
-    surface =3D qemu_console_surface(con);
-    if (!surface) {
-        error_setg(errp, "no surface");
-        return;
-    }
-
-    ppm_save(filename, surface, errp);
-}
-
 void qmp_screendump(const char *filename,
                     bool has_device, const char *device,
                     bool has_head, int64_t head,
--=20
2.22.0.428.g6d5b264208


