Received: from eggs.gnu.org ([2001:4830:134:3::10]:53114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxEpl-0004gV-0w
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxEpj-0001ct-SZ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:09:44 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  4 Sep 2018 13:09:18 -0400
Message-Id: <20180904170930.28619-4-jsnow@redhat.com>
In-Reply-To: <20180904170930.28619-1-jsnow@redhat.com>
References: <20180904170930.28619-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 03/15] block/stream: add block job creation
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Add support for taking and passing forward job creation flags.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/stream.c            | 5 +++--
 blockdev.c                | 3 ++-
 include/block/block_int.h | 5 ++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 67e1e72e23..700eb239e4 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -214,7 +214,8 @@ static const BlockJobDriver stream_job_driver = {
 
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int64_t speed, BlockdevOnError on_error, Error **errp)
+                  int creation_flags, int64_t speed,
+                  BlockdevOnError on_error, Error **errp)
 {
     StreamBlockJob *s;
     BlockDriverState *iter;
@@ -236,7 +237,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
                          BLK_PERM_GRAPH_MOD,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_WRITE,
-                         speed, JOB_DEFAULT, NULL, NULL, errp);
+                         speed, creation_flags, NULL, NULL, errp);
     if (!s) {
         goto fail;
     }
diff --git a/blockdev.c b/blockdev.c
index 6574356708..ec90eb1cf9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3123,6 +3123,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     AioContext *aio_context;
     Error *local_err = NULL;
     const char *base_name = NULL;
+    int job_flags = JOB_DEFAULT;
 
     if (!has_on_error) {
         on_error = BLOCKDEV_ON_ERROR_REPORT;
@@ -3185,7 +3186,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     base_name = has_backing_file ? backing_file : base_name;
 
     stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
-                 has_speed ? speed : 0, on_error, &local_err);
+                 job_flags, has_speed ? speed : 0, on_error, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index b40f0bfc9b..4000d2af45 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -958,6 +958,8 @@ int is_windows_drive(const char *filename);
  * flatten the whole backing file chain onto @bs.
  * @backing_file_str: The file name that will be written to @bs as the
  * the new backing file if the job completes. Ignored if @base is %NULL.
+ * @creation_flags: Flags that control the behavior of the Job lifetime.
+ *                  See @BlockJobCreateFlags
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @on_error: The action to take upon error.
  * @errp: Error object.
@@ -971,7 +973,8 @@ int is_windows_drive(const char *filename);
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int64_t speed, BlockdevOnError on_error, Error **errp);
+                  int creation_flags, int64_t speed,
+                  BlockdevOnError on_error, Error **errp);
 
 /**
  * commit_start:
-- 
2.14.4
