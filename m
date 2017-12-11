Received: from eggs.gnu.org ([2001:4830:134:3::10]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOU23-00089C-4m
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOU20-0006lL-9w
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOU20-0006kH-3n
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:28 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 11 Dec 2017 19:46:08 +0000
Message-Id: <20171211194610.3962-7-dgilbert@redhat.com>
In-Reply-To: <20171211194610.3962-1-dgilbert@redhat.com>
References: <20171211194610.3962-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/8] vhost: Compare and copy updated region
 data into device state
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

Compare the temporary region data with the original, and if it's
different update the original in the device state.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  2 ++
 hw/virtio/vhost.c      | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 92fadec192..fac89aaba5 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -2,6 +2,8 @@
 
 # hw/virtio/vhost.c
 vhost_section(const char *name, int r) "%s:%d"
+vhost_update_mem(void) ""
+vhost_update_mem_changed(void) ""
 vhost_update_mem_cb(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_update_mem_cb_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 646a3480c1..c00d82f96a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -707,10 +707,12 @@ static int vhost_update_mem(struct vhost_dev *dev, bool *changed)
 {
     int res;
     struct vhost_update_mem_tmp vtmp;
+    size_t mem_size;
     vtmp.regions = 0;
     vtmp.nregions = 0;
     vtmp.dev = dev;
 
+    trace_vhost_update_mem();
     *changed = false;
     res = address_space_iterate(&address_space_memory,
                                 vhost_update_mem_cb, &vtmp);
@@ -718,8 +720,21 @@ static int vhost_update_mem(struct vhost_dev *dev, bool *changed)
         goto out;
     }
 
-    /* TODO */
-    *changed = dev->mem_changed_start_addr < dev->mem_changed_end_addr;
+    mem_size = offsetof(struct vhost_memory, regions) +
+               (vtmp.nregions + 1) * sizeof dev->mem->regions[0];
+
+    if (vtmp.nregions != dev->mem->nregions ||
+       memcmp(vtmp.regions, dev->mem->regions, mem_size)) {
+        *changed = true;
+        /* Update the main regions list from our tmp */
+        dev->mem = g_realloc(dev->mem, mem_size);
+        dev->mem->nregions = vtmp.nregions;
+        memcpy(dev->mem->regions, vtmp.regions,
+               vtmp.nregions * sizeof dev->mem->regions[0]);
+        used_memslots = vtmp.nregions;
+        trace_vhost_update_mem_changed();
+    }
+
 out:
     g_free(vtmp.regions);
     return res;
-- 
2.14.3
