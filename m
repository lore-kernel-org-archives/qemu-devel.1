Received: from eggs.gnu.org ([2001:4830:134:3::10]:60939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMm-0002BB-E8
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMl-0008NA-Iy
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:57 +0200
Message-Id: <1498234919-27316-60-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 59/61] blkverify: Catch bs->exact_filename
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

The bs->exact_filename field may not be sufficient to store the full
blkverify node filename. In this case, we should not generate a filename
at all instead of an unusable one.

Cc: qemu-stable@nongnu.org
Reported-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170613172006.19685-3-mreitz@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkverify.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index 6b0a603..06369f9 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -301,10 +301,14 @@ static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
     if (bs->file->bs->exact_filename[0]
         && s->test_file->bs->exact_filename[0])
     {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "blkverify:%s:%s",
-                 bs->file->bs->exact_filename,
-                 s->test_file->bs->exact_filename);
+        int ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                           "blkverify:%s:%s",
+                           bs->file->bs->exact_filename,
+                           s->test_file->bs->exact_filename);
+        if (ret >= sizeof(bs->exact_filename)) {
+            /* An overflow makes the filename unusable, so do not report any */
+            bs->exact_filename[0] = 0;
+        }
     }
 }
 
-- 
1.8.3.1
