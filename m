Received: from eggs.gnu.org ([2001:4830:134:3::10]:39109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXQ4P-0007cB-43
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXQ4O-0001xn-5v
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:54:09 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Jun 2018 13:53:51 +0200
Message-Id: <20180625115352.6889-9-david@redhat.com>
In-Reply-To: <20180625115352.6889-1-david@redhat.com>
References: <20180625115352.6889-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 8/9] s390x/tcg: rearm the CKC timer during
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

If the CPU data is migrated after the TOD clock, the CKC timer of a CPU
is not rearmed. Let's rearm it when loading the CPU state.

Introduce tcg-stub.c just like kvm-stub.c for tcg specific stubs.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/Makefile.objs |  1 +
 target/s390x/machine.c     |  6 ++++++
 target/s390x/tcg-stub.c    | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 target/s390x/tcg-stub.c

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 31932de9cf..22a9a9927a 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -5,6 +5,7 @@ obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
 obj-$(CONFIG_SOFTMMU) += sigp.o
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
 
 # build and run feature list generator
 feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 84b4928755..bd3230d027 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -19,6 +19,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_s390x.h"
+#include "tcg_s390x.h"
 #include "sysemu/kvm.h"
 
 static int cpu_post_load(void *opaque, int version_id)
@@ -34,6 +35,11 @@ static int cpu_post_load(void *opaque, int version_id)
         return kvm_s390_vcpu_interrupt_post_load(cpu);
     }
 
+    if (tcg_enabled()) {
+        /* Rearm the CKC timer if necessary */
+        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);
+    }
+
     return 0;
 }
 
diff --git a/target/s390x/tcg-stub.c b/target/s390x/tcg-stub.c
new file mode 100644
index 0000000000..c93501db0b
--- /dev/null
+++ b/target/s390x/tcg-stub.c
@@ -0,0 +1,20 @@
+/*
+ * QEMU TCG support -- s390x specific function stubs.
+ *
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *   David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "tcg_s390x.h"
+
+void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
+{
+}
-- 
2.17.1
