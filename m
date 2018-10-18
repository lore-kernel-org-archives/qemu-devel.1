Received: from eggs.gnu.org ([2001:4830:134:3::10]:48434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyc-0007hv-Do
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyY-0006aA-IG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyY-0006ZI-8w
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id z204-v6so1611720wmc.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:03 +0200
Message-Id: <1539894735-14232-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 36/48] i386: add hyperv-stub for CONFIG_HYPERV=n
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

This will allow to build slightly leaner QEMU that supports some HyperV
features of KVM (e.g. SynIC timers, PV spinlocks, APIC assists, etc.)
but nothing else on the QEMU side.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082041.29380-6-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs | 17 ++++++++++-------
 target/i386/hyperv-stub.c | 35 +++++++++++++++++++++++++++++++++++
 target/i386/hyperv.h      |  2 ++
 3 files changed, 47 insertions(+), 7 deletions(-)
 create mode 100644 target/i386/hyperv-stub.c

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 04678f5..32bf966 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -3,17 +3,20 @@ obj-$(CONFIG_TCG) += translate.o
 obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
 obj-$(CONFIG_TCG) += seg_helper.o smm_helper.o svm_helper.o
-obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
-obj-$(CONFIG_KVM) += kvm.o hyperv.o
-obj-$(CONFIG_SEV) += sev.o
+ifeq ($(CONFIG_SOFTMMU),y)
+obj-y += machine.o arch_memory_mapping.o arch_dump.o monitor.o
+obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
-# HAX support
-ifdef CONFIG_WIN32
+obj-$(CONFIG_HYPERV) += hyperv.o
+obj-$(call lnot,$(CONFIG_HYPERV)) += hyperv-stub.o
+ifeq ($(CONFIG_WIN32),y)
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
-ifdef CONFIG_DARWIN
+ifeq ($(CONFIG_DARWIN),y)
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
 obj-$(CONFIG_HVF) += hvf/
 endif
 obj-$(CONFIG_WHPX) += whpx-all.o
+endif
+obj-$(CONFIG_SEV) += sev.o
+obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
new file mode 100644
index 0000000..5919ba8
--- /dev/null
+++ b/target/i386/hyperv-stub.c
@@ -0,0 +1,35 @@
+/*
+ * Stubs for CONFIG_HYPERV=n
+ *
+ * Copyright (c) 2015-2018 Virtuozzo International GmbH.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hyperv.h"
+
+#ifdef CONFIG_KVM
+int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
+{
+    switch (exit->type) {
+    case KVM_EXIT_HYPERV_SYNIC:
+        if (!cpu->hyperv_synic) {
+            return -1;
+        }
+
+        /*
+         * Tracking the changes in the MSRs is unnecessary as there are no
+         * users for them beside save/load, which is handled nicely by the
+         * generic MSR save/load code
+         */
+        return 0;
+    case KVM_EXIT_HYPERV_HCALL:
+        exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
+        return 0;
+    default:
+        return -1;
+    }
+}
+#endif
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 5c49251..f0a27c3 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -18,6 +18,8 @@
 #include "sysemu/kvm.h"
 #include "hw/hyperv/hyperv.h"
 
+#ifdef CONFIG_KVM
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
+#endif
 
 #endif
-- 
1.8.3.1
