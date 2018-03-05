Received: from eggs.gnu.org ([2001:4830:134:3::10]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1est7k-0000WM-K7
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1est7h-0003mE-GE
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:38:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1est7h-0003m0-CF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:38:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29C6D405CC2D
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 16:37:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  5 Mar 2018 17:37:48 +0100
Message-Id: <1520267868-31778-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] qapi: Add device ID and head parameters to
 screendump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

QEMU's screendump command can only take dumps from the primary display.
When using multiple VGA cards, there is no way to get a dump from a
secondary card or other display heads yet. So let's add an 'device' and
a 'head' parameter to the HMP and QMP commands to be able to specify
alternative devices and heads with the screendump command, too.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v4:
 - Improved the documentation of the parameters in ui.json a little bit
   (according to the suggestions from Eric)

 hmp-commands.hx |  7 ++++---
 hmp.c           |  4 +++-
 qapi/ui.json    | 10 +++++++++-
 ui/console.c    | 24 +++++++++++++++++++-----
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 964eb51..1723cbe 100644
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
index 016cb5c..ba9e299 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2140,9 +2140,11 @@ err_out:
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
index 3e82f25..5d01ad4 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -77,6 +77,13 @@
 #
 # @filename: the path of a new PPM file to store the image
 #
+# @device: ID of the display device that should be dumped. If this param=
eter
+#          is missing, the primary display will be used. (Since 2.12)
+#
+# @head: head to use in case the device supports multiple heads. If this
+#        parameter is missing, head #0 will be used. Also note that the =
head
+#        can only be specified in conjunction with the device ID. (Since=
 2.12)
+#
 # Returns: Nothing on success
 #
 # Since: 0.14.0
@@ -88,7 +95,8 @@
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
index 6a1f499..f2794c7 100644
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
