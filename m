Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C2BC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8952084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8952084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46015 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDte7-0002ui-2r
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:30:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtM1-0003kV-Af
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtM0-0005N9-4P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLz-0005MV-P5
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:12:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DEE98125A;
	Tue,  9 Apr 2019 16:11:57 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0FD17AD8;
	Tue,  9 Apr 2019 16:11:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:10:09 +0200
Message-Id: <20190409161009.6322-21-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 09 Apr 2019 16:12:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 20/20] hmp: call the asynchronous QMP
 screendump to fix outdated/glitches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409161009.Zy-cblHnSv8NgCCVzPpVPFYSJXwow3-97tP3k1ofoOc@z>

In order to fix the bad screendumps (same as rhbz#1230527), call into
the asynchonous version of the QMP command.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hmp.h           |  3 ++-
 hmp.c           |  6 ++----
 ui/console.c    | 22 ----------------------
 hmp-commands.hx |  3 ++-
 4 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/hmp.h b/hmp.h
index 43617f2646..4059c8bea9 100644
--- a/hmp.h
+++ b/hmp.h
@@ -16,6 +16,7 @@
=20
 #include "qemu-common.h"
 #include "qemu/readline.h"
+#include "qapi/qmp/dispatch.h"
=20
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
@@ -102,7 +103,7 @@ void hmp_netdev_del(Monitor *mon, const QDict *qdict)=
;
 void hmp_getfd(Monitor *mon, const QDict *qdict);
 void hmp_closefd(Monitor *mon, const QDict *qdict);
 void hmp_sendkey(Monitor *mon, const QDict *qdict);
-void hmp_screendump(Monitor *mon, const QDict *qdict);
+void hmp_screendump_async(Monitor *mon, const QDict *qdict, QmpReturn *q=
ret);
 void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
diff --git a/hmp.c b/hmp.c
index 9428c90c5d..60d2bc1c76 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2373,15 +2373,13 @@ err_out:
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
index 620cd14b80..c259cf68aa 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -429,28 +429,6 @@ static QemuConsole *get_console(bool has_device, con=
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
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 9b4035965c..638b59e764 100644
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
--=20
2.21.0.196.g041f5ea1cf


