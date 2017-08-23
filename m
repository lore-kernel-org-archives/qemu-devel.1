Received: from eggs.gnu.org ([2001:4830:134:3::10]:36190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkXzz-0005jM-8J
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkXzx-0000mU-Go
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkXzx-0000mD-Aw
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:55:17 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 23 Aug 2017 17:54:52 +0200
Message-Id: <20170823155458.19601-4-cohuck@redhat.com>
In-Reply-To: <20170823155458.19601-1-cohuck@redhat.com>
References: <20170823155458.19601-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v5 3/9] s390x/pci: add stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Some non-pci code calls into zpci code. Provide some stubs for builds
without pci.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/Makefile.objs   |  3 +-
 hw/s390x/s390-pci-stub.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/s390-pci-stub.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index b2aade2466..7ee19d3abc 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -11,7 +11,8 @@ obj-y += 3270-ccw.o
 obj-y += virtio-ccw.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
-obj-y += s390-pci-bus.o s390-pci-inst.o
+obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
+obj-$(call lnot,$(CONFIG_PCI)) += s390-pci-stub.o
 obj-y += s390-skeys.o
 obj-y += s390-stattrib.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
new file mode 100644
index 0000000000..2e7e42a2af
--- /dev/null
+++ b/hw/s390x/s390-pci-stub.c
@@ -0,0 +1,74 @@
+/* stubs for non-pci builds */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "s390-pci-inst.h"
+#include "s390-pci-bus.h"
+
+/* target/s390x/ioinst.c */
+int chsc_sei_nt2_get_event(void *res)
+{
+    return 1;
+}
+
+int chsc_sei_nt2_have_event(void)
+{
+    return 0;
+}
+
+/* hw/s390x/sclp.c */
+void s390_pci_sclp_configure(SCCB *sccb)
+{
+}
+
+void s390_pci_sclp_deconfigure(SCCB *sccb)
+{
+}
+
+/* target/s390x/kvm.c */
+int clp_service_call(S390CPU *cpu, uint8_t r2)
+{
+    return -1;
+}
+
+int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+{
+    return -1;
+}
+
+int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+{
+    return -1;
+}
+
+int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
+{
+    return -1;
+}
+
+int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+{
+    return -1;
+}
+
+int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
+                        uint8_t ar)
+{
+    return -1;
+}
+
+int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
+{
+    return -1;
+}
+
+S390pciState *s390_get_phb(void)
+{
+    return NULL;
+}
+
+S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx)
+{
+    return NULL;
+}
-- 
2.13.5
