Received: from eggs.gnu.org ([2001:4830:134:3::10]:57323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6l-0005ny-2x
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6g-0002V3-5n
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:29 +0100
Message-Id: <20171222151846.28110-19-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 18/35] block: Assert drain_all is only called
 from main AioContext
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/io.c b/block/io.c
index cf780c3cb0..b94740b8ff 100644
--- a/block/io.c
+++ b/block/io.c
@@ -330,6 +330,12 @@ void bdrv_drain_all_begin(void)
     BdrvNextIterator it;
     GSList *aio_ctxs = NULL, *ctx;
 
+    /* BDRV_POLL_WHILE() for a node can only be called from its own I/O thread
+     * or the main loop AioContext. We potentially use BDRV_POLL_WHILE() on
+     * nodes in several different AioContexts, so make sure we're in the main
+     * context. */
+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+
     block_job_pause_all();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-- 
2.13.6
