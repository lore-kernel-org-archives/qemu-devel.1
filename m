Received: from eggs.gnu.org ([2001:4830:134:3::10]:47009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Hs-0008Cs-JJ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Hr-0003CZ-DQ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7Hr-0003BN-2j
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:35 -0400
Date: Mon, 3 Jul 2017 22:45:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-12-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 11/21] i386/kvm/pci-assign: Fix return type of
 verify_irqchip_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com, marcel@redhat.com

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

When the function no success value to transmit, it usually make the
function return void. It has turned out not to be a success, because
it means that the extra local_err variable and error_propagate() will
be needed. It leads to cumbersome code, therefore, transmit success/
failure in the return value is worth. So fix the return type to avoid
it.

Cc: pbonzini@redhat.com
Cc: rth@twiddle.net
Cc: ehabkost@redhat.com
Cc: mst@redhat.com
Cc: armbru@redhat.com
Cc: marcel@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/kvm/pci-assign.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
index 3d60455..b7fdb47 100644
--- a/hw/i386/kvm/pci-assign.c
+++ b/hw/i386/kvm/pci-assign.c
@@ -824,12 +824,13 @@ static void assign_device(AssignedDevice *dev, Error **errp)
     }
 }
 
-static void verify_irqchip_in_kernel(Error **errp)
+static int verify_irqchip_in_kernel(Error **errp)
 {
     if (kvm_irqchip_in_kernel()) {
-        return;
+        return -1;
     }
     error_setg(errp, "pci-assign requires KVM with in-kernel irqchip enabled");
+    return 0;
 }
 
 static int assign_intx(AssignedDevice *dev, Error **errp)
@@ -838,7 +839,6 @@ static int assign_intx(AssignedDevice *dev, Error **errp)
     PCIINTxRoute intx_route;
     bool intx_host_msi;
     int r;
-    Error *local_err = NULL;
 
     /* Interrupt PIN 0 means don't use INTx */
     if (assigned_dev_pci_read_byte(&dev->dev, PCI_INTERRUPT_PIN) == 0) {
@@ -846,9 +846,7 @@ static int assign_intx(AssignedDevice *dev, Error **errp)
         return 0;
     }
 
-    verify_irqchip_in_kernel(&local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (verify_irqchip_in_kernel(errp) < 0) {
         return -ENOTSUP;
     }
 
@@ -1246,9 +1244,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
      * MSI capability is the 1st capability in capability config */
     pos = pci_find_cap_offset(pci_dev, PCI_CAP_ID_MSI, 0);
     if (pos != 0 && kvm_check_extension(kvm_state, KVM_CAP_ASSIGN_DEV_IRQ)) {
-        verify_irqchip_in_kernel(&local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (verify_irqchip_in_kernel(errp) < 0) {
             return -ENOTSUP;
         }
         dev->dev.cap_present |= QEMU_PCI_CAP_MSI;
@@ -1281,9 +1277,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
         uint32_t msix_table_entry;
         uint16_t msix_max;
 
-        verify_irqchip_in_kernel(&local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (verify_irqchip_in_kernel(errp) < 0) {
             return -ENOTSUP;
         }
         dev->dev.cap_present |= QEMU_PCI_CAP_MSIX;
-- 
MST
