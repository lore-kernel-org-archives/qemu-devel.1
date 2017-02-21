Received: from eggs.gnu.org ([2001:4830:134:3::10]:56647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBFj-0002S5-S1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBFc-0004kL-0u
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:17:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBFb-0004jm-No
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:17:07 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA0F942BA0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:17:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:50 +0400
Message-Id: <20170221141451.28305-30-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 29/30] tests: fix virtio-blk-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use qvirtio_pci_device_find_slot() to avoid leaking the non-hp
device. Add assert() to avoid further leaks in the future.

Use qvirtio_pci_device_free() to correctly free QVirtioPCIDevice.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/libqos/virtio-pci.c |  1 +
 tests/virtio-blk-test.c   | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 8a0904bbf0..7ac15c04e1 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -68,6 +68,7 @@ static void qvirtio_pci_foreach_callback(
 static void qvirtio_pci_assign_device(QVirtioDevice *d, void *data)
 {
     QVirtioPCIDevice **vpcidev =3D data;
+    assert(!*vpcidev);
     *vpcidev =3D (QVirtioPCIDevice *)d;
 }
=20
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 10a92b410a..1eee95df49 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -108,7 +108,7 @@ static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus =
*bus, int slot)
 {
     QVirtioPCIDevice *dev;
=20
-    dev =3D qvirtio_pci_device_find(bus, VIRTIO_ID_BLOCK);
+    dev =3D qvirtio_pci_device_find_slot(bus, VIRTIO_ID_BLOCK, slot);
     g_assert(dev !=3D NULL);
     g_assert_cmphex(dev->vdev.device_type, =3D=3D, VIRTIO_ID_BLOCK);
     g_assert_cmphex(dev->pdev->devfn, =3D=3D, ((slot << 3) | PCI_FN));
@@ -296,7 +296,7 @@ static void pci_basic(void)
     /* End test */
     qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, qs->alloc);
     qvirtio_pci_device_disable(dev);
-    g_free(dev);
+    qvirtio_pci_device_free(dev);
     qtest_shutdown(qs);
 }
=20
@@ -389,7 +389,7 @@ static void pci_indirect(void)
     /* End test */
     qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, qs->alloc);
     qvirtio_pci_device_disable(dev);
-    g_free(dev);
+    qvirtio_pci_device_free(dev);
     qtest_shutdown(qs);
 }
=20
@@ -418,7 +418,7 @@ static void pci_config(void)
     g_assert_cmpint(capacity, =3D=3D, n_size / 512);
=20
     qvirtio_pci_device_disable(dev);
-    g_free(dev);
+    qvirtio_pci_device_free(dev);
=20
     qtest_shutdown(qs);
 }
@@ -526,7 +526,7 @@ static void pci_msix(void)
     qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, qs->alloc);
     qpci_msix_disable(dev->pdev);
     qvirtio_pci_device_disable(dev);
-    g_free(dev);
+    qvirtio_pci_device_free(dev);
     qtest_shutdown(qs);
 }
=20
@@ -642,7 +642,7 @@ static void pci_idx(void)
     qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, qs->alloc);
     qpci_msix_disable(dev->pdev);
     qvirtio_pci_device_disable(dev);
-    g_free(dev);
+    qvirtio_pci_device_free(dev);
     qtest_shutdown(qs);
 }
=20
@@ -661,7 +661,7 @@ static void pci_hotplug(void)
     dev =3D virtio_blk_pci_init(qs->pcibus, PCI_SLOT_HP);
     g_assert(dev);
     qvirtio_pci_device_disable(dev);
-    g_free(dev);
+    qvirtio_pci_device_free(dev);
=20
     /* unplug secondary disk */
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
--=20
2.11.0.295.gd7dffce1c.dirty
