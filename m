Received: from eggs.gnu.org ([2001:4830:134:3::10]:49418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nw-0001VB-KG
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nv-0004U2-1A
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:40 +1100
Message-Id: <20180306040154.3669-17-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/30] openpic: move KVM-specific declarations
 into separate openpic_kvm.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is needed before the next patch because the target-dependent kvm stub
uses the existing kvm_openpic_connect_vcpu() declaration, making it impossible
to move the device-specific declarations into the same file without breaking
ppc-linux-user compilation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/openpic_kvm.c        | 1 +
 hw/ppc/e500.c                | 1 +
 include/hw/ppc/openpic.h     | 3 ---
 include/hw/ppc/openpic_kvm.h | 7 +++++++
 target/ppc/kvm-stub.c        | 2 +-
 5 files changed, 10 insertions(+), 4 deletions(-)
 create mode 100644 include/hw/ppc/openpic_kvm.h

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index fa83420254..f1a59e5a85 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -30,6 +30,7 @@
 #include "exec/address-spaces.h"
 #include "hw/hw.h"
 #include "hw/ppc/openpic.h"
+#include "hw/ppc/openpic_kvm.h"
 #include "hw/pci/msi.h"
 #include "hw/sysbus.h"
 #include "sysemu/kvm.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index a40d3ec3e3..13a34f50b7 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -29,6 +29,7 @@
 #include "kvm_ppc.h"
 #include "sysemu/device_tree.h"
 #include "hw/ppc/openpic.h"
+#include "hw/ppc/openpic_kvm.h"
 #include "hw/ppc/ppc.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index e55ce546aa..693e981965 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -28,7 +28,4 @@ enum {
 #define OPENPIC_MAX_IRQ     (OPENPIC_MAX_SRC + OPENPIC_MAX_IPI + \
                              OPENPIC_MAX_TMR)
 
-#define TYPE_KVM_OPENPIC "kvm-openpic"
-int kvm_openpic_connect_vcpu(DeviceState *d, CPUState *cs);
-
 #endif /* OPENPIC_H */
diff --git a/include/hw/ppc/openpic_kvm.h b/include/hw/ppc/openpic_kvm.h
new file mode 100644
index 0000000000..9ef4215257
--- /dev/null
+++ b/include/hw/ppc/openpic_kvm.h
@@ -0,0 +1,7 @@
+#ifndef OPENPIC_KVM_H
+#define OPENPIC_KVM_H
+
+#define TYPE_KVM_OPENPIC "kvm-openpic"
+int kvm_openpic_connect_vcpu(DeviceState *d, CPUState *cs);
+
+#endif /* OPENPIC_KVM_H */
diff --git a/target/ppc/kvm-stub.c b/target/ppc/kvm-stub.c
index efeafca1df..b8aa97f2d4 100644
--- a/target/ppc/kvm-stub.c
+++ b/target/ppc/kvm-stub.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/ppc/openpic.h"
+#include "hw/ppc/openpic_kvm.h"
 
 int kvm_openpic_connect_vcpu(DeviceState *d, CPUState *cs)
 {
-- 
2.14.3
