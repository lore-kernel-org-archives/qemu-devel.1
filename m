Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z2-0003Dp-HO
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z1-0001aC-CD
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:36 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:18 +0100
Message-Id: <20181212132735.16080-25-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/41] file-posix: Switch to .bdrv_co_ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

No real reason to keep using the callback based mechanism here when the
rest of the file-posix driver is coroutine based. Changing it brings
ioctls more in line with how other request types work.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/scsi/pr-manager.h |  8 +++-----
 block/file-posix.c        | 21 +++++++++++----------
 scsi/pr-manager.c         | 21 +++++++++------------
 scsi/trace-events         |  2 +-
 4 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/include/scsi/pr-manager.h b/include/scsi/pr-manager.h
index 50a77b08fc..6ad5fd1ff7 100644
--- a/include/scsi/pr-manager.h
+++ b/include/scsi/pr-manager.h
@@ -5,6 +5,7 @@
 #include "qapi/visitor.h"
 #include "qom/object_interfaces.h"
 #include "block/aio.h"
+#include "qemu/coroutine.h"
=20
 #define TYPE_PR_MANAGER "pr-manager"
=20
@@ -37,11 +38,8 @@ typedef struct PRManagerClass {
 } PRManagerClass;
=20
 bool pr_manager_is_connected(PRManager *pr_mgr);
-BlockAIOCB *pr_manager_execute(PRManager *pr_mgr,
-                               AioContext *ctx, int fd,
-                               struct sg_io_hdr *hdr,
-                               BlockCompletionFunc *complete,
-                               void *opaque);
+int coroutine_fn pr_manager_execute(PRManager *pr_mgr, AioContext *ctx, =
int fd,
+                                    struct sg_io_hdr *hdr);
=20
 PRManager *pr_manager_lookup(const char *id, Error **errp);
=20
diff --git a/block/file-posix.c b/block/file-posix.c
index c8a085a911..9c15bbe429 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3109,24 +3109,25 @@ hdev_open_Mac_error:
 }
=20
 #if defined(__linux__)
-
-static BlockAIOCB *hdev_aio_ioctl(BlockDriverState *bs,
-        unsigned long int req, void *buf,
-        BlockCompletionFunc *cb, void *opaque)
+static int coroutine_fn
+hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
 {
     BDRVRawState *s =3D bs->opaque;
     RawPosixAIOData *acb;
     ThreadPool *pool;
+    int ret;
=20
-    if (fd_open(bs) < 0)
-        return NULL;
+    ret =3D fd_open(bs);
+    if (ret < 0) {
+        return ret;
+    }
=20
     if (req =3D=3D SG_IO && s->pr_mgr) {
         struct sg_io_hdr *io_hdr =3D buf;
         if (io_hdr->cmdp[0] =3D=3D PERSISTENT_RESERVE_OUT ||
             io_hdr->cmdp[0] =3D=3D PERSISTENT_RESERVE_IN) {
             return pr_manager_execute(s->pr_mgr, bdrv_get_aio_context(bs=
),
-                                      s->fd, io_hdr, cb, opaque);
+                                      s->fd, io_hdr);
         }
     }
=20
@@ -3138,7 +3139,7 @@ static BlockAIOCB *hdev_aio_ioctl(BlockDriverState =
*bs,
     acb->ioctl.buf =3D buf;
     acb->ioctl.cmd =3D req;
     pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
-    return thread_pool_submit_aio(pool, aio_worker, acb, cb, opaque);
+    return thread_pool_submit_co(pool, aio_worker, acb);
 }
 #endif /* linux */
=20
@@ -3279,7 +3280,7 @@ static BlockDriver bdrv_host_device =3D {
=20
     /* generic scsi device */
 #ifdef __linux__
-    .bdrv_aio_ioctl     =3D hdev_aio_ioctl,
+    .bdrv_co_ioctl          =3D hdev_co_ioctl,
 #endif
 };
=20
@@ -3401,7 +3402,7 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_lock_medium   =3D cdrom_lock_medium,
=20
     /* generic scsi device */
-    .bdrv_aio_ioctl     =3D hdev_aio_ioctl,
+    .bdrv_co_ioctl      =3D hdev_co_ioctl,
 };
 #endif /* __linux__ */
=20
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index 2a8f300dde..d9f4e8c3ad 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -48,24 +48,21 @@ static int pr_manager_worker(void *opaque)
 }
=20
=20
-BlockAIOCB *pr_manager_execute(PRManager *pr_mgr,
-                               AioContext *ctx, int fd,
-                               struct sg_io_hdr *hdr,
-                               BlockCompletionFunc *complete,
-                               void *opaque)
+int coroutine_fn pr_manager_execute(PRManager *pr_mgr, AioContext *ctx, =
int fd,
+                                    struct sg_io_hdr *hdr)
 {
-    PRManagerData *data =3D g_new(PRManagerData, 1);
     ThreadPool *pool =3D aio_get_thread_pool(ctx);
+    PRManagerData data =3D {
+        .pr_mgr =3D pr_mgr,
+        .fd     =3D fd,
+        .hdr    =3D hdr,
+    };
=20
-    trace_pr_manager_execute(fd, hdr->cmdp[0], hdr->cmdp[1], opaque);
-    data->pr_mgr =3D pr_mgr;
-    data->fd =3D fd;
-    data->hdr =3D hdr;
+    trace_pr_manager_execute(fd, hdr->cmdp[0], hdr->cmdp[1]);
=20
     /* The matching object_unref is in pr_manager_worker.  */
     object_ref(OBJECT(pr_mgr));
-    return thread_pool_submit_aio(pool, pr_manager_worker,
-                                  data, complete, opaque);
+    return thread_pool_submit_co(pool, pr_manager_worker, &data);
 }
=20
 bool pr_manager_is_connected(PRManager *pr_mgr)
diff --git a/scsi/trace-events b/scsi/trace-events
index 45f5b6e49b..f8a68b11eb 100644
--- a/scsi/trace-events
+++ b/scsi/trace-events
@@ -1,3 +1,3 @@
 # scsi/pr-manager.c
-pr_manager_execute(int fd, int cmd, int sa, void *opaque) "fd=3D%d cmd=3D=
0x%02x service action=3D0x%02x opaque=3D%p"
+pr_manager_execute(int fd, int cmd, int sa) "fd=3D%d cmd=3D0x%02x servic=
e action=3D0x%02x"
 pr_manager_run(int fd, int cmd, int sa) "fd=3D%d cmd=3D0x%02x service ac=
tion=3D0x%02x"
--=20
2.19.2
