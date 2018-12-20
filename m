Received: from eggs.gnu.org ([2001:4830:134:3::10]:60230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZr4w-0003bv-JD
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZr4v-0005vY-UQ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:41:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gZr4v-0005ul-N5
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:41:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D26EC057F38
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 05:41:01 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 20 Dec 2018 13:40:37 +0800
Message-Id: <20181220054037.24320-4-peterx@redhat.com>
In-Reply-To: <20181220054037.24320-1-peterx@redhat.com>
References: <20181220054037.24320-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] x86-iommu: turn on IR by default if
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

When the user didn't specify "intremap" for the IOMMU device, we turn
it on by default if it is supported.  This will turn IR on for the
default Q35 platform as long as the IOMMU device is specified on new
kernels.

Signed-off-by: Peter Xu <peterx@redhat.com>
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
2.17.1
