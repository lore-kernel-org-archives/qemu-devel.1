Received: from eggs.gnu.org ([2001:4830:134:3::10]:47467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gX-0003NG-Ou
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gW-0006IC-Re
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eu1gW-0006Hb-Mm
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2419C4015A42
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 19:58:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  8 Mar 2018 19:58:00 +0000
Message-Id: <20180308195811.24894-19-dgilbert@redhat.com>
In-Reply-To: <20180308195811.24894-1-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 18/29] vhost+postcopy: Resolve client address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Resolve fault addresses read off the clients UFD into RAMBlock
and offset, and call back to the postcopy code to ask for the page.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/virtio/trace-events |  3 +++
 hw/virtio/vhost-user.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index d7e9e1084b..3afd12cfea 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -7,6 +7,9 @@ vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx
 vhost_section(const char *name, int r) "%s:%d"
 
 # hw/virtio/vhost-user.c
+vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_address, int nregions) "%s: @0x%"PRIx64" nregions:%d"
+vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint64_t size) "%d: client 0x%"PRIx64" +0x%"PRIx64
+vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t rb_offset) "%d: region_offset: 0x%"PRIx64" rb_offset:0x%"PRIx64
 vhost_user_postcopy_listen(void) ""
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
 vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB offset:0x%"PRIx64
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index fd65616961..e19b9ef9cf 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -26,6 +26,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <linux/vhost.h>
+#include <linux/userfaultfd.h>
 
 #define VHOST_MEMORY_MAX_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
@@ -974,7 +975,35 @@ out:
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
+            if (region_offset < dev->mem->regions[i].memory_size) {
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
2.14.3
