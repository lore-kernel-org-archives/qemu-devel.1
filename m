Received: from eggs.gnu.org ([2001:4830:134:3::10]:48534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZQ-0005HA-FB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZK-0007IN-NR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZK-0007I9-HL
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38C6E83221
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:07:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:51 +0200
Message-Id: <1531840015-28804-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/13] virtio-scsi: fix hotplug ->reset() vs
 event race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

There is a race condition during hotplug when iothread is used.  It
occurs because virtio-scsi may be processing command queues in the
iothread while the monitor performs SCSI device hotplug.

When a SCSI device is hotplugged the HotplugHandler->plug() callback is
invoked and virtio-scsi emits a rescan event to the guest.

If the guest submits a SCSI command at this point then it may be
cancelled before hotplug completes.  This happens because ->reset() is
called by hw/core/qdev.c:device_set_realized() after
HotplugHandler->plug() has been called and
hw/scsi/scsi-disk.c:scsi_disk_reset() purges all requests.

This patch uses the new HotplugHandler->post_plug() callback to emit the
rescan event after ->reset().  This eliminates the race conditions where
requests could be cancelled.

Reported-by: l00284672 <lizhengui@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180716083732.3347-3-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/virtio-scsi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa9971..5a3057d 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -797,8 +797,16 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         virtio_scsi_acquire(s);
         blk_set_aio_context(sd->conf.blk, s->ctx);
         virtio_scsi_release(s);
-
     }
+}
+
+/* Announce the new device after it has been plugged */
+static void virtio_scsi_post_hotplug(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(hotplug_dev);
+    VirtIOSCSI *s = VIRTIO_SCSI(vdev);
+    SCSIDevice *sd = SCSI_DEVICE(dev);
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
         virtio_scsi_acquire(s);
@@ -968,6 +976,7 @@ static void virtio_scsi_class_init(ObjectClass *klass, void *data)
     vdc->start_ioeventfd = virtio_scsi_dataplane_start;
     vdc->stop_ioeventfd = virtio_scsi_dataplane_stop;
     hc->plug = virtio_scsi_hotplug;
+    hc->post_plug = virtio_scsi_post_hotplug;
     hc->unplug = virtio_scsi_hotunplug;
 }
 
-- 
1.8.3.1
