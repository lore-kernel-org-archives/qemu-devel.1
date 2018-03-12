Received: from eggs.gnu.org ([2001:4830:134:3::10]:53102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR93-0008ID-CG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR90-0007fG-76
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR90-0007eu-1D
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA843401DE7F
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:21:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:10 +0000
Message-Id: <20180312172124.56461-16-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 15/29] vhost+postcopy: Send address back to
 qemu
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

We need a better way, but at the moment we need the address of the
mappings sent back to qemu so it can interpret the messages on the
userfaultfd it reads.

This is done as a 3 stage set:
   QEMU -> client
      set_mem_table

   mmap stuff, get addresses

   client -> qemu
       here are the addresses

   qemu -> client
       OK - now you can use them

That ensures that qemu has registered the new addresses in it's
userfault code before the client starts accessing them.

Note: We don't ask for the default 'ack' reply since we've got our own.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 24 ++++++++++++-
 docs/interop/vhost-user.txt           |  9 +++++
 hw/virtio/trace-events                |  1 +
 hw/virtio/vhost-user.c                | 67 +++++++++++++++++++++++++++++=
++++--
 4 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 7c8cd5878e..6314549b65 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -491,10 +491,32 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUse=
rMsg *vmsg)
                    dev_region->mmap_addr);
         }
=20
+        /* Return the address to QEMU so that it can translate the ufd
+         * fault addresses back.
+         */
+        msg_region->userspace_addr =3D (uintptr_t)(mmap_addr +
+                                                 dev_region->mmap_offset=
);
         close(vmsg->fds[i]);
     }
=20
-    /* TODO: Get address back to QEMU */
+    /* Send the message back to qemu with the addresses filled in */
+    vmsg->fd_num =3D 0;
+    if (!vu_message_write(dev, dev->sock, vmsg)) {
+        vu_panic(dev, "failed to respond to set-mem-table for postcopy")=
;
+        return false;
+    }
+
+    /* Wait for QEMU to confirm that it's registered the handler for the
+     * faults.
+     */
+    if (!vu_message_read(dev, dev->sock, vmsg) ||
+        vmsg->size !=3D sizeof(vmsg->payload.u64) ||
+        vmsg->payload.u64 !=3D 0) {
+        vu_panic(dev, "failed to receive valid ack for postcopy set-mem-=
table");
+        return false;
+    }
+
+    /* OK, now we can go and register the memory and generate faults */
     for (i =3D 0; i < dev->nregions; i++) {
         VuDevRegion *dev_region =3D &dev->regions[i];
 #ifdef UFFDIO_REGISTER
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 0d24203d31..e295ef12ca 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -455,12 +455,21 @@ Master message types
       Id: 5
       Equivalent ioctl: VHOST_SET_MEM_TABLE
       Master payload: memory regions description
+      Slave payload: (postcopy only) memory regions description
=20
       Sets the memory map regions on the slave so it can translate the v=
ring
       addresses. In the ancillary data there is an array of file descrip=
tors
       for each memory mapped region. The size and ordering of the fds ma=
tches
       the number and ordering of memory regions.
=20
+      When VHOST_USER_POSTCOPY_LISTEN has been received, SET_MEM_TABLE r=
eplies with
+      the bases of the memory mapped regions to the master.  The slave m=
ust
+      have mmap'd the regions but not yet accessed them and should not y=
et generate
+      a userfault event. Note NEED_REPLY_MASK is not set in this case.
+      QEMU will then reply back to the list of mappings with an empty
+      VHOST_USER_SET_MEM_TABLE as an acknowledgment; only upon reception=
 of this
+      message may the guest start accessing the memory and generating fa=
ults.
+
  * VHOST_USER_SET_LOG_BASE
=20
       Id: 6
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 06ec03d6e7..05d18ada77 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -8,6 +8,7 @@ vhost_section(const char *name, int r) "%s:%d"
=20
 # hw/virtio/vhost-user.c
 vhost_user_postcopy_listen(void) ""
+vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, i=
nt reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply =
%d region %d"
=20
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned=
 out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b6757ebae3..1603d70bea 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -174,6 +174,7 @@ struct vhost_user {
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
+    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
     /* True once we've entered postcopy_listen */
     bool               postcopy_listen;
 };
@@ -343,12 +344,15 @@ static int vhost_user_set_log_base(struct vhost_dev=
 *dev, uint64_t base,
 static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                              struct vhost_memory *mem)
 {
+    struct vhost_user *u =3D dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     int i, fd;
     size_t fd_num =3D 0;
     bool reply_supported =3D virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
-    /* TODO: Add actual postcopy differences */
+    VhostUserMsg msg_reply;
+    int region_i, msg_i;
+
     VhostUserMsg msg =3D {
         .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
         .hdr.flags =3D VHOST_USER_VERSION,
@@ -395,6 +399,64 @@ static int vhost_user_set_mem_table_postcopy(struct =
vhost_dev *dev,
         return -1;
     }
=20
+    if (vhost_user_read(dev, &msg_reply) < 0) {
+        return -1;
+    }
+
+    if (msg_reply.hdr.request !=3D VHOST_USER_SET_MEM_TABLE) {
+        error_report("%s: Received unexpected msg type."
+                     "Expected %d received %d", __func__,
+                     VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request);
+        return -1;
+    }
+    /* We're using the same structure, just reusing one of the
+     * fields, so it should be the same size.
+     */
+    if (msg_reply.hdr.size !=3D msg.hdr.size) {
+        error_report("%s: Unexpected size for postcopy reply "
+                     "%d vs %d", __func__, msg_reply.hdr.size, msg.hdr.s=
ize);
+        return -1;
+    }
+
+    memset(u->postcopy_client_bases, 0,
+           sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+
+    /* They're in the same order as the regions that were sent
+     * but some of the regions were skipped (above) if they
+     * didn't have fd's
+    */
+    for (msg_i =3D 0, region_i =3D 0;
+         region_i < dev->mem->nregions;
+        region_i++) {
+        if (msg_i < fd_num &&
+            msg_reply.payload.memory.regions[msg_i].guest_phys_addr =3D=3D
+            dev->mem->regions[region_i].guest_phys_addr) {
+            u->postcopy_client_bases[region_i] =3D
+                msg_reply.payload.memory.regions[msg_i].userspace_addr;
+            trace_vhost_user_set_mem_table_postcopy(
+                msg_reply.payload.memory.regions[msg_i].userspace_addr,
+                msg.payload.memory.regions[msg_i].userspace_addr,
+                msg_i, region_i);
+            msg_i++;
+        }
+    }
+    if (msg_i !=3D fd_num) {
+        error_report("%s: postcopy reply not fully consumed "
+                     "%d vs %zd",
+                     __func__, msg_i, fd_num);
+        return -1;
+    }
+    /* Now we've registered this with the postcopy code, we ack to the c=
lient,
+     * because now we're in the position to be able to deal with any fau=
lts
+     * it generates.
+     */
+    /* TODO: Use this for failure cases as well with a bad value */
+    msg.hdr.size =3D sizeof(msg.payload.u64);
+    msg.payload.u64 =3D 0; /* OK */
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
     if (reply_supported) {
         return process_message_reply(dev, &msg);
     }
@@ -411,7 +473,8 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,
     size_t fd_num =3D 0;
     bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported =3D virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
+                                          VHOST_USER_PROTOCOL_F_REPLY_AC=
K) &&
+                                          !do_postcopy;
=20
     if (do_postcopy) {
         /* Postcopy has enough differences that it's best done in it's o=
wn
--=20
2.14.3
