Received: from eggs.gnu.org ([2001:4830:134:3::10]:53221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKa-0000Wf-Bq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKZ-0007ho-Ew
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:56 +0200
Message-Id: <1500387486-5469-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/21] ide: bdrv_attach_dev() for empty CD-ROM
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

IDE does not support hot unplug, but if it did, qdev would take care to
call the matching blk_detach_dev() on unplug.

This fixes at least the bug that such devices didn't show up in
query-block, and probably some more problems.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
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
