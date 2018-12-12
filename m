Received: from eggs.gnu.org ([2001:4830:134:3::10]:46236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yk-0002nU-8O
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yi-0001KC-Ty
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:18 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:08 +0100
Message-Id: <20181212132735.16080-15-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/41] file-posix: Reorganise RawPosixAIOData
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

RawPosixAIOData contains a lot of fields for several separate operations
that are to be processed in a worker thread and that need different
parameters. The struct is currently rather unorganised, with unions that
cover some, but not all operations, and even one #define for field names
instead of a union.

Clean this up to have some common fields and a single union. As a side
effect, on x86_64 the struct shrinks from 72 to 48 bytes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 89 +++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bbdab953..d0102a7ec0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -182,25 +182,29 @@ static int64_t raw_getlength(BlockDriverState *bs);
=20
 typedef struct RawPosixAIOData {
     BlockDriverState *bs;
+    int aio_type;
     int aio_fildes;
-    union {
-        struct iovec *aio_iov;
-        void *aio_ioctl_buf;
-    };
-    int aio_niov;
-    uint64_t aio_nbytes;
-#define aio_ioctl_cmd   aio_nbytes /* for QEMU_AIO_IOCTL */
+
     off_t aio_offset;
-    int aio_type;
+    uint64_t aio_nbytes;
+
     union {
+        struct {
+            struct iovec *iov;
+            int niov;
+        } io;
+        struct {
+            uint64_t cmd;
+            void *buf;
+        } ioctl;
         struct {
             int aio_fd2;
             off_t aio_offset2;
-        };
+        } copy_range;
         struct {
             PreallocMode prealloc;
             Error **errp;
-        };
+        } truncate;
     };
 } RawPosixAIOData;
=20
@@ -1152,7 +1156,7 @@ static ssize_t handle_aiocb_ioctl(RawPosixAIOData *=
aiocb)
 {
     int ret;
=20
-    ret =3D ioctl(aiocb->aio_fildes, aiocb->aio_ioctl_cmd, aiocb->aio_io=
ctl_buf);
+    ret =3D ioctl(aiocb->aio_fildes, aiocb->ioctl.cmd, aiocb->ioctl.buf)=
;
     if (ret =3D=3D -1) {
         return -errno;
     }
@@ -1233,13 +1237,13 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIO=
Data *aiocb)
     do {
         if (aiocb->aio_type & QEMU_AIO_WRITE)
             len =3D qemu_pwritev(aiocb->aio_fildes,
-                               aiocb->aio_iov,
-                               aiocb->aio_niov,
+                               aiocb->io.iov,
+                               aiocb->io.niov,
                                aiocb->aio_offset);
          else
             len =3D qemu_preadv(aiocb->aio_fildes,
-                              aiocb->aio_iov,
-                              aiocb->aio_niov,
+                              aiocb->io.iov,
+                              aiocb->io.niov,
                               aiocb->aio_offset);
     } while (len =3D=3D -1 && errno =3D=3D EINTR);
=20
@@ -1305,8 +1309,8 @@ static ssize_t handle_aiocb_rw(RawPosixAIOData *aio=
cb)
          * If there is just a single buffer, and it is properly aligned
          * we can just use plain pread/pwrite without any problems.
          */
