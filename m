Received: from eggs.gnu.org ([2001:4830:134:3::10]:39515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjM-00043n-9q
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjI-0005lq-B4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:58:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59707
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkjI-0005lg-4z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:58:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9rfkt159936
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:59 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28pgs4jebr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:59 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:52 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:32 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-11-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 10/12] virtio-ccw: support VIRTIO_QUEUE_MAX
 virtqueues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

The maximal number of virtqueues per device can be limited on a per
transport basis. For virtio-ccw this limit is defined by
VIRTIO_CCW_QUEUE_MAX, however the limitation used to come form the
number of adapter routes supported by flic (via notifiers).

Recently the limitation of the flic was adjusted so that it can
accommodate VIRTIO_QUEUE_MAX queues, and is in the meanwhile checked for
separately too.

Let us remove the transport specific limitation of virtio-ccw by
dropping VIRTIO_CCW_QUEUE_MAX and using VIRTIO_QUEUE_MAX instead.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c   |  2 +-
 hw/s390x/virtio-ccw.c        | 16 ++++++++--------
 include/hw/s390x/s390_flic.h |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ea244bbf55..4f0d62b2d8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -63,7 +63,7 @@ static int virtio_ccw_hcall_notify(const uint64_t *args)
     if (!sch || !css_subch_visible(sch)) {
         return -EINVAL;
     }
-    if (queue >= VIRTIO_CCW_QUEUE_MAX) {
+    if (queue >= VIRTIO_QUEUE_MAX) {
         return -EINVAL;
     }
     virtio_queue_notify(virtio_ccw_get_vdev(sch), queue);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a2ea95947f..00b3bde4e9 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -128,7 +128,7 @@ static int virtio_ccw_set_vqs(SubchDev *sch, VqInfoBlock *info,
     uint16_t num = info ? info->num : linfo->num;
     uint64_t desc = info ? info->desc : linfo->queue;
 
-    if (index >= VIRTIO_CCW_QUEUE_MAX) {
+    if (index >= VIRTIO_QUEUE_MAX) {
         return -EINVAL;
     }
 
@@ -164,7 +164,7 @@ static int virtio_ccw_set_vqs(SubchDev *sch, VqInfoBlock *info,
         virtio_queue_set_vector(vdev, index, index);
     }
     /* tell notify handler in case of config change */
-    vdev->config_vector = VIRTIO_CCW_QUEUE_MAX;
+    vdev->config_vector = VIRTIO_QUEUE_MAX;
     return 0;
 }
 
@@ -565,7 +565,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                                     ccw.cda,
                                                     MEMTXATTRS_UNSPECIFIED,
                                                     NULL);
-            if (vq_config.index >= VIRTIO_CCW_QUEUE_MAX) {
+            if (vq_config.index >= VIRTIO_QUEUE_MAX) {
                 ret = -EINVAL;
                 break;
             }
@@ -960,11 +960,11 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
     uint64_t indicators;
 
     /* queue indicators + secondary indicators */
-    if (vector >= VIRTIO_CCW_QUEUE_MAX + 64) {
+    if (vector >= VIRTIO_QUEUE_MAX + 64) {
         return;
     }
 
-    if (vector < VIRTIO_CCW_QUEUE_MAX) {
+    if (vector < VIRTIO_QUEUE_MAX) {
         if (!dev->indicators) {
             return;
         }
@@ -1325,10 +1325,10 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
         dev->max_rev = 0;
     }
 
-    if (virtio_get_num_queues(vdev) > VIRTIO_CCW_QUEUE_MAX) {
+    if (virtio_get_num_queues(vdev) > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "The number of virtqueues %d "
-                   "exceeds ccw limit %d", n,
-                   VIRTIO_CCW_QUEUE_MAX);
+                   "exceeds virtio limit %d", n,
+                   VIRTIO_QUEUE_MAX);
         return;
     }
     if (virtio_get_num_queues(vdev) > flic->adapter_routes_max_batch) {
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 7f8ec7541b..f9e6890c90 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -24,7 +24,6 @@
  * maximum right now.
  */
 #define ADAPTER_ROUTES_MAX_GSI VIRTIO_QUEUE_MAX
-#define VIRTIO_CCW_QUEUE_MAX 64
 
 typedef struct AdapterRoutes {
     AdapterInfo adapter;
-- 
2.11.0
