Received: from eggs.gnu.org ([2001:4830:134:3::10]:46055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPU-0006NB-2u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPS-0003cU-5u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:31:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gWPPS-0003cC-0K
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:31:58 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Dec 2018 17:31:45 +0000
Message-Id: <20181210173151.16629-2-dgilbert@redhat.com>
In-Reply-To: <20181210173151.16629-1-dgilbert@redhat.com>
References: <20181210173151.16629-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 1/7] virtio: Add shared memory capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, sweil@redhat.com, swhiteho@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define a new capability type 'VIRTIO_PCI_CAP_SHARED_MEMORY_CFG'
and the data structure 'virtio_pci_shm_cap' to go with it.
They allow defining shared memory regions with sizes and offsets
of 2^32 and more.
Multiple instances of the capability are allowed and distinguished
by a device-specific 'id'.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/virtio-pci.c                      | 20 ++++++++++++++++++++
 include/standard-headers/linux/virtio_pci.h |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a954799267..1e737531b5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1163,6 +1163,26 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *=
proxy,
     return offset;
 }
=20
+static int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
+                                   uint8_t bar,
+                                   uint64_t offset, uint64_t length,
+                                   uint8_t id)
+{
+    struct virtio_pci_shm_cap cap =3D {
+        .cap.cap_len =3D sizeof cap,
+        .cap.cfg_type =3D VIRTIO_PCI_CAP_SHARED_MEMORY_CFG,
+    };
+    uint32_t mask32 =3D ~0;
+
+    cap.cap.bar =3D bar;
+    cap.cap.length =3D cpu_to_le32(length & mask32);
+    cap.length_hi =3D cpu_to_le32((length >> 32) & mask32);
+    cap.cap.offset =3D cpu_to_le32(offset & mask32);
+    cap.offset_hi =3D cpu_to_le32((offset >> 32) & mask32);
+    cap.id =3D id;
+    return virtio_pci_add_mem_cap(proxy, &cap.cap);
+}
+
 static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
                                        unsigned size)
 {
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standa=
rd-headers/linux/virtio_pci.h
index 9262acd130..745d7a1942 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG	4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG		5
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
=20
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -163,6 +165,13 @@ struct virtio_pci_cfg_cap {
 	uint8_t pci_cfg_data[4]; /* Data for BAR access. */
 };
=20
+struct virtio_pci_shm_cap {
+	struct virtio_pci_cap cap;
+	uint32_t offset_hi;             /* Most sig 32 bits of offset */
+	uint32_t length_hi;             /* Most sig 32 bits of length */
+        uint8_t  id;                    /* To distinguish shm chunks */
+};
+
 /* Macro versions of offsets for the Old Timers! */
 #define VIRTIO_PCI_CAP_VNDR		0
 #define VIRTIO_PCI_CAP_NEXT		1
--=20
2.19.2
