Received: from eggs.gnu.org ([2001:4830:134:3::10]:60420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUX-0001CC-98
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUW-0000gt-9R
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:21 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUV-0000gO-Vs
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:20 -0400
Received: by mail-wr0-x243.google.com with SMTP id v65so22374840wrc.11
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:21 +0100
Message-Id: <1520945798-50640-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/22] kvm: add memory encryption context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>

From: Brijesh Singh <brijesh.singh@amd.com>

Split from a patch by Brijesh Singh (brijesh.singh@amd.com).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/Makefile.objs     |  2 +-
 accel/kvm/Makefile.objs |  3 ++-
 accel/kvm/kvm-all.c     | 25 +++++++++++++++++++++++++
 accel/kvm/sev-stub.c    | 21 +++++++++++++++++++++
 accel/stubs/kvm-stub.c  |  5 +++++
 include/sysemu/kvm.h    |  9 +++++++++
 include/sysemu/sev.h    | 20 ++++++++++++++++++++
 7 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 accel/kvm/sev-stub.c
 create mode 100644 include/sysemu/sev.h

diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 10666ed..c3718a1 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SOFTMMU) += accel.o
-obj-y += kvm/
+obj-$(CONFIG_KVM) += kvm/
 obj-$(CONFIG_TCG) += tcg/
 obj-y += stubs/
diff --git a/accel/kvm/Makefile.objs b/accel/kvm/Makefile.objs
index 85351e7..fdfa481 100644
--- a/accel/kvm/Makefile.objs
+++ b/accel/kvm/Makefile.objs
@@ -1 +1,2 @@
-obj-$(CONFIG_KVM) += kvm-all.o
+obj-y += kvm-all.o
+obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b91fcb7..e0e43fd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -38,6 +38,7 @@
 #include "qemu/event_notifier.h"
 #include "trace.h"
 #include "hw/irq.h"
+#include "sysemu/sev.h"
 
 #include "hw/boards.h"
 
@@ -103,6 +104,9 @@ struct KVMState
 #endif
     KVMMemoryListener memory_listener;
     QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
+
+    /* memory encryption */
+    void *memcrypt_handle;
 };
 
 KVMState *kvm_state;
@@ -138,6 +142,15 @@ int kvm_get_max_memslots(void)
     return s->nr_slots;
 }
 
+bool kvm_memcrypt_enabled(void)
+{
+    if (kvm_state && kvm_state->memcrypt_handle) {
+        return true;
+    }
+
+    return false;
+}
+
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
     KVMState *s = kvm_state;
@@ -1636,6 +1649,18 @@ static int kvm_init(MachineState *ms)
 
     kvm_state = s;
 
+    /*
+     * if memory encryption object is specified then initialize the memory
+     * encryption context.
+     */
+    if (ms->memory_encryption) {
+        kvm_state->memcrypt_handle = sev_guest_init(ms->memory_encryption);
+        if (!kvm_state->memcrypt_handle) {
+            ret = -1;
+            goto err;
+        }
+    }
+
     ret = kvm_arch_init(ms, s);
     if (ret < 0) {
         goto err;
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
new file mode 100644
index 0000000..4a5cc55
--- /dev/null
+++ b/accel/kvm/sev-stub.c
@@ -0,0 +1,21 @@
+/*
+ * QEMU SEV stub
+ *
+ * Copyright Advanced Micro Devices 2018
+ *
+ * Authors:
+ *      Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/sev.h"
+
+void *sev_guest_init(const char *id)
+{
+    return NULL;
+}
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c964af3..f83192d 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -105,6 +105,11 @@ int kvm_on_sigbus(int code, void *addr)
     return 1;
 }
 
+bool kvm_memcrypt_enabled(void)
+{
+    return false;
+}
+
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
 {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 85002ac..84017a0 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -231,6 +231,15 @@ int kvm_destroy_vcpu(CPUState *cpu);
  */
 bool kvm_arm_supports_user_irq(void);
 
+/**
+ * kvm_memcrypt_enabled - return boolean indicating whether memory encryption
+ *                        is enabled
+ * Returns: 1 memory encryption is enabled
+ *          0 memory encryption is disabled
+ */
+bool kvm_memcrypt_enabled(void);
+
+
 #ifdef NEED_CPU_H
 #include "cpu.h"
 
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
new file mode 100644
index 0000000..f7a6057
--- /dev/null
+++ b/include/sysemu/sev.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU Secure Encrypted Virutualization (SEV) support
+ *
+ * Copyright: Advanced Micro Devices, 2016-2018
+ *
+ * Authors:
+ *  Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_SEV_H
+#define QEMU_SEV_H
+
+#include "sysemu/kvm.h"
+
+void *sev_guest_init(const char *id);
+#endif
-- 
1.8.3.1
