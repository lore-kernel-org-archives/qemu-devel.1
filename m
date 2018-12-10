Received: from eggs.gnu.org ([2001:4830:134:3::10]:46114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPb-0006TQ-GJ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPY-0003ek-9F
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gWPPX-0003eM-Ur
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:04 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Dec 2018 17:31:49 +0000
Message-Id: <20181210173151.16629-6-dgilbert@redhat.com>
In-Reply-To: <20181210173151.16629-1-dgilbert@redhat.com>
References: <20181210173151.16629-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 5/7] virtio-fs: Fill in slave commands for
 mapping
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

Fill in definitions for map, unmap and sync commands.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user-fs.c | 129 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index da70d9cd2c..bbb15477e5 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -24,20 +24,137 @@
 int vhost_user_fs_slave_map(struct vhost_dev *dev, VhostUserFSSlaveMsg *=
sm,
                             int fd)
 {
-    /* TODO */
-    return -1;
+    VHostUserFS *fs =3D VHOST_USER_FS(dev->vdev);
+    size_t cache_size =3D fs->conf.cache_size;
+    void *cache_host =3D memory_region_get_ram_ptr(&fs->cache);
+
+    unsigned int i;
+    int res =3D 0;
+
+    if (fd < 0) {
+        fprintf(stderr, "%s: Bad fd for map\n", __func__);
+        return -1;
+    }
+
+    for (i =3D 0; i < VHOST_USER_FS_SLAVE_ENTRIES; i++) {
+        if (sm->len[i] =3D=3D 0) {
+            continue;
+        }
+
+        if ((sm->c_offset[i] + sm->len[i]) < sm->len[i] ||
+            (sm->c_offset[i] + sm->len[i]) > cache_size) {
+            fprintf(stderr, "%s: Bad offset/len for map [%d] %"
+                            PRIx64 "+%" PRIx64 "\n", __func__,
+                            i, sm->c_offset[i], sm->len[i]);
+            res =3D -1;
+            break;
+        }
+
+        if (mmap(cache_host + sm->c_offset[i], sm->len[i],
+                 ((sm->flags[i] & VHOST_USER_FS_FLAG_MAP_R) ? PROT_READ =
: 0) |
+                 ((sm->flags[i] & VHOST_USER_FS_FLAG_MAP_W) ? PROT_WRITE=
 : 0),
+                 MAP_SHARED | MAP_FIXED,
+                 fd, sm->fd_offset[i]) !=3D (cache_host + sm->c_offset[i=
])) {
+            fprintf(stderr, "%s: map failed err %d [%d] %"
+                            PRIx64 "+%" PRIx64 " from %" PRIx64 "\n", __=
func__,
+                            errno, i, sm->c_offset[i], sm->len[i],
+                            sm->fd_offset[i]);
+            res =3D -1;
+            break;
+        }
+    }
+
+    if (res) {
+        /* Something went wrong, unmap them all */
+        vhost_user_fs_slave_unmap(dev, sm);
+    }
+    return res;
 }
=20
 int vhost_user_fs_slave_unmap(struct vhost_dev *dev, VhostUserFSSlaveMsg=
 *sm)
 {
-    /* TODO */
-    return -1;
+    VHostUserFS *fs =3D VHOST_USER_FS(dev->vdev);
+    size_t cache_size =3D fs->conf.cache_size;
+    void *cache_host =3D memory_region_get_ram_ptr(&fs->cache);
+
+    unsigned int i;
+    int res =3D 0;
+
+    /* Note even if one unmap fails we try the rest, since the effect
+     * is to clean up as much as possible.
+     */
+    for (i =3D 0; i < VHOST_USER_FS_SLAVE_ENTRIES; i++) {
+        void *ptr;
+        if (sm->len[i] =3D=3D 0) {
+            continue;
+        }
+
+        if (sm->len[i] =3D=3D ~(uint64_t)0) {
+            /* Special case meaning the whole arena */
+            sm->len[i] =3D cache_size;
+        }
+
+        if ((sm->c_offset[i] + sm->len[i]) < sm->len[i] ||
+            (sm->c_offset[i] + sm->len[i]) > cache_size) {
+            fprintf(stderr, "%s: Bad offset/len for unmap [%d] %"
+                            PRIx64 "+%" PRIx64 "\n", __func__,
+                            i, sm->c_offset[i], sm->len[i]);
+            res =3D -1;
+            continue;
+        }
+
+        ptr =3D mmap(cache_host + sm->c_offset[i], sm->len[i],
+                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, =
0);
+        if (ptr !=3D (cache_host + sm->c_offset[i])) {
+            fprintf(stderr, "%s: mmap failed (%s) [%d] %"
+                            PRIx64 "+%" PRIx64 " from %" PRIx64 " res: %=
p\n",
+                            __func__,
+                            strerror(errno),
+                            i, sm->c_offset[i], sm->len[i],
+                            sm->fd_offset[i], ptr);
+            res =3D -1;
+        }
+    }
+
+    return res;
 }
=20
 int vhost_user_fs_slave_sync(struct vhost_dev *dev, VhostUserFSSlaveMsg =
*sm)
 {
-    /* TODO */
-    return -1;
+    VHostUserFS *fs =3D VHOST_USER_FS(dev->vdev);
+    size_t cache_size =3D fs->conf.cache_size;
+    void *cache_host =3D memory_region_get_ram_ptr(&fs->cache);
+
+    unsigned int i;
+    int res =3D 0;
+
+    /* Note even if one sync fails we try the rest */
+    for (i =3D 0; i < VHOST_USER_FS_SLAVE_ENTRIES; i++) {
+        if (sm->len[i] =3D=3D 0) {
+            continue;
+        }
+
+        if ((sm->c_offset[i] + sm->len[i]) < sm->len[i] ||
+            (sm->c_offset[i] + sm->len[i]) > cache_size) {
+            fprintf(stderr, "%s: Bad offset/len for sync [%d] %"
+                            PRIx64 "+%" PRIx64 "\n", __func__,
+                            i, sm->c_offset[i], sm->len[i]);
+            res =3D -1;
+            continue;
+        }
+
+        if (msync(cache_host + sm->c_offset[i], sm->len[i],
+                  MS_SYNC /* ?? */)) {
+            fprintf(stderr, "%s: msync failed (%s) [%d] %"
+                            PRIx64 "+%" PRIx64 " from %" PRIx64 "\n", __=
func__,
+                            strerror(errno),
+                            i, sm->c_offset[i], sm->len[i],
+                            sm->fd_offset[i]);
+            res =3D -1;
+        }
+    }
+
+    return res;
 }
=20
=20
--=20
2.19.2
