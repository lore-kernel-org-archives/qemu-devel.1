Received: from eggs.gnu.org ([2001:4830:134:3::10]:54736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dk0ju-0000vt-Dn
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dk0jt-00088n-GY
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:24:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 22 Aug 2017 14:24:16 +1000
Message-Id: <20170822042416.26758-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170822042416.26758-1-david@gibson.dropbear.id.au>
References: <20170822042416.26758-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 7/7] hw/ppc/spapr_iommu: Fix crash when removing
 the "spapr-tce-table" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, mdroth@linux.vnet.ibm.com, cohuck@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e614621a83..ed2d53559a 100644
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
2.13.5
