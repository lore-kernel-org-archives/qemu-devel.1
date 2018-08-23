Received: from eggs.gnu.org ([2001:4830:134:3::10]:59280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0N-0005dP-5A
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0L-0001FS-5i
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Aug 2018 18:22:37 -0400
Message-Id: <20180823222249.13518-2-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-1-jsnow@redhat.com>
References: <20180823222249.13518-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/13] block/commit: add block job creation
 flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>

Add support for taking and passing forward job creation flags.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/commit.c            | 5 +++--
 blockdev.c                | 7 ++++---
 include/block/block_int.h | 5 ++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index da69165de3..b6e8969877 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -249,7 +249,8 @@ static BlockDriver bdrv_commit_top = {
 };
 
 void commit_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, BlockDriverState *top, int64_t speed,
+                  BlockDriverState *base, BlockDriverState *top,
+                  int creation_flags, int64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
                   const char *filter_node_name, Error **errp)
 {
@@ -267,7 +268,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     }
 
     s = block_job_create(job_id, &commit_job_driver, NULL, bs, 0, BLK_PERM_ALL,
-                         speed, JOB_DEFAULT, NULL, NULL, errp);
+                         speed, creation_flags, NULL, NULL, errp);
     if (!s) {
         return;
     }
diff --git a/blockdev.c b/blockdev.c
index 72f5347df5..c15a1e624b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3214,6 +3214,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
      * BlockdevOnError change for blkmirror makes it in
      */
     BlockdevOnError on_error = BLOCKDEV_ON_ERROR_REPORT;
+    int job_flags = JOB_DEFAULT;
 
     if (!has_speed) {
         speed = 0;
@@ -3295,15 +3296,15 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
             goto out;
         }
         commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
-                            JOB_DEFAULT, speed, on_error,
+                            job_flags, speed, on_error,
                             filter_node_name, NULL, NULL, false, &local_err);
     } else {
         BlockDriverState *overlay_bs = bdrv_find_overlay(bs, top_bs);
         if (bdrv_op_is_blocked(overlay_bs, BLOCK_OP_TYPE_COMMIT_TARGET, errp)) {
             goto out;
         }
-        commit_start(has_job_id ? job_id : NULL, bs, base_bs, top_bs, speed,
-                     on_error, has_backing_file ? backing_file : NULL,
+        commit_start(has_job_id ? job_id : NULL, bs, base_bs, top_bs, job_flags,
+                     speed, on_error, has_backing_file ? backing_file : NULL,
                      filter_node_name, &local_err);
     }
     if (local_err != NULL) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 903b9c1034..ffab0b4d3e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -980,6 +980,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
  * @bs: Active block device.
  * @top: Top block device to be committed.
  * @base: Block device that will be written into, and become the new top.
+ * @creation_flags: Flags that control the behavior of the Job lifetime.
+ *                  See @BlockJobCreateFlags
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @on_error: The action to take upon error.
  * @backing_file_str: String to use as the backing file in @top's overlay
@@ -990,7 +992,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
  *
  */
 void commit_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, BlockDriverState *top, int64_t speed,
+                  BlockDriverState *base, BlockDriverState *top,
+                  int creation_flags, int64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
                   const char *filter_node_name, Error **errp);
 /**
-- 
2.14.4
