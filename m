Received: from eggs.gnu.org ([2001:4830:134:3::10]:47931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgIDH-0000Ao-7V
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgIDC-0003TU-B9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:43:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cgIDC-0003RR-2f
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:43:06 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D34461B91
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 21:43:05 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 21 Feb 2017 14:43:03 -0700
Message-ID: <20170221214228.12515.79751.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vfio/pci: Improve extended capability comments,
 skip masked caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Since commit 4bb571d857d9 ("pci/pcie: don't assume cap id 0 is
reserved") removes the internal use of extended capability ID 0, the
comment here becomes invalid.  However, peeling back the onion, the
code is still correct and we still can't seed the capability chain
with ID 0, unless we want to muck with using the version number to
force the header to be non-zero, which is much uglier to deal with.
The comment also now covers some of the subtleties of using cap ID 0,
such as transparently indicating absence of capabilities if none are
added.  This doesn't detract from the correctness of the referenced
commit as vfio in the kernel also uses capability ID zero to mask
capabilties.  In fact, we should skip zero capabilities precisely
because the kernel might also expose such a capability at the head
position and re-introduce the problem.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/pci.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index f2ba9b6cfafc..03a3d0154976 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1880,16 +1880,26 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     /*
      * Extended capabilities are chained with each pointing to the next, so we
      * can drop anything other than the head of the chain simply by modifying
-     * the previous next pointer.  For the head of the chain, we can modify the
-     * capability ID to something that cannot match a valid capability.  ID
-     * 0 is reserved for this since absence of capabilities is indicated by
-     * 0 for the ID, version, AND next pointer.  However, pcie_add_capability()
-     * uses ID 0 as reserved for list management and will incorrectly match and
-     * assert if we attempt to pre-load the head of the chain with this ID.
-     * Use ID 0xFFFF temporarily since it is also seems to be reserved in
-     * part for identifying absence of capabilities in a root complex register
-     * block.  If the ID still exists after adding capabilities, switch back to
-     * zero.  We'll mark this entire first dword as emulated for this purpose.
+     * the previous next pointer.  Seed the head of the chain here such that
+     * we can simply skip any capabilities we want to drop below, regardless
+     * of their position in the chain.  If this stub capability still exists
+     * after we add the capabilities we want to expose, update the capability
+     * ID to zero.  Note that we cannot seed with the capability header being
+     * zero as this conflicts with definition of an absent capability chain
+     * and prevents capabilities beyond the head of the list from being added.
+     * By replacing the dummy capability ID with zero after walking the device
+     * chain, we also transparently mark extended capabilities as absent if
+     * no capabilities were added.  Note that the PCIe spec defines an absence
+     * of extended capabilities to be determined by a value of zero for the
+     * capability ID, version, AND next pointer.  A non-zero next pointer
+     * should be sufficient to indicate additional capabilities are present,
+     * which will occur if we call pcie_add_capability() below.  The entire
+     * first dword is emulated to support this.
+     *
+     * NB. The kernel side does similar masking, so be prepared that our
+     * view of the device may also contain a capability ID zero in the head
+     * of the chain.  Skip it for the same reason that we cannot seed the
+     * chain with a zero capability.
      */
     pci_set_long(pdev->config + PCI_CONFIG_SPACE_SIZE,
                  PCI_EXT_CAP(0xFFFF, 0, 0));
@@ -1915,6 +1925,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
                                    PCI_EXT_CAP_NEXT_MASK);
 
         switch (cap_id) {
+        case 0: /* kernel masked capability */
         case PCI_EXT_CAP_ID_SRIOV: /* Read-only VF BARs confuse OVMF */
         case PCI_EXT_CAP_ID_ARI: /* XXX Needs next function virtualization */
             trace_vfio_add_ext_cap_dropped(vdev->vbasedev.name, cap_id, next);
