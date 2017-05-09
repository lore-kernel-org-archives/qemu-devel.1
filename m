Received: from eggs.gnu.org ([2001:4830:134:3::10]:60087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83R8-0006gk-Cc
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83R4-0003KP-9x
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83R4-0003KC-0g
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:36:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04DC280B20
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:36:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:32 +0400
Message-Id: <20170509113332.4987-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/13] char: make chr_fe_deinit() optionaly
 delete backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This simplifies removing a backend for a frontend user (no need to
retrive the associated driver and seperate delete call etc).

NB: many frontends have questionable handling of ending a chardev. They
should probably delete the backend to prevent broken reusage.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h        |  6 ++++--
 backends/rng-egd.c               |  2 +-
 chardev/char-fe.c                |  5 ++++-
 chardev/char-mux.c               |  2 +-
 gdbstub.c                        | 15 ++-------------
 hw/char/serial.c                 |  2 +-
 hw/char/xen_console.c            |  2 +-
 hw/core/qdev-properties-system.c |  2 +-
 hw/usb/ccid-card-passthru.c      |  5 +----
 hw/usb/redirect.c                |  4 +---
 monitor.c                        |  2 +-
 net/colo-compare.c               |  8 +++-----
 net/filter-mirror.c              |  6 +++---
 net/vhost-user.c                 |  5 +----
 tests/test-char.c                | 22 ++++++++--------------
 tests/vhost-user-test.c          |  4 +---
 16 files changed, 34 insertions(+), 58 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index bd82093218..2cbb262f66 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -30,12 +30,14 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Err=
or **errp);
=20
 /**
  * @qemu_chr_fe_deinit:
- *
+ * @b: a CharBackend
+ * @del: if true, delete the chardev backend
+*
  * Dissociate the CharBackend from the Chardev.
  *
  * Safe to call without associated Chardev.
  */
