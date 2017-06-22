Received: from eggs.gnu.org ([2001:4830:134:3::10]:37024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dNwkC-0005lC-In
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dNwkB-0007IU-Pg
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:41:36 -0400
From: Alexander Graf <agraf@suse.de>
Date: Thu, 22 Jun 2017 09:41:58 +0200
Message-Id: <1498117318-162102-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] input: Decrement queue count on kbd delay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org

Delays in the input layer are special cased input events. Every input
event is accounted for in a global intput queue count. The special cased
delays however did not get removed from the queue, leading to queue overruns
and thus silent key drops after typing quite a few characters.

Signed-off-by: Alexander Graf <agraf@suse.de>
Fixes: be1a7176 ("input: add support for kbd delays")
Cc: qemu-stable@nongnu.org
---
 ui/input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/input.c b/ui/input.c
index 290ca9f..650a57e 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -257,6 +257,7 @@ static void qemu_input_queue_process(void *opaque)
     item = QTAILQ_FIRST(queue);
     g_assert(item->type == QEMU_INPUT_QUEUE_DELAY);
     QTAILQ_REMOVE(queue, item, node);
+    queue_count--;
     g_free(item);
 
     while (!QTAILQ_EMPTY(queue)) {
-- 
1.8.5.6
