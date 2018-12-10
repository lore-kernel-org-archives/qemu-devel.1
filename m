Received: from eggs.gnu.org ([2001:4830:134:3::10]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPZ-0006RJ-0p
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWPPX-0003eS-Ix
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gWPPX-0003dh-9f
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:32:03 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Dec 2018 17:31:48 +0000
Message-Id: <20181210173151.16629-5-dgilbert@redhat.com>
In-Reply-To: <20181210173151.16629-1-dgilbert@redhat.com>
References: <20181210173151.16629-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 4/7] virtio-fs: Add vhost-user slave
 commands for mapping
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

The daemon may request that fd's be mapped into the virtio-fs cache
visible to the guest.
These mappings are triggered by commands sent over the slave fd
from the daemon.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  3 +++
 docs/interop/vhost-user.txt           | 35 +++++++++++++++++++++++++++
 hw/virtio/vhost-user-fs.c             | 20 +++++++++++++++
 hw/virtio/vhost-user.c                | 16 ++++++++++++
 include/hw/virtio/vhost-user-fs.h     | 24 ++++++++++++++++++
 5 files changed, 98 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 4aa55b4d2d..6cff0ff189 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -99,6 +99,9 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_IOTLB_MSG =3D 1,
     VHOST_USER_SLAVE_CONFIG_CHANGE_MSG =3D 2,
     VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG =3D 3,
+    VHOST_USER_SLAVE_FS_MAP =3D 4,
+    VHOST_USER_SLAVE_FS_UNMAP =3D 5,
+    VHOST_USER_SLAVE_FS_SYNC =3D 6,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
=20
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index c2194711d9..29cdd74523 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -815,6 +815,41 @@ Slave message types
       This request should be sent only when VHOST_USER_PROTOCOL_F_HOST_N=
OTIFIER
       protocol feature has been successfully negotiated.
=20
+ * VHOST_USER_SLAVE_FS_MAP
+
+      Id: 4
+      Equivalent ioctl: N/A
+      Slave payload: fd + n * (offset + address + len)
+      Master payload: N/A
+
+      Requests that the QEMU mmap the given fd into the virtio-fs cache;
+      multiple chunks can be mapped in one command.
+      A reply is generated indicating whether mapping succeeded.
+
+ * VHOST_USER_SLAVE_FS_UNMAP
+
+      Id: 5
+      Equivalent ioctl: N/A
+      Slave payload: n * (address + len)
+      Master payload: N/A
+
+      Requests that the QEMU un-mmap the given range in the virtio-fs ca=
che;
+      multiple chunks can be unmapped in one command.
+      A reply is generated indicating whether unmapping succeeded.
+
+ * VHOST_USER_SLAVE_FS_SYNC
+
+      Id: 6
+      Equivalent ioctl: N/A
+      Slave payload: n * (address + len)
+      Master payload: N/A
+
+      Requests that the QEMU causes any changes to the virtio-fs cache t=
o
+      be synchronised with the backing files.  Multiple chunks can be sy=
nced
+      in one command.
+      A reply is generated indicating whether syncing succeeded.
+      [Semantic details TBD]
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 14ee922661..da70d9cd2c 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -21,6 +21,26 @@
 #include "hw/virtio/vhost-user-fs.h"
 #include "monitor/monitor.h"
=20
+int vhost_user_fs_slave_map(struct vhost_dev *dev, VhostUserFSSlaveMsg *=
sm,
+                            int fd)
+{
+    /* TODO */
+    return -1;
+}
+
+int vhost_user_fs_slave_unmap(struct vhost_dev *dev, VhostUserFSSlaveMsg=
 *sm)
+{
+    /* TODO */
+    return -1;
+}
+
+int vhost_user_fs_slave_sync(struct vhost_dev *dev, VhostUserFSSlaveMsg =
*sm)
+{
+    /* TODO */
+    return -1;
+}
+
+
 static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VHostUserFS *fs =3D VHOST_USER_FS(vdev);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e09bed0e4a..beb028c7e2 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-fs.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-net.h"
@@ -97,6 +98,9 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_IOTLB_MSG =3D 1,
     VHOST_USER_SLAVE_CONFIG_CHANGE_MSG =3D 2,
     VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG =3D 3,
+    VHOST_USER_SLAVE_FS_MAP =3D 4,
+    VHOST_USER_SLAVE_FS_UNMAP =3D 5,
+    VHOST_USER_SLAVE_FS_SYNC =3D 6,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
=20
@@ -169,6 +173,7 @@ typedef union {
         VhostUserConfig config;
         VhostUserCryptoSession session;
         VhostUserVringArea area;
+        VhostUserFSSlaveMsg fs;
 } VhostUserPayload;
=20
 typedef struct VhostUserMsg {
@@ -1010,6 +1015,17 @@ static void slave_read(void *opaque)
         ret =3D vhost_user_slave_handle_vring_host_notifier(dev, &payloa=
d.area,
                                                           fd[0]);
         break;
+#ifdef CONFIG_VHOST_USER_FS
+    case VHOST_USER_SLAVE_FS_MAP:
+        ret =3D vhost_user_fs_slave_map(dev, &payload.fs, fd[0]);
+        break;
+    case VHOST_USER_SLAVE_FS_UNMAP:
+        ret =3D vhost_user_fs_slave_unmap(dev, &payload.fs);
+        break;
+    case VHOST_USER_SLAVE_FS_SYNC:
+        ret =3D vhost_user_fs_slave_sync(dev, &payload.fs);
+        break;
+#endif
     default:
         error_report("Received unexpected msg type.");
         ret =3D -EINVAL;
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-=
user-fs.h
index be153e1c7a..9989bcd9e7 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -23,6 +23,24 @@
 #define VHOST_USER_FS(obj) \
         OBJECT_CHECK(VHostUserFS, (obj), TYPE_VHOST_USER_FS)
=20
+/* Structures carried over the slave channel back to QEMU */
+#define VHOST_USER_FS_SLAVE_ENTRIES 8
+
+/* For the flags field of VhostUserFSSlaveMsg */
+#define VHOST_USER_FS_FLAG_MAP_R (1ull << 0)
+#define VHOST_USER_FS_FLAG_MAP_W (1ull << 1)
+
+typedef struct {
+    /* Offsets within the file being mapped */
+    uint64_t fd_offset[VHOST_USER_FS_SLAVE_ENTRIES];
+    /* Offsets within the cache */
+    uint64_t c_offset[VHOST_USER_FS_SLAVE_ENTRIES];
+    /* Lengths of sections */
+    uint64_t len[VHOST_USER_FS_SLAVE_ENTRIES];
+    /* Flags, from VHOST_USER_FS_FLAG_* */
+    uint64_t flags[VHOST_USER_FS_SLAVE_ENTRIES];
+} VhostUserFSSlaveMsg;
+
 typedef struct {
     CharBackend chardev;
     char *tag;
@@ -44,4 +62,10 @@ typedef struct {
     MemoryRegion cache;
 } VHostUserFS;
=20
+/* Callbacks from the vhost-user code for slave commands */
+int vhost_user_fs_slave_map(struct vhost_dev *dev, VhostUserFSSlaveMsg *=
sm,
+                            int fd);
+int vhost_user_fs_slave_unmap(struct vhost_dev *dev, VhostUserFSSlaveMsg=
 *sm);
+int vhost_user_fs_slave_sync(struct vhost_dev *dev, VhostUserFSSlaveMsg =
*sm);
+
 #endif /* _QEMU_VHOST_USER_FS_H */
--=20
2.19.2