-void qemu_chr_fe_deinit(CharBackend *b);
+void qemu_chr_fe_deinit(CharBackend *b, bool del);
=20
 /**
  * @qemu_chr_fe_get_driver:
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index ad3e1e5edf..e7ce2cac80 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -145,7 +145,7 @@ static void rng_egd_finalize(Object *obj)
 {
     RngEgd *s =3D RNG_EGD(obj);
=20
-    qemu_chr_fe_deinit(&s->chr);
+    qemu_chr_fe_deinit(&s->chr, false);
     g_free(s->chr_name);
 }
=20
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index ba19e168ce..dcdce93154 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -211,7 +211,7 @@ unavailable:
     return false;
 }
=20
-void qemu_chr_fe_deinit(CharBackend *b)
+void qemu_chr_fe_deinit(CharBackend *b, bool del)
 {
     assert(b);
=20
@@ -224,6 +224,9 @@ void qemu_chr_fe_deinit(CharBackend *b)
             MuxChardev *d =3D MUX_CHARDEV(b->chr);
             d->backends[b->tag] =3D NULL;
         }
+        if (del) {
+            object_unparent(OBJECT(b->chr));
+        }
         b->chr =3D NULL;
     }
 }
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 106c682e7f..08570b915e 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -266,7 +266,7 @@ static void char_mux_finalize(Object *obj)
             be->chr =3D NULL;
         }
     }
-    qemu_chr_fe_deinit(&d->chr);
+    qemu_chr_fe_deinit(&d->chr, false);
 }
=20
 void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
diff --git a/gdbstub.c b/gdbstub.c
index 98854c33e7..521b952964 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1588,9 +1588,6 @@ void gdb_exit(CPUArchState *env, int code)
 {
   GDBState *s;
   char buf[4];
-#ifndef CONFIG_USER_ONLY
-  Chardev *chr;
-#endif
=20
   s =3D gdbserver_state;
   if (!s) {
@@ -1600,19 +1597,13 @@ void gdb_exit(CPUArchState *env, int code)
   if (gdbserver_fd < 0 || s->fd < 0) {
       return;
   }
-#else
-  chr =3D qemu_chr_fe_get_driver(&s->chr);
-  if (!chr) {
-      return;
-  }
 #endif
=20
   snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
   put_packet(s, buf);
=20
 #ifndef CONFIG_USER_ONLY
-  qemu_chr_fe_deinit(&s->chr);
-  object_unparent(OBJECT(chr));
+  qemu_chr_fe_deinit(&s->chr, true);
 #endif
 }
=20
@@ -1912,9 +1903,7 @@ int gdbserver_start(const char *device)
                                    NULL, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
-        if (qemu_chr_fe_get_driver(&s->chr)) {
-            object_unparent(OBJECT(qemu_chr_fe_get_driver(&s->chr)));
-        }
+        qemu_chr_fe_deinit(&s->chr, true);
         mon_chr =3D s->mon_chr;
         memset(s, 0, sizeof(GDBState));
         s->mon_chr =3D mon_chr;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 23e5fe9d18..e1f12507bf 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -905,7 +905,7 @@ void serial_realize_core(SerialState *s, Error **errp=
)
=20
 void serial_exit_core(SerialState *s)
 {
-    qemu_chr_fe_deinit(&s->chr);
+    qemu_chr_fe_deinit(&s->chr, false);
=20
     timer_del(s->modem_status_poll);
     timer_free(s->modem_status_poll);
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index cb849c2e3e..f9af8cadf4 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -261,7 +261,7 @@ static void con_disconnect(struct XenDevice *xendev)
 {
     struct XenConsole *con =3D container_of(xendev, struct XenConsole, x=
endev);
=20
-    qemu_chr_fe_deinit(&con->chr);
+    qemu_chr_fe_deinit(&con->chr, false);
     xen_pv_unbind_evtchn(&con->xendev);
=20
     if (con->sring) {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index a549d39030..3bef41914d 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -225,7 +225,7 @@ static void release_chr(Object *obj, const char *name=
, void *opaque)
     Property *prop =3D opaque;
     CharBackend *be =3D qdev_get_prop_ptr(dev, prop);
=20
-    qemu_chr_fe_deinit(be);
+    qemu_chr_fe_deinit(be, false);
 }
=20
 PropertyInfo qdev_prop_chr =3D {
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index fed3683a50..ac1725eeae 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -264,10 +264,7 @@ static void ccid_card_vscard_handle_message(Passthru=
State *card,
=20
 static void ccid_card_vscard_drop_connection(PassthruState *card)
 {
-    Chardev *chr =3D qemu_chr_fe_get_driver(&card->cs);
-
-    qemu_chr_fe_deinit(&card->cs);
-    object_unparent(OBJECT(chr));
+    qemu_chr_fe_deinit(&card->cs, true);
     card->vscard_in_pos =3D card->vscard_in_hdr =3D 0;
 }
=20
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 865aa9fbe0..b6f6a4edcb 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1430,10 +1430,8 @@ static void usbredir_cleanup_device_queues(USBRedi=
rDevice *dev)
 static void usbredir_unrealize(USBDevice *udev, Error **errp)
 {
     USBRedirDevice *dev =3D USB_REDIRECT(udev);
-    Chardev *chr =3D qemu_chr_fe_get_driver(&dev->cs);
=20
-    qemu_chr_fe_deinit(&dev->cs);
-    object_unparent(OBJECT(chr));
+    qemu_chr_fe_deinit(&dev->cs, true);
=20
     /* Note must be done after qemu_chr_close, as that causes a close ev=
ent */
     qemu_bh_delete(dev->chardev_close_bh);
diff --git a/monitor.c b/monitor.c
index 032e97485b..1456f0b213 100644
--- a/monitor.c
+++ b/monitor.c
@@ -579,7 +579,7 @@ static void monitor_data_init(Monitor *mon)
=20
 static void monitor_data_destroy(Monitor *mon)
 {
-    qemu_chr_fe_deinit(&mon->chr);
+    qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
         json_message_parser_destroy(&mon->qmp.parser);
     }
diff --git a/net/colo-compare.c b/net/colo-compare.c
index db18e8ec7e..16b29c4765 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -790,11 +790,9 @@ static void colo_compare_finalize(Object *obj)
 {
     CompareState *s =3D COLO_COMPARE(obj);
=20
-    qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
-                             s->worker_context, true);
-    qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
-                             s->worker_context, true);
-    qemu_chr_fe_deinit(&s->chr_out);
+    qemu_chr_fe_deinit(&s->chr_pri_in, false);
+    qemu_chr_fe_deinit(&s->chr_sec_in, false);
+    qemu_chr_fe_deinit(&s->chr_out, false);
=20
     g_main_loop_quit(s->compare_loop);
     qemu_thread_join(&s->thread);
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 33818955e2..908c7490c5 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -178,15 +178,15 @@ static void filter_mirror_cleanup(NetFilterState *n=
f)
 {
     MirrorState *s =3D FILTER_MIRROR(nf);
=20
-    qemu_chr_fe_deinit(&s->chr_out);
+    qemu_chr_fe_deinit(&s->chr_out, false);
 }
=20
 static void filter_redirector_cleanup(NetFilterState *nf)
 {
     MirrorState *s =3D FILTER_REDIRECTOR(nf);
=20
-    qemu_chr_fe_deinit(&s->chr_in);
-    qemu_chr_fe_deinit(&s->chr_out);
+    qemu_chr_fe_deinit(&s->chr_in, false);
+    qemu_chr_fe_deinit(&s->chr_out, false);
 }
