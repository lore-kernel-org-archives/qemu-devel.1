Received: from eggs.gnu.org ([2001:4830:134:3::10]:52609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxoP-0002vT-PC
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxoO-0005Bk-Mj
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxoO-0005B1-Dr
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:04 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:17 +0100
Message-Id: <20170824192730.8440-20-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 19/32] vhost+postcopy: Resolve client address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Resolve fault addresses read off the clients UFD into RAMBlock
and offset, and call back to the postcopy code to ask for the page.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  3 +++
 hw/virtio/vhost-user.c | 30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 5067dee19b..f7d4b831fe 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/virtio/vhost-user.c
+vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_address, int nregions) "%s: @0x%"PRIx64" nregions:%d"
+vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint64_t size) "%d: client 0x%"PRIx64" +0x%"PRIx64
+vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t rb_offset) "%d: region_offset: 0x%"PRIx64" rb_offset:0x%"PRIx64
 vhost_user_postcopy_listen(void) ""
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
 vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB offset:0x%"PRIx64
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index fbe2743298..2897ff70b3 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -816,7 +816,35 @@ out:
 static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
                                              void *ufd)
 {
-    return 0;
+    struct vhost_dev *dev = pcfd->data;
+    struct vhost_user *u = dev->opaque;
+    struct uffd_msg *msg = ufd;
+    uint64_t faultaddr = msg->arg.pagefault.address;
+    RAMBlock *rb = NULL;
+    uint64_t rb_offset;
+    int i;
+
+    trace_vhost_user_postcopy_fault_handler(pcfd->idstr, faultaddr,
+                                            dev->mem->nregions);
+    for (i = 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++) {
+        trace_vhost_user_postcopy_fault_handler_loop(i,
+                u->postcopy_client_bases[i], dev->mem->regions[i].memory_size);
+        if (faultaddr >= u->postcopy_client_bases[i]) {
+            /* Ofset of the fault address in the vhost region */
+            uint64_t region_offset = faultaddr - u->postcopy_client_bases[i];
+            if (region_offset <= dev->mem->regions[i].memory_size) {
+                rb_offset = region_offset + u->region_rb_offset[i];
+                trace_vhost_user_postcopy_fault_handler_found(i,
+                        region_offset, rb_offset);
+                rb = u->region_rb[i];
+                return postcopy_request_shared_page(pcfd, rb, faultaddr,
+                                                    rb_offset);
+            }
+        }
+    }
+    error_report("%s: Failed to find region for fault %" PRIx64,
+                 __func__, faultaddr);
+    return -1;
 }
 
 /*
-- 
2.13.5
