Received: from eggs.gnu.org ([2001:4830:134:3::10]:46204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNRz-0003eu-An
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNRm-0001jp-7o
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:00:46 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  7 Nov 2018 14:59:43 +0200
Message-Id: <abc8e013c928437aa186b2f26ae159ec25ff274c.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 08/15] block: Use
 bdrv_reopen_set_read_only() in the mirror driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The 'block-commit' QMP command is implemented internally using two
different drivers. If the source image is the active layer then the
mirror driver is used (commit_active_start()), otherwise the commit
driver is used (commit_start()).

In both cases the destination image must be put temporarily in
read-write mode. This is done correctly in the latter case, but what
commit_active_start() does is copy all flags instead.

This patch replaces the bdrv_reopen() calls in that function with
bdrv_reopen_set_read_only() so that only the read-only status is
changed.

A similar change is made in mirror_exit(), which is also used by the
'drive-mirror' and 'blockdev-mirror' commands.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 56d9ef7474..41b6cbaad6 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -672,9 +672,10 @@ static int mirror_exit_common(Job *job)
 
     if (s->should_complete && !abort) {
         BlockDriverState *to_replace = s->to_replace ?: src;
+        bool ro = bdrv_is_read_only(to_replace);
 
-        if (bdrv_get_flags(target_bs) != bdrv_get_flags(to_replace)) {
-            bdrv_reopen(target_bs, bdrv_get_flags(to_replace), NULL);
+        if (ro != bdrv_is_read_only(target_bs)) {
+            bdrv_reopen_set_read_only(target_bs, ro, NULL);
         }
 
         /* The mirror job has no requests in flight any more, but we need to
@@ -1692,13 +1693,15 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
                          BlockCompletionFunc *cb, void *opaque,
                          bool auto_complete, Error **errp)
 {
-    int orig_base_flags;
+    bool base_read_only;
     Error *local_err = NULL;
 
-    orig_base_flags = bdrv_get_flags(base);
+    base_read_only = bdrv_is_read_only(base);
 
-    if (bdrv_reopen(base, bs->open_flags, errp)) {
-        return;
+    if (base_read_only) {
+        if (bdrv_reopen_set_read_only(base, false, errp) < 0) {
+            return;
+        }
     }
 
     mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0,
@@ -1717,6 +1720,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
 error_restore_flags:
     /* ignore error and errp for bdrv_reopen, because we want to propagate
      * the original error */
-    bdrv_reopen(base, orig_base_flags, NULL);
+    if (base_read_only) {
+        bdrv_reopen_set_read_only(base, true, NULL);
+    }
     return;
 }
-- 
2.11.0
