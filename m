Received: from eggs.gnu.org ([2001:4830:134:3::10]:38819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbiZ-0004G8-0S
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbiW-0004RY-46
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:35:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 11:33:55 +0100
Message-Id: <20171220103412.13048-3-kwolf@redhat.com>
In-Reply-To: <20171220103412.13048-1-kwolf@redhat.com>
References: <20171220103412.13048-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 02/19] block: Assert drain_all is only called
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
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
