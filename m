Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRGYy-0000N8-AT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRGYv-0005fS-8O
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:32:16 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Jun 2018 15:32:08 +0300
Message-Id: <20180608123208.54033-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block/qcow2: save dirty_bitmaps_loaded during
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com

This variable was introduced to handle reopens. We need it on the
following qcow2_do_open, to don't try load bitmaps again.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 549fee9b69..29f7eab576 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2178,6 +2178,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
     QDict *options;
     Error *local_err = NULL;
     int ret;
+    bool dirty_bitmaps_loaded = s->dirty_bitmaps_loaded;
 
     /*
      * Backing files are read-only which makes all of their metadata immutable,
@@ -2190,6 +2191,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
     qcow2_close(bs);
 
     memset(s, 0, sizeof(BDRVQcow2State));
+    s->dirty_bitmaps_loaded = dirty_bitmaps_loaded;
     options = qdict_clone_shallow(bs->options);
 
     flags &= ~BDRV_O_INACTIVE;
-- 
2.11.1
