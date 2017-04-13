Received: from eggs.gnu.org ([2001:4830:134:3::10]:56739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cygua-00079b-Fr
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 11:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyguZ-0006Fu-Fh
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 11:43:56 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 13 Apr 2017 17:43:34 +0200
Message-Id: <20170413154334.23708-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10?] block: Do not unref bs->file on
 error in BD's open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

The block layer takes care of removing the bs->file child if the block
driver's bdrv_open()/bdrv_file_open() implementation fails. The block
driver therefore does not need to do so, and indeed should not unless it
sets bs->file to NULL afterwards -- because if this is not done, the
bdrv_unref_child() in bdrv_open_inherit() will dereference the freed
memory block at bs->file afterwards, which is not good.

We can now decide whether to add a "bs->file = NULL;" after each of the
offending bdrv_unref_child() invocations, or just drop them altogether.
The latter is simpler, so let's do that.

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
It's an issue only in blkdebug, blkreplace and blkverify, and only when
an error occurs in their open functions; therefore I think this is fine
to delay until 2.10.

However, it *is* a use-after-free newly introduced in 2.9, so that's
where the question mark comes from...
---
 block/blkdebug.c  | 4 +---
 block/blkreplay.c | 3 ---
 block/blkverify.c | 3 ---
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 67e8024e36..cc4a146e84 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -389,14 +389,12 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     } else if (align) {
         error_setg(errp, "Invalid alignment");
         ret = -EINVAL;
-        goto fail_unref;
+        goto out;
     }
 
     ret = 0;
     goto out;
 
-fail_unref:
-    bdrv_unref_child(bs, bs->file);
 out:
     if (ret < 0) {
         g_free(s->config_file);
diff --git a/block/blkreplay.c b/block/blkreplay.c
index e1102119fb..6aa5fd4156 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -37,9 +37,6 @@ static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = 0;
 fail:
-    if (ret < 0) {
-        bdrv_unref_child(bs, bs->file);
-    }
     return ret;
 }
 
diff --git a/block/blkverify.c b/block/blkverify.c
index 9a1e21c6ad..af23281669 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -142,9 +142,6 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = 0;
 fail:
-    if (ret < 0) {
-        bdrv_unref_child(bs, bs->file);
-    }
     qemu_opts_del(opts);
     return ret;
 }
-- 
2.12.2
