Received: from eggs.gnu.org ([2001:4830:134:3::10]:40903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TvW-0002b8-PU
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7Tgd-0004EZ-1k
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:02:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  2 Oct 2018 19:02:18 -0400
Message-Id: <20181002230218.13949-7-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-1-jsnow@redhat.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 6/6] nbd: forbid use of frozen bitmaps
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

Whether it's "locked" or "frozen", it's in use and should
not be allowed for the purposes of this operation.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 nbd/server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index c3dd402b45..940b7aa0cd 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2478,8 +2478,8 @@ void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
         return;
     }
 
-    if (bdrv_dirty_bitmap_qmp_locked(bm)) {
-        error_setg(errp, "Bitmap '%s' is locked", bitmap);
+    if (bdrv_dirty_bitmap_user_locked(bm)) {
+        error_setg(errp, "Bitmap '%s' is in use", bitmap);
         return;
     }
 
-- 
2.14.4
