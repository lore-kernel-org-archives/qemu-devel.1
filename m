Received: from eggs.gnu.org ([2001:4830:134:3::10]:34023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQcKg-00073x-U2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQcKf-0000j4-IT
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQcKf-0000iE-AQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6ACE2E254B
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 16:30:16 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-88.ams2.redhat.com
	[10.36.116.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DBDC691E77
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 16:30:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 29 Jun 2017 17:30:11 +0100
Message-Id: <20170629163011.13388-3-dgilbert@redhat.com>
In-Reply-To: <20170629163011.13388-1-dgilbert@redhat.com>
References: <20170629163011.13388-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stefan Fritsch <sf@sfritsch.de>

Sending a break on a serial console can be useful for debugging the
guest. But not all chardev backends support sending breaks (only telnet
and mux do). The chardev-send-break command allows to send a break even
if using other backends.

Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170611074817.13621-1-sf@sfritsch.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Use 'send a break' in all 3 pieces of text as suggested by eblake
---
 chardev/char.c    | 12 ++++++++++++
 hmp-commands.hx   | 16 ++++++++++++++++
 hmp.c             |  8 ++++++++
 hmp.h             |  1 +
 qapi-schema.json  | 20 ++++++++++++++++++++
 tests/test-char.c | 12 ++++++++++--
 tests/test-hmp.c  |  1 +
 7 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index bcfc065d16..2b679a2295 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -951,6 +951,18 @@ void qmp_chardev_remove(const char *id, Error **errp=
)
     object_unparent(OBJECT(chr));
 }
=20
+void qmp_chardev_send_break(const char *id, Error **errp)
+{
+    Chardev *chr;
+
+    chr =3D qemu_chr_find(id);
+    if (chr =3D=3D NULL) {
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
index e763606fe5..275ccdfbc7 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1745,6 +1745,22 @@ Removes the chardev @var{id}.
 ETEXI
=20
     {
+        .name       =3D "chardev-send-break",
+        .args_type  =3D "id:s",
+        .params     =3D "id",
+        .help       =3D "send a break on chardev",
+        .cmd        =3D hmp_chardev_send_break,
+        .command_completion =3D chardev_remove_completion,
+    },
+
+STEXI
+@item chardev-send-break id
+@findex chardev-send-break
+Send a break on the chardev @var{id}.
+
+ETEXI
+
+    {
         .name       =3D "qemu-io",
         .args_type  =3D "device:B,command:s",
         .params     =3D "[device] \"[command]\"",
diff --git a/hmp.c b/hmp.c
index 4c41cac625..dee40284c1 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2236,6 +2236,14 @@ void hmp_chardev_remove(Monitor *mon, const QDict =
*qdict)
     hmp_handle_error(mon, &local_err);
 }
=20
+void hmp_chardev_send_break(Monitor *mon, const QDict *qdict)
+{
+    Error *local_err =3D NULL;
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
@@ -103,6 +103,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qd=
ict);
 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
 void hmp_chardev_add(Monitor *mon, const QDict *qdict);
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
+void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
 void hmp_qemu_io(Monitor *mon, const QDict *qdict);
 void hmp_cpu_add(Monitor *mon, const QDict *qdict);
 void hmp_object_add(Monitor *mon, const QDict *qdict);
diff --git a/qapi-schema.json b/qapi-schema.json
index 9e34cf71f3..37c4b95aad 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5117,6 +5117,26 @@
 { 'command': 'chardev-remove', 'data': {'id': 'str'} }
=20
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
index 9e361c8d09..87c724c5c2 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -53,7 +53,9 @@ static void fe_event(void *opaque, int event)
     FeHandler *h =3D opaque;
=20
     h->last_event =3D event;
-    quit =3D true;
+    if (event !=3D CHR_EVENT_BREAK) {
+        quit =3D true;
+    }
 }
=20
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
@@ -517,7 +519,7 @@ static void char_file_test(void)
=20
         file.in =3D fifo;
         file.has_in =3D true;
-        chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+        chr =3D qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backe=
nd,
                                &error_abort);
=20
         qemu_chr_fe_init(&be, chr, &error_abort);
@@ -527,6 +529,12 @@ static void char_file_test(void)
                                  fe_event,
                                  &fe, NULL, true);
=20
+        g_assert_cmpint(fe.last_event, !=3D, CHR_EVENT_BREAK);
+        qmp_chardev_send_break("label-foo", NULL);
+        g_assert_cmpint(fe.last_event, !=3D, CHR_EVENT_BREAK);
+        qmp_chardev_send_break("label-file", NULL);
+        g_assert_cmpint(fe.last_event, =3D=3D, CHR_EVENT_BREAK);
+
         main_loop();
=20
         close(fd);
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 99e35ec15a..6dfa0c36e2 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -22,6 +22,7 @@ static int verbose;
 static const char *hmp_cmds[] =3D {
     "boot_set ndc",
     "chardev-add null,id=3Dtestchardev1",
+    "chardev-send-break testchardev2",
     "chardev-remove testchardev1",
     "commit all",
     "cpu-add 1",
--=20
2.13.0
