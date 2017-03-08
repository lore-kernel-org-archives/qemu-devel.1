Received: from eggs.gnu.org ([2001:4830:134:3::10]:55141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cljEF-0004ak-Hz
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cljED-0000CW-RS
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:34:39 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  8 Mar 2017 15:34:27 -0600
Message-Id: <20170308213429.29244-2-eblake@redhat.com>
In-Reply-To: <20170308213429.29244-1-eblake@redhat.com>
References: <20170308213429.29244-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] backup: React to bdrv_is_allocated() errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

If bdrv_is_allocated() fails, we should immediately do the backup
error action, rather than attempting backup_do_cow() (although
that will likely fail too).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/backup.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d3d20db..a4fb288 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -468,13 +468,14 @@ static void coroutine_fn backup_run(void *opaque)
         /* Both FULL and TOP SYNC_MODE's require copying.. */
         for (; start < end; start++) {
             bool error_is_read;
+            int alloced = 0;
+
             if (yield_and_check(job)) {
                 break;
             }

             if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
                 int i, n;
-                int alloced = 0;

                 /* Check to see if these blocks are already in the
                  * backing file. */
@@ -492,7 +493,7 @@ static void coroutine_fn backup_run(void *opaque)
                                 sectors_per_cluster - i, &n);
                     i += n;

-                    if (alloced == 1 || n == 0) {
+                    if (alloced || n == 0) {
                         break;
                     }
                 }
@@ -504,8 +505,13 @@ static void coroutine_fn backup_run(void *opaque)
                 }
             }
             /* FULL sync mode we copy the whole drive. */
-            ret = backup_do_cow(job, start * sectors_per_cluster,
-                                sectors_per_cluster, &error_is_read, false);
+            if (alloced < 0) {
+                ret = alloced;
+            } else {
+                ret = backup_do_cow(job, start * sectors_per_cluster,
+                                    sectors_per_cluster, &error_is_read,
+                                    false);
+            }
             if (ret < 0) {
                 /* Depending on error action, fail now or retry cluster */
                 BlockErrorAction action =
-- 
2.9.3
