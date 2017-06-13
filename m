Received: from eggs.gnu.org ([2001:4830:134:3::10]:57520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKpUH-0002cX-MS
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKpUG-00010V-Q4
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:20:17 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 19:20:05 +0200
Message-Id: <20170613172006.19685-2-mreitz@redhat.com>
In-Reply-To: <20170613172006.19685-1-mreitz@redhat.com>
References: <20170613172006.19685-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] blkdebug: Catch bs->exact_filename overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The bs->exact_filename field may not be sufficient to store the full
blkdebug node filename. In this case, we should not generate a filename
at all instead of an unusable one.

Cc: qemu-stable@nongnu.org
Reported-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkdebug.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a5196e8..6166d6a 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -840,9 +840,13 @@ static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
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
2.9.4
