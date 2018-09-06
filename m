Received: from eggs.gnu.org ([2001:4830:134:3::10]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fxn8I-00087u-In
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fxn5H-0007xl-0K
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:44:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fxn5G-0007ua-Qi
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:44:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  6 Sep 2018 13:43:37 +0800
Message-Id: <20180906054340.28988-2-famz@redhat.com>
In-Reply-To: <20180906054340.28988-1-famz@redhat.com>
References: <20180906054340.28988-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] virtio: update MemoryRegionCaches when
 guest negotiates features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Brad Smith <brad@comstyle.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Because the cache is sized to include the rings and the event indices,
negotiating the VIRTIO_RING_F_EVENT_IDX feature will result in the size
of the cache changing.  And because MemoryRegionCache accesses are
range-checked, if we skip this we end up with an assertion failure.
This happens with OpenBSD 6.3.

Reported-by: Fam Zheng <famz@redhat.com>
Fixes: 97cd965c070152bc626c7507df9fb356bbe1cd81
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/virtio/virtio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d4e4d98b59..f6a588ab57 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2006,14 +2006,25 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
 
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
-   /*
+    int ret;
+    /*
      * The driver must not attempt to set features after feature negotiation
      * has finished.
      */
     if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
         return -EINVAL;
     }
-    return virtio_set_features_nocheck(vdev, val);
+    ret = virtio_set_features_nocheck(vdev, val);
+    if (!ret && virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
+        int i;
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            if (vdev->vq[i].vring.num != 0) {
+                virtio_init_region_cache(vdev, i);
+            }
+        }
+    }
+    return ret;
 }
 
 int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
-- 
2.17.1
