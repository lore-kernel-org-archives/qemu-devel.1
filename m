Received: from eggs.gnu.org ([2001:4830:134:3::10]:42360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBn-0002XI-Fn
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBk-0001Dv-B5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBk-0001Ck-2U
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hd9S016417
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:23 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm5151q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:22 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:22 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:16 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-23-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 22/67] vfio/pci: Fix regression in MSI routing
 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, Gavin Shan <gwshan@au1.ibm.com>

From: David Gibson <david@gibson.dropbear.id.au>

d1f6af6 "kvm-irqchip: simplify kvm_irqchip_add_msi_route" was a cleanup
of kvmchip routing configuration, that was mostly intended for x86.
However, it also contains a subtle change in behaviour which breaks EEH[1]
error recovery on certain VFIO passthrough devices on spapr guests.  So far
it's only been seen on a BCM5719 NIC on a POWER8 server, but there may be
other hardware with the same problem.  It's also possible there could be
circumstances where it causes a bug on x86 as well, though I don't know of
any obvious candidates.

Prior to d1f6af6, both vfio_msix_vector_do_use() and
vfio_add_kvm_msi_virq() used msg == NULL as a special flag to mark this
as the "dummy" vector used to make the host hardware state sync with the
guest expected hardware state in terms of MSI configuration.

Specifically that flag caused vfio_add_kvm_msi_virq() to become a no-op,
meaning the dummy irq would always be delivered via qemu. d1f6af6 changed
vfio_add_kvm_msi_virq() so it takes a vector number instead of the msg
parameter, and determines the correct message itself.  The test for !msg
was removed, and not replaced with anything there or in the caller.

With an spapr guest which has a VFIO device, if an EEH error occurs on the
host hardware, then the device will be isolated then reset.  This is a
combination of host and guest action, mediated by some EEH related
hypercalls.  I haven't fully traced the mechanics, but somehow installing
the kvm irqchip route for the dummy irq on the BCM5719 means that after EEH
reset and recovery, at least some irqs are no longer delivered to the
guest.

In particular, the guest never gets the link up event, and so the NIC is
effectively dead.

[1] EEH (Enhanced Error Handling) is an IBM POWER server specific PCI-*
    error reporting and recovery mechanism.  The concept is somewhat
    similar to PCI-E AER, but the details are different.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1373802

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Gavin Shan <gwshan@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-stable@nongnu.org
Fixes: d1f6af6a17a6 ("kvm-irqchip: simplify kvm_irqchip_add_msi_route")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
(cherry picked from commit 6d17a018d09801a2b18133a4febd81433bb0cf85)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7bfa17c..a5a620a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -496,7 +496,9 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             vfio_update_kvm_msi_virq(vector, *msg, pdev);
         }
     } else {
-        vfio_add_kvm_msi_virq(vdev, vector, nr, true);
+        if (msg) {
+            vfio_add_kvm_msi_virq(vdev, vector, nr, true);
+        }
     }
 
     /*
-- 
1.9.1
