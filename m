Received: from eggs.gnu.org ([2001:4830:134:3::10]:43275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpE48-0005yb-Sj
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpE48-0007mk-3g
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:43:28 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Aug 2018 16:43:19 +0200
Message-Id: <20180813144320.12382-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] nvme: simplify code around completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

nvme_poll_queues is already protected by q->lock, and
AIO callbacks are invoked outside the AioContext lock.
So remove the acquire/release pair in nvme_handle_event.

Remove unnecessary variable in in nvme_poll_cb.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nvme.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 6f71122bf5..df2e16fabe 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -489,10 +489,8 @@ static void nvme_handle_event(EventNotifier *n)
     BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
 
     trace_nvme_handle_event(s);
-    aio_context_acquire(s->aio_context);
     event_notifier_test_and_clear(n);
     nvme_poll_queues(s);
-    aio_context_release(s->aio_context);
 }
 
 static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
@@ -539,11 +537,9 @@ static bool nvme_poll_cb(void *opaque)
 {
     EventNotifier *e = opaque;
     BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
-    bool progress = false;
 
     trace_nvme_poll_cb(s);
-    progress = nvme_poll_queues(s);
-    return progress;
+    return nvme_poll_queues(s);
 }
 
 static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
-- 
2.17.1
