Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4n-0002IL-TC
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4Z-0006tV-0d
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:11 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:50856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4Y-0006qv-En
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:02 -0400
Received: by mail-wm0-x22c.google.com with SMTP id s12-v6so3661136wmc.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:26 +0200
Message-Id: <1534870966-9287-55-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 54/74] vhost-user-scsi: move host_features into
 VHostSCSICommon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Edwards <gedwards@ddn.com>

From: Greg Edwards <gedwards@ddn.com>

In preparation for having vhost-scsi also make use of host_features,
move it from struct VHostUserSCSI into struct VHostSCSICommon.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
Message-Id: <20180808195235.5843-2-gedwards@ddn.com>
Reviewed-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vhost-user-scsi.c             | 15 ++++++++-------
 include/hw/virtio/vhost-scsi-common.h |  1 +
 include/hw/virtio/vhost-user-scsi.h   |  1 -
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 9355cfd..694cb80 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -141,9 +141,10 @@ static uint64_t vhost_user_scsi_get_features(VirtIODevice *vdev,
                                              uint64_t features, Error **errp)
 {
     VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
 
     /* Turn on predefined features supported by this device */
-    features |= s->host_features;
+    features |= vsc->host_features;
 
     return vhost_scsi_common_get_features(vdev, features, errp);
 }
@@ -157,12 +158,12 @@ static Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
-    DEFINE_PROP_BIT64("hotplug", VHostUserSCSI, host_features,
-                                                VIRTIO_SCSI_F_HOTPLUG,
-                                                true),
-    DEFINE_PROP_BIT64("param_change", VHostUserSCSI, host_features,
-                                                     VIRTIO_SCSI_F_CHANGE,
-                                                     true),
+    DEFINE_PROP_BIT64("hotplug", VHostSCSICommon, host_features,
+                                                  VIRTIO_SCSI_F_HOTPLUG,
+                                                  true),
+    DEFINE_PROP_BIT64("param_change", VHostSCSICommon, host_features,
+                                                       VIRTIO_SCSI_F_CHANGE,
+                                                       true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index 4553be4..57fb1d8 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -35,6 +35,7 @@ typedef struct VHostSCSICommon {
     int channel;
     int target;
     int lun;
+    uint64_t host_features;
 } VHostSCSICommon;
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc);
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhost-user-scsi.h
index 3ec34ae..e429cac 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -30,7 +30,6 @@
 
 typedef struct VHostUserSCSI {
     VHostSCSICommon parent_obj;
-    uint64_t host_features;
     VhostUserState *vhost_user;
 } VHostUserSCSI;
 
-- 
1.8.3.1
