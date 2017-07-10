Received: from eggs.gnu.org ([2001:4830:134:3::10]:55219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUagS-00057O-7e
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUagO-0002wK-9U
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUagO-0002uZ-10
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:08 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 10 Jul 2017 17:32:36 +0200
Message-Id: <1499700760-4777-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1499700760-4777-1-git-send-email-thuth@redhat.com>
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/10] pc-bios/s390-ccw: Add code for virtio
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
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

The upcoming virtio-net driver needs to negotiate some features,
so we need the possibility to do this in the core virtio code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h      |  2 ++
 pc-bios/s390-ccw/virtio-blkdev.c |  3 ++-
 pc-bios/s390-ccw/virtio.c        | 25 ++++++++++++++++++-------
 pc-bios/s390-ccw/virtio.h        |  2 +-
 4 files changed, 23 insertions(+), 9 deletions(-)

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
 
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 6cb77bc..ed4026f 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -266,9 +266,10 @@ uint64_t virtio_get_blocks(void)
 void virtio_blk_setup_device(SubChannelId schid)
 {
     VDev *vdev = virtio_get_device();
+    uint32_t guestfeats[2] = { 0, 0 };
 
     vdev->schid = schid;
-    virtio_setup_ccw(vdev);
+    virtio_setup_ccw(vdev, guestfeats);
 
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_BLOCK:
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 09ab291..e3dcfd3 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -12,6 +12,7 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
+#include "bswap.h"
 
 #define VRING_WAIT_REPLY_TIMEOUT 3
 
@@ -247,10 +248,14 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
     return 0;
 }
 
-void virtio_setup_ccw(VDev *vdev)
+void virtio_setup_ccw(VDev *vdev, uint32_t guestfeats[2])
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
+    for (i = 0; i < ARRAY_SIZE(guestfeats); i++) {
+        feats.features = 0;
+        feats.index = i;
+        rc = run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats));
+        IPL_assert(rc == 0, "Could not get features bits");
+        guestfeats[i] &= bswap32(feats.features);
+        feats.features = bswap32(guestfeats[i]);
+        rc = run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats));
+        IPL_assert(rc == 0, "Could not set features bits");
+    }
 
     for (i = 0; i < vdev->nr_vqs; i++) {
         VqInfo info = {
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index d743919..e3d7150 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -295,6 +295,6 @@ int drain_irqs(SubChannelId schid);
 void vring_send_buf(VRing *vr, void *p, int len, int flags);
 int vring_wait_reply(void);
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
-void virtio_setup_ccw(VDev *vdev);
+void virtio_setup_ccw(VDev *vdev, uint32_t guestfeats[2]);
 
 #endif /* VIRTIO_H */
-- 
1.8.3.1
