Received: from eggs.gnu.org ([209.51.188.92]:41405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gu8dE-0001L0-SE
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gu8dD-00058B-PG
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gu8d7-0004Lc-Uj
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:11 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 23:26:32 -0500
Message-Id: <1550118402-4057-2-git-send-email-wexu@redhat.com>
In-Reply-To: <1550118402-4057-1-git-send-email-wexu@redhat.com>
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/11] virtio: rename structure for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Redefine packed ring structure according to Qemu nomenclature.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a1ff647..eafb4cc 100644
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
@@ -77,17 +84,25 @@ typedef struct VRing
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
 
     /* Next head to pop */
     uint16_t last_avail_idx;
+    bool last_avail_wrap_counter;
 
     /* Last avail_idx read from VQ. */
     uint16_t shadow_avail_idx;
+    bool avail_wrap_counter;
 
     uint16_t used_idx;
+    bool used_wrap_counter;
 
     /* Last used index value we have signalled on */
     uint16_t signalled_used;
-- 
1.8.3.1
