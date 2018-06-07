Received: from eggs.gnu.org ([2001:4830:134:3::10]:49308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fQqc5-0007tS-ID
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fQqc2-0002ld-Gf
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:49:45 -0400
Received: from [45.249.212.35] (port=59186 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fQqc2-0002dh-2J
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:49:42 -0400
From: liujunjie <liujunjie23@huawei.com>
Date: Thu, 7 Jun 2018 16:02:37 +0800
Message-ID: <20180607080237.12360-1-liujunjie23@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] ps2: check PS2Queue wptr pointer in post_load
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, berrange@redhat.com
Cc: arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, fangying1@huawei.com, qemu-devel@nongnu.org, liujunjie <liujunjie23@huawei.com>

In commit 802cbcb7300, most issues have been fixed when qemu guest
migration. But the queue size still need to check whether is equal to
PS2_QUEUE_SIZE. If yes, the wptr should set as 0. Or, wptr would larger
than PS2_QUEUE_SIZE and never come back when ps2_queue_noirq is called.
This could lead to OOB access, add check to avoid it.

Signed-off-by: liujunjie <liujunjie23@huawei.com>
---
 hw/input/ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index eeec618..fdfcadf 100644
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
1.8.3.1
