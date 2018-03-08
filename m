Received: from eggs.gnu.org ([2001:4830:134:3::10]:47423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gV-0003KO-0a
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gT-0006Df-Tt
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eu1gT-0006DN-P3
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 356BE8182D24
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 19:58:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  8 Mar 2018 19:57:58 +0000
Message-Id: <20180308195811.24894-17-dgilbert@redhat.com>
In-Reply-To: <20180308195811.24894-1-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 16/29] vhost+postcopy: Stash RAMBlock and
 offset
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

Stash the RAMBlock and offset for later use looking up
addresses.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 05d18ada77..d7e9e1084b 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -9,6 +9,7 @@ vhost_section(const char *name, int r) "%s:%d"
 # hw/virtio/vhost-user.c
 vhost_user_postcopy_listen(void) ""
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
+vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB offset:0x%"PRIx64
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6875f729e8..fd65616961 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -175,6 +175,15 @@ struct vhost_user {
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
     uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
+    /* Length of the region_rb and region_rb_offset arrays */
+    size_t             region_rb_len;
+    /* RAMBlock associated with a given region */
+    RAMBlock         **region_rb;
+    /* The offset from the start of the RAMBlock to the start of the
+     * vhost region.
+     */
+    ram_addr_t        *region_rb_offset;
+
     /* True once we've entered postcopy_listen */
     bool               postcopy_listen;
 };
@@ -362,6 +371,17 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
+    if (u->region_rb_len < dev->mem->nregions) {
+        u->region_rb = g_renew(RAMBlock*, u->region_rb, dev->mem->nregions);
+        u->region_rb_offset = g_renew(ram_addr_t, u->region_rb_offset,
+                                      dev->mem->nregions);
+        memset(&(u->region_rb[u->region_rb_len]), '\0',
+               sizeof(RAMBlock *) * (dev->mem->nregions - u->region_rb_len));
+        memset(&(u->region_rb_offset[u->region_rb_len]), '\0',
+               sizeof(ram_addr_t) * (dev->mem->nregions - u->region_rb_len));
+        u->region_rb_len = dev->mem->nregions;
+    }
+
     for (i = 0; i < dev->mem->nregions; ++i) {
         struct vhost_memory_region *reg = dev->mem->regions + i;
         ram_addr_t offset;
@@ -372,6 +392,12 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                      &offset);
         fd = memory_region_get_fd(mr);
         if (fd > 0) {
+            trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
+                                                  reg->memory_size,
+                                                  reg->guest_phys_addr,
+                                                  reg->userspace_addr, offset);
+            u->region_rb_offset[i] = offset;
+            u->region_rb[i] = mr->ram_block;
             msg.payload.memory.regions[fd_num].userspace_addr =
                 reg->userspace_addr;
             msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
@@ -380,6 +406,9 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
             msg.payload.memory.regions[fd_num].mmap_offset = offset;
             assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
             fds[fd_num++] = fd;
+        } else {
+            u->region_rb_offset[i] = 0;
+            u->region_rb[i] = NULL;
         }
     }
 
@@ -1148,6 +1177,11 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
         close(u->slave_fd);
         u->slave_fd = -1;
     }
+    g_free(u->region_rb);
+    u->region_rb = NULL;
+    g_free(u->region_rb_offset);
+    u->region_rb_offset = NULL;
+    u->region_rb_len = 0;
     g_free(u);
     dev->opaque = 0;
 
-- 
2.14.3
