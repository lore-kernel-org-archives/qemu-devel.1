Received: from eggs.gnu.org ([2001:4830:134:3::10]:40944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEp-0005Xh-0n
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEl-0000EV-Rz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIEl-0000ED-Jr
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:51 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:42 +0100
Message-Id: <20170628190047.26159-25-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 24/29] vhost+postcopy: Lock around set_mem_table
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
 hw/virtio/vhost-user.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 0f2e05f817..74e4313782 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -138,6 +138,7 @@ struct vhost_user {
      * vhost region.
      */
     ram_addr_t         region_rb_offset[VHOST_MEMORY_MAX_NREGIONS];
+    uint64_t           in_set_mem_table; /*Hack! 1 while waiting for set_mem_table reply */
 };
 
 static bool ioeventfd_enabled(void)
@@ -321,6 +322,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         msg.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
+    atomic_set(&u->in_set_mem_table, true);
     for (i = 0; i < dev->mem->nregions; ++i) {
         struct vhost_memory_region *reg = dev->mem->regions + i;
         ram_addr_t offset;
@@ -351,14 +353,15 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
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
 
@@ -373,6 +376,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
             error_report("%s: Received unexpected msg type."
                          "Expected %d received %d", __func__,
                          VHOST_USER_SET_MEM_TABLE, msg_reply.request);
+            atomic_set(&u->in_set_mem_table, false);
             return -1;
         }
         /* We're using the same structure, just reusing one of the
@@ -381,6 +385,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         if (msg_reply.size != msg.size) {
             error_report("%s: Unexpected size for postcopy reply "
                          "%d vs %d", __func__, msg_reply.size, msg.size);
+            atomic_set(&u->in_set_mem_table, false);
             return -1;
         }
 
@@ -410,9 +415,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
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
@@ -821,6 +828,11 @@ static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *rb,
     int i;
 
     trace_vhost_user_postcopy_waker(qemu_ram_get_idstr(rb), offset);
+    while (atomic_mb_read(&u->in_set_mem_table)) {
+        fprintf(stderr, "%s: Spin waiting for memtable\n", __func__);
+        usleep(1000*100);
+    }
+
     /* Translate the offset into an address in the clients address space */
     for (i = 0; i < dev->mem->nregions; i++) {
         if (u->region_rb[i] == rb &&
-- 
2.13.0
