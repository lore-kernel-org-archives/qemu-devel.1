Received: from eggs.gnu.org ([2001:4830:134:3::10]:40722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEK-000568-31
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEJ-0008O7-50
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIEI-0008Nk-Sq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:23 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:36 +0100
Message-Id: <20170628190047.26159-19-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 18/29] vhost+postcopy: Resolve client address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Resolve fault addresses read off the clients UFD into RAMBlock
and offset, and call back to the postcopy code to ask for the page.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  3 +++
 hw/virtio/vhost-user.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 1fd194363a..3cec81bb1e 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,9 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/virtio/vhost-user.c
+vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_address, int nregions) "%s: @%"PRIx64" nregions:%d"
+vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint64_t size) "%d: client%"PRIx64" +%"PRIx64
+vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t rb_offset) "%d: region_offset: %"PRIx64" rb_offset:%"PRIx64
 vhost_user_postcopy_listen(void) ""
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:%"PRIx64" for hva: %"PRIx64" reply %d region %d"
 vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:%"PRIx64" GPA:%"PRIx64" QVA/userspace:%"PRIx64" RB offset:%"PRIx64
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3185af7a45..92620830e4 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -782,9 +782,35 @@ out:
 static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
                                              void *ufd)
 {
+    struct vhost_dev *dev = pcfd->data;
+    struct vhost_user *u = dev->opaque;
     struct uffd_msg *msg = ufd;
+    uint64_t faultaddr = msg->arg.pagefault.address;
+    RAMBlock *rb = NULL;
+    uint64_t rb_offset;
+    int i;
 
-    return 0;
+    trace_vhost_user_postcopy_fault_handler(pcfd->idstr, faultaddr,
+                                            dev->mem->nregions);
+    for (i = 0; i < dev->mem->nregions; i++) {
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
2.13.0
