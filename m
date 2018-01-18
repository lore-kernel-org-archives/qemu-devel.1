Received: from eggs.gnu.org ([2001:4830:134:3::10]:47000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH4m-0004jL-C9
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH4j-0004Rb-8Y
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecH4i-0004Ql-VL
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:17 -0500
Date: Thu, 18 Jan 2018 22:46:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516308132-10272-21-git-send-email-mst@redhat.com>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516308132-10272-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 20/29] vhost-user-test: use init_virtio_dev
 in multiqueue test
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

Now that init_virtio_dev() has been generalized to all cases,
use it in test_multiqueue() to avoid code duplication.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 65 ++++++-------------------------------------=
------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 6a144e8..ec6ac9d 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -892,79 +892,30 @@ static void test_flags_mismatch(void)
=20
 #endif
=20
-static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
-{
-    QVirtioPCIDevice *dev;
-
-    dev =3D qvirtio_pci_device_find(bus, VIRTIO_ID_NET);
-    g_assert(dev !=3D NULL);
-    g_assert_cmphex(dev->vdev.device_type, =3D=3D, VIRTIO_ID_NET);
-
-    qvirtio_pci_device_enable(dev);
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
-
-    return dev;
-}
-
-static void driver_init(QVirtioDevice *dev)
-{
-    uint32_t features;
-
-    features =3D qvirtio_get_features(dev);
-    features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
-                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
-                            (1u << VIRTIO_RING_F_EVENT_IDX));
-    qvirtio_set_features(dev, features);
-
-    qvirtio_set_driver_ok(dev);
-}
-
-#define PCI_SLOT                0x04
-
 static void test_multiqueue(void)
 {
-    const int queues =3D 2;
     TestServer *s =3D test_server_new("mq");
-    QVirtioPCIDevice *dev;
-    QPCIBus *bus;
-    QVirtQueuePCI *vq[queues * 2];
-    QGuestAllocator *alloc;
     char *cmd;
-    int i;
-
-    s->queues =3D queues;
+    uint32_t features_mask =3D ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1u << VIRTIO_RING_F_EVENT_IDX));
+    s->queues =3D 2;
     test_server_listen(s);
=20
     cmd =3D g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",=
queues=3D%d "
                           "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,=
vectors=3D%d",
                           512, 512, root, s->chr_name,
                           s->socket_path, "", s->chr_name,
-                          queues, queues * 2 + 2);
+                          s->queues, s->queues * 2 + 2);
     qtest_start(cmd);
     g_free(cmd);
=20
-    bus =3D qpci_init_pc(NULL);
-    dev =3D virtio_net_pci_init(bus, PCI_SLOT);
+    init_virtio_dev(s, features_mask);
=20
-    alloc =3D pc_alloc_init();
-    for (i =3D 0; i < queues * 2; i++) {
-        vq[i] =3D (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, alloc, i=
);
-    }
+    wait_for_rings_started(s, s->queues * 2);
=20
-    driver_init(&dev->vdev);
-    wait_for_rings_started(s, queues * 2);
+    uninit_virtio_dev(s);
=20
-    /* End test */
-    for (i =3D 0; i < queues * 2; i++) {
-        qvirtqueue_cleanup(dev->vdev.bus, &vq[i]->vq, alloc);
-    }
-    pc_alloc_uninit(alloc);
-    qvirtio_pci_device_disable(dev);
-    g_free(dev->pdev);
-    g_free(dev);
-    qpci_free_pc(bus);
     qtest_end();
=20
     test_server_free(s);
--=20
MST
