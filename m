Received: from eggs.gnu.org ([2001:4830:134:3::10]:41705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNM-000728-Bd
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNL-0001lO-F7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:44 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Jun 2018 14:04:23 +0200
Message-Id: <20180619120434.25062-2-cohuck@redhat.com>
In-Reply-To: <20180619120434.25062-1-cohuck@redhat.com>
References: <20180619120434.25062-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] virtio-ccw: clean up notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.ibm.com>

Coverity recently started complaining about virtio_ccw_notify().  Turns
out, there is a couple of things that can be cleaned up.  Let's clean!

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: CID 1390619
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20180516132757.68558-1-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 0a9bec484b..b92a85d0b0 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1001,10 +1001,15 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
     SubchDev *sch = ccw_dev->sch;
     uint64_t indicators;
 
-    /* queue indicators + secondary indicators */
-    if (vector >= VIRTIO_QUEUE_MAX + 64) {
+    if (vector == VIRTIO_NO_VECTOR) {
         return;
     }
+    /*
+     * vector < VIRTIO_QUEUE_MAX: notification for a virtqueue
+     * vector == VIRTIO_QUEUE_MAX: configuration change notification
+     * bits beyond that are unused and should never be notified for
+     */
+    assert(vector <= VIRTIO_QUEUE_MAX);
 
     if (vector < VIRTIO_QUEUE_MAX) {
         if (!dev->indicators) {
@@ -1027,6 +1032,7 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
                 css_adapter_interrupt(CSS_IO_ADAPTER_VIRTIO, dev->thinint_isc);
             }
         } else {
+            assert(vector < NR_CLASSIC_INDICATOR_BITS);
             indicators = address_space_ldq(&address_space_memory,
                                            dev->indicators->addr,
                                            MEMTXATTRS_UNSPECIFIED,
@@ -1040,12 +1046,11 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
         if (!dev->indicators2) {
             return;
         }
-        vector = 0;
         indicators = address_space_ldq(&address_space_memory,
                                        dev->indicators2->addr,
                                        MEMTXATTRS_UNSPECIFIED,
                                        NULL);
-        indicators |= 1ULL << vector;
+        indicators |= 1ULL;
         address_space_stq(&address_space_memory, dev->indicators2->addr,
                           indicators, MEMTXATTRS_UNSPECIFIED, NULL);
         css_conditional_io_interrupt(sch);
-- 
2.14.4
