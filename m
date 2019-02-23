Received: from eggs.gnu.org ([209.51.188.92]:55848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxKqf-0000Nb-HY
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxKqW-0001nq-Rw
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:07:15 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Feb 2019 19:06:09 -0500
Message-Id: <20190223000614.13894-6-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-1-jsnow@redhat.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/10] nbd: change error checking order for
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

Check that the bitmap is not in use prior to it checking if it is
not enabled/recording guest writes. The bitmap being busy was likely
at the behest of the user, so this error has a greater chance of being
understood by the user.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 nbd/server.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 0910d09a6d..de21c64ce3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1510,6 +1510,11 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
             goto fail;
         }
 
+        if (bdrv_dirty_bitmap_user_locked(bm)) {
+            error_setg(errp, "Bitmap '%s' is in use", bitmap);
+            goto fail;
+        }
+
         if ((nbdflags & NBD_FLAG_READ_ONLY) && bdrv_is_writable(bs) &&
             bdrv_dirty_bitmap_enabled(bm)) {
             error_setg(errp,
@@ -1518,11 +1523,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
             goto fail;
         }
 
-        if (bdrv_dirty_bitmap_user_locked(bm)) {
-            error_setg(errp, "Bitmap '%s' is in use", bitmap);
-            goto fail;
-        }
-
         bdrv_dirty_bitmap_set_qmp_locked(bm, true);
         exp->export_bitmap = bm;
         exp->export_bitmap_context = g_strdup_printf("qemu:dirty-bitmap:%s",
-- 
2.17.2
