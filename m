Received: from eggs.gnu.org ([2001:4830:134:3::10]:57560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKpUK-0002fM-MD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKpUJ-00014M-Ps
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:20:20 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 19:20:06 +0200
Message-Id: <20170613172006.19685-3-mreitz@redhat.com>
In-Reply-To: <20170613172006.19685-1-mreitz@redhat.com>
References: <20170613172006.19685-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] blkverify: Catch bs->exact_filename
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The bs->exact_filename field may not be sufficient to store the full
blkverify node filename. In this case, we should not generate a filename
at all instead of an unusable one.

Cc: qemu-stable@nongnu.org
Reported-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
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
2.9.4
