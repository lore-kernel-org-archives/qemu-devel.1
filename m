Received: from eggs.gnu.org ([2001:4830:134:3::10]:42178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS8Hq-0000h3-Ey
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS8Hp-0000Sd-GQ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS8Hp-0000SI-8O
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8285F4DB12
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 21:21:52 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 21 Dec 2017 22:21:23 +0100
Message-Id: <20171221212125.19075-4-maxime.coquelin@redhat.com>
In-Reply-To: <20171221212125.19075-1-maxime.coquelin@redhat.com>
References: <20171221212125.19075-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/5] vhost-user-test: setup virtqueues in
 all tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

Only the multiqueue test setups the virtqueues.
This patch generalizes the setup of virtqueues for all tests.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 tests/vhost-user-test.c | 53 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index df567248ae..969e3932cc 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -55,6 +55,7 @@
 /*********** FROM hw/virtio/vhost-user.c *************************************/
 
 #define VHOST_MEMORY_MAX_NREGIONS    8
+#define VHOST_MAX_VIRTQUEUES    0x100
 
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_PROTOCOL_F_MQ 0
@@ -141,6 +142,8 @@ enum {
 
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
 
 static const char *tmpfs;
@@ -162,26 +166,43 @@ static const char *root;
 
 static void init_virtio_dev(TestServer *s)
 {
-    QVirtioPCIDevice *dev;
     uint32_t features;
+    int i;
 
     s->bus = qpci_init_pc(NULL);
     g_assert_nonnull(s->bus);
 
-    dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
-    g_assert_nonnull(dev);
+    s->dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
+    g_assert_nonnull(s->dev);
 
-    qvirtio_pci_device_enable(dev);
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
+    qvirtio_pci_device_enable(s->dev);
+    qvirtio_reset(&s->dev->vdev);
+    qvirtio_set_acknowledge(&s->dev->vdev);
+    qvirtio_set_driver(&s->dev->vdev);
+
+    s->alloc = pc_alloc_init();
 
-    features = qvirtio_get_features(&dev->vdev);
+    for (i = 0; i < s->queues * 2; i++) {
+        s->vq[i] = qvirtqueue_setup(&s->dev->vdev, s->alloc, i);
+    }
+
+    features = qvirtio_get_features(&s->dev->vdev);
     features = features & (1u << VIRTIO_NET_F_MAC);
-    qvirtio_set_features(&dev->vdev, features);
+    qvirtio_set_features(&s->dev->vdev, features);
 
-    qvirtio_set_driver_ok(&dev->vdev);
-    qvirtio_pci_device_free(dev);
+    qvirtio_set_driver_ok(&s->dev->vdev);
+}
+
+static void uninit_virtio_dev(TestServer *s)
+{
+    int i;
+
+    for (i = 0; i < s->queues * 2; i++) {
+        qvirtqueue_cleanup(s->dev->vdev.bus, s->vq[i], s->alloc);
+    }
+    pc_alloc_uninit(s->alloc);
+
+    qvirtio_pci_device_free(s->dev);
 }
 
 static void wait_for_fds(TestServer *s)
@@ -635,6 +656,8 @@ static void test_read_guest_mem(void)
 
     read_guest_mem(server);
 
+    uninit_virtio_dev(server);
+
     qtest_quit(s);
     test_server_free(server);
 }
@@ -711,6 +734,8 @@ static void test_migrate(void)
 
     read_guest_mem(dest);
 
+    uninit_virtio_dev(s);
+
     g_source_destroy(source);
     g_source_unref(source);
 
@@ -789,6 +814,8 @@ static void test_reconnect_subprocess(void)
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
+    uninit_virtio_dev(s);
+
     qtest_end();
     test_server_free(s);
     return;
@@ -818,6 +845,8 @@ static void test_connect_fail_subprocess(void)
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
+    uninit_virtio_dev(s);
+
     qtest_end();
     test_server_free(s);
 }
@@ -846,6 +875,8 @@ static void test_flags_mismatch_subprocess(void)
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
+    uninit_virtio_dev(s);
+
     qtest_end();
     test_server_free(s);
 }
-- 
2.14.3
