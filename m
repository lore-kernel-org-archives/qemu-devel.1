Received: from eggs.gnu.org ([209.51.188.92]:46191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpyX-0002vJ-SI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpyX-00073K-1q
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:31:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpyW-0006xc-RU
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:31:40 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:07 -0500
Message-Id: <1547663480-547-3-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/15] virtio: redefine structure & memory
 cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, tiwei.bie@intel.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Redefine packed ring structure according to Qemu nomenclature,
field data(wrap counter, etc) are introduced also.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 22bd1ac..827e745 100644
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