=20
 static void filter_mirror_setup(NetFilterState *nf, Error **errp)
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 526290d8c1..a042ec6a34 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -151,10 +151,7 @@ static void vhost_user_cleanup(NetClientState *nc)
         s->vhost_net =3D NULL;
     }
     if (nc->queue_index =3D=3D 0) {
-        Chardev *chr =3D qemu_chr_fe_get_driver(&s->chr);
-
-        qemu_chr_fe_deinit(&s->chr);
-        object_unparent(OBJECT(chr));
+        qemu_chr_fe_deinit(&s->chr, true);
     }
=20
     qemu_purge_queued_packets(nc);
diff --git a/tests/test-char.c b/tests/test-char.c
index 42844993a3..ee01659422 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -97,8 +97,7 @@ static void char_stdio_test_subprocess(void)
     ret =3D qemu_chr_fe_write(&be, (void *)"buf", 4);
     g_assert_cmpint(ret, =3D=3D, 4);
=20
-    qemu_chr_fe_deinit(&be);
-    object_unparent(OBJECT(chr));
+    qemu_chr_fe_deinit(&be, true);
 }
=20
 static void char_stdio_test(void)
@@ -146,8 +145,7 @@ static void char_ringbuf_test(void)
     g_assert_cmpstr(data, =3D=3D, "");
     g_free(data);
=20
-    qemu_chr_fe_deinit(&be);
-    object_unparent(OBJECT(chr));
+    qemu_chr_fe_deinit(&be, true);
=20
     /* check alias */
     opts =3D qemu_opts_create(qemu_find_opts("chardev"), "memory-label",
@@ -231,9 +229,8 @@ static void char_mux_test(void)
     g_assert_cmpint(strlen(data), !=3D, 0);
     g_free(data);
=20
-    qemu_chr_fe_deinit(&chr_be1);
-    qemu_chr_fe_deinit(&chr_be2);
-    object_unparent(OBJECT(chr));
+    qemu_chr_fe_deinit(&chr_be1, false);
+    qemu_chr_fe_deinit(&chr_be2, true);
 }
=20
 typedef struct SocketIdleData {
@@ -397,8 +394,7 @@ static void char_pipe_test(void)
     g_assert_cmpint(fe.read_count, =3D=3D, 8);
     g_assert_cmpstr(fe.read_buf, =3D=3D, "pipe-in");
=20
-    qemu_chr_fe_deinit(&be);
-    object_unparent(OBJECT(chr));
+    qemu_chr_fe_deinit(&be, true);
=20
     g_assert(g_unlink(in) =3D=3D 0);
     g_assert(g_unlink(out) =3D=3D 0);
@@ -512,8 +508,7 @@ static void char_file_test(void)
=20
         g_assert_cmpint(fe.read_count, =3D=3D, 8);
         g_assert_cmpstr(fe.read_buf, =3D=3D, "fifo-in");
-        qemu_chr_fe_deinit(&be);
-        object_unref(OBJECT(chr));
+        qemu_chr_fe_deinit(&be, true);
         g_unlink(fifo);
         g_free(fifo);
     }
@@ -550,7 +545,7 @@ static void char_null_test(void)
     error_free_or_abort(&err);
=20
     /* deinit & reinit */
-    qemu_chr_fe_deinit(&be);
+    qemu_chr_fe_deinit(&be, false);
     qemu_chr_fe_init(&be, chr, &error_abort);
=20
     qemu_chr_fe_set_open(&be, true);
@@ -564,8 +559,7 @@ static void char_null_test(void)
     ret =3D qemu_chr_fe_write(&be, (void *)"buf", 4);
     g_assert_cmpint(ret, =3D=3D, 4);
=20
-    qemu_chr_fe_deinit(&be);
-    object_unparent(OBJECT(chr));
+    qemu_chr_fe_deinit(&be, true);
 }
=20
 static void char_invalid_test(void)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 4ca11ae28d..b3cc045765 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -488,10 +488,8 @@ static inline void test_server_connect(TestServer *s=
erver)
 static gboolean _test_server_free(TestServer *server)
 {
     int i;
-    Chardev *chr =3D qemu_chr_fe_get_driver(&server->chr);
=20
-    qemu_chr_fe_deinit(&server->chr);
-    object_unparent(OBJECT(chr));
+    qemu_chr_fe_deinit(&server->chr, true);
=20
     for (i =3D 0; i < server->fds_num; i++) {
         close(server->fds[i]);
--=20
2.13.0.rc1.16.gd80b50c3f
