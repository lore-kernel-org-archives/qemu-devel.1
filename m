Received: from eggs.gnu.org ([2001:4830:134:3::10]:46081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPY-0006Qt-IA
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPX-0003e7-Ab
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gWPPV-0003dG-W7
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:02 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Dec 2018 17:31:47 +0000
Message-Id: <20181210173151.16629-4-dgilbert@redhat.com>
In-Reply-To: <20181210173151.16629-1-dgilbert@redhat.com>
References: <20181210173151.16629-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 3/7] virtio-fs: Add cache BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, sweil@redhat.com, swhiteho@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a cache BAR into which files will be directly mapped.
The size cacn be set with the cache-size=3D property, e.g.
   -device vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs,cache-size=3D16G

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user-fs.c                  | 16 ++++++++++++++++
 hw/virtio/virtio-pci.c                     | 19 +++++++++++++++++++
 hw/virtio/virtio-pci.h                     |  1 +
 include/hw/virtio/vhost-user-fs.h          |  2 ++
 include/standard-headers/linux/virtio_fs.h |  5 +++++
 5 files changed, 43 insertions(+)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index bc21beeac3..14ee922661 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -195,6 +195,21 @@ static void vuf_device_realize(DeviceState *dev, Err=
or **errp)
                    VIRTQUEUE_MAX_SIZE);
         return;
     }
+    if (!is_power_of_2(fs->conf.cache_size) ||
+        fs->conf.cache_size < sysconf(_SC_PAGESIZE)) {
+        error_setg(errp, "cache-size property must be a power of 2 "
+                         "no smaller than the page size");
+        return;
+    }
+    /* We need a region with some host memory, 'ram' is the easiest */
+    memory_region_init_ram_nomigrate(&fs->cache, OBJECT(vdev),
+                       "virtio-fs-cache",
+                       fs->conf.cache_size, NULL);
+    /* But we don't actually want anyone reading/writing the raw
+     * area with no cache data.
+     */
+    mprotect(memory_region_get_ram_ptr(&fs->cache), fs->conf.cache_size,
+             PROT_NONE);
=20
     fs->vhost_user =3D vhost_user_init();
     if (!fs->vhost_user) {
@@ -263,6 +278,7 @@ static Property vuf_properties[] =3D {
     DEFINE_PROP_UINT16("num-queues", VHostUserFS, conf.num_queues, 1),
     DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 128),
     DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
+    DEFINE_PROP_SIZE("cache-size", VHostUserFS, conf.cache_size, 1ull <<=
 30),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d744f93655..e819a29fb1 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
=20
 #include "standard-headers/linux/virtio_pci.h"
+#include "standard-headers/linux/virtio_fs.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
@@ -2678,9 +2679,27 @@ static void vhost_user_fs_pci_realize(VirtIOPCIPro=
xy *vpci_dev, Error **errp)
 {
     VHostUserFSPCI *dev =3D VHOST_USER_FS_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
+    uint64_t cachesize;
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+    cachesize =3D memory_region_size(&dev->vdev.cache);
+
+    /* The bar starts with the data/DAX cache
+     * Others will be added later.
+     */
+    memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
+                       "vhost-fs-pci-cachebar", cachesize);
+    memory_region_add_subregion(&dev->cachebar, 0, &dev->vdev.cache);
+    virtio_pci_add_shm_cap(vpci_dev, VIRTIO_FS_PCI_CACHE_BAR, 0, cachesi=
ze,
+                           VIRTIO_FS_PCI_SHMCAP_ID_CACHE);
+
+    /* After 'realized' so the memory region exists */
+    pci_register_bar(&vpci_dev->pci_dev, VIRTIO_FS_PCI_CACHE_BAR,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &dev->cachebar);
 }
=20
 static void vhost_user_fs_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index a635dc564c..53b87f245c 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -429,6 +429,7 @@ struct VirtIOCryptoPCI {
 struct VHostUserFSPCI {
     VirtIOPCIProxy parent_obj;
     VHostUserFS vdev;
+    MemoryRegion cachebar;
 };
 #endif
=20
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-=
user-fs.h
index 29629acc54..be153e1c7a 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -29,6 +29,7 @@ typedef struct {
     uint16_t num_queues;
     uint16_t queue_size;
     char *vhostfd;
+    size_t cache_size;
 } VHostUserFSConf;
=20
 typedef struct {
@@ -40,6 +41,7 @@ typedef struct {
     VhostUserState *vhost_user;
=20
     /*< public >*/
+    MemoryRegion cache;
 } VHostUserFS;
=20
 #endif /* _QEMU_VHOST_USER_FS_H */
diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standar=
d-headers/linux/virtio_fs.h
index 4f811a0b70..b5f137ca79 100644
--- a/include/standard-headers/linux/virtio_fs.h
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -38,4 +38,9 @@ struct virtio_fs_config {
 	uint32_t num_queues;
 } QEMU_PACKED;
=20
+#define VIRTIO_FS_PCI_CACHE_BAR 2
+
+/* For the id field in virtio_pci_shm_cap */
+#define VIRTIO_FS_PCI_SHMCAP_ID_CACHE 0
+
 #endif /* _LINUX_VIRTIO_FS_H */
--=20
2.19.2
