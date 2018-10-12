Received: from eggs.gnu.org ([2001:4830:134:3::10]:48568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAmb8-00085e-G1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAmb5-0004cG-E9
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gAmb5-0004bU-5x
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:50:35 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 12 Oct 2018 09:50:26 +0800
Message-Id: <20181012015026.17441-3-famz@redhat.com>
In-Reply-To: <20181012015026.17441-1-famz@redhat.com>
References: <20181012015026.17441-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] nvme: correct locking around completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

nvme_poll_queues is already protected by q->lock, and
AIO callbacks are invoked outside the AioContext lock.
So remove the acquire/release pair in nvme_handle_event.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180814062739.19640-1-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 781d77d6d2..29294038fc 100644
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
-- 
2.17.1
