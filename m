Received: from eggs.gnu.org ([2001:4830:134:3::10]:50156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNPKb-0002R8-S1
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNPKa-0001Oy-Rp
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eNPKa-0001NO-Io
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:12 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Dec 2017 20:32:54 +0000
Message-Id: <20171208203257.13102-6-dgilbert@redhat.com>
In-Reply-To: <20171208203257.13102-1-dgilbert@redhat.com>
References: <20171208203257.13102-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 5/8] vhost: update_mem_cb implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the meat of update_mem_cb;  this is called for each region,
to add a region to our temporary list.
Our temporary list is in order we look to see if this
region can be merged with the current head of list.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  2 ++
 hw/virtio/vhost.c      | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 4a493bcd46..92fadec192 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -2,6 +2,8 @@
 
 # hw/virtio/vhost.c
 vhost_section(const char *name, int r) "%s:%d"
+vhost_update_mem_cb(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
+vhost_update_mem_cb_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d1b2d3441b..9d39271bfc 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -643,11 +643,63 @@ struct vhost_update_mem_tmp {
 /* Called for each MRS from vhost_update_mem */
 static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
 {
+    struct vhost_update_mem_tmp *vtmp = opaque;
+    struct vhost_memory_region *cur_vmr;
+    bool need_add = true;
+    uint64_t mrs_size;
+    uint64_t mrs_gpa;
+    uintptr_t mrs_host;
+
     if (!vhost_section(mrs)) {
         return 0;
     }
+    mrs_size = int128_get64(mrs->size);
+    mrs_gpa  = mrs->offset_within_address_space;
+    mrs_host = (uintptr_t)memory_region_get_ram_ptr(mrs->mr) +
+                         mrs->offset_within_region;
+
+    trace_vhost_update_mem_cb(mrs->mr->name, mrs_gpa, mrs_size, mrs_host);
+
+    if (vtmp->nregions) {
+        /* Since we already have at least one region, lets see if
+         * this extends it; since we're scanning in order, we only
+         * have to look at the last one, and the FlatView that calls
+         * us shouldn't have overlaps.
+         */
+        struct vhost_memory_region *prev_vmr = vtmp->regions +
+                                               (vtmp->nregions - 1);
+        uint64_t prev_gpa_start = prev_vmr->guest_phys_addr;
+        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start,
+                                                 prev_vmr->memory_size);
+        uint64_t prev_host_start = prev_vmr->userspace_addr;
+        uint64_t prev_host_end   = range_get_last(prev_host_start,
+                                                  prev_vmr->memory_size);
+
+        if (prev_gpa_end + 1 == mrs_gpa &&
+            prev_host_end + 1 == mrs_host &&
+            (!vtmp->dev->vhost_ops->vhost_backend_can_merge ||
+                vtmp->dev->vhost_ops->vhost_backend_can_merge(vtmp->dev,
+                    mrs_host, mrs_size,
+                    prev_host_start, prev_vmr->memory_size))) {
+            /* The two regions abut */
+            need_add = false;
+            mrs_size = mrs_size + prev_vmr->memory_size;
+            prev_vmr->memory_size = mrs_size;
+            trace_vhost_update_mem_cb_abut(mrs->mr->name, mrs_size);
+        }
+    }
+
+    if (need_add) {
+        vtmp->nregions++;
+        vtmp->regions = g_realloc_n(vtmp->regions, vtmp->nregions,
+                                    sizeof(vtmp->regions[0]));
+        cur_vmr = &vtmp->regions[vtmp->nregions - 1];
+        cur_vmr->guest_phys_addr = mrs_gpa;
+        cur_vmr->memory_size     = mrs_size;
+        cur_vmr->userspace_addr  = mrs_host;
+        cur_vmr->flags_padding = 0;
+    }
 
-    /* TODO */
     return 0;
 }
 
-- 
2.14.3
