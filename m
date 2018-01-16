Received: from eggs.gnu.org ([2001:4830:134:3::10]:48184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJA7-0008N0-1A
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJA3-0004to-UH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJA3-0004tU-LN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:47 -0500
Date: Tue, 16 Jan 2018 06:47:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-19-git-send-email-mst@redhat.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516077852-7974-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/33] vhost-user-test: setup virtqueues in all
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

Only the multiqueue test setups the virtqueues.
This patch generalizes the setup of virtqueues for all tests.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 53 +++++++++++++++++++++++++++++++++++++++----=
------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index df56724..969e393 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -55,6 +55,7 @@
 /*********** FROM hw/virtio/vhost-user.c *******************************=
******/
=20
 #define VHOST_MEMORY_MAX_NREGIONS    8
+#define VHOST_MAX_VIRTQUEUES    0x100
=20
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_PROTOCOL_F_MQ 0
@@ -141,6 +142,8 @@ enum {
=20
 typedef struct TestServer {
     QPCIBus *bus;
+    QVirtioPCIDevice *dev;
+    QVirtQueue *vq[VHOST_MAX_VIRTQUEUES];
     gchar *socket_path;
     gchar *mig_path;
     gchar *chr_name;
@@ -155,6 +158,7 @@ typedef struct TestServer {
     bool test_fail;
     int test_flags;
     int queues;
+    QGuestAllocator *alloc;
 } TestServer;
=20
 static const char *tmpfs;
@@ -162,26 +166,43 @@ static const char *root;
=20
 static void init_virtio_dev(TestServer *s)
 {
-    QVirtioPCIDevice *dev;
     uint32_t features;
+    int i;
=20
     s->bus =3D qpci_init_pc(NULL);
     g_assert_nonnull(s->bus);
=20
-    dev =3D qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
-    g_assert_nonnull(dev);
+    s->dev =3D qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
+    g_assert_nonnull(s->dev);
=20
-    qvirtio_pci_device_enable(dev);
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
+    qvirtio_pci_device_enable(s->dev);
+    qvirtio_reset(&s->dev->vdev);
+    qvirtio_set_acknowledge(&s->dev->vdev);
+    qvirtio_set_driver(&s->dev->vdev);
+
+    s->alloc =3D pc_alloc_init();
=20
-    features =3D qvirtio_get_features(&dev->vdev);
+    for (i =3D 0; i < s->queues * 2; i++) {
+        s->vq[i] =3D qvirtqueue_setup(&s->dev->vdev, s->alloc, i);
+    }
+
+    features =3D qvirtio_get_features(&s->dev->vdev);
     features =3D features & (1u << VIRTIO_NET_F_MAC);
-    qvirtio_set_features(&dev->vdev, features);
+    qvirtio_set_features(&s->dev->vdev, features);
=20
-    qvirtio_set_driver_ok(&dev->vdev);
-    qvirtio_pci_device_free(dev);
+    qvirtio_set_driver_ok(&s->dev->vdev);
+}
+
+static void uninit_virtio_dev(TestServer *s)
+{
+    int i;
+
+    for (i =3D 0; i < s->queues * 2; i++) {
+        qvirtqueue_cleanup(s->dev->vdev.bus, s->vq[i], s->alloc);
+    }
+    pc_alloc_uninit(s->alloc);
+
+    qvirtio_pci_device_free(s->dev);
 }
=20
 static void wait_for_fds(TestServer *s)
@@ -635,6 +656,8 @@ static void test_read_guest_mem(void)
=20
     read_guest_mem(server);
=20
+    uninit_virtio_dev(server);
+
     qtest_quit(s);
     test_server_free(server);
 }
@@ -711,6 +734,8 @@ static void test_migrate(void)
=20
     read_guest_mem(dest);
=20
+    uninit_virtio_dev(s);
+
     g_source_destroy(source);
     g_source_unref(source);
=20
@@ -789,6 +814,8 @@ static void test_reconnect_subprocess(void)
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
=20
+    uninit_virtio_dev(s);
+
     qtest_end();
     test_server_free(s);
     return;
@@ -818,6 +845,8 @@ static void test_connect_fail_subprocess(void)
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
=20
+    uninit_virtio_dev(s);
+
     qtest_end();
     test_server_free(s);
 }
@@ -846,6 +875,8 @@ static void test_flags_mismatch_subprocess(void)
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
=20
+    uninit_virtio_dev(s);
+
     qtest_end();
     test_server_free(s);
 }
--=20
MST
