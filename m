Received: from eggs.gnu.org ([2001:4830:134:3::10]:49231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJF-0007Z2-IB
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ0-00043x-Jo
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:46 +0200
Message-Id: <1502117160-24655-43-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 42/56] blockjob: Lift speed sign conversion
 out of stream_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

stream_start() takes int64_t speed.  The underlying BlockJob
abstraction takes uint64_t.  stream_start() converts from int64_t to
uint64_t, rejecting negative speed.

Lift this check and conversion out of stream_start() into its caller.
I'm going to lift it further until it falls off the top.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/stream.c            | 8 +-------
 blockdev.c                | 6 ++++++
 include/block/block_int.h | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index fefcdb9..16acb1e 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -223,7 +223,7 @@ static const BlockJobDriver stream_job_driver = {
 
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int64_t speed, BlockdevOnError on_error, Error **errp)
+                  uint64_t speed, BlockdevOnError on_error, Error **errp)
 {
     StreamBlockJob *s;
     BlockDriverState *iter;
@@ -237,12 +237,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
-                   "a non-negative rate limit");
-        return;
-    }
-
     /* Prevent concurrent jobs trying to modify the graph structure here, we
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
diff --git a/blockdev.c b/blockdev.c
index 1deea49..4d9a665 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2989,6 +2989,12 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         return;
     }
 
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative rate limit");
+        return;
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 19639c0..695d7b3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -821,7 +821,7 @@ int is_windows_drive(const char *filename);
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
-                  int64_t speed, BlockdevOnError on_error, Error **errp);
+                  uint64_t speed, BlockdevOnError on_error, Error **errp);
 
 /**
  * commit_start:
-- 
2.7.5
