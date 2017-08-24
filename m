Received: from eggs.gnu.org ([2001:4830:134:3::10]:52838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxox-0003Pv-M5
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxow-0005Vn-EN
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxow-0005VK-4k
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:38 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:23 +0100
Message-Id: <20170824192730.8440-26-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 25/32] vhost+postcopy: Lock around
 set_mem_table
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

**HACK - better solution needed **
We have the situation where:

     qemu                      bridge

     send set_mem_table
                              map memory
  a)                          mark area with UFD
                              send reply with map addresses
  b)                          start using
  c) receive reply

  As soon as (a) happens qemu might start seeing faults
from memory accesses (but doesn't until b); but it can't
process those faults until (c) when it's received the
mmap addresses.

Make the fault handler spin until it gets the reply in (c).

At the very least this needs some proper locks, but preferably
we need to split the message.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/vhost-user.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index adebf6dc6b..065822c70a 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -10,6 +10,7 @@ vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_siz
 vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
 vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
 vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
+vhost_user_postcopy_waker_spin(const char *rb) "%s"
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3bff33a1a6..4d03383a66 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -143,6 +143,7 @@ struct vhost_user {
      * vhost region.
      */
     ram_addr_t        *region_rb_offset;
+    uint64_t           in_set_mem_table; /*Hack! 1 while waiting for set_mem_table reply */
 };
 
 static bool ioeventfd_enabled(void)
@@ -338,6 +339,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         u->region_rb_len = dev->mem->nregions;
     }
 
+    atomic_set(&u->in_set_mem_table, true);
     for (i = 0; i < dev->mem->nregions; ++i) {
         struct vhost_memory_region *reg = dev->mem->regions + i;
         ram_addr_t offset;
@@ -368,14 +370,15 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     if (!fd_num) {
         error_report("Failed initializing vhost-user memory map, "
                      "consider using -object memory-backend-file share=on");
+        atomic_set(&u->in_set_mem_table, false);
         return -1;
     }
 
     msg.size = sizeof(msg.payload.memory.nregions);
     msg.size += sizeof(msg.payload.memory.padding);
     msg.size += fd_num * sizeof(VhostUserMemoryRegion);
-
     if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
+        atomic_set(&u->in_set_mem_table, false);
         return -1;
     }
 
@@ -390,6 +393,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
             error_report("%s: Received unexpected msg type."
                          "Expected %d received %d", __func__,
                          VHOST_USER_SET_MEM_TABLE, msg_reply.request);
+            atomic_set(&u->in_set_mem_table, false);
             return -1;
         }
         /* We're using the same structure, just reusing one of the
@@ -398,6 +402,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         if (msg_reply.size != msg.size) {
             error_report("%s: Unexpected size for postcopy reply "
                          "%d vs %d", __func__, msg_reply.size, msg.size);
+            atomic_set(&u->in_set_mem_table, false);
             return -1;
         }
 
@@ -427,9 +432,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
             error_report("%s: postcopy reply not fully consumed "
                          "%d vs %zd",
                          __func__, reply_i, fd_num);
+            atomic_set(&u->in_set_mem_table, false);
             return -1;
         }
     }
+    atomic_set(&u->in_set_mem_table, false);
     if (reply_supported) {
         return process_message_reply(dev, &msg);
     }
@@ -855,6 +862,14 @@ static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *rb,
     int i;
 
     trace_vhost_user_postcopy_waker(qemu_ram_get_idstr(rb), offset);
+    if (!u) {
+        return 0;
+    }
+    while (atomic_mb_read(&u->in_set_mem_table)) {
+        trace_vhost_user_postcopy_waker_spin(qemu_ram_get_idstr(rb));
+        usleep(1000*100);
+    }
+
     /* Translate the offset into an address in the clients address space */
     for (i = 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++) {
         if (u->region_rb[i] == rb &&
-- 
2.13.5
