Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMc-0007X5-JY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMb-0000OC-Ml
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:38 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 23:32:17 +0200
Message-Id: <20180502213219.7842-6-mreitz@redhat.com>
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC 5/7] block: Add blk_new_open_string_opts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an interface to bdrv_open_string_opts().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/sysemu/block-backend.h |  2 ++
 block/block-backend.c          | 30 +++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 92ab624fac..1ad002fa7e 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -79,6 +79,8 @@ typedef struct BlockBackendPublic {
 BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm);
 BlockBackend *blk_new_open(const char *filename, const char *reference,
                            QDict *options, int flags, Error **errp);
+BlockBackend *blk_new_open_string_opts(const char *filename, QDict *options,
+                                       int flags, Error **errp);
 int blk_get_refcnt(BlockBackend *blk);
 void blk_ref(BlockBackend *blk);
 void blk_unref(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index 89f47b00ea..fd3024602a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -105,6 +105,11 @@ static const AIOCBInfo block_backend_aiocb_info = {
 static void drive_info_del(DriveInfo *dinfo);
 static BlockBackend *bdrv_first_blk(BlockDriverState *bs);
 
+static BlockBackend *blk_do_new_open(const char *filename,
+                                     const char *reference, QDict *options,
+                                     int flags, bool string_opts,
+                                     Error **errp);
+
 /* All BlockBackends */
 static QTAILQ_HEAD(, BlockBackend) block_backends =
     QTAILQ_HEAD_INITIALIZER(block_backends);
@@ -348,6 +353,24 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
  */
 BlockBackend *blk_new_open(const char *filename, const char *reference,
                            QDict *options, int flags, Error **errp)
+{
+    return blk_do_new_open(filename, reference, options, flags, false, errp);
+}
+
+/*
+ * Like blk_new_open(), but accepts an @options QDict where some (or
+ * all) values are strings instead of their correct type.
+ */
+BlockBackend *blk_new_open_string_opts(const char *filename, QDict *options,
+                                       int flags, Error **errp)
+{
+    return blk_do_new_open(filename, NULL, options, flags, true, errp);
+}
+
+static BlockBackend *blk_do_new_open(const char *filename,
+                                     const char *reference, QDict *options,
+                                     int flags, bool string_opts,
+                                     Error **errp)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -372,7 +395,12 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
     }
 
     blk = blk_new(perm, BLK_PERM_ALL);
-    bs = bdrv_open(filename, reference, options, flags, errp);
+    if (string_opts) {
+        assert(!reference);
+        bs = bdrv_open_string_opts(filename, options, flags, errp);
+    } else {
+        bs = bdrv_open(filename, reference, options, flags, errp);
+    }
     if (!bs) {
         blk_unref(blk);
         return NULL;
-- 
2.14.3
