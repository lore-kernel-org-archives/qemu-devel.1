Received: from eggs.gnu.org ([2001:4830:134:3::10]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRv-0001lx-36
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRt-0007Xj-HS
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:03 -0300
Message-Id: <20171006235023.11952-69-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 68/88] virtio: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: more changes/files]
---
 hw/char/virtio-serial-bus.c | 6 ++----
 hw/display/virtio-gpu.c     | 4 ++--
 hw/net/virtio-net.c         | 4 ++--
 hw/virtio/vhost.c           | 2 +-
 hw/virtio/virtio-crypto.c   | 2 +-
 hw/virtio/virtio.c          | 2 +-
 tests/libqos/virtio-mmio.c  | 4 ++--
 tests/libqos/virtio-pci.c   | 4 ++--
 8 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7be7..fe739bb773 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1054,10 +1054,8 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
     QTAILQ_INIT(&vser->ports);
 
     vser->bus.max_nr_ports = vser->serial.max_virtserial_ports;
-    vser->ivqs = g_malloc(vser->serial.max_virtserial_ports
-                          * sizeof(VirtQueue *));
-    vser->ovqs = g_malloc(vser->serial.max_virtserial_ports
-                          * sizeof(VirtQueue *));
+    vser->ivqs = g_new(VirtQueue *, vser->serial.max_virtserial_ports);
+    vser->ovqs = g_new(VirtQueue *, vser->serial.max_virtserial_ports);
 
     /* Add a queue for host to guest transfers for port 0 (backward compat) */
     vser->ivqs[0] = virtio_add_queue(vdev, 128, handle_input);
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43bbe09ea0..fb3884220b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -676,9 +676,9 @@ int virtio_gpu_create_mapping_iov(struct virtio_gpu_resource_attach_backing *ab,
         return -1;
     }
 
-    *iov = g_malloc0(sizeof(struct iovec) * ab->nr_entries);
+    *iov = g_new0(struct iovec, ab->nr_entries);
     if (addr) {
-        *addr = g_malloc0(sizeof(uint64_t) * ab->nr_entries);
+        *addr = g_new0(uint64_t, ab->nr_entries);
     }
     for (i = 0; i < ab->nr_entries; i++) {
         uint64_t a = le64_to_cpu(ents[i].addr);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 150fd0748e..ce488b63d5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -359,7 +359,7 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetClientState *nc)
     strList *str_list, *entry;
     int i;
 
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(RxFilterInfo, 1);
     info->name = g_strdup(nc->name);
     info->promiscuous = n->promisc;
 
@@ -1978,7 +1978,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         virtio_cleanup(vdev);
         return;
     }
-    n->vqs = g_malloc0(sizeof(VirtIONetQueue) * n->max_queues);
+    n->vqs = g_new0(VirtIONetQueue, n->max_queues);
     n->curr_queues = 1;
     n->tx_timeout = n->net_conf.txtimer;
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5fd69f0b2e..f4abc1d26d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -742,7 +742,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
         return;
     }
 
-    iommu = g_malloc0(sizeof(*iommu));
+    iommu = g_new0(struct vhost_iommu, 1);
     end = int128_add(int128_make64(section->offset_within_region),
                      section->size);
     end = int128_sub(end, int128_one());
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 19c82e0432..9544ea92ef 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -798,7 +798,7 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
 
     virtio_init(vdev, "virtio-crypto", VIRTIO_ID_CRYPTO, vcrypto->config_size);
     vcrypto->curr_queues = 1;
-    vcrypto->vqs = g_malloc0(sizeof(VirtIOCryptoQueue) * vcrypto->max_queues);
+    vcrypto->vqs = g_new0(VirtIOCryptoQueue, vcrypto->max_queues);
     for (i = 0; i < vcrypto->max_queues; i++) {
         vcrypto->vqs[i].dataq =
                  virtio_add_queue(vdev, 1024, virtio_crypto_handle_dataq_bh);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 311929e9df..9a38fe695a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2245,7 +2245,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
     atomic_set(&vdev->isr, 0);
     vdev->queue_sel = 0;
     vdev->config_vector = VIRTIO_NO_VECTOR;
-    vdev->vq = g_malloc0(sizeof(VirtQueue) * VIRTIO_QUEUE_MAX);
+    vdev->vq = g_new0(VirtQueue, VIRTIO_QUEUE_MAX);
     vdev->vm_running = runstate_is_running();
     vdev->broken = false;
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 7aa8383338..a48fecab63 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -127,7 +127,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
     QVirtQueue *vq;
     uint64_t addr;
 
-    vq = g_malloc0(sizeof(*vq));
+    vq = g_new0(QVirtQueue, 1);
     qvirtio_mmio_queue_select(d, index);
     writel(dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);
 
@@ -191,7 +191,7 @@ QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size)
 {
     QVirtioMMIODevice *dev;
     uint32_t magic;
-    dev = g_malloc0(sizeof(*dev));
+    dev = g_new0(QVirtioMMIODevice, 1);
 
     magic = readl(addr + QVIRTIO_MMIO_MAGIC_VALUE);
     g_assert(magic == ('v' | 'i' << 8 | 'r' << 16 | 't' << 24));
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 7ac15c04e1..02d5e0853e 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -38,7 +38,7 @@ void qvirtio_pci_device_free(QVirtioPCIDevice *dev)
 static QVirtioPCIDevice *qpcidevice_to_qvirtiodevice(QPCIDevice *pdev)
 {
     QVirtioPCIDevice *vpcidev;
-    vpcidev = g_malloc0(sizeof(*vpcidev));
+    vpcidev = g_new0(QVirtioPCIDevice, 1);
 
     if (pdev) {
         vpcidev->pdev = pdev;
@@ -229,7 +229,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
     uint64_t addr;
     QVirtQueuePCI *vqpci;
 
-    vqpci = g_malloc0(sizeof(*vqpci));
+    vqpci = g_new0(QVirtQueuePCI, 1);
     feat = qvirtio_pci_get_guest_features(d);
 
     qvirtio_pci_queue_select(d, index);
-- 
2.14.2
