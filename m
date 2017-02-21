Received: from eggs.gnu.org ([2001:4830:134:3::10]:42728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuS-0008Es-1h
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuR-0007qj-1t
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:06 +0100
Message-Id: <1487689130-30373-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 10/54] vvfat: Use opened node as backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

We should not try to assign a not yet opened node as the backing file,
because as soon as the permission system is added it will fail.  The
just added bdrv_new_open_driver() function is the right tool to open a
file with an internal driver, use it.

In case anyone wonders whether that magic fake backing file to trigger a
special action on 'commit' actually works today: No, not for me. One
reason is that we've been adding a raw format driver on top for several
years now and raw doesn't support commit. Other reasons include that the
backing file isn't writable and the driver doesn't support reopen, and
it's also size 0 and the driver doesn't support bdrv_truncate. All of
these are easily fixable, but then 'commit' ended up in an infinite loop
deep in the vvfat code for me, so I thought I'd best leave it alone. I'm
not really sure what it was supposed to do anyway.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index c6bf67e..7f230be 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2968,6 +2968,7 @@ static void write_target_close(BlockDriverState *bs) {
 
 static BlockDriver vvfat_write_target = {
     .format_name        = "vvfat_write_target",
+    .instance_size      = sizeof(void*),
     .bdrv_co_pwritev    = write_target_commit,
     .bdrv_close         = write_target_close,
 };
@@ -3036,14 +3037,13 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
     unlink(s->qcow_filename);
 #endif
 
-    backing = bdrv_new();
+    backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
+                                   &error_abort);
+    *(void**) backing->opaque = s;
+
     bdrv_set_backing_hd(s->bs, backing);
     bdrv_unref(backing);
 
-    s->bs->backing->bs->drv = &vvfat_write_target;
-    s->bs->backing->bs->opaque = g_new(void *, 1);
-    *(void**)s->bs->backing->bs->opaque = s;
-
     return 0;
 
 err:
-- 
1.8.3.1
