Received: from eggs.gnu.org ([2001:4830:134:3::10]:46172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cw8Md-0005mZ-7z
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cw8Ma-0001pw-13
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:26:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  6 Apr 2017 22:25:26 +0800
Message-Id: <20170406142527.25835-5-famz@redhat.com>
In-Reply-To: <20170406142527.25835-1-famz@redhat.com>
References: <20170406142527.25835-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 4/5] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

During block job completion, nothing is preventing
block_job_defer_to_main_loop_bh from being called in a nested
aio_poll(), which is a trouble, such as in this code path:

    qmp_block_commit
      commit_active_start
        bdrv_reopen
          bdrv_reopen_multiple
            bdrv_reopen_prepare
              bdrv_flush
                aio_poll
                  aio_bh_poll
                    aio_bh_call
                      block_job_defer_to_main_loop_bh
                        stream_complete
                          bdrv_reopen

block_job_defer_to_main_loop_bh is the last step of the stream job,
which should have been "paused" by the bdrv_drained_begin/end in
bdrv_reopen_multiple, but it is not done because it's in the form of a
main loop BH.

Similar to why block jobs should be paused between drained_begin and
drained_end, BHs they schedule must be excluded as well.  To achieve
this, this patch forces draining the BH before leaving bdrv_drained_begin().

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 2709a70..b9cfd18 100644
--- a/block/io.c
+++ b/block/io.c
@@ -228,7 +228,12 @@ void bdrv_drained_begin(BlockDriverState *bs)
         bdrv_parent_drained_begin(bs);
     }
 
-    bdrv_drain_recurse(bs);
+    while (true) {
+        if (!bdrv_drain_recurse(bs) &&
+            !aio_poll(bdrv_get_aio_context(bs), false)) {
+                break;
+            }
+    }
 }
 
 void bdrv_drained_end(BlockDriverState *bs)
-- 
2.9.3
