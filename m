Received: from eggs.gnu.org ([2001:4830:134:3::10]:59285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0N-0005dY-6y
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0L-0001G3-CW
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Aug 2018 18:22:41 -0400
Message-Id: <20180823222249.13518-6-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-1-jsnow@redhat.com>
References: <20180823222249.13518-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/13] block/mirror: conservative
 mirror_exit refactor
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

For purposes of minimum code movement, refactor the mirror_exit
callback to use the post-finalization callbacks in a trivial way.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 837279e979..f5b504406d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -79,6 +79,7 @@ typedef struct MirrorBlockJob {
     int max_iov;
     bool initial_zeroing_ongoing;
     int in_active_write_counter;
+    bool prepared;
 } MirrorBlockJob;
 
 typedef struct MirrorBDSOpaque {
@@ -607,7 +608,7 @@ static void mirror_wait_for_all_io(MirrorBlockJob *s)
     }
 }
 
-static void mirror_exit(Job *job)
+static int mirror_exit_common(Job *job)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
     BlockJob *bjob = &s->common;
@@ -619,6 +620,11 @@ static void mirror_exit(Job *job)
     Error *local_err = NULL;
     int ret = job->ret;
 
+    if (s->prepared) {
+        return ret;
+    }
+    s->prepared = true;
+
     bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
 
     /* Make sure that the source BDS doesn't go away before we called
@@ -711,7 +717,17 @@ static void mirror_exit(Job *job)
     bdrv_unref(mirror_top_bs);
     bdrv_unref(src);
 
-    job->ret = ret;
+    return ret;
+}
+
+static int mirror_prepare(Job *job)
+{
+    return mirror_exit_common(job);
+}
+
+static void mirror_abort(Job *job)
+{
+    mirror_exit_common(job);
 }
 
 static void mirror_throttle(MirrorBlockJob *s)
@@ -1132,7 +1148,8 @@ static const BlockJobDriver mirror_job_driver = {
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
         .run                    = mirror_run,
-        .exit                   = mirror_exit,
+        .prepare                = mirror_prepare,
+        .abort                  = mirror_abort,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
@@ -1149,7 +1166,8 @@ static const BlockJobDriver commit_active_job_driver = {
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
         .run                    = mirror_run,
-        .exit                   = mirror_exit,
+        .prepare                = mirror_prepare,
+        .abort                  = mirror_abort,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
-- 
2.14.4
