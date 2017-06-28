Received: from eggs.gnu.org ([2001:4830:134:3::10]:40863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEe-0005Nv-Qo
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEZ-00004x-VL
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIEZ-0008WA-NQ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:39 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:39 +0100
Message-Id: <20170628190047.26159-22-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 21/29] vhost+postcopy: Add vhost waker
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

Register a waker function in vhost-user code to be notified when
pages arrive or requests to previously mapped pages get requested.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  3 +++
 hw/virtio/vhost-user.c | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3cec81bb1e..e320a90941 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -5,6 +5,9 @@ vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_address, int
 vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint64_t size) "%d: client%"PRIx64" +%"PRIx64
 vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t rb_offset) "%d: region_offset: %"PRIx64" rb_offset:%"PRIx64
 vhost_user_postcopy_listen(void) ""
+vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + %"PRIx64
+vhost_user_postcopy_waker_found(uint64_t client_addr) "%"PRIx64
+vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + %"PRIx64
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:%"PRIx64" for hva: %"PRIx64" reply %d region %d"
 vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:%"PRIx64" GPA:%"PRIx64" QVA/userspace:%"PRIx64" RB offset:%"PRIx64
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 92620830e4..0f2e05f817 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -813,6 +813,31 @@ static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
     return -1;
 }
 
+static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *rb,
+                                     uint64_t offset)
+{
+    struct vhost_dev *dev = pcfd->data;
+    struct vhost_user *u = dev->opaque;
+    int i;
+
+    trace_vhost_user_postcopy_waker(qemu_ram_get_idstr(rb), offset);
+    /* Translate the offset into an address in the clients address space */
+    for (i = 0; i < dev->mem->nregions; i++) {
+        if (u->region_rb[i] == rb &&
+            offset >= u->region_rb_offset[i] &&
+            offset < (u->region_rb_offset[i] +
+                      dev->mem->regions[i].memory_size)) {
+            uint64_t client_addr = (offset - u->region_rb_offset[i]) +
+                                   u->postcopy_client_bases[i];
+            trace_vhost_user_postcopy_waker_found(client_addr);
+            return postcopy_wake_shared(pcfd, client_addr, rb);
+        }
+    }
+
+    trace_vhost_user_postcopy_waker_nomatch(qemu_ram_get_idstr(rb), offset);
+    return 0;
+}
+
 /*
  * Called at the start of an inbound postcopy on reception of the
  * 'advise' command.
@@ -858,6 +883,7 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
     u->postcopy_fd.fd = ufd;
     u->postcopy_fd.data = dev;
     u->postcopy_fd.handler = vhost_user_postcopy_fault_handler;
+    u->postcopy_fd.waker = vhost_user_postcopy_waker;
     u->postcopy_fd.idstr = "vhost-user"; /* Need to find unique name */
     postcopy_register_shared_ufd(&u->postcopy_fd);
     return 0;
-- 
2.13.0
