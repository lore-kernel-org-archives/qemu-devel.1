Received: from eggs.gnu.org ([2001:4830:134:3::10]:35711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPpeH-0004Co-Ht
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPpeD-0007b1-LU
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gPpeD-0007Xd-EX
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:01 -0500
From: wexu@redhat.com
Date: Thu, 22 Nov 2018 09:06:08 -0500
Message-Id: <1542895581-10721-4-git-send-email-wexu@redhat.com>
In-Reply-To: <1542895581-10721-1-git-send-email-wexu@redhat.com>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v1 03/16] virtio: redefine structure & memory
 cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Redefine packed ring structure according to Qemu nomenclature,
field data(wrap counter, etc) are introduced also.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4136d23..a8e737c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -39,6 +39,13 @@ typedef struct VRingDesc
     uint16_t next;
 } VRingDesc;
 
+typedef struct VRingPackedDesc {
+    uint64_t addr;
+    uint32_t len;
+    uint16_t id;
+    uint16_t flags;
+} VRingPackedDesc;
+
 typedef struct VRingAvail
 {
     uint16_t flags;
@@ -77,6 +84,11 @@ typedef struct VRing
     VRingMemoryRegionCaches *caches;
 } VRing;
 
+typedef struct VRingPackedDescEvent {
+    uint16_t off_wrap;
+    uint16_t flags;
+} VRingPackedDescEvent ;
+
 struct VirtQueue
 {
     VRing vring;
@@ -87,7 +99,11 @@ struct VirtQueue
     /* Last avail_idx read from VQ. */
     uint16_t shadow_avail_idx;
 
+    bool event_wrap_counter;
+    bool avail_wrap_counter;
+
     uint16_t used_idx;
+    bool used_wrap_counter;
 
     /* Last used index value we have signalled on */
     uint16_t signalled_used;
-- 
1.8.3.1
