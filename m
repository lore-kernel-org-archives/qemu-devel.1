Received: from eggs.gnu.org ([2001:4830:134:3::10]:50965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eskO2-0004MJ-4k
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eskNx-0008NV-6S
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:18:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eskNx-0008NC-10
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:18:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 525734023155
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 07:18:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  5 Mar 2018 08:18:00 +0100
Message-Id: <1520234280-19410-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Allow to specify a display ID whith the
 screendump command
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
secondary card yet. So let's add an 'id' parameter to the HMP and QMP
commands to be able to specify alternative devices with the screendump
command, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hmp-commands.hx |  6 +++---
 hmp.c           |  3 ++-
 qapi/ui.json    |  4 +++-
 ui/console.c    | 16 +++++++++++++++-
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index d26eb41..045ffb0 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -253,9 +253,9 @@ ETEXI
 
     {
         .name       = "screendump",
-        .args_type  = "filename:F",
-        .params     = "filename",
-        .help       = "save screen into PPM image 'filename'",
+        .args_type  = "filename:F,id:s?",
+        .params     = "filename [id]",
+        .help       = "save screen from device 'id' into PPM image 'filename'",
         .cmd        = hmp_screendump,
     },
 
diff --git a/hmp.c b/hmp.c
index ae86bfb..e2f46f1 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2132,9 +2132,10 @@ err_out:
 void hmp_screendump(Monitor *mon, const QDict *qdict)
 {
     const char *filename = qdict_get_str(qdict, "filename");
+    const char *id = qdict_get_try_str(qdict, "id");
     Error *err = NULL;
 
-    qmp_screendump(filename, &err);
+    qmp_screendump(filename, id != NULL, id, &err);
     hmp_handle_error(mon, &err);
 }
 
diff --git a/qapi/ui.json b/qapi/ui.json
index 3e82f25..977212a 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -77,6 +77,8 @@
 #
 # @filename: the path of a new PPM file to store the image
 #
+# @id: ID of the display device that should be used (since 2.12)
+#
 # Returns: Nothing on success
 #
 # Since: 0.14.0
@@ -88,7 +90,7 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'screendump', 'data': {'filename': 'str'} }
+{ 'command': 'screendump', 'data': {'filename': 'str', '*id': 'str'} }
 
 ##
 # == Spice
diff --git a/ui/console.c b/ui/console.c
index e22931a..a0db0c5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -344,10 +344,24 @@ write_err:
     goto out;
 }
 
-void qmp_screendump(const char *filename, Error **errp)
+void qmp_screendump(const char *filename, bool has_id, const char *id,
+                    Error **errp)
 {
     QemuConsole *con = qemu_console_lookup_by_index(0);
     DisplaySurface *surface;
+    DeviceState *dev;
+
+    if (has_id) {
+        dev = qdev_find_recursive(sysbus_get_default(), id);
+        if (!dev) {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                      "Device '%s' not found", id);
+            return;
+        }
+        con = qemu_console_lookup_by_device(dev, 0);
+    } else {
+        con = qemu_console_lookup_by_index(0);
+    }
 
     if (con == NULL) {
         error_setg(errp, "There is no QemuConsole I can screendump from.");
-- 
1.8.3.1
