Received: from eggs.gnu.org ([2001:4830:134:3::10]:58195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98x5-0001Ik-RC
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98x1-0000xS-PH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:15 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:53452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98x1-0000wq-FU
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:11 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.92])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id D7C41BE335
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:09 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:21 +0200
Message-Id: <20180419124331.3915-26-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 25/35] spapr/xive: add KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This introduces a set of XIVE models specific to KVM. They handle the
synchronization of the state with KVM, for the monitor usage and for
the migration.

The TIMA and ESB MMIO regions are initialized differently under KVM.
'ram device' memory mappings, similarly to VFIO, are exposed to the
guest and the associated VMAs on the host are populated dynamically
with the appropriate pages using a fault handler.

For migration, the main sPAPRXive interrupt controller model saves and
restores the IVE table needed for routing. Each VCPU presenter model
(XiveNVT) does the same for the interrupt management registers and for
the XIVE EQs. The XIVE EQ pages, which reside in the guest RAM, are
marked dirty when the EQs are captured. These get/set operations rely
on their KVM counterpart in the host kernel which acts as a proxy for
OPAL, the host firmware.

The XiveSource model can save and restore the PQ bits directly in the
ESB MMIO region and does not need KVM support.

The XIVE migration sequence is currently ordered with priorities but
this might not be enough to capture correctly all HW state. Extra
quiescence points are possibly needed. Work in progress.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 default-configs/ppc64-softmmu.mak |   1 +
 hw/intc/Makefile.objs             |   1 +
 hw/intc/spapr_xive.c              |   1 +
 hw/intc/spapr_xive_kvm.c          | 565 ++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xive.c                    |   1 +
 include/hw/ppc/spapr_xive.h       |  23 ++
 include/hw/ppc/xive.h             |   3 +
 include/migration/vmstate.h       |   2 +
 8 files changed, 597 insertions(+)
 create mode 100644 hw/intc/spapr_xive_kvm.c

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index f8d34722931d..ac7e3af2473c 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -18,4 +18,5 @@ CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
 CONFIG_XIVE=3D$(CONFIG_PSERIES)
 CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
+CONFIG_XIVE_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
 CONFIG_MEM_HOTPLUG=3Dy
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index eacd26836ebf..dd4d69db2bdd 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -39,6 +39,7 @@ obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
 obj-$(CONFIG_XIVE) +=3D xive.o
 obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o spapr_xive_hcall.o
