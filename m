Received: from eggs.gnu.org ([2001:4830:134:3::10]:39629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkA-0004Wm-AF
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIk9-00048L-6K
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIk8-000480-VC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13779274873
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:25 +0400
Message-Id: <20170202145141.17138-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/22] char: add a /chardevs container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a /chardevs container object to hold the list of chardevs.
(Note: QTAILQ chardevs is going away in the following commits)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h |  3 ++-
 chardev/char.c        | 46 ++++++++++++++++++++++++++++++++++++++-------=
-
 gdbstub.c             |  2 +-
 hw/bt/hci-csr.c       |  2 +-
 4 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index a30ff3fa80..e3f3a10d17 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -490,7 +490,8 @@ typedef struct ChardevClass {
 } ChardevClass;
=20
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-                          ChardevBackend *backend, Error **errp);
+                          ChardevBackend *backend, bool enlist,
+                          Error **errp);
=20
 extern int term_escape_char;
=20
diff --git a/chardev/char.c b/chardev/char.c
index 9f02c6d5f1..5a12a79c3b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -45,6 +45,11 @@
 static QTAILQ_HEAD(ChardevHead, Chardev) chardevs =3D
     QTAILQ_HEAD_INITIALIZER(chardevs);
=20
+static Object *get_chardevs_root(void)
+{
+    return container_get(object_get_root(), "/chardevs");
+}
+
 void qemu_chr_be_event(Chardev *s, int event)
 {
     CharBackend *be =3D s->be;
@@ -804,7 +809,7 @@ static Chardev *qemu_chardev_add(const char *id, cons=
t char *typename,
         return NULL;
     }
=20
-    chr =3D qemu_chardev_new(id, typename, backend, errp);
+    chr =3D qemu_chardev_new(id, typename, backend, true, errp);
     if (!chr) {
         return NULL;
     }
@@ -1061,8 +1066,14 @@ void qemu_chr_fe_disconnect(CharBackend *be)
=20
 void qemu_chr_delete(Chardev *chr)
 {
-    QTAILQ_REMOVE(&chardevs, chr, next);
-    object_unref(OBJECT(chr));
+    if (QTAILQ_IN_USE(chr, next)) {
+        QTAILQ_REMOVE(&chardevs, chr, next);
+    }
+    if (OBJECT(chr)->parent) {
+        object_unparent(OBJECT(chr));
+    } else {
+        object_unref(OBJECT(chr));
+    }
 }
=20
 ChardevInfoList *qmp_query_chardev(Error **errp)
@@ -1224,22 +1235,33 @@ void qemu_chr_set_feature(Chardev *chr,
 }
=20
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-                          ChardevBackend *backend, Error **errp)
+                          ChardevBackend *backend, bool enlist,
+                          Error **errp)
 {
+    Object *obj;
     Chardev *chr =3D NULL;
     Error *local_err =3D NULL;
     bool be_opened =3D true;
=20
     assert(g_str_has_prefix(typename, "chardev-"));
=20
-    chr =3D CHARDEV(object_new(typename));
+    if (enlist) {
+        obj =3D object_new_with_props(typename, get_chardevs_root(),
+                                    id, &local_err, NULL);
+    } else {
+        obj =3D object_new(typename);
+    }
+    if (local_err) {
+        assert(!obj);
+        goto end;
+    }
+
+    chr =3D CHARDEV(obj);
     chr->label =3D g_strdup(id);
=20
     qemu_char_open(chr, backend, &be_opened, &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        object_unref(OBJECT(chr));
-        return NULL;
+        goto end;
     }
=20
     if (!chr->filename) {
@@ -1249,6 +1271,14 @@ Chardev *qemu_chardev_new(const char *id, const ch=
ar *typename,
         qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     }
=20
+end:
+    if (local_err) {
+        error_propagate(errp, local_err);
+        if (chr) {
+            qemu_chr_delete(chr);
+        }
+        return NULL;
+    }
     return chr;
 }
=20
diff --git a/gdbstub.c b/gdbstub.c
index 755a8e378d..613ac48fed 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1793,7 +1793,7 @@ int gdbserver_start(const char *device)
=20
         /* Initialize a monitor terminal for gdb */
         mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
-                                   NULL, &error_abort);
+                                   NULL, false, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         if (qemu_chr_fe_get_driver(&s->chr)) {
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 3c193848fc..9c211e89c4 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -503,7 +503,7 @@ static const TypeInfo char_hci_type_info =3D {
 Chardev *uart_hci_init(void)
 {
     return qemu_chardev_new(NULL, TYPE_CHARDEV_HCI,
-                            NULL, &error_abort);
+                            NULL, false, &error_abort);
 }
=20
 static void register_types(void)
--=20
2.11.0.295.gd7dffce1c.dirty
