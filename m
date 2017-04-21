Received: from eggs.gnu.org ([2001:4830:134:3::10]:54241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xez-0002Q3-DD
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xey-0000ng-5L
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xex-0000mv-Si
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFDF88E3FB
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:34 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:27:07 +0800
Message-Id: <20170421122710.15373-12-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 11/14] scsi: Make errp the last parameter of
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
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.3
