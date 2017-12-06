Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMXKW-0001uM-4J
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMXKV-0006fw-EJ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:53:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Dec 2017 11:53:08 +0100
Message-Id: <20171206105309.3468-6-kwolf@redhat.com>
In-Reply-To: <20171206105309.3468-1-kwolf@redhat.com>
References: <20171206105309.3468-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] block: Don't wait for requests in
 bdrv_drain*_end()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

The device is drained, so there is no point in waiting for requests at
the end of the drained section. Remove the bdrv_drain_recurse() calls
there.

The bdrv_drain_recurse() calls were introduced in commit 481cad48e5e
in order to call the the .bdrv_co_drain_end() driver callback. This is
now done by a separate bdrv_drain_invoke() call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 390d463c71..5fdb92a15e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -299,7 +299,6 @@ void bdrv_drained_end(BlockDriverState *bs)
 
     bdrv_parent_drained_end(bs);
     bdrv_drain_invoke(bs, false);
-    bdrv_drain_recurse(bs);
     aio_enable_external(bdrv_get_aio_context(bs));
 }
 
@@ -400,7 +399,6 @@ void bdrv_drain_all_end(void)
         aio_enable_external(aio_context);
         bdrv_parent_drained_end(bs);
         bdrv_drain_invoke(bs, false);
-        bdrv_drain_recurse(bs);
         aio_context_release(aio_context);
     }
 
-- 
2.13.6
