Received: from eggs.gnu.org ([2001:4830:134:3::10]:51355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8qF-0002EA-CK
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cS8qE-00021G-Bi
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:52:55 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jan 2017 21:52:32 +0100
Message-Id: <20170113205237.30386-5-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 4/9] block: Do not blindly copy filename
 from file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

bdrv_refresh_filename() can do the same and it has some checks whether
the filename can actually be inherited or not, so we can let it do its
job in bdrv_open_inherit() after bdrv_open_common() has been called.

The only thing we need to set in bdrv_open_common() is the
exact_filename of a BDS without an underlying file, for two reasons:
(1) It cannot be inherited from an underlying file BDS, so it has to be
    set somewhere.
(2) The driver may need the filename in its bdrv_file_open()
    implementation (format drivers do not need their own filename,
    though they may need their file BDS's name).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 9943d8eff6..19f8a84d03 100644
--- a/block.c
+++ b/block.c
@@ -1116,12 +1116,11 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
         bs->detect_zeroes = value;
     }
 
-    if (filename != NULL) {
-        pstrcpy(bs->filename, sizeof(bs->filename), filename);
+    if (!file && filename) {
+        pstrcpy(bs->exact_filename, sizeof(bs->exact_filename), filename);
     } else {
-        bs->filename[0] = '\0';
+        assert(!drv->bdrv_needs_filename);
     }
-    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename), bs->filename);
 
     bs->drv = drv;
     bs->opaque = g_malloc0(drv->instance_size);
-- 
2.11.0
