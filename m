Received: from eggs.gnu.org ([2001:4830:134:3::10]:50948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dJxcP-0007zv-Qs
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 03:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dJxcO-0008UP-Ix
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 03:49:05 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:40022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dJxcO-0008Sw-Ba
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 03:49:04 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Sun, 11 Jun 2017 09:48:17 +0200
Message-Id: <20170611074817.13621-1-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH v2] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Fritsch <sf@sfritsch.de>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Sending a break on a serial console can be useful for debugging the
guest. But not all chardev backends support sending breaks (only telnet
and mux do). The chardev-send-break command allows to send a break even
if using other backends.

Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
v2: added tests and Acked-by line

 chardev/char.c    | 12 ++++++++++++
 hmp-commands.hx   | 16 ++++++++++++++++
 hmp.c             |  8 ++++++++
 hmp.h             |  1 +
 qapi-schema.json  | 20 ++++++++++++++++++++
 tests/test-char.c | 12 ++++++++++--
 tests/test-hmp.c  |  1 +
 7 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 7aa0210765..cc56bca672 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -951,6 +951,18 @@ void qmp_chardev_remove(const char *id, Error **errp)
     object_unparent(OBJECT(chr));
 }
 
+void qmp_chardev_send_break(const char *id, Error **errp)
+{
+    Chardev *chr;
+
+    chr = qemu_chr_find(id);
+    if (chr == NULL) {
+        error_setg(errp, "Chardev '%s' not found", id);
+        return;
+    }
+    qemu_chr_be_event(chr, CHR_EVENT_BREAK);
+}
+
 void qemu_chr_cleanup(void)
 {
     object_unparent(get_chardevs_root());
diff --git a/hmp-commands.hx b/hmp-commands.hx
index e763606fe5..fc8d54b52a 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1745,6 +1745,22 @@ Removes the chardev @var{id}.
 ETEXI
 
     {
+        .name       = "chardev-send-break",
+        .args_type  = "id:s",
+        .params     = "id",
+        .help       = "send break on chardev",
+        .cmd        = hmp_chardev_send_break,
+        .command_completion = chardev_remove_completion,
+    },
+
+STEXI
+@item chardev-send-break id
+@findex chardev-send-break
+Sends break on the chardev @var{id}.
+
+ETEXI
+
+    {
         .name       = "qemu-io",
         .args_type  = "device:B,command:s",
         .params     = "[device] \"[command]\"",
diff --git a/hmp.c b/hmp.c
index 8c72c58b20..94cafe970e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2233,6 +2233,14 @@ void hmp_chardev_remove(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &local_err);
 }
 
+void hmp_chardev_send_break(Monitor *mon, const QDict *qdict)
+{
+    Error *local_err = NULL;
+
+    qmp_chardev_send_break(qdict_get_str(qdict, "id"), &local_err);
+    hmp_handle_error(mon, &local_err);
+}
+
 void hmp_qemu_io(Monitor *mon, const QDict *qdict)
 {
     BlockBackend *blk;
diff --git a/hmp.h b/hmp.h
index d8b94ce9dc..214b2617e7 100644
--- a/hmp.h
+++ b/hmp.h
@@ -103,6 +103,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
 void hmp_chardev_add(Monitor *mon, const QDict *qdict);
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
+void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
 void hmp_qemu_io(Monitor *mon, const QDict *qdict);
 void hmp_cpu_add(Monitor *mon, const QDict *qdict);
 void hmp_object_add(Monitor *mon, const QDict *qdict);
diff --git a/qapi-schema.json b/qapi-schema.json
index 4b50b652d3..e01dd83dd9 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5114,6 +5114,26 @@
 { 'command': 'chardev-remove', 'data': {'id': 'str'} }
 
 ##
+# @chardev-send-break:
+#
+# Send a break to a character device
+#
+# @id: the chardev's ID, must exist
+#
+# Returns: Nothing on success
+#
+# Since: 2.10
+#
+# Example:
+#
+# -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'chardev-send-break', 'data': {'id': 'str'} }
+
+
+##
 # @TpmModel:
 #
 # An enumeration of TPM models
diff --git a/tests/test-char.c b/tests/test-char.c
index dfe856cb85..c7f7ec1798 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -53,7 +53,9 @@ static void fe_event(void *opaque, int event)
     FeHandler *h = opaque;
 
     h->last_event = event;
-    quit = true;
+    if (event != CHR_EVENT_BREAK) {
+        quit = true;
+    }
 }
 
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
@@ -491,7 +493,7 @@ static void char_file_test(void)
 
         file.in = fifo;
         file.has_in = true;
-        chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+        chr = qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
                                &error_abort);
 
         qemu_chr_fe_init(&be, chr, &error_abort);
@@ -501,6 +503,12 @@ static void char_file_test(void)
                                  fe_event,
                                  &fe, NULL, true);
 
+        g_assert_cmpint(fe.last_event, !=, CHR_EVENT_BREAK);
+        qmp_chardev_send_break("label-foo", NULL);
+        g_assert_cmpint(fe.last_event, !=, CHR_EVENT_BREAK);
+        qmp_chardev_send_break("label-file", NULL);
+        g_assert_cmpint(fe.last_event, ==, CHR_EVENT_BREAK);
+
         main_loop();
 
         close(fd);
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 99e35ec15a..6dfa0c36e2 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -22,6 +22,7 @@ static int verbose;
 static const char *hmp_cmds[] = {
     "boot_set ndc",
     "chardev-add null,id=testchardev1",
+    "chardev-send-break testchardev2",
     "chardev-remove testchardev1",
     "commit all",
     "cpu-add 1",
-- 
2.11.0
