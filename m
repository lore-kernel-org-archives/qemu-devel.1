Received: from eggs.gnu.org ([2001:4830:134:3::10]:58962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUFDH-0003S1-Cb
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 12:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUFDE-0002Kc-9A
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 12:37:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dUFDE-0002AF-1h
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 12:37:36 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun,  9 Jul 2017 17:37:22 +0100
Message-Id: <20170709163722.19284-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] xen_pt_msi.c: Check for xen_host_pci_get_*
 failures in xen_pt_msix_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Check the return status of the xen_host_pci_get_* functions we call in
xen_pt_msix_init(), and fail device init if the reads failed rather than
ploughing ahead. (Spotted by Coverity: CID 777338.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: compile tested only!

The only other Xen-related Coverity issue outstanding is that
we don't check the return value of net_hub_id_for_client() in
xen_config_dev_nic(), but that's too complicated for me to figure
out what the right thing to do is (or if it's even a bug at all).
---
 hw/xen/xen_pt_msi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index 62add0639f..ff9a79f5d2 100644
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
2.11.0
