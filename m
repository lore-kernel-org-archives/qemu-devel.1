Received: from eggs.gnu.org ([2001:4830:134:3::10]:57398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxTBw-0000a4-Jq
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxTBr-0006Q5-LC
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:29:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxTBr-0006Kw-E9
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:29:31 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Sep 2018 12:29:19 +0400
Message-Id: <20180905082919.6986-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] memory: size can be different from ptr_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, dgilbert@redhat.com, quintela@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

memory_region_init_ram*_ptr() take only the size of the MemoryRegion,
and allocate a RAMBlock with the same size. However, it may be
convenient to expose a smaller MemoryRegion (for ex: a few bytes) than
the RAMBlock (which must be a multiple of TARGET_PAGE_SIZE).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/exec/memory.h  |  8 ++++++--
 exec.c                 |  3 +++
 hw/display/g364fb.c    |  2 +-
 hw/vfio/common.c       |  3 ++-
 hw/virtio/vhost-user.c |  2 +-
 memory.c               | 10 ++++++----
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index eb4f2fb249..03f257829b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -700,6 +700,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
+ * @ptr_size: size of @ptr buffer
  *
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the c=
aller.
@@ -708,7 +709,8 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 struct Object *owner,
                                 const char *name,
                                 uint64_t size,
-                                void *ptr);
+                                void *ptr,
+                                uint64_t ptr_size);
=20
 /**
  * memory_region_init_ram_device_ptr:  Initialize RAM device memory regi=
on from
@@ -727,6 +729,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
  * @name: the name of the region.
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
+ * @ptr_size: size of @ptr buffer
  *
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the c=
aller.
@@ -736,7 +739,8 @@ void memory_region_init_ram_device_ptr(MemoryRegion *=
mr,
                                        struct Object *owner,
                                        const char *name,
                                        uint64_t size,
-                                       void *ptr);
+                                       void *ptr,
+                                       uint64_t ptr_size);
=20
 /**
  * memory_region_init_alias: Initialize a memory region that aliases all=
 or a
diff --git a/exec.c b/exec.c
index 6826c8337d..fcea614e79 100644
--- a/exec.c
+++ b/exec.c
@@ -2361,6 +2361,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, =
ram_addr_t max_size,
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                    MemoryRegion *mr, Error **errp)
 {
+    assert(size >=3D TARGET_PAGE_SIZE);
+    assert(size % TARGET_PAGE_SIZE =3D=3D 0);
+
     return qemu_ram_alloc_internal(size, size, NULL, host, false,
                                    false, mr, errp);
 }
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index fbc2b2422d..f4f5643761 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -475,7 +475,7 @@ static void g364fb_init(DeviceState *dev, G364State *=
s)
=20
     memory_region_init_io(&s->mem_ctrl, NULL, &g364fb_ctrl_ops, s, "ctrl=
", 0x180000);
     memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram",
-                               s->vram_size, s->vram);
+                               s->vram_size, s->vram, s->vram_size);
     vmstate_register_ram(&s->mem_vram, dev);
     memory_region_set_log(&s->mem_vram, true, DIRTY_MEMORY_VGA);
 }
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c185e5a2e..e5dfbbafe3 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -854,7 +854,8 @@ int vfio_region_mmap(VFIORegion *region)
         memory_region_init_ram_device_ptr(&region->mmaps[i].mem,
                                           memory_region_owner(region->me=
m),
                                           name, region->mmaps[i].size,
-                                          region->mmaps[i].mmap);
+                                          region->mmaps[i].mmap,
+                                          region->mmaps[i].size);
         g_free(name);
         memory_region_add_subregion(region->mem, region->mmaps[i].offset=
,
                                     &region->mmaps[i].mem);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b041343632..3abe960f29 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -935,7 +935,7 @@ static int vhost_user_slave_handle_vring_host_notifie=
r(struct vhost_dev *dev,
     name =3D g_strdup_printf("vhost-user/host-notifier@%p mmaps[%d]",
                            user, queue_idx);
     memory_region_init_ram_device_ptr(&n->mr, OBJECT(vdev), name,
-                                      page_size, addr);
+                                      page_size, addr, page_size);
     g_free(name);
=20
     if (virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, true)=
) {
diff --git a/memory.c b/memory.c
index 9b73892768..07f8458d38 100644
--- a/memory.c
+++ b/memory.c
@@ -1587,7 +1587,8 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 Object *owner,
                                 const char *name,
                                 uint64_t size,
-                                void *ptr)
+                                void *ptr,
+                                uint64_t ptr_size)
 {
     memory_region_init(mr, owner, name, size);
     mr->ram =3D true;
@@ -1597,16 +1598,17 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
=20
     /* qemu_ram_alloc_from_ptr cannot fail with ptr !=3D NULL.  */
     assert(ptr !=3D NULL);
-    mr->ram_block =3D qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fata=
l);
+    mr->ram_block =3D qemu_ram_alloc_from_ptr(ptr_size, ptr, mr, &error_=
fatal);
 }
=20
 void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
                                        uint64_t size,
-                                       void *ptr)
+                                       void *ptr,
+                                       uint64_t ptr_size)
 {
-    memory_region_init_ram_ptr(mr, owner, name, size, ptr);
+    memory_region_init_ram_ptr(mr, owner, name, size, ptr, ptr_size);
     mr->ram_device =3D true;
     mr->ops =3D &ram_device_mem_ops;
     mr->opaque =3D mr;
--=20
2.19.0.rc1
