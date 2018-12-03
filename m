Received: from eggs.gnu.org ([2001:4830:134:3::10]:51601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEH-00080c-7o
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEG-0004Ay-Ci
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEG-0004AE-54
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:48 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:24 +0100
Message-Id: <1543851204-41186-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/71] vhost-user-test: reduce usage of
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

Whenever the code can run on multiple QTestStates, use them explicitly in=
stead of
global_qtest.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 59e1aec..c3a8af3 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -187,12 +187,12 @@ static char *get_qemu_cmd(TestServer *s,
     }
 }
=20
-static void init_virtio_dev(TestServer *s, uint32_t features_mask)
+static void init_virtio_dev(QTestState *qts, TestServer *s, uint32_t fea=
tures_mask)
 {
     uint32_t features;
     int i;
=20
-    s->bus =3D qpci_init_pc(global_qtest, NULL);
+    s->bus =3D qpci_init_pc(qts, NULL);
     g_assert_nonnull(s->bus);
=20
     s->dev =3D qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
@@ -203,7 +203,7 @@ static void init_virtio_dev(TestServer *s, uint32_t f=
eatures_mask)
     qvirtio_set_acknowledge(&s->dev->vdev);
     qvirtio_set_driver(&s->dev->vdev);
=20
-    s->alloc =3D pc_alloc_init(global_qtest);
+    s->alloc =3D pc_alloc_init(qts);
=20
     for (i =3D 0; i < s->queues * 2; i++) {
         s->vq[i] =3D qvirtqueue_setup(&s->dev->vdev, s->alloc, i);
@@ -265,7 +265,7 @@ static bool wait_for_fds(TestServer *s)
     return got_region;
 }
=20
-static void read_guest_mem_server(TestServer *s)
+static void read_guest_mem_server(QTestState *qts, TestServer *s)
 {
     uint8_t *guest_mem;
     int i, j;
@@ -293,7 +293,7 @@ static void read_guest_mem_server(TestServer *s)
         guest_mem +=3D (s->memory.regions[i].mmap_offset / sizeof(*guest=
_mem));
=20
         for (j =3D 0; j < 1024; j++) {
-            uint32_t a =3D readb(s->memory.regions[i].guest_phys_addr + =
j);
+            uint32_t a =3D qtest_readb(qts, s->memory.regions[i].guest_p=
hys_addr + j);
             uint32_t b =3D guest_mem[j];
=20
             g_assert_cmpint(a, =3D=3D, b);
@@ -670,13 +670,13 @@ static void test_read_guest_mem(const void *arg)
     s =3D qtest_start(qemu_cmd);
     g_free(qemu_cmd);
=20
-    init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, server, 1u << VIRTIO_NET_F_MAC);
=20
     if (!wait_for_fds(server)) {
         goto exit;
     }
=20
-    read_guest_mem_server(server);
+    read_guest_mem_server(global_qtest, server);
=20
 exit:
     uninit_virtio_dev(server);
@@ -690,7 +690,7 @@ static void test_migrate(void)
     TestServer *s =3D test_server_new("src");
     TestServer *dest =3D test_server_new("dest");
     char *uri =3D g_strdup_printf("%s%s", "unix:", dest->mig_path);
-    QTestState *global =3D global_qtest, *from, *to;
+    QTestState *from, *to;
     GSource *source;
     gchar *cmd, *tmp;
     QDict *rsp;
@@ -704,7 +704,7 @@ static void test_migrate(void)
     from =3D qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(from, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -717,7 +717,7 @@ static void test_migrate(void)
     g_free(tmp);
     to =3D qtest_init(cmd);
     g_free(cmd);
-    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(to, dest, 1u << VIRTIO_NET_F_MAC);
=20
     source =3D g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -753,12 +753,10 @@ static void test_migrate(void)
     qobject_unref(rsp);
=20
     qmp_eventwait("STOP");
+    qtest_qmp_eventwait(to, "RESUME");
=20
-    global_qtest =3D to;
-    qmp_eventwait("RESUME");
-
-    g_assert(wait_for_fds(s));
-    read_guest_mem_server(dest);
+    g_assert(wait_for_fds(dest));
+    read_guest_mem_server(to, dest);
=20
     uninit_virtio_dev(dest);
     qtest_quit(to);
@@ -773,8 +771,6 @@ exit:
     qtest_quit(from);
     test_server_free(s);
     g_free(uri);
-
-    global_qtest =3D global;
 }
=20
 static void wait_for_rings_started(TestServer *s, size_t count)
@@ -831,7 +827,7 @@ static void test_reconnect_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -873,7 +869,7 @@ static void test_connect_fail_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -906,7 +902,7 @@ static void test_flags_mismatch_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -957,7 +953,7 @@ static void test_multiqueue(void)
     qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s, features_mask);
+    init_virtio_dev(global_qtest, s, features_mask);
=20
     wait_for_rings_started(s, s->queues * 2);
=20
--=20
1.8.3.1
