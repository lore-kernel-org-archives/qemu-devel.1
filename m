Received: from eggs.gnu.org ([2001:4830:134:3::10]:57628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHyTo-0004Tl-DQ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHyTl-0008BV-8q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:56:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 31 Oct 2018 22:56:12 +0100
Message-Id: <20181031215622.27690-3-kwolf@redhat.com>
In-Reply-To: <20181031215622.27690-1-kwolf@redhat.com>
References: <20181031215622.27690-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/12] file-posix: Factor out
 raw_thread_pool_submit()
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

Getting the thread pool of the AioContext of a block node and scheduling
some work in it is an operation that is already done twice, and we'll
get more instances. Factor it out into a separate function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 68cea7685a..28eb55c29e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1803,13 +1803,20 @@ static int aio_worker(void *arg)
     return ret;
 }
=20
+static int coroutine_fn raw_thread_pool_submit(BlockDriverState *bs,
+                                               ThreadPoolFunc func, void=
 *arg)
+{
+    /* @bs can be NULL, bdrv_get_aio_context() returns the main context =
then */
+    ThreadPool *pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
+    return thread_pool_submit_co(pool, func, arg);
+}
+
 static int paio_submit_co_full(BlockDriverState *bs, int fd,
                                int64_t offset, int fd2, int64_t offset2,
                                QEMUIOVector *qiov,
                                int bytes, int type)
 {
     RawPosixAIOData *acb =3D g_new(RawPosixAIOData, 1);
-    ThreadPool *pool;
=20
     acb->bs =3D bs;
     acb->aio_type =3D type;
@@ -1828,8 +1835,7 @@ static int paio_submit_co_full(BlockDriverState *bs=
, int fd,
     }
=20
     trace_file_paio_submit_co(offset, bytes, type);
-    pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
-    return thread_pool_submit_co(pool, aio_worker, acb);
+    return raw_thread_pool_submit(bs, aio_worker, acb);
 }
=20
 static inline int paio_submit_co(BlockDriverState *bs, int fd,
@@ -1959,7 +1965,6 @@ raw_regular_truncate(BlockDriverState *bs, int fd, =
int64_t offset,
                      PreallocMode prealloc, Error **errp)
 {
     RawPosixAIOData *acb =3D g_new(RawPosixAIOData, 1);
-    ThreadPool *pool;
=20
     *acb =3D (RawPosixAIOData) {
         .bs             =3D bs,
@@ -1972,9 +1977,7 @@ raw_regular_truncate(BlockDriverState *bs, int fd, =
int64_t offset,
         },
     };
=20
-    /* @bs can be NULL, bdrv_get_aio_context() returns the main context =
then */
-    pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
-    return thread_pool_submit_co(pool, aio_worker, acb);
+    return raw_thread_pool_submit(bs, aio_worker, acb);
 }
=20
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t of=
fset,
--=20
2.19.1
