Received: from eggs.gnu.org ([2001:4830:134:3::10]:38598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ehCvB-00086X-6O
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ehCv8-0006Dc-3S
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:20:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ehCv7-0006DB-Tn
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:20:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C122EA342B
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 11:20:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Feb 2018 19:20:28 +0800
Message-Id: <20180201112028.23552-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] pcie-root-port: let it has higher migrate
 priority
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

In the past, we prioritized IOMMU migration so that we have such a
priority order:

    IOMMU > PCI Devices

When migrating a guest with both vIOMMU and pcie-root-port, we'll always
migrate vIOMMU first, since pcie-root-port will be seen to have the same
priority of general PCI devices.

That's problematic.

The thing is that PCI bus number information is stored in the root port,
and that is needed by vIOMMU during post_load(), e.g., to figure out
context entry for a device.  If we don't have correct bus numbers for
devices, we won't be able to recover device state of the DMAR memory
regions, and things will be messed up.

So let's boost the PCIe root ports to be even with higher priority:

   PCIe Root Port > IOMMU > PCI Devices

A smoke test shows that this patch fixes bug 1538953.

CC: Alex Williamson <alex.williamson@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Laurent Vivier <lvivier@redhat.com>
Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1538953
Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
Marcel & all,

I think it's possible that we need similar thing for other bridge-like
devices, but I'm not that familiar.  Would you help confirm?  Thanks,
---
 hw/pci-bridge/gen_pcie_root_port.c | 1 +
 include/migration/vmstate.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 0e2f2e8bf1..e6ff1effd8 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -101,6 +101,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_rp_dev = {
     .name = "pcie-root-port",
+    .priority = MIG_PRI_PCIE_ROOT_PORT,
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pcie_cap_slot_post_load,
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 8c3889433c..491449db9f 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -148,6 +148,7 @@ enum VMStateFlags {
 typedef enum {
     MIG_PRI_DEFAULT = 0,
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
+    MIG_PRI_PCIE_ROOT_PORT,     /* Must happen before IOMMU */
     MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
     MIG_PRI_GICV3,              /* Must happen before the ITS */
     MIG_PRI_MAX,
-- 
2.14.3
