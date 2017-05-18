Received: from eggs.gnu.org ([2001:4830:134:3::10]:45036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dBIfN-0006vu-3n
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dBIfK-0002nb-22
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:28:21 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 18 May 2017 18:28:08 +0800
Message-Id: <20170518102808.30046-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-scsi: Unset hotplug handler when
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

This matches the qbus_set_hotplug_handler in realize and is important to
release the final reference to the embedded VirtIODevice so that it is
properly finalized.

A use-after-free is fixed with this patch, indirectly:
virtio_device_instance_finalize wasn't called at hot-unplug, and the
vdev->listener would be a dangling pointer in the global and the per
address space listener list. See also RHBZ 1449031.

Thanks to Paolo for explaining the reference counting.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>

---

Like suggested by Paolo, it seems to make sense to do this clean up in
bus_unparent, but given how confused I got when working on this bug, I'm
not confident in my reasoning about the ref count balance in other
callers.
---
 hw/scsi/virtio-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 46a3e3f..f46f06d 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -918,6 +918,9 @@ void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp)
 
 static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
 {
+    VirtIOSCSI *s = VIRTIO_SCSI(dev);
+
+    qbus_set_hotplug_handler(BUS(&s->bus), NULL, &error_abort);
     virtio_scsi_common_unrealize(dev, errp);
 }
 
-- 
2.9.3
