Received: from eggs.gnu.org ([2001:4830:134:3::10]:50603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e99qR-0007DG-O6
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e99qL-0001nr-UC
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:11:11 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 30 Oct 2017 14:10:27 +0100
Message-Id: <e3abcb61ba8cdc2bb236368ab14a9037cbe7729b.1509368614.git.jcody@redhat.com>
In-Reply-To: <cover.1509368614.git.jcody@redhat.com>
References: <cover.1509368614.git.jcody@redhat.com>
In-Reply-To: <cover.1509368614.git.jcody@redhat.com>
References: <cover.1509368614.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] block/parallals: Do not update header
 or truncate image when INMIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com

If we write or modify the image file while the QEMU run state is
INMIGRATE, then the BDRV_O_INACTIVE BDS flag is set.  This will cause
an assert, since the image is marked inactive.  Make sure we obey this
flag.

Signed-off-by: Jeff Cody <jcody@redhat.com>
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
