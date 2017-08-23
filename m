Received: from eggs.gnu.org ([2001:4830:134:3::10]:53081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkVw5-0004RD-50
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkVw4-00020m-E9
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:43:09 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 23 Aug 2017 21:42:41 +0800
Message-Id: <20170823134242.12080-4-famz@redhat.com>
In-Reply-To: <20170823134242.12080-1-famz@redhat.com>
References: <20170823134242.12080-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 3/4] mirror: Mark target BB as "force
 allow inactivate"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index c9a6a3ca86..429751b9fe 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1134,6 +1134,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              const BlockJobDriver *driver,
                              bool is_none_mode, BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
+                             bool is_mirror,
                              Error **errp)
 {
     MirrorBlockJob *s;
@@ -1222,6 +1223,15 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     if (ret < 0) {
         goto fail;
     }
+    if (is_mirror) {
+        /* XXX: Mirror target could be a NBD server of target QEMU in the case
+         * of non-shared block migration. To allow migration completion, we
+         * have to allow "inactivate" of the target BB.  When that happens, we
+         * know the job is drained, and the vcpus are stopped, so no write
+         * operation will be performed. Block layer already has assertions to
+         * ensure that. */
+        blk_set_force_allow_inactivate(s->target);
+    }
 
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
@@ -1306,7 +1316,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL,
                      &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, errp);
+                     filter_node_name, true, errp);
 }
 
 void commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -1329,7 +1339,7 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
-                     filter_node_name, &local_err);
+                     filter_node_name, false, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error_restore_flags;
-- 
2.13.5
