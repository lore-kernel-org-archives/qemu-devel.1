Received: from eggs.gnu.org ([2001:4830:134:3::10]:42530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVH6S-0000Ly-T7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVH6R-0004y9-U3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVH6R-0004xW-KN
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:51 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Jul 2017 14:49:49 +0200
Message-Id: <1499863793-18627-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1499863793-18627-1-git-send-email-thuth@redhat.com>
References: <1499863793-18627-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v5 07/11] pc-bios/s390-ccw: Add code for virtio
 feature negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

The upcoming virtio-net driver needs to negotiate some features,
so we need the possibility to do this in the core virtio code.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h |  2 ++
 pc-bios/s390-ccw/virtio.c   | 23 +++++++++++++++++------
 pc-bios/s390-ccw/virtio.h   |  1 +
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 6fdc858..25d4d21 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -44,6 +44,8 @@ typedef unsigned long long __u64;
                             ((b) == 0 ? (a) : (MIN(a, b))))
 #endif
 
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+
 #include "cio.h"
 #include "iplb.h"
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 9d9e61f..18fc5d1 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -12,6 +12,7 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
+#include "bswap.h"
 
 #define VRING_WAIT_REPLY_TIMEOUT 3
 
@@ -249,8 +250,12 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
 
 void virtio_setup_ccw(VDev *vdev)
 {
-    int i, cfg_size = 0;
+    int i, rc, cfg_size = 0;
     unsigned char status = VIRTIO_CONFIG_S_DRIVER_OK;
+    struct VirtioFeatureDesc {
+        uint32_t features;
+        uint8_t index;
+    } __attribute__((packed)) feats;
 
     IPL_assert(virtio_is_supported(vdev->schid), "PE");
     /* device ID has been established now */
@@ -277,11 +282,17 @@ void virtio_setup_ccw(VDev *vdev)
     IPL_assert(run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size) == 0,
                "Could not get block device configuration");
 
-    /*
-     * Skipping CCW_CMD_READ_FEAT. We're not doing anything fancy, and
-     * we'll just stop dead anyway if anything does not work like we
-     * expect it.
-     */
+    /* Feature negotiation */
+    for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
+        feats.features = 0;
+        feats.index = i;
+        rc = run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats));
+        IPL_assert(rc == 0, "Could not get features bits");
+        vdev->guest_features[i] &= bswap32(feats.features);
+        feats.features = bswap32(vdev->guest_features[i]);
+        rc = run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats));
+        IPL_assert(rc == 0, "Could not set features bits");
+    }
 
     for (i = 0; i < vdev->nr_vqs; i++) {
         VqInfo info = {
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index d733780..a00a320 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -251,6 +251,7 @@ struct VDev {
     ScsiDevice selected_scsi_device;
     uint64_t netboot_start_addr;
     uint32_t max_transfer;
+    uint32_t guest_features[2];
 };
 typedef struct VDev VDev;
 
-- 
1.8.3.1
