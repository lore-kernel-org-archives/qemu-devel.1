Received: from eggs.gnu.org ([2001:4830:134:3::10]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmBj-0001RD-El
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmBi-0007nk-I2
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:31:51 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 10 Jul 2018 14:31:15 +0800
Message-Id: <20180710063124.2263-2-famz@redhat.com>
In-Reply-To: <20180710063124.2263-1-famz@redhat.com>
References: <20180710063124.2263-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/10] block: Prefix file driver trace
 points with "file_"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

With in one module, trace points usually have a common prefix named
after the module name. paio_submit and paio_submit_co are the only two
trace points so far in the two file protocol drivers. As we are adding
more, having a common prefix here is better so that trace points can be
enabled with a glob. Rename them.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 2 +-
 block/file-win32.c | 2 +-
 block/trace-events | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4fec8cb53c..1185c7c5cc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1743,7 +1743,7 @@ static int paio_submit_co_full(BlockDriverState *bs, int fd,
         assert(qiov->size == bytes);
     }
 
-    trace_paio_submit_co(offset, bytes, type);
+    trace_file_paio_submit_co(offset, bytes, type);
     pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     return thread_pool_submit_co(pool, aio_worker, acb);
 }
diff --git a/block/file-win32.c b/block/file-win32.c
index 0411fe80fd..f1e2187f3b 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -162,7 +162,7 @@ static BlockAIOCB *paio_submit(BlockDriverState *bs, HANDLE hfile,
     acb->aio_nbytes = count;
     acb->aio_offset = offset;
 
-    trace_paio_submit(acb, opaque, offset, count, type);
+    trace_file_paio_submit(acb, opaque, offset, count, type);
     pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     return thread_pool_submit_aio(pool, aio_worker, acb, cb, opaque);
 }
diff --git a/block/trace-events b/block/trace-events
index c35287b48a..854d5525af 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -55,8 +55,8 @@ qmp_block_stream(void *bs, void *job) "bs %p job %p"
 
 # block/file-win32.c
 # block/file-posix.c
-paio_submit_co(int64_t offset, int count, int type) "offset %"PRId64" count %d type %d"
-paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
+file_paio_submit_co(int64_t offset, int count, int type) "offset %"PRId64" count %d type %d"
+file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
 
 # block/qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
-- 
2.17.1
