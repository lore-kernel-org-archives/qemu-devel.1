Received: from eggs.gnu.org ([2001:4830:134:3::10]:49505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyS-0004VB-L8
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyR-0000zz-J7
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:36 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2017 13:21:08 +0200
Message-Id: <1495192872-27667-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/20] virtio-scsi: Unset hotplug handler when
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
Cc: Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org

From: Fam Zheng <famz@redhat.com>

This matches the qbus_set_hotplug_handler in realize, and it releases
the final reference to the embedded VirtIODevice so that it is
properly finalized.

A use-after-free is fixed with this patch, indirectly:
virtio_device_instance_finalize wasn't called at hot-unplug, and the
vdev->listener would be a dangling pointer in the global and the per
address space listener list. See also RHBZ 1449031.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170518102808.30046-1-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
