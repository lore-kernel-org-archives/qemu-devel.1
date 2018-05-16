Received: from eggs.gnu.org ([2001:4830:134:3::10]:55560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIwTy-0001bF-62
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIwTv-0006lC-2A
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:28:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fIwTu-0006kl-QF
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:28:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GDOWFa128095
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:28:37 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j0ketp864-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:28:37 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 16 May 2018 14:28:34 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 16 May 2018 15:27:57 +0200
Message-Id: <20180516132757.68558-1-pasic@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio-ccw: clean up notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

Coverity recently started complaining about virtio_ccw_notify().  Turns
out, there is a couple of things that can be cleaned up.  Let's clean!

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: CID 1390619
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 22df33b509..09fa7eed4c 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1003,10 +1003,15 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
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
@@ -1029,6 +1034,7 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
                 css_adapter_interrupt(CSS_IO_ADAPTER_VIRTIO, dev->thinint_isc);
             }
         } else {
+            assert(vector < NR_CLASSIC_INDICATOR_BITS);
             indicators = address_space_ldq(&address_space_memory,
                                            dev->indicators->addr,
                                            MEMTXATTRS_UNSPECIFIED,
@@ -1042,12 +1048,11 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
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
2.16.3
