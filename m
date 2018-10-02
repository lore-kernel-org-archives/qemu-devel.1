Received: from eggs.gnu.org ([2001:4830:134:3::10]:40666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TwG-00025I-HY
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TgZ-0004CX-1a
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:02:35 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  2 Oct 2018 19:02:14 -0400
Message-Id: <20181002230218.13949-3-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-1-jsnow@redhat.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/6] block/dirty-bitmaps: fix merge
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

In prior commits that made merge transactionable, we removed the
assertion that merge cannot operate on disabled bitmaps. In addition,
we want to make sure that we are prohibiting merges to "locked" bitmaps.

Use the new user_locked function to check.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 85bc668f6a..8a6e07930f 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -806,9 +806,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
 
     qemu_mutex_lock(dest->mutex);
 
-    if (bdrv_dirty_bitmap_frozen(dest)) {
-        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
-                   dest->name);
+    if (bdrv_dirty_bitmap_user_locked(dest)) {
+        error_setg(errp, "Bitmap '%s' is currently in use by another"
+        " operation and cannot be modified", dest->name);
         goto out;
     }
 
-- 
2.14.4
