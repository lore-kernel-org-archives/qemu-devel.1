Received: from eggs.gnu.org ([2001:4830:134:3::10]:50899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWSP7-0002pP-CS
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWSP6-0003NV-E2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:11:33 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Jun 2018 16:11:22 -0400
Message-Id: <20180622201122.9358-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: Appease coverity,
 skip empty block trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peter.maydell@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>

If a tree consists exclusively of implicit filter nodes, we might crash
QEMU. This configuration should not exist in practice, but if it did,
skipping it would be fine.

For the purposes of debug builds, throw an assert to remind us that
this configuration is truly unexpected, but if it's compiled out we
will cope just fine.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 migration/block-dirty-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 3bafbbdc4c..02725293dd 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -287,6 +287,10 @@ static int init_dirty_bitmap_migration(void)
         while (bs && bs->drv && bs->implicit) {
             bs = backing_bs(bs);
         }
+        if (!bs) {
+            g_assert_not_reached();
+            continue;
+        }
 
         for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
              bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
-- 
2.14.4
