Received: from eggs.gnu.org ([2001:4830:134:3::10]:52420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFj-0001lS-0N
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFe-0005x6-7Q
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFe-0005w8-0L
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:14 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:05 +0100
Message-Id: <1543851204-41186-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 52/71] tests/libqos: support multiqueue for
 virtio-net
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

Initialize the additional virtqueues if they are supported.
This is needed to switch vhost-user-test's multiqueue test
to the virtio-net qgraph.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/virtio-net.c | 21 +++++++++++++++++----
 tests/libqos/virtio-net.h |  4 ++--
 tests/virtio-net-test.c   |  6 +++---
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
index 3ddfbdc..61c5617 100644
--- a/tests/libqos/virtio-net.c
+++ b/tests/libqos/virtio-net.c
@@ -27,14 +27,19 @@ static QGuestAllocator *alloc;
 
 static void virtio_net_cleanup(QVirtioNet *interface)
 {
-    qvirtqueue_cleanup(interface->vdev->bus, interface->rx, alloc);
-    qvirtqueue_cleanup(interface->vdev->bus, interface->tx, alloc);
+    int i;
+
+    for (i = 0; i < interface->n_queues; i++) {
+        qvirtqueue_cleanup(interface->vdev->bus, interface->queues[i], alloc);
+    }
+    g_free(interface->queues);
 }
 
 static void virtio_net_setup(QVirtioNet *interface)
 {
     QVirtioDevice *vdev = interface->vdev;
     uint64_t features;
+    int i;
 
     features = qvirtio_get_features(vdev);
     features &= ~(QVIRTIO_F_BAD_FEATURE |
@@ -42,8 +47,16 @@ static void virtio_net_setup(QVirtioNet *interface)
                   (1u << VIRTIO_RING_F_EVENT_IDX));
     qvirtio_set_features(vdev, features);
 
-    interface->rx = qvirtqueue_setup(vdev, alloc, 0);
-    interface->tx = qvirtqueue_setup(vdev, alloc, 1);
+    if (features & (1u << VIRTIO_NET_F_MQ)) {
+        interface->n_queues = qvirtio_config_readw(vdev, 8) * 2;
+    } else {
+        interface->n_queues = 2;
+    }
+
+    interface->queues = g_new(QVirtQueue *, interface->n_queues);
+    for (i = 0; i < interface->n_queues; i++) {
+        interface->queues[i] = qvirtqueue_setup(vdev, alloc, i);
+    }
     qvirtio_set_driver_ok(vdev);
 }
 
diff --git a/tests/libqos/virtio-net.h b/tests/libqos/virtio-net.h
index e6905cd..28238a1 100644
--- a/tests/libqos/virtio-net.h
+++ b/tests/libqos/virtio-net.h
@@ -26,8 +26,8 @@ typedef struct QVirtioNetDevice QVirtioNetDevice;
 
 struct QVirtioNet {
     QVirtioDevice *vdev;
-    QVirtQueue *rx;
-    QVirtQueue *tx;
+    int n_queues;
+    QVirtQueue **queues;
 };
 
 struct QVirtioNetPCI {
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index c6550e1..b232074 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -137,8 +137,8 @@ static void send_recv_test(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtioNet *net_if = obj;
     QVirtioDevice *dev = net_if->vdev;
-    QVirtQueue *rx = net_if->rx;
-    QVirtQueue *tx = net_if->tx;
+    QVirtQueue *rx = net_if->queues[0];
+    QVirtQueue *tx = net_if->queues[1];
     int *sv = data;
 
     rx_test(dev, t_alloc, rx, sv[0]);
@@ -149,7 +149,7 @@ static void stop_cont_test(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtioNet *net_if = obj;
     QVirtioDevice *dev = net_if->vdev;
-    QVirtQueue *rx = net_if->rx;
+    QVirtQueue *rx = net_if->queues[0];
     int *sv = data;
 
     rx_stop_cont_test(dev, t_alloc, rx, sv[0]);
-- 
1.8.3.1
