Received: from eggs.gnu.org ([2001:4830:134:3::10]:47018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbP-00048N-TS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbO-0000Ft-Be
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRbO-0000Ea-2q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B96E85540
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:21:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:05 +0400
Message-Id: <20170316092121.25672-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/21] char: add a /chardevs container
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
 include/sysemu/char.h       |  8 --------
 chardev/char.c              | 50 +++++++++++++++++++++++++++++----------=
------
 gdbstub.c                   |  4 ++--
 hw/usb/ccid-card-passthru.c |  2 +-
 hw/usb/redirect.c           |  2 +-
 net/vhost-user.c            |  2 +-
 tests/test-char.c           |  8 ++++----
 tests/vhost-user-test.c     |  2 +-
 8 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index a30ff3fa80..98903f31e4 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -171,14 +171,6 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Erro=
r **errp);
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename);
=20
 /**
- * @qemu_chr_delete:
- *
- * Destroy a character backend and remove it from the list of
- * identified character backends.
- */
-void qemu_chr_delete(Chardev *chr);
-
-/**
  * @qemu_chr_fe_set_echo:
  *
  * Ask the backend to override its normal echo setting.  This only reall=
y
diff --git a/chardev/char.c b/chardev/char.c
index 674c097fbe..5456fb2e3a 100644
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
@@ -413,6 +418,9 @@ static void char_finalize(Object *obj)
 {
     Chardev *chr =3D CHARDEV(obj);
=20
+    if (QTAILQ_IN_USE(chr, next)) {
+        QTAILQ_REMOVE(&chardevs, chr, next);
+    }
     if (chr->be) {
         chr->be->chr =3D NULL;
     }
@@ -946,7 +954,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         backend->u.mux.data->chardev =3D g_strdup(bid);
         mux =3D qemu_chardev_add(id, TYPE_CHARDEV_MUX, backend, errp);
         if (mux =3D=3D NULL) {
-            qemu_chr_delete(chr);
+            object_unparent(OBJECT(chr));
             chr =3D NULL;
             goto out;
         }
@@ -1060,12 +1068,6 @@ void qemu_chr_fe_disconnect(CharBackend *be)
     }
 }
=20
-void qemu_chr_delete(Chardev *chr)
-{
-    QTAILQ_REMOVE(&chardevs, chr, next);
-    object_unref(OBJECT(chr));
-}
-
 ChardevInfoList *qmp_query_chardev(Error **errp)
 {
     ChardevInfoList *chr_list =3D NULL;
@@ -1225,22 +1227,23 @@ void qemu_chr_set_feature(Chardev *chr,
 }
=20
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-                          ChardevBackend *backend, Error **errp)
+                          ChardevBackend *backend,
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
+    obj =3D object_new(typename);
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
@@ -1250,6 +1253,21 @@ Chardev *qemu_chardev_new(const char *id, const ch=
ar *typename,
         qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     }
=20
+    if (id) {
+        object_property_add_child(get_chardevs_root(), id, obj, &local_e=
rr);
+        if (local_err) {
+            goto end;
+        }
+        object_unref(obj);
+    }
+
+end:
+    if (local_err) {
+        error_propagate(errp, local_err);
+        object_unref(obj);
+        return NULL;
+    }
+
     return chr;
 }
=20
@@ -1298,16 +1316,12 @@ void qmp_chardev_remove(const char *id, Error **e=
rrp)
             "Chardev '%s' cannot be unplugged in record/replay mode", id=
);
         return;
     }
-    qemu_chr_delete(chr);
+    object_unparent(OBJECT(chr));
 }
=20
 void qemu_chr_cleanup(void)
 {
-    Chardev *chr, *tmp;
-
-    QTAILQ_FOREACH_SAFE(chr, &chardevs, next, tmp) {
-        qemu_chr_delete(chr);
-    }
+    object_unparent(get_chardevs_root());
 }
=20
 static void register_types(void)
diff --git a/gdbstub.c b/gdbstub.c
index 991115361e..07ebfe9626 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1611,7 +1611,7 @@ void gdb_exit(CPUArchState *env, int code)
=20
 #ifndef CONFIG_USER_ONLY
   qemu_chr_fe_deinit(&s->chr);
-  qemu_chr_delete(chr);
+  object_unparent(OBJECT(chr));
 #endif
 }
=20
@@ -1912,7 +1912,7 @@ int gdbserver_start(const char *device)
         monitor_init(mon_chr, 0);
     } else {
         if (qemu_chr_fe_get_driver(&s->chr)) {
-            qemu_chr_delete(qemu_chr_fe_get_driver(&s->chr));
+            object_unparent(OBJECT(qemu_chr_fe_get_driver(&s->chr)));
         }
         mon_chr =3D s->mon_chr;
         memset(s, 0, sizeof(GDBState));
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index daab0d56cf..a41b0d6ec5 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -267,7 +267,7 @@ static void ccid_card_vscard_drop_connection(Passthru=
State *card)
     Chardev *chr =3D qemu_chr_fe_get_driver(&card->cs);
=20
     qemu_chr_fe_deinit(&card->cs);
-    qemu_chr_delete(chr);
+    object_unparent(OBJECT(chr));
     card->vscard_in_pos =3D card->vscard_in_hdr =3D 0;
 }
=20
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 0efe62f725..b001a27f05 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1433,7 +1433,7 @@ static void usbredir_unrealize(USBDevice *udev, Err=
or **errp)
     Chardev *chr =3D qemu_chr_fe_get_driver(&dev->cs);
=20
     qemu_chr_fe_deinit(&dev->cs);
-    qemu_chr_delete(chr);
+    object_unparent(OBJECT(chr));
=20
     /* Note must be done after qemu_chr_close, as that causes a close ev=
ent */
     qemu_bh_delete(dev->chardev_close_bh);
