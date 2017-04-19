Received: from eggs.gnu.org ([2001:4830:134:3::10]:52743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAP-0004PW-7o
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAM-0005cY-5r
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:50 +0800
Message-Id: <20170419094356.19826-11-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/16] mirror: Do initial aio context move
 of target via BB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

While blockdev-backup tried to verify before moving target's aio context, the
same is missing for blockdev-mirror. Now that we have the right interface, fix
this as well.

As a bonus, the aio context move is now conditional, which avoids some
unnecessary operations in bdrv_set_aio_context.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 9 +++++++++
 blockdev.c     | 4 ----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index fe2fb7a..2a287b0 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1117,6 +1117,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              bool is_none_mode, BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name)
 {
+    AioContext *aio_context, *target_context;
     MirrorBlockJob *s;
     BlockDriverState *mirror_top_bs;
     bool target_graph_mod;
@@ -1200,6 +1201,14 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
+    aio_context = bdrv_get_aio_context(bs);
+    target_context = bdrv_get_aio_context(target);
+    if (target_context != aio_context) {
+        aio_context_acquire(target_context);
+        blk_set_aio_context(s->target, aio_context);
+        aio_context_release(target_context);
+    }
+
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
diff --git a/blockdev.c b/blockdev.c
index dfd1385..53f9874 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3556,8 +3556,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         goto out;
     }
 
-    bdrv_set_aio_context(target_bs, aio_context);
-
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
                            backing_mode, arg->has_speed, arg->speed,
@@ -3608,8 +3606,6 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
-    bdrv_set_aio_context(target_bs, aio_context);
-
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
                            has_replaces, replaces, sync, backing_mode,
                            has_speed, speed,
-- 
2.9.3
