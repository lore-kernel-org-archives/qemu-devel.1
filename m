Received: from eggs.gnu.org ([2001:4830:134:3::10]:47759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDrc-0005uM-RV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDrb-0000QA-Vh
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:22:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLDrb-0000Pk-PU
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:21:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE56AC0587C0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 19:21:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Jun 2017 21:21:52 +0200
Message-Id: <1497468113-2874-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1497468113-2874-1-git-send-email-thuth@redhat.com>
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] include/hw/i386/pc.h: Move CONFIG_KVM
 related definitions to kvm_i386.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

pc.h is included from common code (where is CONFIG_KVM is not available),
so the #defines that depend on CONFIG_KVM should not be declared here
to avoid that anybody is using them in a wrong way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_q35.c       |  1 +
 include/hw/i386/pc.h   | 13 -------------
 target/i386/kvm_i386.h | 13 +++++++++++++
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1523ef3..8f696b7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -36,6 +36,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
+#include "kvm_i386.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "exec/address-spaces.h"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d071c9c..a31f7aa 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -20,19 +20,6 @@
 
 #define HPET_INTCAP "hpet-intcap"
 
-#ifdef CONFIG_KVM
-#define kvm_pit_in_kernel() \
-    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
-#define kvm_pic_in_kernel()  \
-    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
-#define kvm_ioapic_in_kernel() \
-    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
-#else
-#define kvm_pit_in_kernel()      0
-#define kvm_pic_in_kernel()      0
-#define kvm_ioapic_in_kernel()   0
-#endif
-
 /**
  * PCMachineState:
  * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index bfce427..ac33f39 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -15,6 +15,19 @@
 
 #define kvm_apic_in_kernel() (kvm_irqchip_in_kernel())
 
+#ifdef CONFIG_KVM
+#define kvm_pit_in_kernel() \
+    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
+#define kvm_pic_in_kernel()  \
+    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
+#define kvm_ioapic_in_kernel() \
+    (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
+#else
+#define kvm_pit_in_kernel()      0
+#define kvm_pic_in_kernel()      0
+#define kvm_ioapic_in_kernel()   0
+#endif
+
 bool kvm_allows_irq0_override(void);
 bool kvm_has_smm(void);
 bool kvm_has_adjust_clock_stable(void);
-- 
1.8.3.1
