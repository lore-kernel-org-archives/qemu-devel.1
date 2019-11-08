Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18EDC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7C82178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xusmo5R3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7C82178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT69V-0004fR-FW
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5qu-00006l-2n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5qs-0007uw-SS
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:07:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5qs-0007s1-O1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8YNejVxznOcDAaMUcNNOGhdD0r56jyIWDDN7FE48fc=;
 b=Xusmo5R3odNFLvpu/KRKzM1NjbuJsSNJTcnNw6COH9tDVxEiM12RsEPOEw79hMg8ETMsXJ
 1bj7KUyhqbaEUupgCgieTUt5DAr6uSM5Hmzu3awvQACuj5LyZZDXkIu5J3MVX5o5k+TvFx
 PuFYvChkWygVNbeC0Y2J5i6/hcn2IiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-4HcH353HN_uQkdXD2rCBGQ-1; Fri, 08 Nov 2019 10:07:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81724180496F
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:07:02 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4127C50;
 Fri,  8 Nov 2019 15:06:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 25/25] hmp: call the asynchronous QMP screendump to fix
 outdated/glitches
Date: Fri,  8 Nov 2019 19:01:23 +0400
Message-Id: <20191108150123.12213-26-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4HcH353HN_uQkdXD2rCBGQ-1
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

In order to fix the bad screendumps (same as rhbz#1230527), call into
the asynchonous version of the QMP command.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands.hx      |  3 ++-
 include/ui/console.h |  5 ++---
 monitor/hmp-cmds.c   |  6 ++----
 ui/console.c         | 32 --------------------------------
 4 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index cfcc044ce4..82b9236deb 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -278,7 +278,8 @@ ETEXI
         .params     =3D "filename [device [head]]",
         .help       =3D "save screen from head 'head' of display device 'd=
evice' "
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
+void hmp_screendump_async(Monitor *mon, const QDict *qdict, QmpReturn *qre=
t);
=20
 /* keysym is a unicode code except for special keys (see QEMU_KEY_xxx
    constants) */
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index c52e78fedf..93b061cf4f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2301,15 +2301,13 @@ err_out:
     goto out;
 }
=20
-void hmp_screendump(Monitor *mon, const QDict *qdict)
+void hmp_screendump_async(Monitor *mon, const QDict *qdict, QmpReturn *qre=
t)
 {
     const char *filename =3D qdict_get_str(qdict, "filename");
     const char *id =3D qdict_get_try_str(qdict, "device");
     int64_t head =3D qdict_get_try_int(qdict, "head", 0);
-    Error *err =3D NULL;
=20
-    hmp_screendump_sync(filename, id !=3D NULL, id, id !=3D NULL, head, &e=
rr);
-    hmp_handle_error(mon, &err);
+    qmp_screendump(filename, id !=3D NULL, id, id !=3D NULL, head, qret);
 }
=20
 void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
diff --git a/ui/console.c b/ui/console.c
index fd87605b7c..a6f8e34e61 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -417,38 +417,6 @@ static QemuConsole *get_console(bool has_device, const=
 char *device,
     return con;
 }
=20
-void hmp_screendump_sync(const char *filename,
-                         bool has_device, const char *device,
-                         bool has_head, int64_t head, Error **errp)
-{
-    DisplaySurface *surface;
-    QemuConsole *con =3D get_console(has_device, device, has_head, head, e=
rrp);
-    int fd;
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
-    fd =3D qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 06=
66);
-    if (fd =3D=3D -1) {
-        error_setg(errp, "failed to open file '%s': %s", filename,
-                   strerror(errno));
-        return;
-    }
-
-    if (!ppm_save(fd, surface, errp)) {
-        qemu_unlink(filename);
-    }
-}
-
 void qmp_screendump(const char *filename,
                     bool has_device, const char *device,
                     bool has_head, int64_t head,
--=20
2.24.0


