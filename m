Received: from eggs.gnu.org ([2001:4830:134:3::10]:58119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gCEwn-0003Bo-GV
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 22:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gCEwa-0004sz-Ba
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 22:18:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:26038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gCEwZ-0004e5-Q3
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 22:18:48 -0400
From: Zhao Yan <yan.y.zhao@intel.com>
Date: Mon, 15 Oct 2018 22:14:39 -0400
Message-Id: <20181016021439.6212-1-yan.y.zhao@intel.com>
Subject: [Qemu-devel] [PATCH] Xen PCI passthrough: fix passthrough failure
 when irq map failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org
Cc: Zhao Yan <yan.y.zhao@intel.com>

Commit 5a11d0f7 mistakenly converted a log message into an error
condition when irq map is failed for the pci device being
passed through. Revert that part of the commit.

Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>
---
 hw/xen/xen_pt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index e5a6eff44f..840fd0f748 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -849,7 +849,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
     machine_irq = s->real_device.irq;
     rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
     if (rc < 0) {
-        error_setg_errno(errp, errno, "Mapping machine irq %u to"
+        XEN_PT_ERR(d, "Mapping machine irq %u to"
                          " pirq %i failed", machine_irq, pirq);
 
         /* Disable PCI intx assertion (turn on bit10 of devctl) */
@@ -871,7 +871,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
                                        PCI_SLOT(d->devfn),
                                        e_intx);
         if (rc < 0) {
-            error_setg_errno(errp, errno, "Binding of interrupt %u failed",
+            XEN_PT_ERR(d, "Binding of interrupt %u failed",
                              e_intx);
 
             /* Disable PCI intx assertion (turn on bit10 of devctl) */
-- 
2.17.1
