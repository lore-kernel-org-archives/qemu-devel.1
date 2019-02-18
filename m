Received: from eggs.gnu.org ([209.51.188.92]:52314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqH-0006sX-9k
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqB-0006fF-Ak
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:09 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:45 +0100
Message-Id: <20190218111153.22681-3-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] s390x: always provide pci support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

We tried to make pci support optional on s390x in the past;
unfortunately, we still require the s390 phb to be created
unconditionally due to backwards compatibility issues.

Instead of sinking more effort into this (including compat
handling for older machines etc.) for non-obvious gains, let's
just make CONFIG_PCI something that is always set on s390x.

Note that you can still fence off pci for the _guest_ if you
provide a cpu model without the zpci feature.

Message-Id: <20190211113255.3837-1-cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/Makefile.objs      |  3 +-
 hw/s390x/s390-pci-stub.c    | 77 -------------------------------------
 hw/s390x/s390-virtio-ccw.c  |  4 --
 target/s390x/cpu_models.c   |  5 ---
 target/s390x/gen-features.c |  1 -
 target/s390x/kvm.c          |  4 +-
 6 files changed, 2 insertions(+), 92 deletions(-)
 delete mode 100644 hw/s390x/s390-pci-stub.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index a18c4719137e..bfd5326d7c3d 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -21,8 +21,7 @@ obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
-obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
-obj-$(call lnot,$(CONFIG_PCI)) += s390-pci-stub.o
+obj-y += s390-pci-bus.o s390-pci-inst.o
 obj-y += s390-skeys.o
 obj-y += s390-stattrib.o
 obj-y += tod.o
diff --git a/hw/s390x/s390-pci-stub.c b/hw/s390x/s390-pci-stub.c
deleted file mode 100644
index ad4c5a77198f..000000000000
--- a/hw/s390x/s390-pci-stub.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/* stubs for non-pci builds */
-
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "cpu.h"
-#include "s390-pci-inst.h"
-#include "s390-pci-bus.h"
-
-/* target/s390x/ioinst.c */
-int pci_chsc_sei_nt2_get_event(void *res)
-{
-    return 1;
-}
-
-int pci_chsc_sei_nt2_have_event(void)
-{
-    return 0;
-}
-
-/* hw/s390x/sclp.c */
-void s390_pci_sclp_configure(SCCB *sccb)
-{
-    sccb->h.response_code = cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED);
-}
-
-void s390_pci_sclp_deconfigure(SCCB *sccb)
-{
-    sccb->h.response_code = cpu_to_be16(SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED);
-}
-
-/* target/s390x/kvm.c */
-int clp_service_call(S390CPU *cpu, uint8_t r2)
-{
-    return -1;
-}
-
-int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
-{
-    return -1;
-}
-
-int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
-{
-    return -1;
-}
-
-int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
-{
-    return -1;
-}
-
-int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
-{
-    return -1;
-}
-
-int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
-                        uint8_t ar)
-{
-    return -1;
-}
-
-int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
-{
-    return -1;
-}
-
-S390pciState *s390_get_phb(void)
-{
-    return NULL;
-}
-
-S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
-                                              const char *target)
-{
-    return NULL;
-}
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 811fdf913dd6..3fb5c88af9cc 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -272,10 +272,6 @@ static void ccw_init(MachineState *machine)
                       machine->initrd_filename, "s390-ccw.img",
                       "s390-netboot.img", true);
 
-    /*
-     * We cannot easily make the pci host bridge conditional as older QEMUs
-     * always created it. Doing so would break migration across QEMU versions.
-     */
     dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
                               OBJECT(dev), NULL);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7c253ff308c5..249011fd62f5 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -1314,11 +1314,6 @@ static void register_types(void)
 
     /* init all bitmaps from gnerated data initially */
     s390_init_feat_bitmap(qemu_max_cpu_feat_init, qemu_max_cpu_feat);
-#ifndef CONFIG_USER_ONLY
-    if (!pci_available) {
-        clear_bit(S390_FEAT_ZPCI, qemu_max_cpu_feat);
-    }
-#endif
     for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
         s390_init_feat_bitmap(s390_cpu_defs[i].base_init,
                               s390_cpu_defs[i].base_feat);
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 70015eaaf5df..b0e9b271e228 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -598,7 +598,6 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_STFLE_53,
     /* generates a dependency warning, leave it out for now */
     S390_FEAT_MSA_EXT_5,
-    /* only with CONFIG_PCI */
     S390_FEAT_ZPCI,
 };
 
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 9ff80c8461d0..15fdc168e1c5 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2278,9 +2278,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     }
 
     /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
-    if (pci_available) {
-        set_bit(S390_FEAT_ZPCI, model->features);
-    }
+    set_bit(S390_FEAT_ZPCI, model->features);
     set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
 
     if (s390_known_cpu_type(cpu_type)) {
-- 
2.17.2
