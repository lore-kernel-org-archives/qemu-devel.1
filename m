Received: from eggs.gnu.org ([2001:4830:134:3::10]:48315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtpV-0006Zp-M0
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtpS-0000W2-Hy
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:14:05 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:48729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtpR-0000F5-G8
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:14:02 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 22 Dec 2016 11:12:40 +0800
Message-ID: <1482376362-13804-4-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
References: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND 3/5] virtio-crypto-pci: add check for
 cryptodev object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Gonglei <arei.gonglei@huawei.com>

We must assure each virtio crypto pci device has
an invaild cryptodev backend object.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index a1b0906..14bd12c 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -31,6 +31,11 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOCryptoPCI *vcrypto = VIRTIO_CRYPTO_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&vcrypto->vdev);
 
+    if (vcrypto->vdev.conf.cryptodev == NULL) {
+        error_setg(errp, "'cryptodev' parameter expects a valid object");
+        return;
+    }
+
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
     virtio_pci_force_virtio_1(vpci_dev);
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-- 
1.8.3.1