-        if (aiocb->aio_niov =3D=3D 1) {
-             return handle_aiocb_rw_linear(aiocb, aiocb->aio_iov->iov_ba=
se);
+        if (aiocb->io.niov =3D=3D 1) {
+            return handle_aiocb_rw_linear(aiocb, aiocb->io.iov->iov_base=
);
         }
         /*
          * We have more than one iovec, and all are properly aligned.
@@ -1343,9 +1347,9 @@ static ssize_t handle_aiocb_rw(RawPosixAIOData *aio=
cb)
         char *p =3D buf;
         int i;
=20
-        for (i =3D 0; i < aiocb->aio_niov; ++i) {
-            memcpy(p, aiocb->aio_iov[i].iov_base, aiocb->aio_iov[i].iov_=
len);
-            p +=3D aiocb->aio_iov[i].iov_len;
+        for (i =3D 0; i < aiocb->io.niov; ++i) {
+            memcpy(p, aiocb->io.iov[i].iov_base, aiocb->io.iov[i].iov_le=
n);
+            p +=3D aiocb->io.iov[i].iov_len;
         }
         assert(p - buf =3D=3D aiocb->aio_nbytes);
     }
@@ -1356,12 +1360,12 @@ static ssize_t handle_aiocb_rw(RawPosixAIOData *a=
iocb)
         size_t count =3D aiocb->aio_nbytes, copy;
         int i;
=20
-        for (i =3D 0; i < aiocb->aio_niov && count; ++i) {
+        for (i =3D 0; i < aiocb->io.niov && count; ++i) {
             copy =3D count;
-            if (copy > aiocb->aio_iov[i].iov_len) {
-                copy =3D aiocb->aio_iov[i].iov_len;
+            if (copy > aiocb->io.iov[i].iov_len) {
+                copy =3D aiocb->io.iov[i].iov_len;
             }
-            memcpy(aiocb->aio_iov[i].iov_base, p, copy);
+            memcpy(aiocb->io.iov[i].iov_base, p, copy);
             assert(count >=3D copy);
             p     +=3D copy;
             count -=3D copy;
@@ -1572,14 +1576,15 @@ static ssize_t handle_aiocb_copy_range(RawPosixAI=
OData *aiocb)
 {
     uint64_t bytes =3D aiocb->aio_nbytes;
     off_t in_off =3D aiocb->aio_offset;
-    off_t out_off =3D aiocb->aio_offset2;
+    off_t out_off =3D aiocb->copy_range.aio_offset2;
=20
     while (bytes) {
         ssize_t ret =3D copy_file_range(aiocb->aio_fildes, &in_off,
-                                      aiocb->aio_fd2, &out_off,
+                                      aiocb->copy_range.aio_fd2, &out_of=
f,
                                       bytes, 0);
         trace_file_copy_file_range(aiocb->bs, aiocb->aio_fildes, in_off,
-                                   aiocb->aio_fd2, out_off, bytes, 0, re=
t);
+                                   aiocb->copy_range.aio_fd2, out_off, b=
ytes,
+                                   0, ret);
         if (ret =3D=3D 0) {
             /* No progress (e.g. when beyond EOF), let the caller fall b=
ack to
              * buffer I/O. */
@@ -1648,7 +1653,8 @@ static int handle_aiocb_truncate(RawPosixAIOData *a=
iocb)
     struct stat st;
     int fd =3D aiocb->aio_fildes;
     int64_t offset =3D aiocb->aio_offset;
-    Error **errp =3D aiocb->errp;
+    PreallocMode prealloc =3D aiocb->truncate.prealloc;
+    Error **errp =3D aiocb->truncate.errp;
=20
     if (fstat(fd, &st) < 0) {
         result =3D -errno;
@@ -1657,12 +1663,12 @@ static int handle_aiocb_truncate(RawPosixAIOData =
*aiocb)
     }
=20
     current_length =3D st.st_size;
-    if (current_length > offset && aiocb->prealloc !=3D PREALLOC_MODE_OF=
F) {
+    if (current_length > offset && prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Cannot use preallocation for shrinking files")=
;
         return -ENOTSUP;
     }
=20
-    switch (aiocb->prealloc) {
+    switch (prealloc) {
 #ifdef CONFIG_POSIX_FALLOCATE
     case PREALLOC_MODE_FALLOC:
         /*
@@ -1743,7 +1749,7 @@ static int handle_aiocb_truncate(RawPosixAIOData *a=
iocb)
     default:
         result =3D -ENOTSUP;
         error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_str(aiocb->prealloc));
+                   PreallocMode_str(prealloc));
         return result;
     }
=20
@@ -1768,7 +1774,7 @@ static int aio_worker(void *arg)
     case QEMU_AIO_READ:
         ret =3D handle_aiocb_rw(aiocb);
         if (ret >=3D 0 && ret < aiocb->aio_nbytes) {
-            iov_memset(aiocb->aio_iov, aiocb->aio_niov, ret,
+            iov_memset(aiocb->io.iov, aiocb->io.niov, ret,
                       0, aiocb->aio_nbytes - ret);
=20
             ret =3D aiocb->aio_nbytes;
@@ -1829,16 +1835,17 @@ static int paio_submit_co_full(BlockDriverState *=
bs, int fd,
     acb->bs =3D bs;
     acb->aio_type =3D type;
     acb->aio_fildes =3D fd;
-    acb->aio_fd2 =3D fd2;
-    acb->aio_offset2 =3D offset2;
=20
     acb->aio_nbytes =3D bytes;
     acb->aio_offset =3D offset;
=20
     if (qiov) {
-        acb->aio_iov =3D qiov->iov;
-        acb->aio_niov =3D qiov->niov;
+        acb->io.iov =3D qiov->iov;
+        acb->io.niov =3D qiov->niov;
         assert(qiov->size =3D=3D bytes);
+    } else {
+        acb->copy_range.aio_fd2 =3D fd2;
+        acb->copy_range.aio_offset2 =3D offset2;
     }
=20
     trace_file_paio_submit_co(offset, bytes, type);
@@ -1976,8 +1983,10 @@ raw_regular_truncate(BlockDriverState *bs, int fd,=
 int64_t offset,
         .aio_fildes     =3D fd,
         .aio_type       =3D QEMU_AIO_TRUNCATE,
         .aio_offset     =3D offset,
-        .prealloc       =3D prealloc,
-        .errp           =3D errp,
+        .truncate       =3D {
+            .prealloc       =3D prealloc,
+            .errp           =3D errp,
+        },
     };
=20
     /* @bs can be NULL, bdrv_get_aio_context() returns the main context =
then */
@@ -3089,8 +3098,8 @@ static BlockAIOCB *hdev_aio_ioctl(BlockDriverState =
*bs,
     acb->aio_type =3D QEMU_AIO_IOCTL;
     acb->aio_fildes =3D s->fd;
     acb->aio_offset =3D 0;
-    acb->aio_ioctl_buf =3D buf;
-    acb->aio_ioctl_cmd =3D req;
+    acb->ioctl.buf =3D buf;
+    acb->ioctl.cmd =3D req;
     pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
     return thread_pool_submit_aio(pool, aio_worker, acb, cb, opaque);
 }
--=20
2.19.2
