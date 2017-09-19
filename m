Received: from eggs.gnu.org ([2001:4830:134:3::10]:42218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOzS-0005DR-Ng
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOzR-0004e3-P6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Sep 2017 15:18:51 -0500
Message-Id: <20170919201910.25656-2-eblake@redhat.com>
In-Reply-To: <20170919201910.25656-1-eblake@redhat.com>
References: <20170919201910.25656-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 01/20] block: Make bdrv_img_create() size
 selection easier to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

All callers of bdrv_img_create() pass in a size, or -1 to read the
size from the backing file.  We then set that size as the QemuOpt
default, which means we will reuse that default rather than the
final parameter to qemu_opt_get_size() several lines later.  But
it is rather confusing to read subsequent checks of 'size == -1'
when it looks (without seeing the full context) like size defaults
to 0; it also doesn't help that a size of 0 is valid (for some
formats).

Rework the logic to make things more legible.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v6: Combine into a series rather than being a standalone patch (more for
ease of tracking than for being on topic)
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 6dd47e414e..ee6a48976e 100644
--- a/block.c
+++ b/block.c
@@ -4393,7 +4393,7 @@ void bdrv_img_create(const char *filename, const char *fmt,

     /* The size for the image must always be specified, unless we have a backing
      * file and we have not been forbidden from opening it. */
-    size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
+    size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, img_size);
     if (backing_file && !(flags & BDRV_O_NO_BACKING)) {
         BlockDriverState *bs;
         char *full_backing = g_new0(char, PATH_MAX);
-- 
2.13.5
