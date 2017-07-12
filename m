Received: from eggs.gnu.org ([2001:4830:134:3::10]:45400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVHEA-0007Mi-5Y
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVHE9-0001by-Fg
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Jul 2017 14:57:26 +0200
Message-Id: <1499864249-26305-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 6/9] ide: bdrv_attach_dev() for empty CD-ROM
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

IDE does not support hot unplug, but if it did, qdev would take care to
call the matching blk_detach_dev() on unplug.

This fixes at least the bug that such devices didn't show up in
query-block, and probably some more problems.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/ide/qdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 299e592..cc2f5bd 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -164,6 +164,7 @@ static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
     IDEState *s = bus->ifs + dev->unit;
     Error *err = NULL;
+    int ret;
 
     if (!dev->conf.blk) {
         if (kind != IDE_CD) {
@@ -172,6 +173,8 @@ static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
         } else {
             /* Anonymous BlockBackend for an empty drive */
             dev->conf.blk = blk_new(0, BLK_PERM_ALL);
+            ret = blk_attach_dev(dev->conf.blk, &dev->qdev);
+            assert(ret == 0);
         }
     }
 
-- 
1.8.3.1
