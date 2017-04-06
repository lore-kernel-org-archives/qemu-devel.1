Received: from eggs.gnu.org ([2001:4830:134:3::10]:48259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwCmE-0004pb-2D
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 15:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwCmC-0007nN-SE
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 15:09:02 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  6 Apr 2017 14:08:47 -0500
Message-Id: <20170406190847.29347-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] throttle: Remove block from group on
 hot-unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

When a block device that is part of a throttle group is hot-unplugged,
we forgot to remove it from the throttle group. This leaves stale
memory around, and causes an easily reproducible crash:

$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio \
-device virtio-scsi-pci,bus=pci.0 -drive \
id=drive_image2,if=none,format=raw,file=file2,bps=512000,iops=100,group=foo \
-device scsi-hd,id=image2,drive=drive_image2 -drive \
id=drive_image3,if=none,format=raw,file=file3,bps=512000,iops=100,group=foo \
-device scsi-hd,id=image3,drive=drive_image3
{'execute':'qmp_capabilities'}
{'execute':'device_del','arguments':{'id':'image3'}}
{'execute':'system_reset'}

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1428810

Suggested-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/block-backend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 0b63773..d27c3a3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -230,6 +230,9 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
+    if (blk->public.throttle_state) {
+        blk_io_limits_disable(blk);
+    }
     if (blk->root) {
         blk_remove_bs(blk);
     }
-- 
2.9.3
