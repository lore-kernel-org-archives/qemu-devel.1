Received: from eggs.gnu.org ([2001:4830:134:3::10]:45230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdP-0000WO-ES
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdM-0000Se-8H
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:23 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 07:44:42 -0500
Message-Id: <20170707124459.10269-5-eblake@redhat.com>
In-Reply-To: <20170707124459.10269-1-eblake@redhat.com>
References: <20170707124459.10269-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 04/21] stream: Drop reached_end for
 stream_complete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

stream_complete() skips the work of rewriting the backing file if
the job was cancelled, if data->reached_end is false, or if there
was an error detected (non-zero data->ret) during the streaming.
But note that in stream_run(), data->reached_end is only set if the
loop ran to completion, and data->ret is only 0 in two cases:
either the loop ran to completion (possibly by cancellation, but
stream_complete checks for that), or we took an early goto out
because there is no bs->backing.  Thus, we can preserve the same
semantics without the use of reached_end, by merely checking for
bs->backing (and logically, if there was no backing file, streaming
is a no-op, so there is no backing file to rewrite).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

---
v5: no change
v4: new patch
---
 block/stream.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 746d525..12f1659 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -59,7 +59,6 @@ static int coroutine_fn stream_populate(BlockBackend *blk,

 typedef struct {
     int ret;
-    bool reached_end;
 } StreamCompleteData;

 static void stream_complete(BlockJob *job, void *opaque)
@@ -70,7 +69,7 @@ static void stream_complete(BlockJob *job, void *opaque)
     BlockDriverState *base = s->base;
     Error *local_err = NULL;

-    if (!block_job_is_cancelled(&s->common) && data->reached_end &&
+    if (!block_job_is_cancelled(&s->common) && bs->backing &&
         data->ret == 0) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
@@ -211,7 +210,6 @@ out:
     /* Modify backing chain and close BDSes in main loop */
     data = g_malloc(sizeof(*data));
     data->ret = ret;
-    data->reached_end = sector_num == end;
     block_job_defer_to_main_loop(&s->common, stream_complete, data);
 }

-- 
2.9.4
