Received: from eggs.gnu.org ([2001:4830:134:3::10]:37070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1fnUzo-0005hh-L6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1fnUzj-0001RM-O6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:52 -0400
Received: from legacy.ddn.com ([64.47.133.206]:26371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gedwards@ddn.com>) id 1fnUzj-0001Qh-Gx
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:47 -0400
From: Greg Edwards <gedwards@ddn.com>
Date: Wed, 8 Aug 2018 13:52:33 -0600
Message-ID: <20180808195235.5843-2-gedwards@ddn.com>
In-Reply-To: <20180808195235.5843-1-gedwards@ddn.com>
References: <20180808195235.5843-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] vhost-user-scsi: move host_features into
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>, Felipe Franciosi <felipe@nutanix.com>, Greg Edwards <gedwards@ddn.com>

In preparation for having vhost-scsi also make use of host_features,
move it from struct VHostUserSCSI into struct VHostSCSICommon.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 hw/scsi/vhost-user-scsi.c             | 15 ++++++++-------
 include/hw/virtio/vhost-scsi-common.h |  1 +
 include/hw/virtio/vhost-user-scsi.h   |  1 -
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 9355cfdf07f9..694cb801209a 100644
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
index 4553be4bc378..57fb1d87b51d 100644
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
index 3ec34ae867ab..e429cacd8e06 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -30,7 +30,6 @@
 
 typedef struct VHostUserSCSI {
     VHostSCSICommon parent_obj;
-    uint64_t host_features;
     VhostUserState *vhost_user;
 } VHostUserSCSI;
 
-- 
2.17.1
