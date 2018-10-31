Received: from eggs.gnu.org ([2001:4830:134:3::10]:57837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHyU4-0004il-Ff
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHyTz-0008Lo-6O
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:57:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 31 Oct 2018 22:56:18 +0100
Message-Id: <20181031215622.27690-9-kwolf@redhat.com>
In-Reply-To: <20181031215622.27690-1-kwolf@redhat.com>
References: <20181031215622.27690-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/12] file-posix: Move read/write operation
 logic out of aio_worker()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

aio_worker() for reads and writes isn't boring enough yet. It still does
some postprocessing for handling short reads and turning the result into
the right return value.

However, there is no reason why handle_aiocb_rw() couldn't do the same,
and even without duplicating code between the read and write path. So
move the code there.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 074848ed1f..4989208ba3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1290,7 +1290,8 @@ static ssize_t handle_aiocb_rw(RawPosixAIOData *aio=
cb)
          * we can just use plain pread/pwrite without any problems.
          */
         if (aiocb->io.niov =3D=3D 1) {
-             return handle_aiocb_rw_linear(aiocb, aiocb->io.iov->iov_bas=
e);
+             nbytes =3D handle_aiocb_rw_linear(aiocb, aiocb->io.iov->iov=
_base);
+             goto out;
         }
         /*
          * We have more than one iovec, and all are properly aligned.
@@ -1302,7 +1303,7 @@ static ssize_t handle_aiocb_rw(RawPosixAIOData *aio=
cb)
             nbytes =3D handle_aiocb_rw_vector(aiocb);
             if (nbytes =3D=3D aiocb->aio_nbytes ||
                 (nbytes < 0 && nbytes !=3D -ENOSYS)) {
-                return nbytes;
+                goto out;
             }
             preadv_present =3D false;
         }
@@ -1320,7 +1321,8 @@ static ssize_t handle_aiocb_rw(RawPosixAIOData *aio=
cb)
      */
     buf =3D qemu_try_blockalign(aiocb->bs, aiocb->aio_nbytes);
     if (buf =3D=3D NULL) {
-        return -ENOMEM;
+        nbytes =3D -ENOMEM;
+        goto out;
     }
=20
     if (aiocb->aio_type & QEMU_AIO_WRITE) {
@@ -1354,7 +1356,21 @@ static ssize_t handle_aiocb_rw(RawPosixAIOData *ai=
ocb)
     }
     qemu_vfree(buf);
=20
-    return nbytes;
+out:
+    if (nbytes =3D=3D aiocb->aio_nbytes) {
+        return 0;
+    } else if (nbytes >=3D 0 && nbytes < aiocb->aio_nbytes) {
+        if (aiocb->aio_type & QEMU_AIO_WRITE) {
+            return -EINVAL;
+        } else {
+            iov_memset(aiocb->io.iov, aiocb->io.niov, nbytes,
+                      0, aiocb->aio_nbytes - nbytes);
+            return aiocb->aio_nbytes;
+        }
+    } else {
+        assert(nbytes < 0);
+        return nbytes;
+    }
 }
=20
 #ifdef CONFIG_XFS
@@ -1758,25 +1774,9 @@ static int aio_worker(void *arg)
     switch (aiocb->aio_type & QEMU_AIO_TYPE_MASK) {
     case QEMU_AIO_READ:
         ret =3D handle_aiocb_rw(aiocb);
-        if (ret >=3D 0 && ret < aiocb->aio_nbytes) {
-            iov_memset(aiocb->io.iov, aiocb->io.niov, ret,
-                      0, aiocb->aio_nbytes - ret);
-
-            ret =3D aiocb->aio_nbytes;
-        }
-        if (ret =3D=3D aiocb->aio_nbytes) {
-            ret =3D 0;
-        } else if (ret >=3D 0 && ret < aiocb->aio_nbytes) {
-            ret =3D -EINVAL;
-        }
         break;
     case QEMU_AIO_WRITE:
         ret =3D handle_aiocb_rw(aiocb);
-        if (ret =3D=3D aiocb->aio_nbytes) {
-            ret =3D 0;
-        } else if (ret >=3D 0 && ret < aiocb->aio_nbytes) {
-            ret =3D -EINVAL;
-        }
         break;
     case QEMU_AIO_IOCTL:
         ret =3D handle_aiocb_ioctl(aiocb);
--=20
2.19.1
