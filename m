Received: from eggs.gnu.org ([2001:4830:134:3::10]:41790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51p-0003Cp-8E
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51k-0004hl-CA
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew51k-0004hd-6r
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B271A402314E
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:57:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:56:01 +0000
Message-Id: <20180314115618.28831-13-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 12/29] postcopy+vhost-user: Split
 set_mem_table for postcopy
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

Split the set_mem_table routines in both qemu and libvhost-user
because the postcopy versions are going to be quite different
once changes in the later patches are added. However, this patch
doesn't produce any functional change, just the split.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 53 +++++++++++++++++++++++++++++=
+++++
 hw/virtio/vhost-user.c                | 54 +++++++++++++++++++++++++++++=
++++++
 2 files changed, 107 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index e53b1953df..b2de8ed0a8 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -448,6 +448,55 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
=20
+static bool
+vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int i;
+    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    dev->nregions =3D memory->nregions;
+    /* TODO: Postcopy specific code */
+    DPRINT("Nregions: %d\n", memory->nregions);
+    for (i =3D 0; i < dev->nregions; i++) {
+        void *mmap_addr;
+        VhostUserMemoryRegion *msg_region =3D &memory->regions[i];
+        VuDevRegion *dev_region =3D &dev->regions[i];
+
+        DPRINT("Region %d\n", i);
+        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+               msg_region->guest_phys_addr);
+        DPRINT("    memory_size:     0x%016"PRIx64"\n",
+               msg_region->memory_size);
+        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+               msg_region->userspace_addr);
+        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+               msg_region->mmap_offset);
+
+        dev_region->gpa =3D msg_region->guest_phys_addr;
+        dev_region->size =3D msg_region->memory_size;
+        dev_region->qva =3D msg_region->userspace_addr;
+        dev_region->mmap_offset =3D msg_region->mmap_offset;
+
+        /* We don't use offset argument of mmap() since the
+         * mapped address has to be page aligned, and we use huge
+         * pages.  */
+        mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
+                         PROT_READ | PROT_WRITE, MAP_SHARED,
+                         vmsg->fds[i], 0);
+
+        if (mmap_addr =3D=3D MAP_FAILED) {
+            vu_panic(dev, "region mmap error: %s", strerror(errno));
+        } else {
+            dev_region->mmap_addr =3D (uint64_t)(uintptr_t)mmap_addr;
+            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
+                   dev_region->mmap_addr);
+        }
+
+        close(vmsg->fds[i]);
+    }
+
+    return false;
+}
+
 static bool
 vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -464,6 +513,10 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg=
)
     }
     dev->nregions =3D memory->nregions;
=20
+    if (dev->postcopy_listening) {
+        return vu_set_mem_table_exec_postcopy(dev, vmsg);
+    }
+
     DPRINT("Nregions: %d\n", memory->nregions);
     for (i =3D 0; i < dev->nregions; i++) {
         void *mmap_addr;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 660183d23d..060a339914 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -374,14 +374,68 @@ static int vhost_user_prepare_msg(struct vhost_dev =
*dev, VhostUserMemory *mem,
     return 0;
 }
=20
+static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
+                                             struct vhost_memory *mem)
+{
+    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    size_t fd_num;
+    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
+    /* TODO: Add actual postcopy differences */
+    VhostUserMsg msg =3D {
+        .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
+        .hdr.flags =3D VHOST_USER_VERSION,
+    };
+
+    if (reply_supported) {
+        msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
+        error_report("Failed preparing vhost-user memory table msg");
+        return -1;
+    }
+
+    fd_num =3D msg.payload.memory.nregions;
+
+    if (!fd_num) {
+        error_report("Failed initializing vhost-user memory map, "
+                     "consider using -object memory-backend-file share=3D=
on");
+        return -1;
+    }
+
+    msg.hdr.size =3D sizeof(msg.payload.memory.nregions);
+    msg.hdr.size +=3D sizeof(msg.payload.memory.padding);
+    msg.hdr.size +=3D fd_num * sizeof(VhostUserMemoryRegion);
+
+    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
+        return -1;
+    }
+
+    if (reply_supported) {
+        return process_message_reply(dev, &msg);
+    }
+
+    return 0;
+}
+
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
+    struct vhost_user *u =3D dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     size_t fd_num;
+    bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported =3D virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
=20
+    if (do_postcopy) {
+        /* Postcopy has enough differences that it's best done in it's o=
wn
+         * version
+         */
+        return vhost_user_set_mem_table_postcopy(dev, mem);
+    }
+
     VhostUserMsg msg =3D {
         .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
         .hdr.flags =3D VHOST_USER_VERSION,
--=20
2.14.3
