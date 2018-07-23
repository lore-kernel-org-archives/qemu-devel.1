Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLE-0004Q4-2k
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLD-0005gc-4g
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:59 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:40 -0500
Message-Id: <20180723201748.25573-92-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 91/99] migration/block-dirty-bitmap: fix
 dirty_bitmap_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

dirty_bitmap_load_header return code is obtained but not handled. Fix
this.

Bug was introduced in b35ebdf076d697bc
"migration: add postcopy migration of dirty bitmaps" with the whole
function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180530112424.204835-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
(cherry picked from commit a36f6ff46f115672cf86d0e1e7cdb1c2fa4d304b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 migration/block-dirty-bitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 8819aabe3a..2c541c985d 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -672,6 +672,9 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 
     do {
         ret = dirty_bitmap_load_header(f, &s);
+        if (ret < 0) {
+            return ret;
+        }
 
         if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
             ret = dirty_bitmap_load_start(f, &s);
-- 
2.17.1
