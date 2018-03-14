Received: from eggs.gnu.org ([2001:4830:134:3::10]:36300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5i-0000M2-65
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5g-0006NR-PQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:28906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@hotmail.com>)
	id 1evv5g-0006Hx-F6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:28 -0400
From: junyan.he@hotmail.com
Date: Wed, 14 Mar 2018 09:20:11 +0800
Message-Id: <1520990418-28258-4-git-send-email-junyan.he@hotmail.com>
In-Reply-To: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
References: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
Subject: [Qemu-devel] [PATCH 03/10] RFC: Implement save and support snapshot
 dependency in block driver layer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 block/snapshot.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/block/snapshot.h |  7 +++++++
 2 files changed, 52 insertions(+)

diff --git a/block/snapshot.c b/block/snapshot.c
index eacc1f1..8cc40ac 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -401,6 +401,51 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
     return ret;
 }
 
+int bdrv_snapshot_save_dependency(BlockDriverState *bs,
+                                  const char *depend_snapshot_id,
+                                  int64_t depend_offset,
+                                  int64_t depend_size,
+                                  int64_t offset,
+                                  Error **errp)
+{
+    BlockDriver *drv = bs->drv;
+
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
+    if (drv->bdrv_snapshot_save_dependency) {
+        return drv->bdrv_snapshot_save_dependency(bs, depend_snapshot_id,
+                                                  depend_offset, depend_size,
+                                                  offset, errp);
+    }
+
+    if (bs->file) {
+        return bdrv_snapshot_save_dependency(bs->file->bs, depend_snapshot_id,
+                                             depend_offset, depend_size,
+                                             offset, errp);
+    }
+
+    return -ENOTSUP;
+}
+
+int bdrv_snapshot_support_dependency(BlockDriverState *bs, int32_t *alignment)
+{
+    BlockDriver *drv = bs->drv;
+    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
+        return 0;
+    }
+
+    if (drv->bdrv_snapshot_support_dependency) {
+        return drv->bdrv_snapshot_support_dependency(bs, alignment);
+    }
+
+    if (bs->file != NULL) {
+        return bdrv_snapshot_support_dependency(bs->file->bs, alignment);
+    }
+
+    return -ENOTSUP;
+}
 
 /* Group operations. All block drivers are involved.
  * These functions will properly handle dataplane (take aio_context_acquire
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index f73d109..e5bf06f 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -73,6 +73,13 @@ int bdrv_snapshot_load_tmp(BlockDriverState *bs,
 int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
                                          const char *id_or_name,
                                          Error **errp);
+int bdrv_snapshot_save_dependency(BlockDriverState *bs,
+                                  const char *depend_snapshot_id,
+                                  int64_t depend_offset,
+                                  int64_t depend_size,
+                                  int64_t offset,
+                                  Error **errp);
+int bdrv_snapshot_support_dependency(BlockDriverState *bs, int32_t *alignment);
 
 
 /* Group operations. All block drivers are involved.
-- 
2.7.4
