Received: from eggs.gnu.org ([2001:4830:134:3::10]:46776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSW-0003xr-9j
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSB-0002Hc-C5
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:15 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  7 Nov 2018 14:59:38 +0200
Message-Id: <4fba673e8cdeffa724d6c2881c652bb7e34da67a.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 03/15] block: Use
 bdrv_reopen_set_read_only() in commit_start/complete()
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

This patch replaces the bdrv_reopen() calls that set and remove the
BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/commit.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index a2da5740b0..a53c2d04b0 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -38,7 +38,7 @@ typedef struct CommitBlockJob {
     BlockBackend *base;
     BlockDriverState *base_bs;
     BlockdevOnError on_error;
-    int base_flags;
+    bool base_read_only;
     char *backing_file_str;
 } CommitBlockJob;
 
@@ -124,8 +124,8 @@ static void commit_clean(Job *job)
     /* restore base open flags here if appropriate (e.g., change the base back
      * to r/o). These reopens do not need to be atomic, since we won't abort
      * even on failure here */
-    if (s->base_flags != bdrv_get_flags(s->base_bs)) {
-        bdrv_reopen(s->base_bs, s->base_flags, NULL);
+    if (s->base_read_only) {
+        bdrv_reopen_set_read_only(s->base_bs, true, NULL);
     }
 
     g_free(s->backing_file_str);
@@ -264,7 +264,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                   const char *filter_node_name, Error **errp)
 {
     CommitBlockJob *s;
-    int orig_base_flags;
     BlockDriverState *iter;
     BlockDriverState *commit_top_bs = NULL;
     Error *local_err = NULL;
@@ -283,11 +282,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     }
 
     /* convert base to r/w, if necessary */
-    orig_base_flags = bdrv_get_flags(base);
-    if (!(orig_base_flags & BDRV_O_RDWR)) {
-        bdrv_reopen(base, orig_base_flags | BDRV_O_RDWR, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
+    s->base_read_only = bdrv_is_read_only(base);
+    if (s->base_read_only) {
+        if (bdrv_reopen_set_read_only(base, false, errp) != 0) {
             goto fail;
         }
     }
@@ -363,7 +360,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
-    s->base_flags = orig_base_flags;
     s->backing_file_str = g_strdup(backing_file_str);
     s->on_error = on_error;
 
-- 
2.11.0
