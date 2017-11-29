Received: from eggs.gnu.org ([2001:4830:134:3::10]:49108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eK7Rb-00016D-BA
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eK7Ra-0001Tl-25
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:50:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eK7RZ-0001TQ-Os
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:50:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C75FC80476
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 18:50:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 29 Nov 2017 18:50:24 +0000
Message-Id: <20171129185026.23632-6-dgilbert@redhat.com>
In-Reply-To: <20171129185026.23632-1-dgilbert@redhat.com>
References: <20171129185026.23632-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 5/7] vhost: Compare new and old memory lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Compare the memory section list we've just built with the old one
and produce an upper/lower bound of addresses changed.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  3 ++
 hw/virtio/vhost.c      | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 92fadec192..ba85a1855b 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -2,6 +2,9 @@
 
 # hw/virtio/vhost.c
 vhost_section(const char *name, int r) "%s:%d"
+vhost_update_compare_list_loopn(int newi, int oldi, uint64_t gpa, uint64_t size) "%d/%d: (new) 0x%"PRIx64"+0x%"PRIx64
+vhost_update_compare_list_loopo(int newi, int oldi, uint64_t gpa, uint64_t size) "%d/%d: (old) 0x%"PRIx64"+0x%"PRIx64
+vhost_update_mem_comparison(bool update, uint64_t start, uint64_t end) "update: %d  0x%"PRIx64" - 0x%"PRIx64
 vhost_update_mem_cb(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_update_mem_cb_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7e3c6ae032..ae3d57df1d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -699,10 +699,79 @@ static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
     return 0;
 }
 
+static bool vhost_update_compare_list(struct vhost_dev *dev,
+                                      struct vhost_update_mem_tmp *vtmp,
+                                      hwaddr *change_start, hwaddr *change_end)
+{
+    uint32_t oldi, newi;
+    *change_start = 0;
+    *change_end = 0;
+
+    for (newi = 0, oldi = 0; newi < vtmp->nregions; newi++) {
+        struct vhost_memory_region *newr = &vtmp->regions[newi];
+        hwaddr newr_last = range_get_last(newr->guest_phys_addr,
+                                          newr->memory_size);
+        trace_vhost_update_compare_list_loopn(newi, oldi,
+                                        newr->guest_phys_addr,
+                                        newr->memory_size);
+        bool whole_change = true;
+        while (oldi < dev->mem->nregions) {
+            struct vhost_memory_region *oldr = &dev->mem->regions[oldi];
+            hwaddr oldr_last = range_get_last(oldr->guest_phys_addr,
+                                          oldr->memory_size);
+            trace_vhost_update_compare_list_loopo(newi, oldi,
+                                        oldr->guest_phys_addr,
+                                        oldr->memory_size);
+            if (newr->guest_phys_addr == oldr->guest_phys_addr &&
+                newr->memory_size == oldr->memory_size) {
+                /* Match in GPA and size, but it could be different
+                 * in host address or flags
+                 */
+                whole_change = newr->userspace_addr != oldr->userspace_addr ||
+                               newr->flags_padding != oldr->flags_padding;
+                oldi++;
+                break; /* inner old loop */
+            }
+            /* There's a difference - need to figure out what */
+            if (oldr_last < newr->guest_phys_addr) {
+                /* There used to be a region before us that's gone */
+                *change_start = MIN(*change_start, oldr->guest_phys_addr);
+                *change_end = MAX(*change_end, oldr_last);
+                oldi++;
+                continue; /* inner old loop */
+            }
+            if (oldr->guest_phys_addr > newr_last) {
+                /* We've passed all the old mappings that could have overlapped
+                 * this one
+                 */
+                break; /* Inner old loop */
+            }
+            /* Overlap case */
+            *change_start = MIN(*change_start,
+                                MIN(oldr->guest_phys_addr,
+                                    newr->guest_phys_addr));
+            *change_end = MAX(*change_end,
+                                MAX(oldr_last, newr_last));
+            whole_change = false;
+            /* There might be more old mappings that overlap */
+            oldi++;
+        }
+        if (whole_change) {
+            /* No old region to compare against, this must be a change */
+            *change_start = MIN(*change_start, newr->guest_phys_addr);
+            *change_end = MAX(*change_end, newr_last);
+        }
+    }
+
+    return *change_start || *change_end;
+}
+
 static int vhost_update_mem(struct vhost_dev *dev)
 {
     int res;
     struct vhost_update_mem_tmp vtmp;
+    hwaddr change_start, change_end;
+    bool need_update;
     vtmp.regions = 0;
     vtmp.nregions = 0;
     vtmp.dev = dev;
@@ -713,6 +782,11 @@ static int vhost_update_mem(struct vhost_dev *dev)
         goto out;
     }
 
+    need_update = vhost_update_compare_list(dev, &vtmp,
+                                            &change_start, &change_end);
+    trace_vhost_update_mem_comparison(need_update,
+                                      (uint64_t)change_start,
+                                      (uint64_t)change_end);
     /* TODO */
 out:
     g_free(vtmp.regions);
-- 
2.14.3
