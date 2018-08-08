Received: from eggs.gnu.org ([2001:4830:134:3::10]:37071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1fnUzo-0005hi-LI
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1fnUzk-0001Ri-0s
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:52 -0400
Received: from legacy.ddn.com ([64.47.133.206]:26371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gedwards@ddn.com>) id 1fnUzj-0001Qh-RC
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:47 -0400
From: Greg Edwards <gedwards@ddn.com>
Date: Wed, 8 Aug 2018 13:52:34 -0600
Message-ID: <20180808195235.5843-3-gedwards@ddn.com>
In-Reply-To: <20180808195235.5843-1-gedwards@ddn.com>
References: <20180808195235.5843-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] vhost-scsi: unify vhost-scsi get_features
 implementations
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

Move the enablement of preset host features into the common
vhost_scsi_common_get_features() function.  This is in preparation for
having vhost-scsi also make use of host_features.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 hw/scsi/vhost-scsi-common.c |  3 +++
 hw/scsi/vhost-user-scsi.c   | 14 +-------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index e2a5828af137..b7fbab65dd17 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -96,6 +96,9 @@ uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t features,
 {
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
 
+    /* Turn on predefined features supported by this device */
+    features |= vsc->host_features;
+
     return vhost_get_features(&vsc->dev, vsc->feature_bits, features);
 }
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 694cb801209a..26491daaa0bf 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -137,18 +137,6 @@ static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
     }
 }
 
-static uint64_t vhost_user_scsi_get_features(VirtIODevice *vdev,
-                                             uint64_t features, Error **errp)
-{
-    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
-    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-
-    /* Turn on predefined features supported by this device */
-    features |= vsc->host_features;
-
-    return vhost_scsi_common_get_features(vdev, features, errp);
-}
-
 static Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
@@ -188,7 +176,7 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_user_scsi_realize;
     vdc->unrealize = vhost_user_scsi_unrealize;
-    vdc->get_features = vhost_user_scsi_get_features;
+    vdc->get_features = vhost_scsi_common_get_features;
     vdc->set_config = vhost_scsi_common_set_config;
     vdc->set_status = vhost_user_scsi_set_status;
     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
-- 
2.17.1
