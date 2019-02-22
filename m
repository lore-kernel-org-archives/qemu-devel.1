Received: from eggs.gnu.org ([209.51.188.92]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApR-0000pp-Ag
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAeU-0004N8-5C
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAeT-0003vu-Mw
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:06 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDBuRu139482
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qtf667sw4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:39 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:37 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:15 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-7-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/13] spapr/xive: add migration support for
 KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When the VM is stopped, the VM state handler stabilizes the XIVE IC
and marks the EQ pages dirty. These are then transferred to destination
before the transfer of the device vmstates starts.

The sPAPRXive interrupt controller model captures the XIVE internal
tables, EAT and ENDT and the XiveTCTX model does the same for the
thread interrupt context registers.

At restart, the sPAPRXive 'post_load' method restores all the XIVE
states. It is called by the sPAPR machine 'post_load' method, when all
XIVE states have been transferred and loaded.

Finally, the source states are restored in the VM change state handler
when the machine reaches the running state.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |  3 ++
 include/hw/ppc/xive.h       |  1 +
 hw/intc/spapr_xive.c        | 24 ++++++++++
 hw/intc/spapr_xive_kvm.c    | 93 ++++++++++++++++++++++++++++++++++++-
 hw/intc/xive.c              | 17 +++++++
 hw/ppc/spapr_irq.c          |  2 +-
 6 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 298d204d54ef..22d70650b51f 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -55,6 +55,7 @@ typedef struct sPAPRXive {
 bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
+int spapr_xive_post_load(sPAPRXive *xive, int version_id);
=20
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
@@ -83,5 +84,7 @@ void kvmppc_xive_get_queue_config(sPAPRXive *xive, uint=
8_t end_blk,
                                  uint32_t end_idx, XiveEND *end,
                                  Error **errp);
 void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp);
+int kvmppc_xive_pre_save(sPAPRXive *xive);
+int kvmppc_xive_post_load(sPAPRXive *xive, int version_id);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index f3766fd881a2..3b1baa783975 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -432,5 +432,6 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, Error=
 **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
+void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
=20
 #endif /* PPC_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 9f07567f4d78..21fe5e1aa39f 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -469,10 +469,34 @@ static const VMStateDescription vmstate_spapr_xive_=
eas =3D {
     },
 };
=20
+static int vmstate_spapr_xive_pre_save(void *opaque)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvmppc_xive_pre_save(SPAPR_XIVE(opaque));
+    }
+
+    return 0;
+}
+
+/*
+ * Called by the sPAPR IRQ backend 'post_load' method at the machine
+ * level.
+ */
+int spapr_xive_post_load(sPAPRXive *xive, int version_id)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvmppc_xive_post_load(xive, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_spapr_xive =3D {
     .name =3D TYPE_SPAPR_XIVE,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .pre_save =3D vmstate_spapr_xive_pre_save,
+    .post_load =3D NULL, /* handled at the machine level */
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, sPAPRXive, nr_irqs,
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 44d80175b1b5..119fd59fc9ae 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -15,6 +15,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xive.h"
 #include "kvm_ppc.h"
@@ -60,7 +61,30 @@ static void kvm_cpu_enable(CPUState *cs)
 /*
  * XIVE Thread Interrupt Management context (KVM)
  */
-static void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
+
+static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
+{
+    uint64_t state[4];
+    int ret;
+
+    /* word0 and word1 of the OS ring. */
+    state[0] =3D *((uint64_t *) &tctx->regs[TM_QW1_OS]);
+
+    /*
+     * OS CAM line. Used by KVM to print out the VP identifier. This
+     * is for debug only.
+     */
+    state[1] =3D *((uint64_t *) &tctx->regs[TM_QW1_OS + TM_WORD2]);
+
+    ret =3D kvm_set_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
+    if (ret !=3D 0) {
+        error_setg_errno(errp, errno,
+                         "XIVE: could not restore KVM state of CPU %ld",
+                         kvm_arch_vcpu_id(tctx->cs));
+    }
+}
+
+void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 {
     uint64_t state[4] =3D { 0 };
     int ret;
@@ -501,6 +525,73 @@ void kvmppc_xive_synchronize_state(sPAPRXive *xive, =
Error **errp)
     kvmppc_xive_get_queues(xive, errp);
 }
=20
+/*
+ * The sPAPRXive 'pre_save' method is called by the vmstate handler of
+ * the sPAPRXive model, after the XIVE controller is synced in the VM
+ * change handler.
+ */
+int kvmppc_xive_pre_save(sPAPRXive *xive)
+{
+    Error *local_err =3D NULL;
+
+    /* EAT: there is no extra state to query from KVM */
+
+    /* ENDT */
+    kvmppc_xive_get_queues(xive, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -1;
+    }
+
+    return 0;
+}
+
+/*
+ * The sPAPRXive 'post_load' method is not called by a vmstate
+ * handler. It is called at the sPAPR machine level at the end of the
+ * migration sequence by the sPAPR IRQ backend 'post_load' method,
+ * when all XIVE states have been transferred and loaded.
+ */
+int kvmppc_xive_post_load(sPAPRXive *xive, int version_id)
+{
+    Error *local_err =3D NULL;
+    CPUState *cs;
+    int i;
+
+    /* Restore the ENDT first. The targetting depends on it. */
+    for (i =3D 0; i < xive->nr_ends; i++) {
+        kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
+                                     &xive->endt[i], &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+    }
+
+    /* Restore the EAT */
+    for (i =3D 0; i < xive->nr_irqs; i++) {
+        kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_err=
);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+    }
+
+    /* Restore the thread interrupt contexts */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &local_err=
);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+    }
+
+    /* The source states will be restored when the machine starts runnin=
g */
+    return 0;
+}
+
 static void *kvmppc_xive_mmap(sPAPRXive *xive, int pgoff, size_t len,
                               Error **errp)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f478c52ab2a0..1f8e923ca654 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -518,10 +518,27 @@ static void xive_tctx_unrealize(DeviceState *dev, E=
rror **errp)
     qemu_unregister_reset(xive_tctx_reset, dev);
 }
=20
+static int vmstate_xive_tctx_pre_save(void *opaque)
+{
+    Error *local_err =3D NULL;
+
+    if (kvm_irqchip_in_kernel()) {
+        kvmppc_xive_cpu_get_state(XIVE_TCTX(opaque), &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_xive_tctx =3D {
     .name =3D TYPE_XIVE_TCTX,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .pre_save =3D vmstate_xive_tctx_pre_save,
+    .post_load =3D NULL, /* handled by the sPAPRxive model */
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(regs, XiveTCTX),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 1ad57582a403..12ecca6264f3 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -356,7 +356,7 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMachi=
neState *spapr,
=20
 static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
 {
-    return 0;
+    return spapr_xive_post_load(spapr->xive, version_id);
 }
=20
 static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
--=20
2.20.1
