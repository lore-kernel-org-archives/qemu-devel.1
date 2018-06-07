Received: from eggs.gnu.org ([2001:4830:134:3::10]:39396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDG-0003FJ-2A
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDB-0004T3-A2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:34 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:57356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxDA-0004SS-TY
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:29 -0400
Received: from player169.ha.ovh.net (unknown [10.109.105.112])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5C56FE6A4C
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:27 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:59 +0200
Message-Id: <20180607155003.1580-25-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 24/28] spapr/xive: add KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This introduces a set of XIVE models specific to KVM. They handle the
initialization and the state synchronization with KVM, for the monitor
usage and for the migration.

The TIMA and the source ESB memory regions are initialized differently
under KVM. 'ram device' memory mappings, similarly to VFIO, are
exposed to the guest and the associated VMAs on the host are populated
dynamically with the appropriate pages using a fault handler.

Migration needs to follow a specific sequence to make sure the
different internal states are captured correctly. This is why we raise
the sPAPRXive KVM model migration priority to make sure its pre_save
handler runs before the other XIVE models' pre_save.

sPAPRXive pre_save starts by masking all the sources to quiesce the
interrupt flow and perform a XIVE xync to stabilize the EQs. The EQs
are then masked to stop notifications to a VP and their state is
captured. What is important is the EQ index and the toggle
bit. Follows the capture of the state of the thread context. When
done, a rollback is performed to restore the sources and the EQs to
their initial state. Post_load is simpler and only needs to restore
the different state in the correct order.

The get/set operations rely on their KVM counterpart in the host
kernel which acts as a proxy for OPAL, the host firmware. Extra
quiescence points are possibly needed so the XIVE migration is
currently work in progress.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 default-configs/ppc64-softmmu.mak |   1 +
 include/hw/ppc/spapr_xive.h       |  20 +
 include/hw/ppc/xive.h             |   3 +
 include/migration/vmstate.h       |   1 +
 hw/intc/spapr_xive.c              |   1 +
 hw/intc/spapr_xive_kvm.c          | 809 ++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_irq.c                |  29 +-
 hw/intc/Makefile.objs             |   1 +
 8 files changed, 855 insertions(+), 10 deletions(-)
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
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 4aa04bc48ccb..f3e9208ad1f3 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -36,6 +36,10 @@ typedef struct sPAPRXive {
     /* TIMA mapping address */
     hwaddr       tm_base;
     MemoryRegion tm_mmio;
+
+    /* KVM support */
+    int          fd;
+    void         *tm_mmap;
 } sPAPRXive;
=20
 #define SPAPR_XIVE_CLASS(klass) \
@@ -79,4 +83,20 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRXive *xive, int nr_servers, void *fdt,
                    uint32_t phandle);
=20
+/*
+ * XIVE KVM models
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
+#define TYPE_XIVE_TCTX_KVM "xive-tctx-kvm"
+#define XIVE_TCTX_KVM(obj) \
+    OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX_KVM)
+
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 7a54b3ce594f..a2c1cc6b5126 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -65,6 +65,9 @@ typedef struct XiveSource {
     uint32_t        esb_shift;
     MemoryRegion    esb_mmio;
=20
+    /* KVM support */
+    void            *esb_mmap;
+
     XiveFabric      *xive;
 } XiveSource;
=20
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 3747110f951a..b707c31b1b0c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -156,6 +156,7 @@ typedef enum {
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
     MIG_PRI_GICV3,              /* Must happen before the ITS */
+    MIG_PRI_XIVE_IC,            /* Must happen before XIVE thread contex=
t */
     MIG_PRI_MAX,
 } MigrationPriority;
