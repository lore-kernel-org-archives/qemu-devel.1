Received: from eggs.gnu.org ([2001:4830:134:3::10]:33168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nj-0004sX-Dt
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9ni-00064L-MZ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:47 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:23 +0200
Message-Id: <20170706163828.24082-7-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/11] block: add a few more notes on locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/block_int.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 173d9dcaf9..43c9f4fcae 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -114,7 +114,9 @@ struct BlockDriver {
     /* Set if a driver can support backing files */
     bool supports_backing;
 
-    /* For handling image reopen for split or non-split files */
+    /* For handling image reopen for split or non-split files.  Called
+     * with no I/O pending.
+    */
     int (*bdrv_reopen_prepare)(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue, Error **errp);
     void (*bdrv_reopen_commit)(BDRVReopenState *reopen_state);
@@ -125,11 +127,13 @@ struct BlockDriver {
                      Error **errp);
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
-    void (*bdrv_close)(BlockDriverState *bs);
     int (*bdrv_create)(const char *filename, QemuOpts *opts, Error **errp);
-    int (*bdrv_set_key)(BlockDriverState *bs, const char *key);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
+    /* Called from main thread.  */
+    void (*bdrv_close)(BlockDriverState *bs);
+    int (*bdrv_set_key)(BlockDriverState *bs, const char *key);
+
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
 
     /* aio */
-- 
2.13.0
