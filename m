Received: from eggs.gnu.org ([2001:4830:134:3::10]:58508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T2-00071E-QM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T1-0004zf-Qy
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  5 Jul 2018 12:26:04 +0200
Message-Id: <20180705102604.4986-13-kwolf@redhat.com>
In-Reply-To: <20180705102604.4986-1-kwolf@redhat.com>
References: <20180705102604.4986-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v2 12/12] file-posix: Unlock FD after creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Closing the FD does not necessarily mean that it is unlocked.  Fix this
by relinquishing all permission locks before qemu_close().

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index b57c58e80f..98987b80f1 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2111,6 +2111,7 @@ static int coroutine_fn
 raw_co_create(BlockdevCreateOptions *options, Error **errp)
 {
     BlockdevCreateOptionsFile *file_opts;
+    Error *local_err = NULL;
     int fd;
     uint64_t perm, shared;
     int result = 0;
@@ -2156,13 +2157,13 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     /* Step two: Check that nobody else has taken conflicting locks */
     result = raw_check_lock_bytes(fd, perm, shared, errp);
     if (result < 0) {
-        goto out_close;
+        goto out_unlock;
     }
 
     /* Clear the file by truncating it to 0 */
     result = raw_regular_truncate(NULL, fd, 0, PREALLOC_MODE_OFF, errp);
     if (result < 0) {
-        goto out_close;
+        goto out_unlock;
     }
 
     if (file_opts->nocow) {
@@ -2185,7 +2186,17 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     result = raw_regular_truncate(NULL, fd, file_opts->size,
                                   file_opts->preallocation, errp);
     if (result < 0) {
-        goto out_close;
+        goto out_unlock;
+    }
+
+out_unlock:
+    raw_apply_lock_bytes(fd, 0, 0, true, &local_err);
+    if (local_err) {
+        /* The above call should not fail, and if it does, that does
+         * not mean the whole creation operation has failed.  So
+         * report it the user for their convenience, but do not report
+         * it to the caller. */
+        error_report_err(local_err);
     }
 
 out_close:
-- 
2.13.6
