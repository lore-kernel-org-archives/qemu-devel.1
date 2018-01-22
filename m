Received: from eggs.gnu.org ([2001:4830:134:3::10]:40788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1edjK5-0004YE-0j
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1edjK1-00022T-LZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:08:08 -0500
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com
	([104.47.33.96]:36736
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1edjK1-00022I-FX
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:08:05 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 22 Jan 2018 13:07:47 -0800
Message-Id: <1516655269-1785-3-git-send-email-juterry@microsoft.com>
In-Reply-To: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
References: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/4] Add the WHPX vcpu API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

Adds support for the Windows Hypervisor Platform accelerator (WHPX) stubs and
introduces the whpx.h sysemu API for managing the vcpu scheduling and
management.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 accel/stubs/Makefile.objs |  9 +++++----
 accel/stubs/whpx-stub.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/whpx.h     | 40 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 4 deletions(-)
 create mode 100644 accel/stubs/whpx-stub.c
 create mode 100644 include/sysemu/whpx.h

diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index 779343b..3894caf 100644
--- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,4 +1,5 @@
-obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
-obj-$(call lnot,$(CONFIG_HVF)) += hvf-stub.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
+obj-$(call lnot,$(CONFIG_HAX))  += hax-stub.o
+obj-$(call lnot,$(CONFIG_HVF))  += hvf-stub.o
+obj-$(call lnot,$(CONFIG_WHPX)) += whpx-stub.o
+obj-$(call lnot,$(CONFIG_KVM))  += kvm-stub.o
+obj-$(call lnot,$(CONFIG_TCG))  += tcg-stub.o
diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
new file mode 100644
index 0000000..5fb049c
--- /dev/null
+++ b/accel/stubs/whpx-stub.c
@@ -0,0 +1,48 @@
+/*
+ * QEMU Windows Hypervisor Platform accelerator (WHPX) stub
+ *
+ * Copyright Microsoft Corp. 2017
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "sysemu/whpx.h"
+
+int whpx_init_vcpu(CPUState *cpu)
+{
+    return -1;
+}
+
+int whpx_vcpu_exec(CPUState *cpu)
+{
+    return -1;
+}
+
+void whpx_destroy_vcpu(CPUState *cpu)
+{
+}
+
+void whpx_vcpu_kick(CPUState *cpu)
+{
+}
+
+void whpx_cpu_synchronize_state(CPUState *cpu)
+{
+}
+
+void whpx_cpu_synchronize_post_reset(CPUState *cpu)
+{
+}
+
+void whpx_cpu_synchronize_post_init(CPUState *cpu)
+{
+}
+
+void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+}
diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
new file mode 100644
index 0000000..89592ae
--- /dev/null
+++ b/include/sysemu/whpx.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU Windows Hypervisor Platform accelerator (WHPX) support
+ *
+ * Copyright Microsoft, Corp. 2017
+ *
+ * Authors:
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_WHPX_H
+#define QEMU_WHPX_H
+
+#include "config-host.h"
+#include "qemu-common.h"
+
+int whpx_init_vcpu(CPUState *cpu);
+int whpx_vcpu_exec(CPUState *cpu);
+void whpx_destroy_vcpu(CPUState *cpu);
+void whpx_vcpu_kick(CPUState *cpu);
+
+
+void whpx_cpu_synchronize_state(CPUState *cpu);
+void whpx_cpu_synchronize_post_reset(CPUState *cpu);
+void whpx_cpu_synchronize_post_init(CPUState *cpu);
+void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
+
+#ifdef CONFIG_WHPX
+
+int whpx_enabled(void);
+
+#else /* CONFIG_WHPX */
+
+#define whpx_enabled() (0)
+
+#endif /* CONFIG_WHPX */
+
+#endif /* QEMU_WHPX_H */
-- 
2.7.4
