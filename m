Received: from eggs.gnu.org ([2001:4830:134:3::10]:53299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TL-0003et-HU
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TK-0008HN-KX
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:43 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:20:00 +0200
Message-Id: <20180813022006.7216-12-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 11/17] mirror: Inline mirror_write_complete(),
 part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>

Eventually, we want to inline mirror_write_complete() fully into
mirror_co_perform().  This patch does the inlining, but we cannot remove
the function yet, as it is still required by mirror_co_read().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2a131d8b99..66746cf075 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -407,7 +407,17 @@ static void coroutine_fn mirror_co_perform(void *opaque)
         abort();
     }
 
-    mirror_write_complete(op, ret);
+    if (ret < 0) {
+        BlockErrorAction action;
+
+        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset, op->bytes);
+        action = mirror_error_action(s, false, -ret);
+        if (action == BLOCK_ERROR_ACTION_REPORT && s->ret >= 0) {
+            s->ret = ret;
+        }
+    }
+
+    mirror_iteration_done(op, ret);
 
 done:
     aio_context_release(aio_context);
-- 
2.17.1
