Received: from eggs.gnu.org ([2001:4830:134:3::10]:52415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxo8-0002cj-AS
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxo7-0004zk-1E
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxo6-0004yL-OU
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:46 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:14 +0100
Message-Id: <20170824192730.8440-17-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 16/32] vhost+postcopy: Send address back to
 qemu
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

We need a better way, but at the moment we need the address of the
mappings sent back to qemu so it can interpret the messages on the
userfaultfd it reads.

Note: We don't ask for the default 'ack' reply since we've got our own.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 15 ++++++++-
 docs/interop/vhost-user.txt           |  6 ++++
 hw/virtio/trace-events                |  1 +
 hw/virtio/vhost-user.c                | 57 ++++++++++++++++++++++++++++++++++-
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index e6ab059a03..5ec54f7d60 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -477,13 +477,26 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
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
 
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 73c3dd74db..b2a548c94d 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -413,12 +413,18 @@ Master message types
       Id: 5
       Equivalent ioctl: VHOST_SET_MEM_TABLE
       Master payload: memory regions description
+      Slave payload: (postcopy only) memory regions description
 
       Sets the memory map regions on the slave so it can translate the vring
       addresses. In the ancillary data there is an array of file descriptors
       for each memory mapped region. The size and ordering of the fds matches
       the number and ordering of memory regions.
 
+      When postcopy-listening has been received, SET_MEM_TABLE replies with
+      the bases of the memory mapped regions to the master.  It must have mmap'd
+      the regions and enabled userfaultfd on them.  Note NEED_REPLY_MASK
+      is not set in this case.
+
  * VHOST_USER_SET_LOG_BASE
 
       Id: 6
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f736c7c84f..63fd4a79cf 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -2,6 +2,7 @@
 
 # hw/virtio/vhost-user.c
 vhost_user_postcopy_listen(void) ""
+vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9178271ab2..2e4eb0864a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -19,6 +19,7 @@
 #include "qemu/sockets.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
+#include "trace.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -133,6 +134,7 @@ struct vhost_user {
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
+    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
 };
 
 static bool ioeventfd_enabled(void)
@@ -300,11 +302,13 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
+    struct vhost_user *u = dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     int i, fd;
     size_t fd_num = 0;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+                                          VHOST_USER_PROTOCOL_F_REPLY_ACK) &&
+                           !u->postcopy_fd.handler;
 
     VhostUserMsg msg = {
         .request = VHOST_USER_SET_MEM_TABLE,
@@ -350,6 +354,57 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
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
2.13.5
