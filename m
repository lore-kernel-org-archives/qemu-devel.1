Received: from eggs.gnu.org ([2001:4830:134:3::10]:47770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDre-0005uu-Il
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDrd-0000Qh-Ax
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLDrd-0000QM-29
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:22:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1441085541
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 19:22:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Jun 2017 21:21:53 +0200
Message-Id: <1497468113-2874-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1497468113-2874-1-git-send-email-thuth@redhat.com>
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] include/exec/poison: Mark CONFIG_KVM as
 poisoned, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

We unfortunately need some additional "#ifndef NEED_CPU_H" fuzz in
include/sysemu/kvm.h for this, so that the header can still be included
from common code (which is done all over the place), but now we can
finally be sure that nobody uses this define in a wrong place anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/acpi/ich9.c        |  1 -
 include/exec/poison.h |  1 +
 include/sysemu/kvm.h  | 37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5c279bb..c5d8646 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -33,7 +33,6 @@
 #include "sysemu/sysemu.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/tco.h"
-#include "sysemu/kvm.h"
 #include "exec/address-spaces.h"
 
 #include "hw/i386/ich9.h"
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 5ffed4d..540fc70 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -80,6 +80,7 @@
 
 #pragma GCC poison CONFIG_LINUX_USER
 #pragma GCC poison CONFIG_VHOST_NET
+#pragma GCC poison CONFIG_KVM
 
 #endif
 #endif
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 1e91613..8cc57e4 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -19,6 +19,8 @@
 #include "exec/memattrs.h"
 #include "hw/irq.h"
 
+#ifdef NEED_CPU_H
+
 #ifdef CONFIG_KVM
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
@@ -39,6 +41,8 @@
 #define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT 0
 #endif
 
+#endif /* NEED_CPU_H */
+
 extern bool kvm_allowed;
 extern bool kvm_kernel_irqchip;
 extern bool kvm_split_irqchip;
@@ -55,7 +59,8 @@ extern bool kvm_direct_msi_allowed;
 extern bool kvm_ioeventfd_any_length_allowed;
 extern bool kvm_msi_use_devid;
 
-#if defined CONFIG_KVM || !defined NEED_CPU_H
+#if !defined(NEED_CPU_H)
+
 #define kvm_enabled()           (kvm_allowed)
 /**
  * kvm_irqchip_in_kernel:
@@ -178,6 +183,31 @@ extern bool kvm_msi_use_devid;
 #define kvm_msi_devid_required() (kvm_msi_use_devid)
 
 #else
+
+#ifdef CONFIG_KVM
+
+/*
+ * Same definitions again, but we need to keep them separate
+ * since CONFIG_KVM is poisoned without NEED_CPU_H
+ */
+#define kvm_enabled()           (kvm_allowed)
+#define kvm_irqchip_in_kernel() (kvm_kernel_irqchip)
+#define kvm_irqchip_is_split() (kvm_split_irqchip)
+#define kvm_async_interrupts_enabled() (kvm_async_interrupts_allowed)
+#define kvm_halt_in_kernel() (kvm_halt_in_kernel_allowed)
+#define kvm_eventfds_enabled() (kvm_eventfds_allowed)
+#define kvm_irqfds_enabled() (kvm_irqfds_allowed)
+#define kvm_resamplefds_enabled() (kvm_resamplefds_allowed)
+#define kvm_msi_via_irqfd_enabled() (kvm_msi_via_irqfd_allowed)
+#define kvm_gsi_routing_enabled() (kvm_gsi_routing_allowed)
+#define kvm_gsi_direct_mapping() (kvm_gsi_direct_mapping)
+#define kvm_readonly_mem_enabled() (kvm_readonly_mem_allowed)
+#define kvm_direct_msi_enabled() (kvm_direct_msi_allowed)
+#define kvm_ioeventfd_any_length_enabled() (kvm_ioeventfd_any_length_allowed)
+#define kvm_msi_devid_required() (kvm_msi_use_devid)
+
+#else
+
 #define kvm_enabled()           (0)
 #define kvm_irqchip_in_kernel() (false)
 #define kvm_irqchip_is_split() (false)
@@ -193,7 +223,10 @@ extern bool kvm_msi_use_devid;
 #define kvm_direct_msi_enabled() (false)
 #define kvm_ioeventfd_any_length_enabled() (false)
 #define kvm_msi_devid_required() (false)
-#endif
+
+#endif  /* CONFIG_KVM */
+
+#endif  /* NEED_CPU_H */
 
 struct kvm_run;
 struct kvm_lapic_state;
-- 
1.8.3.1
