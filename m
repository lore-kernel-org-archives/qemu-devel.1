Received: from eggs.gnu.org ([2001:4830:134:3::10]:55525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TmB-0006iB-55
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tm7-0003gC-1b
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tm6-0003fo-TB
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:16 +0200
Message-Id: <20180326150916.9602-39-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 38/38] hmp: call the asynchronous QMP
 screendump to fix outdated/glitches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

In order to fix the bad screendumps (same as rhbz#1230527), call into
the asynchonous version of the QMP command.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hmp.h           |  3 ++-
 hmp.c           |  6 ++----
 ui/console.c    | 17 -----------------
 hmp-commands.hx |  3 ++-
 4 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/hmp.h b/hmp.h
index 4e2ec375b0..6ad43b7828 100644
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
@@ -96,7 +97,7 @@ void hmp_netdev_del(Monitor *mon, const QDict *qdict);
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
index da9008fe63..ca1ee8e146 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2137,15 +2137,13 @@ err_out:
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
index da51861191..f1cbbd6317 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -426,23 +426,6 @@ static QemuConsole *get_console(bool has_device, con=
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
-    ppm_save(filename, surface, errp);
-}
-
 void qmp_screendump(const char *filename,
                     bool has_device, const char *device,
                     bool has_head, int64_t head,
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 35d862a5d2..4911fc6474 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -258,7 +258,8 @@ ETEXI
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
2.17.0.rc1.1.g4c4f2b46a3