diff --git a/net/vhost-user.c b/net/vhost-user.c
index e7e63408a1..00a0c1cbc5 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -154,7 +154,7 @@ static void vhost_user_cleanup(NetClientState *nc)
         Chardev *chr =3D qemu_chr_fe_get_driver(&s->chr);
=20
         qemu_chr_fe_deinit(&s->chr);
-        qemu_chr_delete(chr);
+        object_unparent(OBJECT(chr));
     }
=20
     qemu_purge_queued_packets(nc);
diff --git a/tests/test-char.c b/tests/test-char.c
index da69f110e4..71de4b35ee 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -53,7 +53,7 @@ static void char_stdio_test_subprocess(void)
     g_assert_cmpint(ret, =3D=3D, 4);
=20
     qemu_chr_fe_deinit(&be);
-    qemu_chr_delete(chr);
+    object_unparent(OBJECT(chr));
 }
=20
 static void char_stdio_test(void)
@@ -103,7 +103,7 @@ static void char_ringbuf_test(void)
     g_free(data);
=20
     qemu_chr_fe_deinit(&be);
-    qemu_chr_delete(chr);
+    object_unparent(OBJECT(chr));
 }
=20
 static void char_mux_test(void)
@@ -179,7 +179,7 @@ static void char_mux_test(void)
=20
     qemu_chr_fe_deinit(&chr_be1);
     qemu_chr_fe_deinit(&chr_be2);
-    qemu_chr_delete(chr);
+    object_unparent(OBJECT(chr));
 }
=20
 static void char_null_test(void)
@@ -222,7 +222,7 @@ static void char_null_test(void)
     g_assert_cmpint(ret, =3D=3D, 4);
=20
     qemu_chr_fe_deinit(&be);
-    qemu_chr_delete(chr);
+    object_unparent(OBJECT(chr));
 }
=20
 static void char_invalid_test(void)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index a61896c32d..9095af267e 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -491,7 +491,7 @@ static gboolean _test_server_free(TestServer *server)
     Chardev *chr =3D qemu_chr_fe_get_driver(&server->chr);
=20
     qemu_chr_fe_deinit(&server->chr);
-    qemu_chr_delete(chr);
+    object_unparent(OBJECT(chr));
=20
     for (i =3D 0; i < server->fds_num; i++) {
         close(server->fds[i]);
--=20
2.12.0.191.gc5d8de91d
