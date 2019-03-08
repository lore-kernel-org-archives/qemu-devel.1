Received: from eggs.gnu.org ([209.51.188.92]:44806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7G-0000ob-IE
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7F-0006sU-08
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7B-0006m5-DE
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:10 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:46 -0500
Message-Id: <20190308202858.26636-6-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 05/17] nbd: change error checking order for
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Check that the bitmap is not in use prior to it checking if it is
not enabled/recording guest writes. The bitmap being busy was likely
at the behest of the user, so this error has a greater chance of being
understood by the user.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190223000614.13894-6-jsnow@redhat.com
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
