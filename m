Received: from eggs.gnu.org ([2001:4830:134:3::10]:33691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyhGh-0006JY-65
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyhGg-0004BC-Az
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:06:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 13 Apr 2017 18:06:24 +0200
Message-Id: <20170413160625.27719-2-mreitz@redhat.com>
In-Reply-To: <20170413160625.27719-1-mreitz@redhat.com>
References: <20170413160625.27719-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/2] block: An empty filename counts
 as no filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

Reproducer:
    $ ./qemu-img info ''
    qemu-img: ./block.c:1008: bdrv_open_driver: Assertion
        `!drv->bdrv_needs_filename || bs->filename[0]' failed.
    [1]    26105 abort (core dumped)  ./qemu-img info ''

This patch fixes this to be:
    $ ./qemu-img info ''
    qemu-img: Could not open '': The 'file' block driver requires a file
    name

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1fbbb8d606..46da908c93 100644
--- a/block.c
+++ b/block.c
@@ -1167,7 +1167,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
         filename = qdict_get_try_str(options, "filename");
     }
 
-    if (drv->bdrv_needs_filename && !filename) {
+    if (drv->bdrv_needs_filename && (!filename || !filename[0])) {
         error_setg(errp, "The '%s' block driver requires a file name",
                    drv->format_name);
         ret = -EINVAL;
-- 
2.12.2
