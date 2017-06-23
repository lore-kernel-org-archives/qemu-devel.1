Received: from eggs.gnu.org ([2001:4830:134:3::10]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMl-00029u-9a
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMk-0008Ln-BF
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:56 +0200
Message-Id: <1498234919-27316-59-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 58/61] blkdebug: Catch bs->exact_filename
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
blkdebug node filename. In this case, we should not generate a filename
at all instead of an unusable one.

Cc: qemu-stable@nongnu.org
Reported-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170613172006.19685-2-mreitz@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkdebug.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 6431962..a1b24b9 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -839,9 +839,13 @@ static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 
     if (!force_json && bs->file->bs->exact_filename[0]) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "blkdebug:%s:%s", s->config_file ?: "",
-                 bs->file->bs->exact_filename);
+        int ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                           "blkdebug:%s:%s", s->config_file ?: "",
+                           bs->file->bs->exact_filename);
+        if (ret >= sizeof(bs->exact_filename)) {
+            /* An overflow makes the filename unusable, so do not report any */
+            bs->exact_filename[0] = 0;
+        }
     }
 
     opts = qdict_new();
-- 
1.8.3.1
