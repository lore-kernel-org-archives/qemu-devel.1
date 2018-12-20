Received: from eggs.gnu.org ([2001:4830:134:3::10]:60718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3FZ-000643-RX
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3FL-0002L2-Gt
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3FI-00024Z-BN
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:34 -0500
Date: Thu, 20 Dec 2018 13:40:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-45-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 44/44] x86-iommu: turn on IR by default if
 proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

When the user didn't specify "intremap" for the IOMMU device, we turn
it on by default if it is supported.  This will turn IR on for the
default Q35 platform as long as the IOMMU device is specified on new
kernels.

Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 61ee0f1eaa..d1534c1ae0 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -112,6 +112,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
     PCMachineState *pcms =
         PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
     QLIST_INIT(&x86_iommu->iec_notifiers);
+    bool irq_all_kernel = kvm_irqchip_in_kernel() && !kvm_irqchip_is_split();
 
     if (!pcms || !pcms->bus) {
         error_setg(errp, "Machine-type '%s' not supported by IOMMU",
@@ -121,12 +122,12 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
 
     /* If the user didn't specify IR, choose a default value for it */
     if (x86_iommu->intr_supported == ON_OFF_AUTO_AUTO) {
-        x86_iommu->intr_supported = ON_OFF_AUTO_OFF;
+        x86_iommu->intr_supported = irq_all_kernel ?
+            ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
     }
 
     /* Both Intel and AMD IOMMU IR only support "kernel-irqchip={off|split}" */
-    if (x86_iommu_ir_supported(x86_iommu) && kvm_irqchip_in_kernel() &&
-        !kvm_irqchip_is_split()) {
+    if (x86_iommu_ir_supported(x86_iommu) && irq_all_kernel) {
         error_setg(errp, "Interrupt Remapping cannot work with "
                          "kernel-irqchip=on, please use 'split|off'.");
         return;
-- 
MST
