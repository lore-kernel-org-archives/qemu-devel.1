Received: from eggs.gnu.org ([2001:4830:134:3::10]:37225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAs-0002kv-LW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAr-00081l-Ou
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:46 +0200
Message-Id: <1494513181-7900-44-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 43/58] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Rather than store into a local variable, then copy to the struct
if the value is valid, then reporting errors otherwise, it is
simpler to just store into the struct and report errors if the
value is invalid.  This however requires that the struct store
a 64-bit number, rather than a narrower type.  Likewise, setting
a sane errno value in ret prior to the sequence of parsing and
jumping to out: on error makes it easier for the next patch to
add a chain of similar checks.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20170429191419.30051-8-eblake@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkdebug.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index b8cc876..29ab7a3 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -38,7 +38,7 @@
 typedef struct BDRVBlkdebugState {
     int state;
     int new_state;
-    int align;
+    uint64_t align;
 
     /* For blkdebug_refresh_filename() */
     char *config_file;
@@ -353,7 +353,6 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVBlkdebugState *s = bs->opaque;
     QemuOpts *opts;
     Error *local_err = NULL;
-    uint64_t align;
     int ret;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
@@ -387,20 +386,17 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
         bs->file->bs->supported_write_flags;
     bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
         bs->file->bs->supported_zero_flags;
+    ret = -EINVAL;
 
     /* Set request alignment */
-    align = qemu_opt_get_size(opts, "align", 0);
-    if (align < INT_MAX && is_power_of_2(align)) {
-        s->align = align;
-    } else if (align) {
-        error_setg(errp, "Invalid alignment");
-        ret = -EINVAL;
+    s->align = qemu_opt_get_size(opts, "align", 0);
+    if (s->align && (s->align >= INT_MAX || !is_power_of_2(s->align))) {
+        error_setg(errp, "Cannot meet constraints with align %" PRIu64,
+                   s->align);
         goto out;
     }
 
     ret = 0;
-    goto out;
-
 out:
     if (ret < 0) {
         g_free(s->config_file);
-- 
1.8.3.1
