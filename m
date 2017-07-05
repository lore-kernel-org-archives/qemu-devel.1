Received: from eggs.gnu.org ([2001:4830:134:3::10]:46384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWb-0004Ps-AR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWZ-0007Vb-Vx
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:01 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWZ-0007Ul-LR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:59 -0400
Received: by mail-wr0-x242.google.com with SMTP id k67so48979909wrc.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:14:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:11 +0200
Message-Id: <1499238885-26161-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/42] include/exec/poison: Mark CONFIG_KVM as
 poisoned, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

CONFIG_KVM is only defined for target-specific code, so nobody should
use it by accident in common code. To avoid such subtle bugs,
CONFIG_KVM is now marked as poisoned in common code. The header
include/sysemu/kvm.h is somewhat special since it is included
all over the place from common code, too, so we need some extra
logic via "#ifdef NEED_CPU_H" here to make sure that we can
compile all files without problems.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1498454578-18709-4-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/ich9.c        |  1 -
 include/exec/poison.h |  1 +
 include/sysemu/kvm.h  | 18 +++++++++++++-----
 3 files changed, 14 insertions(+), 6 deletions(-)

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
index 7a025b2..32707cd 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -86,6 +86,7 @@
 
 #pragma GCC poison CONFIG_LINUX_USER
 #pragma GCC poison CONFIG_VHOST_NET
+#pragma GCC poison CONFIG_KVM
 
 #endif
 #endif
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ca40b6e..052e11f 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -19,11 +19,18 @@
 #include "exec/memattrs.h"
 #include "hw/irq.h"
 
-#ifdef CONFIG_KVM
-#include <linux/kvm.h>
-#include <linux/kvm_para.h>
+#ifdef NEED_CPU_H
+# ifdef CONFIG_KVM
+#  include <linux/kvm.h>
+#  include <linux/kvm_para.h>
+#  define CONFIG_KVM_IS_POSSIBLE
+# endif
+#else
+# define CONFIG_KVM_IS_POSSIBLE
 #endif
 
+#ifdef CONFIG_KVM_IS_POSSIBLE
+
 extern bool kvm_allowed;
 extern bool kvm_kernel_irqchip;
 extern bool kvm_split_irqchip;
@@ -40,7 +47,6 @@ extern bool kvm_direct_msi_allowed;
 extern bool kvm_ioeventfd_any_length_allowed;
 extern bool kvm_msi_use_devid;
 
-#if defined CONFIG_KVM || !defined NEED_CPU_H
 #define kvm_enabled()           (kvm_allowed)
 /**
  * kvm_irqchip_in_kernel:
@@ -163,6 +169,7 @@ extern bool kvm_msi_use_devid;
 #define kvm_msi_devid_required() (kvm_msi_use_devid)
 
 #else
+
 #define kvm_enabled()           (0)
 #define kvm_irqchip_in_kernel() (false)
 #define kvm_irqchip_is_split() (false)
@@ -178,7 +185,8 @@ extern bool kvm_msi_use_devid;
 #define kvm_direct_msi_enabled() (false)
 #define kvm_ioeventfd_any_length_enabled() (false)
 #define kvm_msi_devid_required() (false)
-#endif
+
+#endif  /* CONFIG_KVM_IS_POSSIBLE */
 
 struct kvm_run;
 struct kvm_lapic_state;
-- 
1.8.3.1
