Received: from eggs.gnu.org ([2001:4830:134:3::10]:53632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOs-0003zb-24
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOq-0006xm-K1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOq-0006xL-Ai
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51398C04B94B
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:57 +0200
Message-Id: <1493018820-23445-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] scsi: Make errp the last parameter of
 virtio_scsi_common_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-12-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/scsi/vhost-scsi.c            |  6 ++++--
 hw/scsi/virtio-scsi.c           | 11 +++++++----
 include/hw/virtio/virtio-scsi.h |  8 +++++---
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index c491ece..f53bc17 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -233,9 +233,11 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    virtio_scsi_common_realize(dev, &err, vhost_dummy_handle_output,
+    virtio_scsi_common_realize(dev,
                                vhost_dummy_handle_output,
-                               vhost_dummy_handle_output);
+                               vhost_dummy_handle_output,
+                               vhost_dummy_handle_output,
+                               &err);
     if (err != NULL) {
         error_propagate(errp, err);
         goto close_fd;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bd62d08..46a3e3f 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -841,10 +841,11 @@ static struct SCSIBusInfo virtio_scsi_scsi_info = {
     .load_request = virtio_scsi_load_request,
 };
 
-void virtio_scsi_common_realize(DeviceState *dev, Error **errp,
+void virtio_scsi_common_realize(DeviceState *dev,
                                 VirtIOHandleOutput ctrl,
                                 VirtIOHandleOutput evt,
-                                VirtIOHandleOutput cmd)
+                                VirtIOHandleOutput cmd,
+                                Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(dev);
@@ -878,9 +879,11 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
     Error *err = NULL;
 
-    virtio_scsi_common_realize(dev, &err, virtio_scsi_handle_ctrl,
+    virtio_scsi_common_realize(dev,
+                               virtio_scsi_handle_ctrl,
                                virtio_scsi_handle_event,
-                               virtio_scsi_handle_cmd);
+                               virtio_scsi_handle_cmd,
+                               &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 8ae0aca..8c8453c 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -135,9 +135,11 @@ static inline void virtio_scsi_release(VirtIOSCSI *s)
     }
 }
 
-void virtio_scsi_common_realize(DeviceState *dev, Error **errp,
-                                VirtIOHandleOutput ctrl, VirtIOHandleOutput evt,
-                                VirtIOHandleOutput cmd);
+void virtio_scsi_common_realize(DeviceState *dev,
+                                VirtIOHandleOutput ctrl,
+                                VirtIOHandleOutput evt,
+                                VirtIOHandleOutput cmd,
+                                Error **errp);
 
 void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp);
 bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq);
-- 
2.7.4
