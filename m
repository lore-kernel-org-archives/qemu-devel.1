Received: from eggs.gnu.org ([2001:4830:134:3::10]:54844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdgSH-0005X2-9h
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdgSD-0003yf-2c
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:53 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:27856 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cdgSC-0003wG-IV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:48 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Feb 2017 19:59:38 +0300
Message-Id: <1487091579-67092-25-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 24/25] qmp: block-dirty-bitmap-remove: remove
 persistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Remove persistent bitmap from the storage on block-dirty-bitmap-remove.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index c41b791..a365cdf 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2767,6 +2767,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
     AioContext *aio_context;
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
+    Error *local_err = NULL;
 
     bitmap = block_dirty_bitmap_lookup(node, name, &bs, &aio_context, errp);
     if (!bitmap || !bs) {
@@ -2779,6 +2780,15 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
                    name);
         goto out;
     }
+
+    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
+        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            goto out;
+        }
+    }
+
     bdrv_dirty_bitmap_make_anon(bitmap);
     bdrv_release_dirty_bitmap(bs, bitmap);
 
-- 
1.8.3.1
