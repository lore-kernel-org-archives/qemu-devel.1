Received: from eggs.gnu.org ([2001:4830:134:3::10]:58441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dXatD-00085T-1A
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dXatC-0004Sv-2B
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dXatB-0004Rn-Rw
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:45 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 18 Jul 2017 15:22:37 -0700
Message-Id: <1500416562-27337-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1500416562-27337-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
	<1500416562-27337-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL for-2.10 2/7] xen_pt_msi.c: Check for
 xen_host_pci_get_* failures in xen_pt_msix_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Check the return status of the xen_host_pci_get_* functions we call in
xen_pt_msix_init(), and fail device init if the reads failed rather than
ploughing ahead. (Spotted by Coverity: CID 777338.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen_pt_msi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index 62add06..ff9a79f 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -535,7 +535,11 @@ int xen_pt_msix_init(XenPCIPassthroughState *s, uint32_t base)
         return -1;
     }
 
-    xen_host_pci_get_word(hd, base + PCI_MSIX_FLAGS, &control);
+    rc = xen_host_pci_get_word(hd, base + PCI_MSIX_FLAGS, &control);
+    if (rc) {
+        XEN_PT_ERR(d, "Failed to read PCI_MSIX_FLAGS field\n");
+        return rc;
+    }
     total_entries = control & PCI_MSIX_FLAGS_QSIZE;
     total_entries += 1;
 
@@ -554,7 +558,11 @@ int xen_pt_msix_init(XenPCIPassthroughState *s, uint32_t base)
                            + XC_PAGE_SIZE - 1)
                           & XC_PAGE_MASK);
 
-    xen_host_pci_get_long(hd, base + PCI_MSIX_TABLE, &table_off);
+    rc = xen_host_pci_get_long(hd, base + PCI_MSIX_TABLE, &table_off);
+    if (rc) {
+        XEN_PT_ERR(d, "Failed to read PCI_MSIX_TABLE field\n");
+        goto error_out;
+    }
     bar_index = msix->bar_index = table_off & PCI_MSIX_FLAGS_BIRMASK;
     table_off = table_off & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->table_base = s->real_device.io_regions[bar_index].base_addr;
-- 
1.9.1
