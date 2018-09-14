Received: from eggs.gnu.org ([2001:4830:134:3::10]:35586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soS-0008Ll-FP
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soP-0003Xt-Pe
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:28 -0400
Received: from mail-co1nam04on0607.outbound.protection.outlook.com
	([2a01:111:f400:fe4d::607]:5920
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0soP-0003Ug-Hd
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:25 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Fri, 14 Sep 2018 13:26:56 -0500
Message-Id: <1536949623-23564-2-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
References: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/8] x86_iommu: move the kernel-irqchip
 check in common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Interrupt remapping needs kernel-irqchip={off|split} on both Intel and AMD
platforms. Move the check in common place.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/intel_iommu.c | 7 -------
 hw/i386/x86-iommu.c   | 9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3dfada1..84dbc20 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3248,13 +3248,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    /* Currently Intel IOMMU IR only support "kernel-irqchip={off|split}" */
-    if (x86_iommu->intr_supported && kvm_irqchip_in_kernel() &&
-        !kvm_irqchip_is_split()) {
-        error_setg(errp, "Intel Interrupt Remapping cannot work with "
-                         "kernel-irqchip=on, please use 'split|off'.");
-        return false;
-    }
     if (s->intr_eim == ON_OFF_AUTO_ON && !x86_iommu->intr_supported) {
         error_setg(errp, "eim=on cannot be selected without intremap=on");
         return false;
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 8a01a2d..7440cb8 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#include "sysemu/kvm.h"
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
@@ -94,6 +95,14 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Both Intel and AMD IOMMU IR only support "kernel-irqchip={off|split}" */
+    if (x86_iommu->intr_supported && kvm_irqchip_in_kernel() &&
+        !kvm_irqchip_is_split()) {
+        error_setg(errp, "Interrupt Remapping cannot work with "
+                         "kernel-irqchip=on, please use 'split|off'.");
+        return;
+    }
+
     if (x86_class->realize) {
         x86_class->realize(dev, errp);
     }
-- 
2.7.4
