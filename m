Received: from eggs.gnu.org ([2001:4830:134:3::10]:39261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeJ-0004mI-D0
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeD-0005nF-Ki
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gAbeD-0005mE-El
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:05 -0400
From: wexu@redhat.com
Date: Thu, 11 Oct 2018 10:08:25 -0400
Message-Id: <1539266915-15216-3-git-send-email-wexu@redhat.com>
In-Reply-To: <1539266915-15216-1-git-send-email-wexu@redhat.com>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [[RFC v3 02/12] virtio: redefine structure & memory
 cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Redefine packed ring structure according to qemu nomenclature,
also supported data(event index, wrap counter, etc) are introduced.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 94f5c8e..500eecf 100644
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
@@ -62,8 +69,14 @@ typedef struct VRingUsed
 typedef struct VRingMemoryRegionCaches {
     struct rcu_head rcu;
     MemoryRegionCache desc;
-    MemoryRegionCache avail;
-    MemoryRegionCache used;
+    union {
+        MemoryRegionCache avail;
+        MemoryRegionCache driver;
+    };
+    union {
+        MemoryRegionCache used;
+        MemoryRegionCache device;
+    };
 } VRingMemoryRegionCaches;
 
 typedef struct VRing
@@ -77,6 +90,11 @@ typedef struct VRing
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
@@ -87,6 +105,10 @@ struct VirtQueue
     /* Last avail_idx read from VQ. */
     uint16_t shadow_avail_idx;
 
+    uint16_t event_idx;
+    bool event_wrap_counter;
+    bool avail_wrap_counter;
+
     uint16_t used_idx;
 
     /* Last used index value we have signalled on */
-- 
1.8.3.1
