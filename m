Received: from eggs.gnu.org ([2001:4830:134:3::10]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gEamp-0002BY-JU
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gEamj-0003hW-7W
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:02:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 22 Oct 2018 22:02:04 +0800
Message-Id: <20181022140204.15791-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com

Use error_report for situations that affect user operation (i.e.  we're
actually returning error), and warn_report/warn_report_err when some
less critical error happened but the user operation can still carry on.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 2da3a76355..2a46899313 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -214,8 +214,7 @@ static int raw_normalize_devicepath(const char **filename)
     fname = *filename;
     dp = strrchr(fname, '/');
     if (lstat(fname, &sb) < 0) {
-        fprintf(stderr, "%s: stat failed: %s\n",
-            fname, strerror(errno));
+        error_report("%s: stat failed: %s", fname, strerror(errno));
         return -errno;
     }
 
@@ -229,9 +228,8 @@ static int raw_normalize_devicepath(const char **filename)
         snprintf(namebuf, PATH_MAX, "%.*s/r%s",
             (int)(dp - fname), fname, dp + 1);
     }
-    fprintf(stderr, "%s is a block device", fname);
     *filename = namebuf;
-    fprintf(stderr, ", using %s\n", *filename);
+    warn_report("%s is a block device, using %s", fname, *filename);
 
     return 0;
 }
@@ -492,11 +490,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     case ON_OFF_AUTO_ON:
         s->use_lock = true;
         if (!qemu_has_ofd_lock()) {
-            fprintf(stderr,
+            warn_report(
                     "File lock requested but OFD locking syscall is "
-                    "unavailable, falling back to POSIX file locks.\n"
+                    "unavailable, falling back to POSIX file locks. "
                     "Due to the implementation, locks can be lost "
-                    "unexpectedly.\n");
+                    "unexpectedly.");
         }
         break;
     case ON_OFF_AUTO_OFF:
@@ -805,7 +803,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
             /* Theoretically the above call only unlocks bytes and it cannot
              * fail. Something weird happened, report it.
              */
-            error_report_err(local_err);
+            warn_report_err(local_err);
         }
         break;
     case RAW_PL_COMMIT:
@@ -815,7 +813,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
             /* Theoretically the above call only unlocks bytes and it cannot
              * fail. Something weird happened, report it.
              */
-            error_report_err(local_err);
+            warn_report_err(local_err);
         }
         break;
     }
@@ -1775,7 +1773,7 @@ static int aio_worker(void *arg)
         ret = handle_aiocb_truncate(aiocb);
         break;
     default:
-        fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type);
+        error_report("invalid aio request (0x%x)", aiocb->aio_type);
         ret = -EINVAL;
         break;
     }
@@ -2263,7 +2261,7 @@ out_unlock:
          * not mean the whole creation operation has failed.  So
          * report it the user for their convenience, but do not report
          * it to the caller. */
-        error_report_err(local_err);
+        warn_report_err(local_err);
     }
 
 out_close:
-- 
2.17.1
