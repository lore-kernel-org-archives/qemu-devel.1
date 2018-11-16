Received: from eggs.gnu.org ([2001:4830:134:3::10]:48749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gNj63-0001uS-08
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gNj62-00038p-BD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:44:02 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 16 Nov 2018 13:43:24 -0500
Message-Id: <20181116184324.8093-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: Silence coverity
 CID 1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>

Coverity warns that backing_bs() could give us a NULL pointer, which
we then use without checking that it isn't.

In our loop condition, we check bs && bs->drv as a point of habit, but
by nature of the block graph, we cannot have null bs pointers here.

This loop skips only implicit nodes, which always have children, so
this loop should never encounter a null value.

Tighten the loop condition to coax Coverity into dropping
its false positive.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 migration/block-dirty-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 5e90f44c2f..00c068fda3 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -284,7 +284,7 @@ static int init_dirty_bitmap_migration(void)
         const char *drive_name = bdrv_get_device_or_node_name(bs);
 
         /* skip automatically inserted nodes */
-        while (bs && bs->drv && bs->implicit) {
+        while (bs->drv && bs->implicit) {
             bs = backing_bs(bs);
         }
 
-- 
2.17.2
