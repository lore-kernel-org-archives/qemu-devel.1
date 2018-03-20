Received: from eggs.gnu.org ([2001:4830:134:3::10]:51133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mZ-0006v9-Q1
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mY-0008KK-Ds
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mY-0008K9-7O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:50 -0400
Date: Tue, 20 Mar 2018 05:17:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-34-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 33/50] postcopy+vhost-user: Split
 set_mem_table for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Split the set_mem_table routines in both qemu and libvhost-user
because the postcopy versions are going to be quite different
once changes in the later patches are added. However, this patch
doesn't produce any functional change, just the split.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 53 ++++++++++++++++++++++++
 hw/virtio/vhost-user.c                | 77 +++++++++++++++++++++++++++++=
+++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index e53b195..b2de8ed 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -449,6 +449,55 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
 }
=20
 static bool
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
+static bool
 vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
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
index c3ab299..b6757eb 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -340,15 +340,86 @@ static int vhost_user_set_log_base(struct vhost_dev=
 *dev, uint64_t base,
     return 0;
 }
=20
+static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
+                                             struct vhost_memory *mem)
+{
+    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int i, fd;
+    size_t fd_num =3D 0;
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
+    for (i =3D 0; i < dev->mem->nregions; ++i) {
+        struct vhost_memory_region *reg =3D dev->mem->regions + i;
+        ram_addr_t offset;
+        MemoryRegion *mr;
+
+        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
+        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace=
_addr,
+                                     &offset);
+        fd =3D memory_region_get_fd(mr);
+        if (fd > 0) {
+            msg.payload.memory.regions[fd_num].userspace_addr =3D
+                reg->userspace_addr;
+            msg.payload.memory.regions[fd_num].memory_size  =3D reg->mem=
ory_size;
+            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
+                reg->guest_phys_addr;
+            msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
+            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
+            fds[fd_num++] =3D fd;
+        }
+    }
+
+    msg.payload.memory.nregions =3D fd_num;
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
     int i, fd;
     size_t fd_num =3D 0;
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
@@ -372,9 +443,11 @@ static int vhost_user_set_mem_table(struct vhost_dev=
 *dev,
                 error_report("Failed preparing vhost-user memory table m=
sg");
                 return -1;
             }
-            msg.payload.memory.regions[fd_num].userspace_addr =3D reg->u=
serspace_addr;
+            msg.payload.memory.regions[fd_num].userspace_addr =3D
+                reg->userspace_addr;
             msg.payload.memory.regions[fd_num].memory_size  =3D reg->mem=
ory_size;
-            msg.payload.memory.regions[fd_num].guest_phys_addr =3D reg->=
guest_phys_addr;
+            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
+                reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
             fds[fd_num++] =3D fd;
         }
--=20
MST
