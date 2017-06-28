Received: from eggs.gnu.org ([2001:4830:134:3::10]:40706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEJ-000556-1X
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEE-0008Mi-55
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIED-0008MO-Ty
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:18 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:34 +0100
Message-Id: <20170628190047.26159-17-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 16/29] vhost+postcopy: Stash RAMBlock and offset
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

Stash the RAMBlock and offset for later use looking up
addresses.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/vhost-user.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f7be340a45..1fd194363a 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -3,6 +3,7 @@
 # hw/virtio/vhost-user.c
 vhost_user_postcopy_listen(void) ""
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:%"PRIx64" for hva: %"PRIx64" reply %d region %d"
+vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:%"PRIx64" GPA:%"PRIx64" QVA/userspace:%"PRIx64" RB offset:%"PRIx64
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6be3e7ff2d..3185af7a45 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -133,6 +133,11 @@ struct vhost_user {
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
     uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
+    RAMBlock          *region_rb[VHOST_MEMORY_MAX_NREGIONS];
+    /* The offset from the start of the RAMBlock to the start of the
+     * vhost region.
+     */
+    ram_addr_t         region_rb_offset[VHOST_MEMORY_MAX_NREGIONS];
 };
 
 static bool ioeventfd_enabled(void)
@@ -324,8 +329,14 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
         mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
                                      &offset);
+        u->region_rb_offset[i] = offset;
+        u->region_rb[i] = mr->ram_block;
         fd = memory_region_get_fd(mr);
         if (fd > 0) {
+            trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
+                                                  reg->memory_size,
+                                                  reg->guest_phys_addr,
+                                                  reg->userspace_addr, offset);
             msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
             msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
             msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
-- 
2.13.0