+obj-$(CONFIG_XIVE_KVM) +=3D spapr_xive_kvm.o
 obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index bd604089ad49..b8496033a8b9 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -208,6 +208,7 @@ static const VMStateDescription vmstate_spapr_xive =3D=
 {
     .minimum_version_id =3D 1,
     .pre_save =3D vmstate_spapr_xive_pre_save,
     .post_load =3D vmstate_spapr_xive_post_load,
+    .priority =3D MIG_PRI_XIVE_IVE,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ivt, sPAPRXive, nr_irqs,
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
new file mode 100644
index 000000000000..ec5613fc2804
--- /dev/null
+++ b/hw/intc/spapr_xive_kvm.c
@@ -0,0 +1,565 @@
+/*
+ * QEMU PowerPC sPAPR XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "target/ppc/cpu.h"
+#include "sysemu/cpus.h"
+#include "sysemu/kvm.h"
+#include "monitor/monitor.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_xive.h"
+#include "hw/ppc/xive.h"
+#include "hw/ppc/xive_regs.h"
+#include "kvm_ppc.h"
+
+#include <sys/ioctl.h>
+
+/* TODO: kernel_xive_fd is used as a global switch for XIVE */
+static int kernel_xive_fd =3D -1;
+
+typedef struct KVMEnabledCPU {
+    unsigned long vcpu_id;
+    QLIST_ENTRY(KVMEnabledCPU) node;
+} KVMEnabledCPU;
+
+static QLIST_HEAD(, KVMEnabledCPU)
+    kvm_enabled_cpus =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_cpus);
+
+static bool xive_nvt_kvm_cpu_is_enabled(CPUState *cs)
+{
+    KVMEnabledCPU *enabled_cpu;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+
+    QLIST_FOREACH(enabled_cpu, &kvm_enabled_cpus, node) {
+        if (enabled_cpu->vcpu_id =3D=3D vcpu_id) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void xive_nvt_kvm_cpu_enable(CPUState *cs)
+{
+    KVMEnabledCPU *enabled_cpu;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+
+    enabled_cpu =3D g_malloc(sizeof(*enabled_cpu));
+    enabled_cpu->vcpu_id =3D vcpu_id;
+    QLIST_INSERT_HEAD(&kvm_enabled_cpus, enabled_cpu, node);
+}
+
+static inline bool xive_queue_is_valid(int priority)
+{
+    switch (priority) {
+    case 0 ... 6:
+        return true;
+    case 7: /* OPAL escalation queue */
+    default:
+        return false;
+    }
+}
+
+static void xive_nvt_kvm_get_state(XiveNVT *nvt)
+{
+    uint64_t state[2] =3D { 0 };
+    int ret;
+    int i;
+
+    ret =3D kvm_get_one_reg(nvt->cs, KVM_REG_PPC_VP_STATE, state);
+    if (ret !=3D 0) {
+        error_report("Unable to retrieve KVM XIVE interrupt controller s=
tate"
+                " for CPU %ld: %s", kvm_arch_vcpu_id(nvt->cs), strerror(=
errno));
+        return;
+    }
+
+    /* First quad should be a backup of word0 and word1 of the OS
+     * ring. Second quad is the OPAL internal state which holds word4
+     * of the VP structure. We are only interested by the IPB in there
+     * but we should consider it as opaque.
+     *
+     * As we won't use the registers of the HV ring on sPAPR, let's
+     * hijack them to store the 'OPAL' state
+     */
+    *((uint64_t *) nvt->ring_os) =3D state[0];
+    *((uint64_t *) &nvt->regs[TM_QW2_HV_POOL]) =3D state[1];
+
+    /* Now dump all the queue internals  */
+    for (i =3D 0; i < ARRAY_SIZE(nvt->eqt); i++) {
+        XiveEQ eq =3D { 0 };
+
+        if (!xive_queue_is_valid(i)) {
+            continue;
+        }
+
+        ret =3D kvm_get_one_reg(nvt->cs, KVM_REG_PPC_VP_EQ0 + i, &eq);
+        if (ret !=3D 0) {
+            error_report("Unable to retrieve KVM XIVE interrupt controll=
er"
+                         " state for CPU %ld priority %d: %s",
+                         kvm_arch_vcpu_id(nvt->cs), i, strerror(errno));
+            return;
+        }
+
+        if (eq.w0 & EQ_W0_VALID) {
+            memcpy(&nvt->eqt[i], &eq, sizeof(nvt->eqt[i]));
+        }
+    }
+}
+
+static void xive_nvt_kvm_do_synchronize_state(CPUState *cpu,
+                                              run_on_cpu_data arg)
+{
+    xive_nvt_kvm_get_state(arg.host_ptr);
+}
+
+static void xive_nvt_kvm_synchronize_state(XiveNVT *nvt)
+{
+    if (nvt->cs) {
+        run_on_cpu(nvt->cs, xive_nvt_kvm_do_synchronize_state,
+                   RUN_ON_CPU_HOST_PTR(nvt));
+    }
+}
+
+static int xive_nvt_kvm_set_state(XiveNVT *nvt, int version_id)
+{
+    uint64_t state[2];
+    int ret;
+    int i;
+
+    /* NVT for this CPU thread is not in use, exiting */
+    if (!nvt->cs) {
+        return 0;
+    }
+
+    state[0] =3D *((uint64_t *) nvt->ring_os);
+    state[1] =3D *((uint64_t *) &nvt->regs[TM_QW2_HV_POOL]);
+
+    ret =3D kvm_set_one_reg(nvt->cs, KVM_REG_PPC_VP_STATE, state);
+    if (ret !=3D 0) {
+        error_report("Unable to restore KVM XIVE interrupt controller st=
ate"
+                     " for CPU %ld: %s", kvm_arch_vcpu_id(nvt->cs),
+                     strerror(errno));
+        return ret;
+    }
+
+    for (i =3D 0; i < ARRAY_SIZE(nvt->eqt); i++) {
+        XiveEQ *eq =3D &nvt->eqt[i];
+
+        if (!xive_queue_is_valid(i)) {
+            continue;
+        }
+
+        if (!(eq->w0 & EQ_W0_VALID)) {
+            continue;
+        }
+
+        ret =3D kvm_set_one_reg(nvt->cs, KVM_REG_PPC_VP_EQ0 + i, eq);
+        if (ret !=3D 0) {
+            error_report("Unable to restore KVM XIVE interrupt controlle=
r"
+                         " state for CPU %ld priority %d: %s",
+                         kvm_arch_vcpu_id(nvt->cs), i, strerror(errno));
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static void xive_nvt_kvm_reset(XiveNVT *nvt)
+{
+    /* XIVE is not enabled at first machine reset, only after CAS. */
+    if (kernel_xive_fd =3D=3D -1) {
+        return;
+    }
+
+    xive_nvt_kvm_set_state(nvt, 1);
+}
+
+static void xive_nvt_kvm_realize(XiveNVT *nvt, Error **errp)
+{
+    CPUState *cs =3D nvt->cs;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+    int ret;
+
+    /* Check if CPU was hot unplugged and replugged. */
+    if (xive_nvt_kvm_cpu_is_enabled(cs)) {
+        return;
+    }
+
+    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_IRQ_XIVE, 0, kernel_xive=
_fd,
+                              vcpu_id, 0);
+    if (ret < 0) {
+        error_setg(errp, "Unable to connect CPU%ld to KVM XIVE device: %=
s",
+                   vcpu_id, strerror(errno));
+        return;
+    }
+
+    xive_nvt_kvm_cpu_enable(cs);
+}
+
+static void xive_nvt_kvm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    XiveNVTClass *xnc =3D XIVE_NVT_CLASS(klass);
+
+    dc->desc =3D "XIVE KVM Interrupt Presenter";
+
+    xnc->realize =3D xive_nvt_kvm_realize;
+    xnc->synchronize_state =3D xive_nvt_kvm_synchronize_state;
+    xnc->reset =3D xive_nvt_kvm_reset;
+    xnc->pre_save =3D xive_nvt_kvm_get_state;
+    xnc->post_load =3D xive_nvt_kvm_set_state;
+}
+
+static const TypeInfo xive_nvt_kvm_info =3D {
+    .name          =3D TYPE_XIVE_NVT_KVM,
+    .parent        =3D TYPE_XIVE_NVT,
+    .instance_size =3D sizeof(XiveNVT),
+    .class_init    =3D xive_nvt_kvm_class_init,
+    .class_size    =3D sizeof(XiveNVTClass),
+};
+
+static void xive_source_kvm_set_irq(void *opaque, int srcno, int val)
+{
+    XiveSource *xsrc =3D opaque;
+    struct kvm_irq_level args;
+    int rc;
+
+    args.irq =3D srcno + xsrc->offset;
+    if (!xive_source_irq_is_lsi(xsrc, srcno)) {
+        if (!val) {
+            return;
+        }
+        args.level =3D KVM_INTERRUPT_SET;
+    } else {
+        args.level =3D val ? KVM_INTERRUPT_SET_LEVEL : KVM_INTERRUPT_UNS=
ET;
+    }
+    rc =3D kvm_vm_ioctl(kvm_state, KVM_IRQ_LINE, &args);
+    if (rc < 0) {
+        error_report("kvm_irq_line() failed : %s", strerror(errno));
+    }
+}
+
+static void xive_source_kvm_reset(XiveSource *xsrc)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE_KVM(xsrc->xive);
+    int i;
+
+    /* XIVE is not enabled at first machine reset, only after CAS. */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
+    /*
+     * At reset, interrupt sources are simply created and MASKED, we
+     * only need to inform KVM about their type: LSI or MSI.
+     */
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        Error *err =3D NULL;
+        uint64_t state =3D 0;
+
+        if (xive_source_irq_is_lsi(xsrc, i)) {
+            state |=3D KVM_XICS_LEVEL_SENSITIVE;
+        }
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCES,
+                          i + xsrc->offset, &state, true, &err);
+        if (err) {
+            error_report_err(err);
+            return;
+        }
+    }
+}
+
+/*
+ * This is used to perform the magic loads from an ESB described in
+ * xive.h.
+ */
+static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t offse=
t)
+{
+    unsigned long addr =3D (unsigned long) xsrc->esb_mmap +
+        (1ull << xsrc->esb_shift) * srcno;
+
+    /* In a two pages ESB MMIO setting, the odd page is for management *=
/
+    if (xive_source_esb_2page(xsrc)) {
+        addr +=3D (1 << (xsrc->esb_shift - 1));
+    }
+    addr +=3D offset;
+
+    return *((uint8_t *) addr);
+}
+
+static void xive_source_kvm_get_state(XiveSource *xsrc)
+{
+    int i;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        /* Perform a load without side effect to retrieve the PQ bits */
+        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
+
+        /* and save PQ locally */
+        xive_source_pq_set(xsrc, i, pq);
+    }
+}
+
+static int xive_source_kvm_set_state(XiveSource *xsrc, int version_id)
+{
+    int i;
+    int unused =3D 0;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq =3D xive_source_pq_get(xsrc, i);
+
+        /* TODO: prevent the compiler from optimizing away the load */
+        unused |=3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8=
));
+    }
+
+    return unused;
+}
+
+static void xive_source_kvm_synchronize_state(XiveSource *xsrc)
+{
+    xive_source_kvm_get_state(xsrc);
+}
+
+static void xive_source_kvm_realize(DeviceState *dev, Error **errp)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE_KVM(dev);
+
+    xive_source_common_realize(xsrc, xive_source_kvm_set_irq, errp);
+
+    /* The memory regions for the ESB MMIOs will be initialized after
+     * KVM is, but we need to declare them on SysBus for the first
+     * munmap to work in spapr_reset_interrupt() */
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xsrc->esb_mmio);
+}
+
+static void xive_source_kvm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    XiveSourceClass *xsc =3D XIVE_SOURCE_CLASS(klass);
+
+    dc->realize =3D xive_source_kvm_realize;
+    dc->desc =3D "XIVE KVM interrupt source";
+
+    xsc->synchronize_state =3D xive_source_kvm_synchronize_state;
+    xsc->reset =3D xive_source_kvm_reset;
+    xsc->pre_save =3D xive_source_kvm_get_state;
+    xsc->post_load =3D xive_source_kvm_set_state;
+}
+
+static const TypeInfo xive_source_kvm_info =3D {
+    .name =3D TYPE_XIVE_SOURCE_KVM,
+    .parent =3D TYPE_XIVE_SOURCE,
+    .instance_size =3D sizeof(XiveSource),
+    .class_init    =3D xive_source_kvm_class_init,
+    .class_size    =3D sizeof(XiveSourceClass),
+};
+
+static void spapr_xive_kvm_get_state(sPAPRXive *xive)
+{
+    XiveSource *xsrc =3D &xive->source;
+    int i;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        XiveIVE *ive =3D &xive->ivt[i];
+
+        if (!(ive->w & IVE_VALID)) {
+            continue;
+        }
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_IVE,
+                          i + xsrc->offset, ive, false, &error_abort);
+    }
+}
+
+static int spapr_xive_kvm_set_state(sPAPRXive *xive, int version_id)
+{
+    XiveSource *xsrc =3D &xive->source;
+    int i;
+
+    /* First initialize the KVM device sources, as XIVE is not enabled
+     * at machine reset */
+    xive_source_kvm_reset(xsrc);
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        XiveIVE *ive =3D &xive->ivt[i];
+        Error *err =3D NULL;
+
+        if (!(ive->w & IVE_VALID) || ive->w & IVE_MASKED) {
+            continue;
+        }
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_IVE,
+                          i + xsrc->offset, ive, true, &err);
+        if (err) {
+            error_report_err(err);
+            return -1;
+        }
+    }
+    return 0;
+}
+
+static void spapr_xive_kvm_synchronize_state(sPAPRXive *xive)
+{
+    spapr_xive_kvm_get_state(xive);
+}
+
+static void spapr_xive_kvm_init(Object *obj)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE_KVM(obj);
+
+    /* We need a KVM flavored source */
+    object_initialize(&xive->source, sizeof(xive->source),
+                      TYPE_XIVE_SOURCE_KVM);
+    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
+}
+
+static void spapr_xive_kvm_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE_KVM(dev);
+    Error *local_err =3D NULL;
+
+    spapr_xive_common_realize(xive, XIVE_ESB_64K_2PAGE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    xive->fd =3D -1;
+
+    /* The memory regions for the TIMA MMIOs will be initialized after
+     * KVM is, but we need to declare them on SysBus for the first
+     * munmap to work in spapr_reset_interrupt() */
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio_user);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio_os);
+}
+
+static void spapr_xive_kvm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    sPAPRXiveClass *sxc =3D SPAPR_XIVE_CLASS(klass);
+
+    dc->realize =3D spapr_xive_kvm_realize;
+    /* spapr_xive_reset() is used for reset. */
+    dc->desc =3D "sPAPR XIVE KVM interrupt controller";
+
+    sxc->synchronize_state =3D spapr_xive_kvm_synchronize_state;
+    sxc->pre_save =3D spapr_xive_kvm_get_state;
+    sxc->post_load =3D spapr_xive_kvm_set_state;
+}
+
+static const TypeInfo spapr_xive_kvm_info =3D {
+    .name =3D TYPE_SPAPR_XIVE_KVM,
+    .parent =3D TYPE_SPAPR_XIVE,
+    .instance_init =3D spapr_xive_kvm_init,
+    .instance_size =3D sizeof(sPAPRXive),
+    .class_init =3D spapr_xive_kvm_class_init,
+    .class_size =3D sizeof(sPAPRXiveClass),
+};
+
+static void xive_kvm_register_types(void)
+{
+    type_register_static(&spapr_xive_kvm_info);
+    type_register_static(&xive_source_kvm_info);
+    type_register_static(&xive_nvt_kvm_info);
+}
+
+type_init(xive_kvm_register_types)
+
+static void *spapr_xive_kvm_mmap(sPAPRXive *xive, int ctrl, size_t len,
+                                 Error **errp)
+{
+    Error *local_err =3D NULL;
+    void *addr;
+    int fd;
+
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL, ctrl, &fd, false,
+                      &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    addr =3D mmap(NULL, len, PROT_WRITE | PROT_READ, MAP_SHARED, fd, 0);
+    close(fd);
+    if (addr =3D=3D MAP_FAILED) {
+        error_setg_errno(errp, errno, "Unable to set XIVE mmaping");
+        return NULL;
+    }
+
+    return addr;
+}
+
+void xive_kvm_init(sPAPRXive *xive, Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
+    size_t esb_len, tima_len;
+
+    if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
+        error_setg(errp,
+                   "IRQ_XIVE capability must be present for KVM XIVE dev=
ice");
+        return;
+    }
+
+    xive->fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
+    if (xive->fd < 0) {
+        error_setg_errno(errp, -xive->fd, "error creating KVM XIVE devic=
e");
+        return;
+    }
+
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL, KVM_DEV_XIVE_VC_B=
ASE,
+                      &xsrc->esb_base, true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* ESB MMIO region */
+    esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+    xsrc->esb_mmap =3D spapr_xive_kvm_mmap(xive, KVM_DEV_XIVE_GET_ESB_FD=
,
+                                         esb_len, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    memory_region_init_ram_device_ptr(&xsrc->esb_mmio, OBJECT(xsrc),
+                                      "xive.esb", esb_len, xsrc->esb_mma=
p);
+
+    /* TIMA USER MMIO region */
+    tima_len =3D 1ull << TM_SHIFT;
+    xive->tm_mmap_user =3D spapr_xive_kvm_mmap(xive, KVM_DEV_XIVE_GET_TI=
MA_FD,
+                                             tima_len, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    memory_region_init_ram_device_ptr(&xive->tm_mmio_user, OBJECT(xive),
+                                      "xive.tima.user", tima_len,
+                                      xive->tm_mmap_user);
+
+    /* TIMA OS MMIO region */
+    xive->tm_mmap_os =3D spapr_xive_kvm_mmap(xive, KVM_DEV_XIVE_GET_TIMA=
_FD,
+                                           tima_len, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    memory_region_init_ram_device_ptr(&xive->tm_mmio_os, OBJECT(xive),
+                                      "xive.tima.os", tima_len,
+                                      xive->tm_mmap_os);
+
+    kernel_xive_fd =3D xive->fd;
+    kvm_kernel_irqchip =3D true;
+    kvm_msi_via_irqfd_allowed =3D true;
+    kvm_gsi_direct_mapping =3D true;
+}
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 520b532dbf09..d96732cfe6be 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -487,6 +487,7 @@ static const VMStateDescription vmstate_xive_nvt =3D =
{
     .minimum_version_id =3D 1,
     .pre_save =3D vmstate_xive_nvt_pre_save,
     .post_load =3D vmstate_xive_nvt_post_load,
+    .priority =3D MIG_PRI_XIVE_NVT,
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(regs, XiveNVT),
         VMSTATE_STRUCT_ARRAY(eqt, XiveNVT, (XIVE_PRIORITY_MAX + 1), 1,
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index f3ac084a71be..75b790cc9730 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -30,6 +30,11 @@ typedef struct sPAPRXive {
     hwaddr       tm_base;
     MemoryRegion tm_mmio_user;
     MemoryRegion tm_mmio_os;
+
+    /* KVM support */
+    int          fd;
+    void         *tm_mmap_user;
+    void         *tm_mmap_os;
 } sPAPRXive;
=20
 #define SPAPR_XIVE_CLASS(klass) \
@@ -66,4 +71,22 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, int nr_servers, void *fdt,
                    uint32_t phandle);
=20
+/*
+ * XIVE KVM device
+ */
+
+#define TYPE_SPAPR_XIVE_KVM "spapr-xive-kvm"
+#define SPAPR_XIVE_KVM(obj) \
+    OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE_KVM)
+
+#define TYPE_XIVE_SOURCE_KVM "xive-source-kvm"
+#define XIVE_SOURCE_KVM(obj) \
+    OBJECT_CHECK(XiveSource, (obj), TYPE_XIVE_SOURCE_KVM)
+
+#define TYPE_XIVE_NVT_KVM "xive-nvt-kvm"
+#define XIVE_NVT_KVM(obj) \
+    OBJECT_CHECK(XiveNVT, (obj), TYPE_XIVE_NVT_KVM)
+
+void xive_kvm_init(sPAPRXive *xive, Error **errp);
+
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index b040cf580fc9..e99cd874ef3c 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -58,6 +58,9 @@ typedef struct XiveSource {
     MemoryRegion esb_mmio;
=20
     XiveFabric   *xive;
+
+    /* KVM support */
+    void         *esb_mmap;
 } XiveSource;
=20
 #define XIVE_SOURCE_CLASS(klass) \
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index df463fd33d69..482bdf365297 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -151,6 +151,8 @@ typedef enum {
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
     MIG_PRI_GICV3,              /* Must happen before the ITS */
+    MIG_PRI_XIVE_IVE,           /* Must happen before XIVE source */
+    MIG_PRI_XIVE_NVT,           /* Must happen before XIVE IVE */
     MIG_PRI_MAX,
 } MigrationPriority;
=20
--=20
2.13.6
