Received: from eggs.gnu.org ([2001:4830:134:3::10]:45013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e1r55-0005wy-OR
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e1r4z-0000f9-W5
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:44:07 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 10 Oct 2017 11:42:47 +0200
Message-Id: <20171010094247.10173-4-maxime.coquelin@redhat.com>
In-Reply-To: <20171010094247.10173-1-maxime.coquelin@redhat.com>
References: <20171010094247.10173-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] memory: fix off-by-one error in
 memory_region_notify_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com, pbonzini@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>

This patch fixes an off-by-one error that could lead to the
notifyee to receive notifications for ranges it is not
registered to.

The bug has been spotted by code review.

Fixes: bd2bfa4c52e5 ("memory: introduce memory_region_notify_one()")
Cc: qemu-stable@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 5e6351a6c1..b637c12bad 100644
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
2.13.6
