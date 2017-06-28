Received: from eggs.gnu.org ([2001:4830:134:3::10]:40633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIE5-0004xU-Gv
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIE0-0008I5-KI
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIE0-0008Hs-6n
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:04 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:33 +0100
Message-Id: <20170628190047.26159-16-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 15/29] vhost+postcopy: Send address back to qemu
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

We need a better way, but at the moment we need the address of the
mappings sent back to qemu so it can interpret the messages on the
userfaultfd it reads.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 15 +++++++++-
 hw/virtio/trace-events                |  1 +
 hw/virtio/vhost-user.c                | 54 +++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index be7470e3a9..0658b6e847 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -479,13 +479,26 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
             DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
                     __func__, i, reg_struct.range.start, reg_struct.range.len);
             /* TODO: Stash 'zero' support flags somewhere */
-            /* TODO: Get address back to QEMU */
 
+            /* TODO: We need to find a way for the qemu not to see the virtual
+             * addresses of the clients, so as to keep better separation.
+             */
+            /* Return the address to QEMU so that it can translate the ufd
+             * fault addresses back.
+             */
+            msg_region->userspace_addr = (uintptr_t)(mmap_addr +
+                                                     dev_region->mmap_offset);
         }
 
         close(vmsg->fds[i]);
     }
 
+    if (dev->postcopy_listening) {
+        /* Need to return the addresses - send the updated message back */
+        vmsg->fd_num = 0;
+        return true;
+    }
+
     return false;
 }
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 1076dbbb1d..f7be340a45 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -2,6 +2,7 @@
 
 # hw/virtio/vhost-user.c
 vhost_user_postcopy_listen(void) ""
+vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:%"PRIx64" for hva: %"PRIx64" reply %d region %d"
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1f70f5760f..6be3e7ff2d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -19,6 +19,7 @@
 #include "qemu/sockets.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
+#include "trace.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -131,6 +132,7 @@ struct vhost_user {
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
+    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
 };
 
 static bool ioeventfd_enabled(void)
@@ -298,6 +300,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
+    struct vhost_user *u = dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     int i, fd;
     size_t fd_num = 0;
@@ -348,6 +351,57 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         return -1;
     }
 
+    if (u->postcopy_fd.handler) {
+        VhostUserMsg msg_reply;
+        int region_i, reply_i;
+        if (vhost_user_read(dev, &msg_reply) < 0) {
+            return -1;
+        }
+
+        if (msg_reply.request != VHOST_USER_SET_MEM_TABLE) {
+            error_report("%s: Received unexpected msg type."
+                         "Expected %d received %d", __func__,
+                         VHOST_USER_SET_MEM_TABLE, msg_reply.request);
+            return -1;
+        }
+        /* We're using the same structure, just reusing one of the
+         * fields, so it should be the same size.
+         */
+        if (msg_reply.size != msg.size) {
+            error_report("%s: Unexpected size for postcopy reply "
+                         "%d vs %d", __func__, msg_reply.size, msg.size);
+            return -1;
+        }
+
+        memset(u->postcopy_client_bases, 0,
+               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+
+        /* They're in the same order as the regions that were sent
+         * but some of the regions were skipped (above) if they
+         * didn't have fd's
+        */
+        for (reply_i = 0, region_i = 0;
+             region_i < dev->mem->nregions;
+             region_i++) {
+            if (reply_i < fd_num &&
+                msg_reply.payload.memory.regions[region_i].guest_phys_addr ==
+                dev->mem->regions[region_i].guest_phys_addr) {
+                u->postcopy_client_bases[region_i] =
+                    msg_reply.payload.memory.regions[reply_i].userspace_addr;
+                trace_vhost_user_set_mem_table_postcopy(
+                    msg_reply.payload.memory.regions[reply_i].userspace_addr,
+                    msg.payload.memory.regions[reply_i].userspace_addr,
+                    reply_i, region_i);
+                reply_i++;
+            }
+        }
+        if (reply_i != fd_num) {
+            error_report("%s: postcopy reply not fully consumed "
+                         "%d vs %zd",
+                         __func__, reply_i, fd_num);
+            return -1;
+        }
+    }
     if (reply_supported) {
         return process_message_reply(dev, &msg);
     }
-- 
2.13.0
