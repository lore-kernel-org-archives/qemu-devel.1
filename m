Received: from eggs.gnu.org ([2001:4830:134:3::10]:54047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth5-0004ja-Nh
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth3-0001K9-KD
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:42 -0400
Message-Id: <20180807043349.27196-15-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 14/21] block/mirror: add block job creation
 flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Add support for taking and passing forward job creaton flags.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c            | 5 +++--
 blockdev.c                | 3 ++-
 include/block/block_int.h | 5 ++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index acf874393e..639d66098a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1639,7 +1639,8 @@ fail:
 
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
-                  int64_t speed, uint32_t granularity, int64_t buf_size,
+                  int creation_flags, int64_t speed,
+                  uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
@@ -1655,7 +1656,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
     }
     is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
-    mirror_start_job(job_id, bs, JOB_DEFAULT, target, replaces,
+    mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL,
                      &mirror_job_driver, is_none_mode, base, false,
diff --git a/blockdev.c b/blockdev.c
index 88ad8d96e5..d31750b024 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3700,6 +3700,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    bool has_copy_mode, MirrorCopyMode copy_mode,
                                    Error **errp)
 {
+    int job_flags = JOB_DEFAULT;
 
     if (!has_speed) {
         speed = 0;
@@ -3752,7 +3753,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
      * and will allow to check whether the node still exist at mirror completion
      */
     mirror_start(job_id, bs, target,
-                 has_replaces ? replaces : NULL,
+                 has_replaces ? replaces : NULL, job_flags,
                  speed, granularity, buf_size, sync, backing_mode,
                  on_source_error, on_target_error, unmap, filter_node_name,
                  copy_mode, errp);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index ffab0b4d3e..b40f0bfc9b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1029,6 +1029,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
  * @target: Block device to write to.
  * @replaces: Block graph node name to replace once the mirror is done. Can
  *            only be used when full mirroring is selected.
+ * @creation_flags: Flags that control the behavior of the Job lifetime.
+ *                  See @BlockJobCreateFlags
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @granularity: The chosen granularity for the dirty bitmap.
  * @buf_size: The amount of data that can be in flight at one time.
@@ -1050,7 +1052,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
  */
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
-                  int64_t speed, uint32_t granularity, int64_t buf_size,
+                  int creation_flags, int64_t speed,
+                  uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
-- 
2.14.4
