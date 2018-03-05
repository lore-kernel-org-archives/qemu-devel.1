Received: from eggs.gnu.org ([2001:4830:134:3::10]:37810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esnz6-0005Zb-9V
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esnz3-0001VH-2N
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:08:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1esnz2-0001Us-Ti
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:08:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96EC6402314E
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 11:08:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  5 Mar 2018 12:08:25 +0100
Message-Id: <1520248105-10053-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] Allow to specify a display device ID and
 head whith the screendump command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

QEMU's screendump command can only take dumps from the primary display.
When using multiple VGA cards, there is no way to get a dump from a
secondary card or other display heads yet. So let's add an 'device' and
a 'head' parameter to the HMP and QMP commands to be able to specify
alternative devices and heads with the screendump command, too.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3:
 - Drop redundant qemu_console_lookup_by_index(0);
 - Remove trailing "." from error message

 hmp-commands.hx |  7 ++++---
 hmp.c           |  4 +++-
 qapi/ui.json    |  7 ++++++-
 ui/console.c    | 24 +++++++++++++++++++-----
 4 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index d26eb41..ebb5fe4 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -253,9 +253,10 @@ ETEXI
=20
     {
         .name       =3D "screendump",
-        .args_type  =3D "filename:F",
-        .params     =3D "filename",
-        .help       =3D "save screen into PPM image 'filename'",
+        .args_type  =3D "filename:F,device:s?,head:i?",
+        .params     =3D "filename [device [head]]",
+        .help       =3D "save screen from head 'head' of display device =
'device' "
+                      "into PPM image 'filename'",
         .cmd        =3D hmp_screendump,
     },
=20
diff --git a/hmp.c b/hmp.c
index ae86bfb..7dcf72f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2132,9 +2132,11 @@ err_out:
 void hmp_screendump(Monitor *mon, const QDict *qdict)
 {
     const char *filename =3D qdict_get_str(qdict, "filename");
+    const char *id =3D qdict_get_try_str(qdict, "device");
+    int64_t head =3D qdict_get_try_int(qdict, "head", 0);
     Error *err =3D NULL;
=20
-    qmp_screendump(filename, &err);
+    qmp_screendump(filename, id !=3D NULL, id, id !=3D NULL, head, &err)=
;
     hmp_handle_error(mon, &err);
 }
=20
diff --git a/qapi/ui.json b/qapi/ui.json
index 3e82f25..e60b323 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -77,6 +77,10 @@
 #
 # @filename: the path of a new PPM file to store the image
 #
+# @device: ID of the display device that should be used (since 2.12)
+#
+# @head: head to use in case the device supports multiple heads (since 2=
.12)
+#
 # Returns: Nothing on success
 #
 # Since: 0.14.0
@@ -88,7 +92,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'screendump', 'data': {'filename': 'str'} }
+{ 'command': 'screendump',
+  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
=20
 ##
 # =3D=3D Spice
diff --git a/ui/console.c b/ui/console.c
index e22931a..4e4296d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -344,14 +344,28 @@ write_err:
     goto out;
 }
=20
-void qmp_screendump(const char *filename, Error **errp)
+void qmp_screendump(const char *filename, bool has_device, const char *d=
evice,
+                    bool has_head, int64_t head, Error **errp)
 {
-    QemuConsole *con =3D qemu_console_lookup_by_index(0);
+    QemuConsole *con;
     DisplaySurface *surface;
=20
-    if (con =3D=3D NULL) {
-        error_setg(errp, "There is no QemuConsole I can screendump from.=
");
-        return;
+    if (has_device) {
+        con =3D qemu_console_lookup_by_device_name(device, has_head ? he=
ad : 0,
+                                                 errp);
+        if (!con) {
+            return;
+        }
+    } else {
+        if (has_head) {
+            error_setg(errp, "'head' must be specified together with 'de=
vice'");
+            return;
+        }
+        con =3D qemu_console_lookup_by_index(0);
+        if (!con) {
+            error_setg(errp, "There is no console to take a screendump f=
rom");
+            return;
+        }
     }
=20
     graphic_hw_update(con);
--=20
1.8.3.1
