Received: from eggs.gnu.org ([2001:4830:134:3::10]:52880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjo-0004fZ-4R
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjj-0000op-Ms
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:16:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Mar 2017 14:15:45 +0100
Message-Id: <1489756546-27142-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
References: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] thread-pool: add missing qemu_bh_cancel in
 completion function
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

From: Peter Lieven <pl@kamp.de>

commit 3c80ca15 fixed a deadlock scenarion with nested aio_poll invocations.

However, the rescheduling of the completion BH introcuded unnecessary spinning
in the main-loop. On very fast file backends this can even lead to the
"WARNING: I/O thread spun for 1000 iterations" message popping up.

Callgrind reports about 3-4% less instructions with this patch running
qemu-img bench on a ramdisk based VMDK file.

Fixes: 3c80ca158c96ff902a30883a8933e755988948b1
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/thread-pool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index ce6cd30..610646d 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -188,6 +188,13 @@ restart:
             aio_context_release(pool->ctx);
             elem->common.cb(elem->common.opaque, elem->ret);
             aio_context_acquire(pool->ctx);
+
+            /* We can safely cancel the completion_bh here regardless of someone
+             * else having scheduled it meanwhile because we reenter the
+             * completion function anyway (goto restart).
+             */
+            qemu_bh_cancel(pool->completion_bh);
+
             qemu_aio_unref(elem);
             goto restart;
         } else {
-- 
1.8.3.1
