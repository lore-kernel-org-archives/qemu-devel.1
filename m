Received: from eggs.gnu.org ([2001:4830:134:3::10]:34424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0F-0002nm-S7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0C-00055J-3B
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:51 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 12:39:40 +0200
Message-Id: <20170623103945.7014-3-kraxel@redhat.com>
In-Reply-To: <20170623103945.7014-1-kraxel@redhat.com>
References: <20170623103945.7014-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] input: Decrement queue count on kbd delay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

From: Alexander Graf <agraf@suse.de>

Delays in the input layer are special cased input events. Every input
event is accounted for in a global intput queue count. The special cased
delays however did not get removed from the queue, leading to queue overruns
and thus silent key drops after typing quite a few characters.

Signed-off-by: Alexander Graf <agraf@suse.de>
Message-id: 1498117318-162102-1-git-send-email-agraf@suse.de
Fixes: be1a7176 ("input: add support for kbd delays")
Cc: qemu-stable@nongnu.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/input.c b/ui/input.c
index 2abd46de93..af05f06368 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -256,6 +256,7 @@ static void qemu_input_queue_process(void *opaque)
     item = QTAILQ_FIRST(queue);
     g_assert(item->type == QEMU_INPUT_QUEUE_DELAY);
     QTAILQ_REMOVE(queue, item, node);
+    queue_count--;
     g_free(item);
 
     while (!QTAILQ_EMPTY(queue)) {
-- 
2.9.3
