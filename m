Received: from eggs.gnu.org ([2001:4830:134:3::10]:48417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUrFJ-0007ZC-AS
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUrFF-0002zE-CA
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:18:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fUrFF-0002xk-7g
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:18:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 12:18:41 +0200
Message-Id: <20180618101841.21609-2-kraxel@redhat.com>
In-Reply-To: <20180618101841.21609-1-kraxel@redhat.com>
References: <20180618101841.21609-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] ps2: check PS2Queue wptr pointer in
 post_load routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: liujunjie <liujunjie23@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>

From: liujunjie <liujunjie23@huawei.com>

In commit 802cbcb7300, most issues have been fixed when qemu guest
migration. But the queue size still need to check whether is equal to
PS2_QUEUE_SIZE. If yes, the wptr should set as 0. Or, wptr would larger
than PS2_QUEUE_SIZE and never come back when ps2_queue_noirq is called.
This could lead to OOB access, add check to avoid it.

Signed-off-by: liujunjie <liujunjie23@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Message-id: 20180607080237.12360-1-liujunjie23@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index eeec6180d0..fdfcadf9a1 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -927,7 +927,7 @@ static void ps2_common_post_load(PS2State *s)
 
     /* reset rptr/wptr/count */
     q->rptr = 0;
-    q->wptr = size;
+    q->wptr = (size == PS2_QUEUE_SIZE) ? 0 : size;
     q->count = size;
     s->update_irq(s->update_arg, q->count != 0);
 }
-- 
2.9.3
