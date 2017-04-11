Received: from eggs.gnu.org ([2001:4830:134:3::10]:59716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxw6B-0007uL-Fu
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxw6A-0002Z9-6x
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:44:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Apr 2017 15:44:34 +0200
Message-Id: <20170411134435.27271-3-mreitz@redhat.com>
In-Reply-To: <20170411134435.27271-1-mreitz@redhat.com>
References: <20170411134435.27271-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] throttle: Remove block from group on
 hot-unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Eric Blake <eblake@redhat.com>

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
Message-id: 20170406190847.29347-1-eblake@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-backend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index a8f2b3440f..7405024e08 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -231,6 +231,9 @@ static void blk_delete(BlockBackend *blk)
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
2.12.2
