Received: from eggs.gnu.org ([2001:4830:134:3::10]:49761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePBSG-0000z3-W0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePBSG-0004GJ-6G
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePBSG-0004Fp-09
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:28 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 13 Dec 2017 18:08:06 +0000
Message-Id: <20171213180807.7066-6-dgilbert@redhat.com>
In-Reply-To: <20171213180807.7066-1-dgilbert@redhat.com>
References: <20171213180807.7066-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/6] vhost: compare and flip in new memory
 region list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Compare the temporary region list with the current list
to generate a change flag (replacing the old mem_changed_start_addr)
and flip the temporary list into becoming the new current list.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/vhost.c      | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 7de0663652..3dd6be797c 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,7 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/virtio/vhost.c
+vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_tmp(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_region_add_tmp_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 vhost_section(const char *name, int r) "%s:%d"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2084888aa7..1b276b210f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -642,15 +642,25 @@ static void vhost_commit(MemoryListener *listener)
                                          memory_listener);
     uint64_t log_size;
     int r;
+    bool changed = false;
 
-    g_free(dev->tmp_mem);
-    if (!dev->memory_changed) {
-        return;
+    if (dev->mem->nregions != dev->tmp_mem->nregions) {
+        changed = true;
+    } else {
+        /* Same size, lets check the contents */
+        size_t region_size = dev->mem->nregions * sizeof dev->mem->regions[0];
+        changed = memcmp(dev->mem->regions, dev->tmp_mem->regions,
+                         region_size) != 0;
     }
+    g_free(dev->mem);
+    dev->mem = dev->tmp_mem;
+    dev->tmp_mem = NULL;
+
+    trace_vhost_commit(dev->started, changed);
     if (!dev->started) {
         return;
     }
-    if (dev->mem_changed_start_addr > dev->mem_changed_end_addr) {
+    if (!changed) {
         return;
     }
 
-- 
2.14.3
