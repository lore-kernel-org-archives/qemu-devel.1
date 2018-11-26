Received: from eggs.gnu.org ([2001:4830:134:3::10]:54801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pizhenwei@bytedance.com>) id 1gR82E-0007sZ-5h
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 22:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pizhenwei@bytedance.com>) id 1gR829-0003OJ-DW
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 22:58:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
	id 1gR829-0003NG-4l
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 22:58:05 -0500
Received: by mail-pl1-x644.google.com with SMTP id gn14so13196949plb.10
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 19:58:04 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
Date: Mon, 26 Nov 2018 11:57:58 +0800
Message-Id: <1543204678-26914-1-git-send-email-pizhenwei@bytedance.com>
Subject: [Qemu-devel] [PATCH] file-posix: Check effective size in truncate
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: pizhenwei@bytedance.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Function raw_co_truncate does not check effective size for BLK device file,
and QEMU may notify guest without any size changing.

Two cases can be reproduced easily by qmp command:
CASE 1:
1, create a logical volume(12M) by LVM, and guest uses this volume as "vdb"
2, run qmp command : virsh qemu-monitor-command INSTANCE '{"execute":
"block_resize", "arguments":{"device":"drive-virtio-disk1","size":12582912}}'

The effective size(12M) is equal to the argument(12M) and the real device file
size(12M). QEMU should ignore this command and has no need to notify guest.

CASE 2:
1, create a logical volume(12M) by LVM, and guest uses this volume as "vdb"
2, resize LV to 16M by lvresize command
3, run qmp command : virsh qemu-monitor-command INSTANCE '{"execute":
"block_resize", "arguments":{"device":"drive-virtio-disk1","size":10485760}}'

The device file size actually grew, but the argument(10M) is less than the
effective size(12M). This command should fail, but QEMU still report success.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/file-posix.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bbdab953..951d910b0b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1991,6 +1991,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
     BDRVRawState *s = bs->opaque;
     struct stat st;
     int ret;
+    int64_t sectors;
 
     if (fstat(s->fd, &st)) {
         ret = -errno;
@@ -2013,6 +2014,20 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
             error_setg(errp, "Cannot grow device files");
             return -EINVAL;
         }
+
+        sectors = raw_getlength(bs) >> BDRV_SECTOR_BITS;
+        if (sectors > bs->total_sectors) {
+            /* device size actually grew */
+            if (offset <= bs->total_sectors * BDRV_SECTOR_SIZE) {
+                error_setg(errp, "The effective size of this device is "
+                        "greater than or equal to the argument");
+                return -EINVAL;
+            }
+        } else if (sectors == bs->total_sectors) {
+            /* device size actually not changed */
+            error_setg(errp, "Detect device file size not changing");
+            return -EINVAL;
+        }
     } else {
         error_setg(errp, "Resizing this file is not supported");
         return -ENOTSUP;
-- 
2.11.0
