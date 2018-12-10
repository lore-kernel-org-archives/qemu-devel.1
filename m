Received: from eggs.gnu.org ([2001:4830:134:3::10]:46137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPd-0006VQ-BG
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPb-0003gT-NQ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gWPPb-0003fx-B5
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:07 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Dec 2018 17:31:51 +0000
Message-Id: <20181210173151.16629-8-dgilbert@redhat.com>
In-Reply-To: <20181210173151.16629-1-dgilbert@redhat.com>
References: <20181210173151.16629-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 7/7] virtio-fs: Allow mapping of journal
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

The 'journal' is a shared block of RAM between QEMU and it's
fuse daemon.  It's typically a shmfs file and it's specified as:

-device
vhost-user-fs-pci,chardev=3Dchar0,tag=3Dmyfs,cache-size=3D1G,versiontable=
=3D/dev/shm/mdvt1,journal=3D/dev/shm/journal1

It gets mapped into the PCI bar after the version table.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user-fs.c                  | 35 ++++++++++++++++++++--
 hw/virtio/virtio-pci.c                     | 14 ++++++++-
 include/hw/virtio/vhost-user-fs.h          |  4 +++
 include/standard-headers/linux/virtio_fs.h |  1 +
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index a39ecd3a16..b263f43c60 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -297,6 +297,7 @@ static void vuf_device_realize(DeviceState *dev, Erro=
r **errp)
     size_t len;
     int ret;
     int mdvtfd =3D -1;
+    int journalfd =3D -1;
=20
     if (!fs->conf.chardev.chr) {
         error_setg(errp, "missing chardev");
@@ -361,8 +362,31 @@ static void vuf_device_realize(DeviceState *dev, Err=
or **errp)
=20
         fs->mdvt_size =3D statbuf.st_size;
     }
-    fprintf(stderr, "%s: cachesize=3D%zd mdvt_size=3D%zd\n", __func__,
-            fs->conf.cache_size, fs->mdvt_size);
+    if (fs->conf.journalpath) {
+        struct stat statbuf;
+
+        journalfd =3D open(fs->conf.journalpath, O_RDWR);
+        if (journalfd < 0) {
+            error_setg_errno(errp, errno,
+                             "Failed to open journal '%s'",
+                             fs->conf.journalpath);
+
+            close(mdvtfd);
+            return;
+        }
+        if (fstat(journalfd, &statbuf) =3D=3D -1) {
+            error_setg_errno(errp, errno,
+                             "Failed to stat journal '%s'",
+                             fs->conf.journalpath);
+            close(mdvtfd);
+            close(journalfd);
+            return;
+        }
+
+        fs->journal_size =3D statbuf.st_size;
+    }
+    fprintf(stderr, "%s: cachesize=3D%zd mdvt_size=3D%zd journal_size=3D=
%zd\n",
+            __func__, fs->conf.cache_size, fs->mdvt_size, fs->journal_si=
ze);
=20
     /* We need a region with some host memory, 'ram' is the easiest */
     memory_region_init_ram_nomigrate(&fs->cache, OBJECT(vdev),
@@ -383,6 +407,12 @@ static void vuf_device_realize(DeviceState *dev, Err=
or **errp)
         memory_region_set_readonly(&fs->mdvt, true);
     }
=20
+    if (journalfd) {
+        memory_region_init_ram_from_fd(&fs->journal, OBJECT(vdev),
+                       "virtio-fs-journal",
+                       fs->journal_size, true, journalfd, NULL);
+    }
+
     fs->vhost_user =3D vhost_user_init();
     if (!fs->vhost_user) {
         error_setg(errp, "failed to initialize vhost-user");
@@ -452,6 +482,7 @@ static Property vuf_properties[] =3D {
     DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
     DEFINE_PROP_SIZE("cache-size", VHostUserFS, conf.cache_size, 1ull <<=
 30),
     DEFINE_PROP_STRING("versiontable", VHostUserFS, conf.mdvtpath),
+    DEFINE_PROP_STRING("journal", VHostUserFS, conf.journalpath),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d8785b78bf..a46dd5a784 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2687,10 +2687,12 @@ static void vhost_user_fs_pci_realize(VirtIOPCIPr=
oxy *vpci_dev, Error **errp)
     cachesize =3D memory_region_size(&dev->vdev.cache);
=20
     /* PCIe bar needs to be a power of 2 */
-    totalsize =3D pow2ceil(cachesize + dev->vdev.mdvt_size);
+    totalsize =3D pow2ceil(cachesize + dev->vdev.mdvt_size +
+                         dev->vdev.journal_size);
=20
     /* The bar starts with the data/DAX cache
      * followed by the metadata cache.
+     * followed by the journal
      */
     memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
                        "vhost-fs-pci-cachebar", totalsize);
@@ -2706,6 +2708,16 @@ static void vhost_user_fs_pci_realize(VirtIOPCIPro=
xy *vpci_dev, Error **errp)
                                VIRTIO_FS_PCI_SHMCAP_ID_VERTAB);
     }
=20
+    if (dev->vdev.journal_size) {
+        memory_region_add_subregion(&dev->cachebar,
+                                    cachesize + dev->vdev.mdvt_size,
+                                    &dev->vdev.journal);
+        virtio_pci_add_shm_cap(vpci_dev, VIRTIO_FS_PCI_CACHE_BAR,
+                               cachesize + dev->vdev.mdvt_size,
+                               dev->vdev.journal_size,
+                               VIRTIO_FS_PCI_SHMCAP_ID_JOURNAL);
+    }
+
     /* After 'realized' so the memory region exists */
     pci_register_bar(&vpci_dev->pci_dev, VIRTIO_FS_PCI_CACHE_BAR,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-=
user-fs.h
index 281ae0a52d..6d9f74a543 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -49,6 +49,7 @@ typedef struct {
     char *vhostfd;
     size_t cache_size;
     char *mdvtpath;
+    char *journalpath;
 } VHostUserFSConf;
=20
 typedef struct {
@@ -64,6 +65,9 @@ typedef struct {
     /* Metadata version table */
     size_t mdvt_size;
     MemoryRegion mdvt;
+    /* Journal */
+    size_t journal_size;
+    MemoryRegion journal;
 } VHostUserFS;
=20
 /* Callbacks from the vhost-user code for slave commands */
diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standar=
d-headers/linux/virtio_fs.h
index 77fa651073..0242f2a06e 100644
--- a/include/standard-headers/linux/virtio_fs.h
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -43,5 +43,6 @@ struct virtio_fs_config {
 /* For the id field in virtio_pci_shm_cap */
 #define VIRTIO_FS_PCI_SHMCAP_ID_CACHE 0
 #define VIRTIO_FS_PCI_SHMCAP_ID_VERTAB 1
+#define VIRTIO_FS_PCI_SHMCAP_ID_JOURNAL 2
=20
 #endif /* _LINUX_VIRTIO_FS_H */
--=20
2.19.2
