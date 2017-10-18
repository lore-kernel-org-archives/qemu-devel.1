Received: from eggs.gnu.org ([2001:4830:134:3::10]:35729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxx-0003Lt-7y
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxw-000230-8g
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:09 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:11:59 +0200
Message-Id: <1508343141-31835-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/29] memory: fix off-by-one error in
 memory_region_notify_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch fixes an off-by-one error that could lead to the
notifyee to receive notifications for ranges it is not
registered to.

The bug has been spotted by code review.

Fixes: bd2bfa4c52e5 ("memory: introduce memory_region_notify_one()")
Cc: qemu-stable@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-Id: <20171010094247.10173-4-maxime.coquelin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 5e6351a..b637c12 100644
--- a/memory.c
+++ b/memory.c
@@ -1892,7 +1892,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
      * Skip the notification if the notification does not overlap
      * with registered range.
      */
-    if (notifier->start > entry->iova + entry->addr_mask + 1 ||
+    if (notifier->start > entry->iova + entry->addr_mask ||
         notifier->end < entry->iova) {
         return;
     }
-- 
1.8.3.1
