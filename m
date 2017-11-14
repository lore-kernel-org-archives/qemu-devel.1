Received: from eggs.gnu.org ([2001:4830:134:3::10]:54265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexc-0006s3-H4
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexb-0004m0-7t
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:25:20 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:15 +0100
Message-Id: <20171114172417.7654-19-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 18/20] block/parallels: Do not update header or
 truncate image when INMIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Jeff Cody <jcody@redhat.com>

If we write or modify the image file while the QEMU run state is
INMIGRATE, then the BDRV_O_INACTIVE BDS flag is set.  This will cause
an assert, since the image is marked inactive.  Make sure we obey this
flag.

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Message-id: 3996c930fa8cde8570b7a63032720d76a28fd78b.1510059970.git.jcody@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/parallels.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 2b6c6e5709..7b7a3efa1d 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -708,7 +708,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
 
-    if (flags & BDRV_O_RDWR) {
+    if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
         s->header->inuse = cpu_to_le32(HEADER_INUSE_MAGIC);
         ret = parallels_update_header(bs);
         if (ret < 0) {
@@ -741,12 +741,9 @@ static void parallels_close(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
 
-    if (bs->open_flags & BDRV_O_RDWR) {
+    if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
         s->header->inuse = 0;
         parallels_update_header(bs);
-    }
-
-    if (bs->open_flags & BDRV_O_RDWR) {
         bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
                       PREALLOC_MODE_OFF, NULL);
     }
-- 
2.13.6
