Received: from eggs.gnu.org ([2001:4830:134:3::10]:44633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAWqI-0003s8-Gy
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAWqD-0004r2-HG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:24:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 16 May 2017 15:24:14 +0800
Message-Id: <20170516072414.19025-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] virtio: Move memory_listener_unregister to
 .unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

This is noticed while working on RHBZ 1449031, and fixes the reported
crash which happens when plugging back a virtio-scsi device after
unplugging it.

The root cause of the crash is not obvious here, but the change
regardlessly makes sense so it's proposed here: the listener was
registered in .realize(), so do the cleanup in the matching .unrealize()
rather than the .finalize() callback.

The difference this makes is that, due to some other references to the
memory region that is owned here, .finalize() is not called when unplug.
(Note that memory_region_ref() does object_ref() on the owner instead of
the MemoryRegion itself.) This is something fishy, and is being
investigated independently.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c5..12604d6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2515,6 +2515,7 @@ static void virtio_device_unrealize(DeviceState *dev, Error **errp)
         }
     }
 
+    memory_listener_unregister(&vdev->listener);
     g_free(vdev->bus_name);
     vdev->bus_name = NULL;
 }
@@ -2539,7 +2540,6 @@ static void virtio_device_instance_finalize(Object *obj)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(obj);
 
-    memory_listener_unregister(&vdev->listener);
     virtio_device_free_virtqueues(vdev);
 
     g_free(vdev->config);
-- 
2.9.3
