Received: from eggs.gnu.org ([2001:4830:134:3::10]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVHEA-0007Mh-5E
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVHE9-0001bt-En
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Jul 2017 14:57:27 +0200
Message-Id: <1499864249-26305-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] scsi-disk: bdrv_attach_dev() for empty
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

If no drive=... option is passed (for an empty drive), we don't only
lack the BlockBackend normally created by parse_drive(), but we also
need to manually call blk_attach_dev().

This fixes at least a segfault when unplugging such devices, the bug
that they didn't show up in query-block, and probably some more
problems.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
