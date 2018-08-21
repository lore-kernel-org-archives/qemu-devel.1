Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0002IT-42
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4b-0006w4-2X
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:13 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:40657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4Z-0006sx-BE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:03 -0400
Received: by mail-wm0-x22e.google.com with SMTP id y9-v6so3498825wma.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:27 +0200
Message-Id: <1534870966-9287-56-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 55/74] vhost-scsi: unify vhost-scsi get_features
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
Cc: Greg Edwards <gedwards@ddn.com>

From: Greg Edwards <gedwards@ddn.com>

Move the enablement of preset host features into the common
vhost_scsi_common_get_features() function.  This is in preparation for
having vhost-scsi also make use of host_features.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
Message-Id: <20180808195235.5843-3-gedwards@ddn.com>
Reviewed-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vhost-scsi-common.c |  3 +++
 hw/scsi/vhost-user-scsi.c   | 14 +-------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index e2a5828..b7fbab6 100644
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
index 694cb80..26491da 100644
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
1.8.3.1
