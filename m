Received: from eggs.gnu.org ([209.51.188.92]:56860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJJkr-0004CI-91
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJJkp-0004Un-Sr
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJJkp-0004TG-ME
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:24:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 24 Apr 2019 16:24:01 +0100
Message-Id: <20190424152401.28304-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtio: clarify VirtioPCIDeviceTypeInfo usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, sebastien.boeuf@intel.com, Stefan Hajnoczi <stefanha@redhat.com>

How to use .base_name, .generic_name, .transitional_name, and
.non_transitional_name can be confusing.

Existing devices have .generic_name but its behavior is somewhat magic.

Devices added to new versions of the VIRTIO specification should forego
transitional mode completely and always operate in non-transitional mode
because there are no existing drivers for them that require backwards
compatibility.

This patch adds comments that hopefully make it easier for developers to
decide how to fill out VirtioPCIDeviceTypeInfo.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio-pci.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 18581854ca..debdee28b3 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -209,7 +209,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
      * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_=
PCI_DEVICE,
      * but PCI Express is supported only in non-transitional mode.
      *
-     * The only type implemented by QEMU 3.1 and older.
+     * The only type implemented by QEMU 3.1 and older.  This type is le=
ss
+     * explicit than the transitional and non-transitional device types.=
  Its
+     * behavior can be affected by machine type compat properties.
      */
     const char *generic_name;
     /*
@@ -222,6 +224,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
      * The non-transitional device type.  Optional.
      *
      * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
+     *
+     * New virtio device types should only define this and base_name, th=
ereby
+     * allowing only non-transitional mode.
      */
     const char *non_transitional_name;
=20
--=20
2.20.1
