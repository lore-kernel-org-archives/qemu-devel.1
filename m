Received: from eggs.gnu.org ([209.51.188.92]:44591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1hDrY1-0006Tu-DV
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1hDrY0-0001iN-A9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:16:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33392 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1hDrXz-0001Zk-NF
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:16:24 -0400
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Tue, 9 Apr 2019 14:14:56 +0000
Message-ID: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] msix: fix interrupt aggregation problem at the
 passthrough of NVMe SSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, Zhuang Yanying <ann.zhuangyanying@huawei.com>

From: Zhuang Yanying <ann.zhuangyanying@huawei.com>

Recently I tested the performance of NVMe SSD passthrough and found that interrupts
were aggregated on vcpu0(or the first vcpu of each numa) by /proc/interrupts,when
GuestOS was upgraded to sles12sp3 (or redhat7.6). But /proc/irq/X/smp_affinity_list
shows that the interrupt is spread out, such as 0-10, 11-21,.... and so on.
This problem cannot be resolved by "echo X > /proc/irq/X/smp_affinity_list", because
the NVMe SSD interrupt is requested by the API pci_alloc_irq_vectors(), so the
interrupt has the IRQD_AFFINITY_MANAGED flag.

GuestOS sles12sp3 backport "automatic interrupt affinity for MSI/MSI-X capable devices",
but the implementation of __setup_irq has no corresponding modification. It is still
irq_startup(), then setup_affinity(), that is sending an affinity message when the
interrupt is unmasked. The bare metal configuration is successful, but qemu will
not trigger the msix update, and the affinity configuration fails.
The affinity is configured by /proc/irq/X/smp_affinity_list, implemented at
apic_ack_edge(), the bitmap is stored in pending_mask,
mask->__pci_write_msi_msg()->unmask,
and the timing is guaranteed, and the configuration takes effect.

The GuestOS linux-master incorporates the "genirq/cpuhotplug: Enforce affinity
setting on startup of managed irqs" to ensure that the affinity is first issued
and then __irq_startup(), for the managerred interrupt. So configuration is
successful.

It now looks like sles12sp3 (up to sles15sp1, linux-4.12.x), redhat7.6
(3.10.0-957.10.1) does not have backport the patch yet.
"if (is_masked == was_masked) return;" can it be removed at qemu?
What is the reason for this check?

Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
---
 hw/pci/msix.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 4e33641..e1ff533 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -119,10 +119,6 @@ static void msix_handle_mask_update(PCIDevice *dev, int vector, bool was_masked)
 {
     bool is_masked = msix_is_masked(dev, vector);
 
-    if (is_masked == was_masked) {
-        return;
-    }
-
     msix_fire_vector_notifier(dev, vector, is_masked);
 
     if (!is_masked && msix_is_pending(dev, vector)) {
-- 
1.8.3.1
