Received: from eggs.gnu.org ([2001:4830:134:3::10]:32917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diLds-0007jy-3G
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diLdo-0008F9-Rk
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:19:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 16:19:16 +0200
Message-Id: <1502979556-31791-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr_iommu: Fix crash when removing
 the "spapr-tce-table" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org

QEMU currently aborts unexpectedly when the user tries to add and
remove a "spapr-tce-table" device:

$ qemu-system-ppc64 -nographic -S -nodefaults -monitor stdio
QEMU 2.9.92 monitor - type 'help' for more information
(qemu) device_add spapr-tce-table,id=x
(qemu) device_del x
**
ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
Aborted (core dumped)

The device should not be accessable for the users at all, it's just
used internally, so mark it with user_creatable = false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e614621..ed2d535 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -618,6 +618,8 @@ static void spapr_tce_table_class_init(ObjectClass *klass, void *data)
     dc->init = spapr_tce_table_realize;
     dc->reset = spapr_tce_reset;
     dc->unrealize = spapr_tce_table_unrealize;
+    /* Reason: This is just an internal device for handling the hypercalls */
+    dc->user_creatable = false;
 
     QLIST_INIT(&spapr_tce_tables);
 
-- 
1.8.3.1
