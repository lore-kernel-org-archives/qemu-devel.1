Received: from eggs.gnu.org ([2001:4830:134:3::10]:53298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKe-0000hD-IS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKb-0007jG-9M
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:57 +0200
Message-Id: <1500387486-5469-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/21] scsi-disk: bdrv_attach_dev() for empty
 CD-ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

If no drive=... option is passed (for an empty drive), we don't only
lack the BlockBackend normally created by parse_drive(), but we also
need to manually call blk_attach_dev().

This fixes at least a segfault when unplugging such devices, the bug
that they didn't show up in query-block, and probably some more
problems.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 hw/scsi/scsi-disk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a53f058..5f1e5e8 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2384,9 +2384,14 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
 static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    int ret;
 
     if (!dev->conf.blk) {
+        /* Anonymous BlockBackend for an empty drive. As we put it into
+         * dev->conf, qdev takes care of detaching on unplug. */
         dev->conf.blk = blk_new(0, BLK_PERM_ALL);
+        ret = blk_attach_dev(dev->conf.blk, &dev->qdev);
+        assert(ret == 0);
     }
 
     s->qdev.blocksize = 2048;
-- 
1.8.3.1
