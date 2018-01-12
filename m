Received: from eggs.gnu.org ([2001:4830:134:3::10]:41271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZvAG-00008J-7B
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZvAF-0004Wx-8p
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:58:16 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 12 Jan 2018 16:55:50 +0800
Message-Id: <20180112085555.14447-5-famz@redhat.com>
In-Reply-To: <20180112085555.14447-1-famz@redhat.com>
References: <20180112085555.14447-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 4/9] block: Introduce buf register API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, alex.williamson@redhat.com, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

Allow block driver to map and unmap a buffer for later I/O, as a performance
hint.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180110091846.10699-5-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c          | 10 ++++++++++
 block/io.c                     | 24 ++++++++++++++++++++++++
 include/block/block.h          | 11 ++++++++++-
 include/block/block_int.h      |  9 +++++++++
 include/sysemu/block-backend.h |  3 +++
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index baef8e7abc..f66349c2c9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2096,3 +2096,13 @@ static void blk_root_drained_end(BdrvChild *child)
         }
     }
 }
+
+void blk_register_buf(BlockBackend *blk, void *host, size_t size)
+{
+    bdrv_register_buf(blk_bs(blk), host, size);
+}
+
+void blk_unregister_buf(BlockBackend *blk, void *host)
+{
+    bdrv_unregister_buf(blk_bs(blk), host);
+}
diff --git a/block/io.c b/block/io.c
index 7ea402352e..89d0745e95 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2825,3 +2825,27 @@ void bdrv_io_unplug(BlockDriverState *bs)
         bdrv_io_unplug(child->bs);
     }
 }
+
+void bdrv_register_buf(BlockDriverState *bs, void *host, size_t size)
+{
+    BdrvChild *child;
+
+    if (bs->drv && bs->drv->bdrv_register_buf) {
+        bs->drv->bdrv_register_buf(bs, host, size);
+    }
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_register_buf(child->bs, host, size);
+    }
+}
+
+void bdrv_unregister_buf(BlockDriverState *bs, void *host)
+{
+    BdrvChild *child;
+
+    if (bs->drv && bs->drv->bdrv_unregister_buf) {
+        bs->drv->bdrv_unregister_buf(bs, host);
+    }
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_unregister_buf(child->bs, host);
+    }
+}
diff --git a/include/block/block.h b/include/block/block.h
index 9b12774ddf..2025d7ed19 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -631,5 +631,14 @@ void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
 bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
                                      uint32_t granularity, Error **errp);
-
+/**
+ *
+ * bdrv_register_buf/bdrv_unregister_buf:
+ *
+ * Register/unregister a buffer for I/O. For example, VFIO drivers are
+ * interested to know the memory areas that would later be used for I/O, so
+ * that they can prepare IOMMU mapping etc., to get better performance.
+ */
+void bdrv_register_buf(BlockDriverState *bs, void *host, size_t size);
+void bdrv_unregister_buf(BlockDriverState *bs, void *host);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 29cafa4236..99b9190627 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -446,6 +446,15 @@ struct BlockDriver {
                                                 const char *name,
                                                 Error **errp);
 
+    /**
+     * Register/unregister a buffer for I/O. For example, when the driver is
+     * interested to know the memory areas that will later be used in iovs, so
+     * that it can do IOMMU mapping with VFIO etc., in order to get better
+     * performance. In the case of VFIO drivers, this callback is used to do
+     * DMA mapping for hot buffers.
+     */
+    void (*bdrv_register_buf)(BlockDriverState *bs, void *host, size_t size);
+    void (*bdrv_unregister_buf)(BlockDriverState *bs, void *host);
     QLIST_ENTRY(BlockDriver) list;
 };
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index c4e52a5fa3..92ab624fac 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -229,4 +229,7 @@ void blk_io_limits_enable(BlockBackend *blk, const char *group);
 void blk_io_limits_update_group(BlockBackend *blk, const char *group);
 void blk_set_force_allow_inactivate(BlockBackend *blk);
 
+void blk_register_buf(BlockBackend *blk, void *host, size_t size);
+void blk_unregister_buf(BlockBackend *blk, void *host);
+
 #endif
-- 
2.14.3
