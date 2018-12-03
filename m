Received: from eggs.gnu.org ([2001:4830:134:3::10]:51591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEF-0007zg-NN
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEE-00049D-RU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEE-00048D-Jr
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:46 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:23 +0100
Message-Id: <1543851204-41186-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/71] vhost-user-test: skip if there is no
 memory at address 0
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

The virt machine cannot run the vhost-user qtests because they hardcode
the presence of memory at address 0.  Report the tests as a skip so that
they can be converted to use qgraph.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 58 ++++++++++++++++++++++++++++++++++++++-----=
------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 82fc6c5..59e1aec 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -228,9 +228,11 @@ static void uninit_virtio_dev(TestServer *s)
     qvirtio_pci_device_free(s->dev);
 }
=20
-static void wait_for_fds(TestServer *s)
+static bool wait_for_fds(TestServer *s)
 {
     gint64 end_time;
+    bool got_region;
+    int i;
=20
     g_mutex_lock(&s->data_mutex);
=20
@@ -248,6 +250,19 @@ static void wait_for_fds(TestServer *s)
     g_assert_cmpint(s->fds_num, =3D=3D, s->memory.nregions);
=20
     g_mutex_unlock(&s->data_mutex);
+
+    got_region =3D false;
+    for (i =3D 0; i < s->memory.nregions; ++i) {
+        VhostUserMemoryRegion *reg =3D &s->memory.regions[i];
+        if (reg->guest_phys_addr =3D=3D 0) {
+            got_region =3D true;
+            break;
+        }
+    }
+    if (!got_region) {
+        g_test_skip("No memory at address 0x0");
+    }
+    return got_region;
 }
=20
 static void read_guest_mem_server(TestServer *s)
@@ -256,8 +271,6 @@ static void read_guest_mem_server(TestServer *s)
     int i, j;
     size_t size;
=20
-    wait_for_fds(s);
-
     g_mutex_lock(&s->data_mutex);
=20
     /* iterate all regions */
@@ -577,8 +590,6 @@ static void write_guest_mem(TestServer *s, uint32_t s=
eed)
     int i, j;
     size_t size;
=20
-    wait_for_fds(s);
-
     /* iterate all regions */
     for (i =3D 0; i < s->fds_num; i++) {
=20
@@ -661,8 +672,13 @@ static void test_read_guest_mem(const void *arg)
=20
     init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
=20
+    if (!wait_for_fds(server)) {
+        goto exit;
+    }
+
     read_guest_mem_server(server);
=20
+exit:
     uninit_virtio_dev(server);
=20
     qtest_quit(s);
@@ -689,8 +705,10 @@ static void test_migrate(void)
     g_free(cmd);
=20
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
+
     size =3D get_log_size(s);
     g_assert_cmpint(size, =3D=3D, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * =
8));
=20
@@ -699,6 +717,7 @@ static void test_migrate(void)
     g_free(tmp);
     to =3D qtest_init(cmd);
     g_free(cmd);
+    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
=20
     source =3D g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -738,15 +757,18 @@ static void test_migrate(void)
     global_qtest =3D to;
     qmp_eventwait("RESUME");
=20
+    g_assert(wait_for_fds(s));
     read_guest_mem_server(dest);
=20
-    uninit_virtio_dev(s);
     uninit_virtio_dev(dest);
+    qtest_quit(to);
=20
     g_source_destroy(source);
     g_source_unref(source);
=20
-    qtest_quit(to);
+exit:
+    uninit_virtio_dev(s);
+
     test_server_free(dest);
     qtest_quit(from);
     test_server_free(s);
@@ -810,16 +832,20 @@ static void test_reconnect_subprocess(void)
     g_free(cmd);
=20
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
+
     wait_for_rings_started(s, 2);
=20
     /* reconnect */
     s->fds_num =3D 0;
     s->rings =3D 0;
     g_idle_add(reconnect_cb, s);
-    wait_for_fds(s);
+    g_assert(wait_for_fds(s));
     wait_for_rings_started(s, 2);
=20
+exit:
     uninit_virtio_dev(s);
=20
     qtest_end();
@@ -848,9 +874,12 @@ static void test_connect_fail_subprocess(void)
     g_free(cmd);
=20
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
     wait_for_rings_started(s, 2);
=20
+exit:
     uninit_virtio_dev(s);
=20
     qtest_end();
@@ -878,9 +907,12 @@ static void test_flags_mismatch_subprocess(void)
     g_free(cmd);
=20
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
     wait_for_rings_started(s, 2);
=20
+exit:
     uninit_virtio_dev(s);
=20
     qtest_end();
--=20
1.8.3.1