=20
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 2812b1a1a030..4eebba5ab8e7 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -335,6 +335,7 @@ static const VMStateDescription vmstate_spapr_xive =3D=
 {
     .minimum_version_id =3D 1,
     .pre_save =3D vmstate_spapr_xive_pre_save,
     .post_load =3D vmstate_spapr_xive_post_load,
+    .priority =3D MIG_PRI_XIVE_IC,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ivt, sPAPRXive, nr_irqs,
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
new file mode 100644
index 000000000000..8b0d5d693e27
--- /dev/null
+++ b/hw/intc/spapr_xive_kvm.c
@@ -0,0 +1,809 @@
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
+/*
+ * Helpers for CPU hotplug
+ */
+typedef struct KVMEnabledCPU {
+    unsigned long vcpu_id;
+    QLIST_ENTRY(KVMEnabledCPU) node;
+} KVMEnabledCPU;
+
+static QLIST_HEAD(, KVMEnabledCPU)
+    kvm_enabled_cpus =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_cpus);
+
+static bool xive_tctx_kvm_cpu_is_enabled(CPUState *cs)
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
+static void xive_tctx_kvm_cpu_enable(CPUState *cs)
+{
+    KVMEnabledCPU *enabled_cpu;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+
+    enabled_cpu =3D g_malloc(sizeof(*enabled_cpu));
+    enabled_cpu->vcpu_id =3D vcpu_id;
+    QLIST_INSERT_HEAD(&kvm_enabled_cpus, enabled_cpu, node);
+}
+
+/*
+ * XIVE Thread Interrupt Management context (KVM)
+ */
+static int xive_tctx_kvm_get_state(XiveTCTX *tctx)
+{
+    uint64_t state[4] =3D { 0 };
+    int ret;
+
+    ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
+    if (ret !=3D 0) {
+        error_report("Unable to retrieve KVM XIVE interrupt controller s=
tate"
+                     " for CPU %ld: %s", kvm_arch_vcpu_id(tctx->cs),
+                     strerror(errno));
+        return ret;
+    }
+
+    /*
+     * First quad is word0 and word1 of the OS ring. Second quad is
+     * the OPAL internal state which holds word4 of the VP
+     * structure. We are only interested by the IPB in there but we
+     * should consider it as opaque.
+     *
+     * As we won't use the registers of the HV ring on sPAPR, let's
+     * hijack them to store the 'OPAL' state
+     */
+    *((uint64_t *) &tctx->regs[TM_QW1_OS]) =3D state[0];
+    *((uint64_t *) &tctx->regs[TM_QW2_HV_POOL]) =3D state[1];
+
+    /*
+     * KVM also returns word2 containing the VP CAM value which is
+     * interesting to print out in the QEMU monitor but we don't
+     * restore it.
+     */
+    *((uint64_t *) &tctx->regs[TM_QW1_OS + TM_WORD2]) =3D state[2];
+
+    return 0;
+}
+
+static void xive_tctx_kvm_do_synchronize_state(CPUState *cpu,
+                                              run_on_cpu_data arg)
+{
+    xive_tctx_kvm_get_state(arg.host_ptr);
+}
+
+static void xive_tctx_kvm_synchronize_state(XiveTCTX *tctx)
+{
+    run_on_cpu(tctx->cs, xive_tctx_kvm_do_synchronize_state,
+               RUN_ON_CPU_HOST_PTR(tctx));
+}
+
+static int xive_tctx_kvm_post_load(XiveTCTX *tctx, int version_id)
+{
+    uint64_t state[4];
+    int ret;
+
+    state[0] =3D *((uint64_t *) &tctx->regs[TM_QW1_OS]);
+    state[1] =3D *((uint64_t *) &tctx->regs[TM_QW2_HV_POOL]);
+
+    ret =3D kvm_set_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
+    if (ret !=3D 0) {
+        error_report("Unable to restore KVM XIVE interrupt controller st=
ate"
+                     " for CPU %ld: %s", kvm_arch_vcpu_id(tctx->cs),
+                     strerror(errno));
+    }
+    return ret;
+}
+
+static void xive_tctx_kvm_realize(XiveTCTX *tctx, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(tctx->xrtr);
+    CPUState *cs =3D tctx->cs;
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+    int ret;
+
+    /* Check if CPU was hot unplugged and replugged. */
+    if (xive_tctx_kvm_cpu_is_enabled(cs)) {
+        return;
+    }
+
+    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_IRQ_XIVE, 0, xive->fd,
+                              vcpu_id, 0);
+    if (ret < 0) {
+        error_setg(errp, "Unable to connect CPU%ld to KVM XIVE device: %=
s",
+                   vcpu_id, strerror(errno));
+        return;
+    }
+
+    xive_tctx_kvm_cpu_enable(cs);
+}
+
+static void xive_tctx_kvm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    XiveTCTXClass *xnc =3D XIVE_TCTX_CLASS(klass);
+
+    dc->desc =3D "sPAPR XIVE KVM Interrupt Thread Context";
+
+    xnc->realize =3D xive_tctx_kvm_realize;
+    xnc->synchronize_state =3D xive_tctx_kvm_synchronize_state;
+    xnc->post_load =3D xive_tctx_kvm_post_load;
+}
+
+static const TypeInfo xive_tctx_kvm_info =3D {
+    .name          =3D TYPE_XIVE_TCTX_KVM,
+    .parent        =3D TYPE_XIVE_TCTX,
+    .instance_size =3D sizeof(XiveTCTX),
+    .class_init    =3D xive_tctx_kvm_class_init,
+    .class_size    =3D sizeof(XiveTCTXClass),
+};
+
+/*
+ * XIVE Interrupt Source (KVM)
+ */
+static void xive_source_kvm_reset(XiveSource *xsrc)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE_KVM(xsrc->xive);
+    int i;
+
+    /*
+     * At reset, interrupt sources are simply created and MASKED. We
+     * only need to inform the KVM device about their type: LSI or
+     * MSI.
+     */
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        Error *err =3D NULL;
+        uint64_t state =3D 0;
+
+        if (xive_source_irq_is_lsi(xsrc, i)) {
+            state |=3D KVM_XIVE_LEVEL_SENSITIVE;
+            if (xsrc->status[i] & XIVE_STATUS_ASSERTED) {
+                state |=3D KVM_XIVE_LEVEL_ASSERTED;
+            }
+        }
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCES,
+                          i, &state, true, &err);
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
+        xive_source_esb_mgmt(xsrc, srcno) + offset;
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
+        xive_source_esb_set(xsrc, i, pq);
+    }
+}
+
+static void xive_source_kvm_synchronize_state(XiveSource *xsrc)
+{
+    xive_source_kvm_get_state(xsrc);
+}
+
+static int xive_source_kvm_post_load(XiveSource *xsrc, int version_id)
+{
+    int i;
+    int unused =3D 0;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq =3D xive_source_esb_get(xsrc, i);
+
+        /* TODO: prevent the compiler from optimizing away the load */
+        unused |=3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8=
));
+    }
+
+    return unused;
+}
+
+static void xive_source_kvm_set_irq(void *opaque, int srcno, int val)
+{
+    XiveSource *xsrc =3D opaque;
+    struct kvm_irq_level args;
+    int rc;
+
+    args.irq =3D srcno;
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
+/*
+ * The sPAPRXive KVM model should have initialized the KVM device
+ * before initializing the source
+ */
+static void xive_source_kvm_realize(DeviceState *dev, Error **errp)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE_KVM(dev);
+    sPAPRXive *xive =3D NULL;
+    Error *local_err =3D NULL;
+    size_t esb_len;
+
+    xive_source_common_realize(xsrc, xive_source_kvm_set_irq, errp);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    xive =3D SPAPR_XIVE_KVM(xsrc->xive);
+
+    /* Map the source ESB pages */
+    esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+    xsrc->esb_mmap =3D spapr_xive_kvm_mmap(xive, KVM_DEV_XIVE_GET_ESB_FD=
,
+                                         esb_len, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    memory_region_init_ram_device_ptr(&xsrc->esb_mmio, OBJECT(xsrc),
+                                      "xive.esb", esb_len, xsrc->esb_mma=
p);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xsrc->esb_mmio);
+}
+
+static void xive_source_kvm_unrealize(DeviceState *dev, Error **errp)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE_KVM(dev);
+    size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+
+    munmap(xsrc->esb_mmap, esb_len);
+}
+
+static void xive_source_kvm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    XiveSourceClass *xsc =3D XIVE_SOURCE_CLASS(klass);
+
+    dc->desc =3D "sPAPR XIVE KVM Interrupt Source";
+    dc->realize =3D xive_source_kvm_realize;
+    dc->unrealize =3D xive_source_kvm_unrealize;
+
+    xsc->synchronize_state =3D xive_source_kvm_synchronize_state;
+    xsc->reset =3D xive_source_kvm_reset;
+    xsc->post_load =3D xive_source_kvm_post_load;
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
+/*
+ * sPAPR XIVE Router (KVM)
+ */
+static int spapr_xive_kvm_set_eq_state(sPAPRXive *xive, CPUState *cs, bo=
ol mask)
+{
+    XiveRouter *xrtr =3D XIVE_ROUTER(xive);
+    int ret;
+    int i;
+
+    for (i =3D 0; i < XIVE_PRIORITY_MAX + 1; i++) {
+        XiveEQ eq;
+        uint8_t eq_blk;
+        uint32_t eq_idx;
+
+        /* skip reserved EQs */
+        if (!spapr_xive_eq_is_valid(i)) {
+            continue;
+        }
+
+        spapr_xive_cpu_to_eq(xrtr, POWERPC_CPU(cs), i, &eq_blk, &eq_idx)=
;
+
+        ret =3D xive_router_get_eq(xrtr, eq_blk, eq_idx, &eq);
+        if (ret) {
+            error_report("XIVE: No EQ for CPU %ld priority %d",
+                         kvm_arch_vcpu_id(cs), i);
+            return ret;
+        }
+
+        if (!(eq.w0 & EQ_W0_VALID)) {
+            continue;
+        }
+
+        /* If EQ is masked, all notification to the NVT will be stopped =
*/
+        if (mask) {
+            eq.w7 =3D SETFIELD(EQ_W7_F0_PRIORITY, 0ul, 0xFF);
+        }
+
+        ret =3D kvm_set_one_reg(cs, KVM_REG_PPC_VP_EQ0 + i, &eq);
+        if (ret !=3D 0) {
+            error_report("KVM XIVE: failed to restore EQ state for CPU %=
ld "
+                         "priority %d: %s", kvm_arch_vcpu_id(cs), i,
+                         strerror(errno));
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static int spapr_xive_kvm_get_eq_state(XiveRouter *xrtr, CPUState *cs)
+{
+    int ret;
+    int i;
+
+    for (i =3D 0; i < XIVE_PRIORITY_MAX + 1; i++) {
+        XiveEQ eq =3D { 0 };
+        uint8_t eq_blk;
+        uint32_t eq_idx;
+
+        /* skip reserved EQs */
+        if (!spapr_xive_eq_is_valid(i)) {
+            continue;
+        }
+
+        ret =3D kvm_get_one_reg(cs, KVM_REG_PPC_VP_EQ0 + i, &eq);
+        if (ret !=3D 0) {
+            error_report("KVM XIVE: failed to save EQ state for CPU %ld =
"
+                         "priority %d: %s", kvm_arch_vcpu_id(cs), i,
+                         strerror(errno));
+            return ret;
+        }
+
+        if (!(eq.w0 & EQ_W0_VALID)) {
+            continue;
+        }
+
+        spapr_xive_cpu_to_eq(xrtr, POWERPC_CPU(cs), i, &eq_blk, &eq_idx)=
;
+
+        ret =3D xive_router_set_eq(xrtr, eq_blk, eq_idx, &eq);
+        if (ret) {
+            error_report("XIVE: No EQ for CPU %ld priority %d",
+                         kvm_arch_vcpu_id(cs), i);
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static int spapr_xive_kvm_set_ive_state(sPAPRXive *xive)
+{
+    XiveSource *xsrc =3D &xive->source;
+    int i;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        XiveIVE *ive =3D &xive->ivt[i];
+        Error *local_err =3D NULL;
+
+        if (!(ive->w & IVE_VALID) || ive->w & IVE_MASKED) {
+            continue;
+        }
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_IVE, i,
+                          ive, true, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+    }
+    return 0;
+}
+
+static void spapr_xive_kvm_get_ive_state(sPAPRXive *xive, Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
+    int i;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        XiveIVE *ive =3D &xive->ivt[i];
+
+        if (!(ive->w & IVE_VALID)) {
+            continue;
+        }
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_IVE, i,
+                          ive, false, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+   }
+}
+
+static void spapr_xive_kvm_sync_all(sPAPRXive *xive, Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
+    int i;
+
+    /* Quiesce the sources */
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        XiveIVE *ive =3D &xive->ivt[i];
+
+        if (!(ive->w & IVE_VALID)) {
+            continue;
+        }
+
+        /* Sync the source now in KVM */
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SYNC, i,
+                          NULL, true, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+}
+
+/*
+ * XIVE save
+ *
+ * Migration needs to follow a specific sequence to make sure the
+ * different internal states are captured correctly. The sPAPRXive KVM
+ * model migration priority is higher to make sure its pre_save
+ * handler runs before the other XIVE models' pre_save.
+ *
+ *   1. mask all the sources by setting PQ=3D01, which returns the
+ *      previous value and save it.
+ *   2. XIVE sync to stabilize the queues
+ *   3. Mask the EQs to stop VP notification (OPAL support)
+ *   4. XIVE sync again
+ *   5. Dump the EQs
+ *   6. Dump the thread context (IPB)
+ *
+ *  Rollback to restore current configuration
+ *
+ *   1. unmask EQs
+ *   2. unmask sources
+ */
+static void spapr_xive_kvm_pre_save(sPAPRXive *xive)
+{
+    XiveSource *xsrc =3D &xive->source;
+    uint8_t *eq_priorities;
+    CPUState *cs;
+    int i;
+    int ret;
+
+    /* Quiesce the sources */
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq;
+
+        /* Mask and save PQ locally */
+        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_01);
+        xive_source_esb_set(xsrc, i, pq);
+    }
+
+    /* Now, sync the sources in KVM */
+    spapr_xive_kvm_sync_all(xive, &error_fatal);
+
+    /* Get the IVT (There are no inflight data, could be done earlier ?)=
 */
+    spapr_xive_kvm_get_ive_state(xive, &error_fatal);
+
+    /*
+     * This EQ backup table is not strictly needed, we could restore
+     * the priority using the EQ index % 8
+     */
+    eq_priorities =3D g_malloc0(xive->nr_eqs);
+
+    /* Get the EQs a first time to save priorities */
+    CPU_FOREACH(cs) {
+        /* TODO: do we need to use run_on_cpu() ? */
+        ret =3D spapr_xive_kvm_get_eq_state(XIVE_ROUTER(xive), cs);
+        if (ret) {
+            goto out;
+        }
+    }
+
+    for (i =3D 0; i < xive->nr_eqs; i++) {
+        eq_priorities[i] =3D GETFIELD(EQ_W7_F0_PRIORITY, xive->eqdt[i].w=
7);
+    }
+
+    /* Mask all the EQs to stop notifications to the NVT.
+     *
+     * TODO: We need OPAL support to mask an EQ, stop queueing and
+     * keep the internal settings
+     */
+    CPU_FOREACH(cs) {
+        int ret =3D spapr_xive_kvm_set_eq_state(xive, cs, true);
+        if (ret) {
+            goto out;
+        }
+    }
+
+    /* And sync again */
+    spapr_xive_kvm_sync_all(xive, &error_fatal);
+
+    /* Get the EQs for real now. We want the EQ index and the toggle bit=
 */
+    CPU_FOREACH(cs) {
+        spapr_xive_kvm_get_eq_state(XIVE_ROUTER(xive), cs);
+    }
+
+    /* And restore the priorities in the EQ dumped state */
+    for (i =3D 0; i < xive->nr_eqs; i++) {
+        xive->eqdt[i].w7 =3D SETFIELD(EQ_W7_F0_PRIORITY, 0ul, eq_priorit=
ies[i]);
+    }
+
+    /* Get the VP thread contexts. The IPB is what we want */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        XiveTCTX *tctx =3D XIVE_TCTX_KVM(cpu->intc);
+
+        ret =3D xive_tctx_kvm_get_state(tctx);
+        if (ret) {
+            goto out;
+        }
+    }
+
+    /* We should be done now. We can roll back */
+
+    /* Restore EQs to their initial state. They were masked */
+    CPU_FOREACH(cs) {
+        int ret =3D spapr_xive_kvm_set_eq_state(xive, cs, false);
+        if (ret) {
+            goto out;
+        }
+    }
+
+    /* Restore the sources to their initial state */
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq =3D xive_source_esb_get(xsrc, i);
+        if (xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8)) !=3D =
0x1) {
+            error_report("XIVE: IRQ %d has an invalid state", i);
+        }
+    }
+
+out:
+    g_free(eq_priorities);
+}
+
+/*
+ * XIVE restore
+ *
+ * post_load is simpler and only needs to restore the different state
+ * in the correct order. sPAPRXive model has the highest priority and
+ * if handles first the XIVE routing internal tables: EQDT and IVT.
+ *
+ * The source ESB PQ bits are restored by the KVM XiveSource. The
+ * thread interrupt context registers are handled by the KVM XiveTCTX
+ * model.
+ */
+static int spapr_xive_kvm_post_load(sPAPRXive *xive, int version_id)
+{
+    XiveSource *xsrc =3D &xive->source;
+    CPUState *cs;
+    int ret;
+
+    /* Set the EQs first. The IVE targetting depends on it. */
+    CPU_FOREACH(cs) {
+        int ret =3D spapr_xive_kvm_set_eq_state(xive, cs, false);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    /*
+     * Create the interrupt sources from a KVM perspective. This is
+     * needed for targetting which is done next
+     */
+    xive_source_kvm_reset(xsrc);
+
+    /* Restore the IVE targetting, if any */
+    ret =3D spapr_xive_kvm_set_ive_state(xive);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
+static void spapr_xive_kvm_eq_do_synchronize_state(CPUState *cs,
+                                                   run_on_cpu_data arg)
+{
+    spapr_xive_kvm_get_eq_state(XIVE_ROUTER(arg.host_ptr), cs);
+}
+
+static void spapr_xive_kvm_synchronize_state(sPAPRXive *xive)
+{
+    CPUState *cs;
+
+    spapr_xive_kvm_get_ive_state(xive, &error_fatal);
+
+    CPU_FOREACH(cs) {
+        run_on_cpu(cs, spapr_xive_kvm_eq_do_synchronize_state,
+                   RUN_ON_CPU_HOST_PTR(xive));
+    }
+}
+
+static void spapr_xive_kvm_instance_init(Object *obj)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE_KVM(obj);
+
+    /* We need a KVM flavored source */
+    object_initialize(&xive->source, sizeof(xive->source),
+                      TYPE_XIVE_SOURCE_KVM);
+    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
+
+    /* No KVM support for EQ ESBs. OPAL doesn't either */
+    object_initialize(&xive->eq_source, sizeof(xive->eq_source),
+                      TYPE_XIVE_EQ_SOURCE);
+    object_property_add_child(obj, "eq_source", OBJECT(&xive->eq_source)=
, NULL);
+}
+
+static void spapr_xive_kvm_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE_KVM(dev);
+    Error *local_err =3D NULL;
+    size_t tima_len;
+
+    if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
+        error_setg(errp,
+                   "IRQ_XIVE capability must be present for KVM XIVE dev=
ice");
+        return;
+    }
+
+    /* First, create a KVM XIVE device */
+    xive->fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
+    if (xive->fd < 0) {
+        error_setg_errno(errp, -xive->fd, "error creating KVM XIVE devic=
e");
+        return;
+    }
+
+    /*
+     * Inform KVM where we will map the source ESB pages. This is
+     * needed but the hcall H_INT_GET_SOURCE_INFO which returns the
+     * source characteristics, among which the ESB page address.
+     */
+    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL, KVM_DEV_XIVE_VC_B=
ASE,
+                      &xive->vc_base, true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /*
+     * Setup the local IVT and EQT tables and the local KVM source
+     * which will map the sources ESB pages
+     */
+    spapr_xive_common_realize(xive, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* Map the TIMA pages */
+    tima_len =3D 4ull << TM_SHIFT;
+    xive->tm_mmap =3D spapr_xive_kvm_mmap(xive, KVM_DEV_XIVE_GET_TIMA_FD=
,
+                                        tima_len, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    memory_region_init_ram_device_ptr(&xive->tm_mmio, OBJECT(xive),
+                                      "xive.tima", tima_len, xive->tm_mm=
ap);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio);
+
+    /* All done. */
+
+    /* May be set these globals in the sPAPR IRQ backend instead */
+    kvm_kernel_irqchip =3D true;
+    kvm_msi_via_irqfd_allowed =3D true;
+    kvm_gsi_direct_mapping =3D true;
+}
+
+static void spapr_xive_kvm_unrealize(DeviceState *dev, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE_KVM(dev);
+
+    close(xive->fd);
+    xive->fd =3D -1;
+
+    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
+}
+
+static void spapr_xive_kvm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    sPAPRXiveClass *sxc =3D SPAPR_XIVE_CLASS(klass);
+
+    dc->desc =3D "sPAPR XIVE KVM Interrupt Controller";
+    dc->realize =3D spapr_xive_kvm_realize;
+    dc->unrealize =3D spapr_xive_kvm_unrealize;
+
+    sxc->synchronize_state =3D spapr_xive_kvm_synchronize_state;
+    sxc->pre_save =3D spapr_xive_kvm_pre_save;
+    sxc->post_load =3D spapr_xive_kvm_post_load;
+}
+
+static const TypeInfo spapr_xive_kvm_info =3D {
+    .name =3D TYPE_SPAPR_XIVE_KVM,
+    .parent =3D TYPE_SPAPR_XIVE,
+    .instance_init =3D spapr_xive_kvm_instance_init,
+    .instance_size =3D sizeof(sPAPRXive),
+    .class_init =3D spapr_xive_kvm_class_init,
+    .class_size =3D sizeof(sPAPRXiveClass),
+};
+
+static void xive_kvm_register_types(void)
+{
+    type_register_static(&spapr_xive_kvm_info);
+    type_register_static(&xive_source_kvm_info);
+    type_register_static(&xive_tctx_kvm_info);
+}
+
+type_init(xive_kvm_register_types)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 745c78024d6f..a5d89c6ac55f 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -575,16 +575,28 @@ static void spapr_irq_init_xive(sPAPRMachineState *=
spapr, uint32_t nr_servers,
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
     int i;
=20
-    /* We don't have KVM support yet, so check for irqchip=3Don */
-    if (kvm_enabled() && machine_kernel_irqchip_required(machine)) {
-        error_report("kernel_irqchip requested. no XIVE support");
-        exit(1);
+    if (kvm_enabled()) {
+        if (machine_kernel_irqchip_allowed(machine)) {
+            spapr->xive_tctx_type =3D TYPE_XIVE_TCTX_KVM;
+            spapr->xive =3D spapr_xive_create(spapr, TYPE_SPAPR_XIVE_KVM=
,
+                                            smc->irq->nr_irqs, nr_server=
s,
+                                            errp);
+        }
+
+        if (machine_kernel_irqchip_required(machine) && !spapr->xive) {
+            error_prepend(errp, "kernel_irqchip requested but unavailabl=
e: ");
+            return;
+        }
     }
=20
-    spapr->xive =3D spapr_xive_create(spapr, TYPE_SPAPR_XIVE, smc->irq->=
nr_irqs,
-                                    nr_servers, errp);
     if (!spapr->xive) {
-        return;
+        spapr->xive =3D spapr_xive_create(spapr, TYPE_SPAPR_XIVE,
+                                        smc->irq->nr_irqs, nr_servers, e=
rrp);
+        if (!spapr->xive) {
+            return;
+        }
+        spapr->xive_tctx_type =3D TYPE_XIVE_TCTX;
+        spapr_xive_hcall_init(spapr);
     }
=20
     /*
@@ -597,9 +609,6 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, uint32_t nr_servers,
     for (i =3D 0; i < nr_servers; ++i) {
         spapr_irq_alloc(spapr, SPAPR_IRQ_IPI, i, errp);
     }
-
-    spapr->xive_tctx_type =3D TYPE_XIVE_TCTX;
-    spapr_xive_hcall_init(spapr);
 }
=20
 /*
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
--=20
2.13.6
