Received: from eggs.gnu.org ([2001:4830:134:3::10]:51582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dHnmb-00008z-7p
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dHnmW-0004Nd-DB
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:54:41 -0400
Received: from manul.sfritsch.de ([138.201.64.112]:54285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dHnmW-0004MB-5t
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:54:36 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Mon,  5 Jun 2017 10:52:54 +0200
Message-Id: <20170605085254.16485-1-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH] Add chardev-send-break monitor command
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
---
 chardev/char.c   | 12 ++++++++++++
 hmp-commands.hx  | 16 ++++++++++++++++
 hmp.c            |  8 ++++++++
 hmp.h            |  1 +
 qapi-schema.json | 20 ++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 4e24dc39af..fa54f7c915 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1307,6 +1307,18 @@ void qmp_chardev_remove(const char *id, Error **errp)
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
index ad723903a6..fb2a38b7d6 100644
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
-- 
2.11.0
