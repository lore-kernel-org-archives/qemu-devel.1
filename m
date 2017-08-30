Received: from eggs.gnu.org ([2001:4830:134:3::10]:56893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Fe-00022x-Mp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Fc-0005Hv-Cd
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6Fc-0005HJ-3A
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:00 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:23 +0200
Message-Id: <20170830165252.13421-16-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 15/44] s390x/pci: add stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Some non-pci code calls into zpci code. Provide some stubs for builds
without pci.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/Makefile.objs   |  3 +-
 hw/s390x/s390-pci-stub.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/sclp.h  |  1 +
 3 files changed, 79 insertions(+), 1 deletion(-)
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
index 0000000000..48f8b4e8a3
--- /dev/null
+++ b/hw/s390x/s390-pci-stub.c
@@ -0,0 +1,76 @@
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
+    sccb->h.response_code = cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED);
+}
+
+void s390_pci_sclp_deconfigure(SCCB *sccb)
+{
+    sccb->h.response_code = cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED);
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
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index e71d526605..fe54442ecd 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -59,6 +59,7 @@
 #define SCLP_RC_INSUFFICIENT_SCCB_LENGTH        0x0300
 #define SCLP_RC_STANDBY_READ_COMPLETION         0x0410
 #define SCLP_RC_ADAPTER_IN_RESERVED_STATE       0x05f0
+#define SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED     0x06f0
 #define SCLP_RC_ADAPTER_ID_NOT_RECOGNIZED       0x09f0
 #define SCLP_RC_INVALID_FUNCTION                0x40f0
 #define SCLP_RC_NO_EVENT_BUFFERS_STORED         0x60f0
-- 
2.13.5
