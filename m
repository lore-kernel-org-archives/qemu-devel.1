Received: from eggs.gnu.org ([2001:4830:134:3::10]:44951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYD-0007yn-TS
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgY8-0004Hj-0y
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:53 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:45549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgY7-00049d-CE
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:47 -0500
Received: from player714.ha.ovh.net (unknown [10.109.160.153])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D1C9F41433
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:25:29 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:41 +0100
Message-Id: <20181205232251.10446-28-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 27/37] spapr/xive: add migration support for
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When the VM is stopped, the VM state handler stabilizes the XIVE IC
and marks the EQ pages dirty. These are then transfered to destination
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
 include/hw/ppc/spapr_xive.h |   5 +
 include/hw/ppc/xive.h       |   1 +
 hw/intc/spapr_xive.c        |  34 +++++++
 hw/intc/spapr_xive_kvm.c    | 187 +++++++++++++++++++++++++++++++++++-
 hw/intc/xive.c              |  17 ++++
 hw/ppc/spapr_irq.c          |   2 +-
 6 files changed, 244 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index c447534b6b29..277771eeb4d5 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -47,6 +47,7 @@ bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn=
);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
 bool spapr_xive_priority_is_reserved(uint8_t priority);
+int spapr_xive_post_load(sPAPRXive *xive, int version_id);
=20
 void spapr_xive_cpu_to_nvt(sPAPRXive *xive, PowerPCCPU *cpu,
                            uint8_t *out_nvt_blk, uint32_t *out_nvt_idx);
@@ -54,6 +55,8 @@ void spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU =
*cpu, uint8_t prio,
                            uint8_t *out_end_blk, uint32_t *out_end_idx);
 int spapr_xive_target_to_end(sPAPRXive *xive, uint32_t target, uint8_t p=
rio,
                              uint8_t *out_end_blk, uint32_t *out_end_idx=
);
+int spapr_xive_end_to_target(sPAPRXive *xive, uint8_t end_blk, uint32_t =
end_idx,
+                             uint32_t *out_server, uint8_t *out_prio);
=20
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
@@ -68,5 +71,7 @@ void spapr_xive_map_mmio(sPAPRXive *xive);
  */
 void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
 void kvmppc_xive_synchronize_state(sPAPRXive *xive);
+int kvmppc_xive_pre_save(sPAPRXive *xive);
+int kvmppc_xive_post_load(sPAPRXive *xive, int version_id);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 7330c11d31c8..d06bcae28e9d 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -448,5 +448,6 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, Error=
 **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx);
+void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
=20
 #endif /* PPC_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 87f60dd4e453..b030cfe7f136 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -82,6 +82,19 @@ static int spapr_xive_target_to_nvt(sPAPRXive *xive, u=
int32_t target,
  * sPAPR END indexing uses a simple mapping of the CPU vcpu_id, 8
  * priorities per CPU
  */
+int spapr_xive_end_to_target(sPAPRXive *xive, uint8_t end_blk, uint32_t =
end_idx,
+                             uint32_t *out_server, uint8_t *out_prio)
+{
+    if (out_server) {
+        *out_server =3D end_idx >> 3;
+    }
+
+    if (out_prio) {
+        *out_prio =3D end_idx & 0x7;
+    }
+    return 0;
+}
+
 void spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU *cpu, uint8_t pri=
o,
                            uint8_t *out_end_blk, uint32_t *out_end_idx)
 {
@@ -426,10 +439,31 @@ static const VMStateDescription vmstate_spapr_xive_=
eas =3D {
     },
 };
=20
+static int vmstate_spapr_xive_pre_save(void *opaque)
+{
+    if (kvmppc_xive_enabled()) {
+        return kvmppc_xive_pre_save(SPAPR_XIVE(opaque));
+    }
+
+    return 0;
+}
+
+/* Called by the sPAPR machine 'post_load' method */
+int spapr_xive_post_load(sPAPRXive *xive, int version_id)
+{
+    if (kvmppc_xive_enabled()) {
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
index 5cb7461e9743..04f997479e8f 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -60,7 +60,29 @@ static void kvm_cpu_enable(CPUState *cs)
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
+        error_setg_errno(errp, errno, "Could restore KVM XIVE CPU %ld st=
ate",
+                         kvm_arch_vcpu_id(tctx->cs));
+    }
+}
+
+void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 {
     uint64_t state[4] =3D { 0 };
     int ret;
@@ -210,6 +232,59 @@ void kvmppc_xive_source_set_irq(void *opaque, int sr=
cno, int val)
 /*
  * sPAPR XIVE interrupt controller (KVM)
  */
+
+static int kvmppc_xive_set_eq_state(sPAPRXive *xive, CPUState *cs,
+                                       Error **errp)
+{
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+    int ret;
+    int i;
+
+    for (i =3D 0; i < XIVE_PRIORITY_MAX + 1; i++) {
+        Error *local_err =3D NULL;
+        XiveEND *end;
+        uint8_t end_blk;
+        uint32_t end_idx;
+        struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
+        uint64_t kvm_eq_idx;
+
+        if (spapr_xive_priority_is_reserved(i)) {
+            continue;
+        }
+
+        spapr_xive_cpu_to_end(xive, POWERPC_CPU(cs), i, &end_blk, &end_i=
dx);
+        assert(end_idx < xive->nr_ends);
+        end =3D &xive->endt[end_idx];
+
+        if (!xive_end_is_valid(end)) {
+            continue;
+        }
+
+        /* Build the KVM state from the local END structure */
+        kvm_eq.flags   =3D KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY;
+        kvm_eq.qsize   =3D GETFIELD_BE32(END_W0_QSIZE, end->w0) + 12;
+        kvm_eq.qpage   =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff) =
<< 32 |
+            be32_to_cpu(end->w3);
+        kvm_eq.qtoggle =3D GETFIELD_BE32(END_W1_GENERATION, end->w1);
+        kvm_eq.qindex  =3D GETFIELD_BE32(END_W1_PAGE_OFF, end->w1);
+
+        /* Encode the tuple (server, prio) as a KVM EQ index */
+        kvm_eq_idx =3D i << KVM_XIVE_EQ_PRIORITY_SHIFT &
+            KVM_XIVE_EQ_PRIORITY_MASK;
+        kvm_eq_idx |=3D vcpu_id << KVM_XIVE_EQ_SERVER_SHIFT &
+            KVM_XIVE_EQ_SERVER_MASK;
+
+        ret =3D kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ, kvm_eq_=
idx,
+                                &kvm_eq, true, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int kvmppc_xive_get_eq_state(sPAPRXive *xive, CPUState *cs,
                                        Error **errp)
 {
@@ -281,6 +356,48 @@ static int kvmppc_xive_get_eq_state(sPAPRXive *xive,=
 CPUState *cs,
     return 0;
 }
=20
+static void kvmppc_xive_set_eas_state(sPAPRXive *xive, Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    int i;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        XiveEAS *eas =3D &xive->eat[i];
+        uint32_t end_idx;
+        uint32_t end_blk;
+        uint32_t eisn;
+        uint8_t priority;
+        uint32_t server;
+        uint64_t kvm_eas;
+        Error *local_err =3D NULL;
+
+        /* No need to set MASKED EAS, this is the default state after re=
set */
+        if (!xive_eas_is_valid(eas) || xive_eas_is_masked(eas)) {
+            continue;
+        }
+
+        end_idx =3D GETFIELD_BE64(EAS_END_INDEX, eas->w);
+        end_blk =3D GETFIELD_BE64(EAS_END_BLOCK, eas->w);
+        eisn =3D GETFIELD_BE64(EAS_END_DATA, eas->w);
+
+        spapr_xive_end_to_target(xive, end_blk, end_idx, &server, &prior=
ity);
+
+        kvm_eas =3D priority << KVM_XIVE_EAS_PRIORITY_SHIFT &
+            KVM_XIVE_EAS_PRIORITY_MASK;
+        kvm_eas |=3D server << KVM_XIVE_EAS_SERVER_SHIFT &
+            KVM_XIVE_EAS_SERVER_MASK;
+        kvm_eas |=3D ((uint64_t)eisn << KVM_XIVE_EAS_EISN_SHIFT) &
+            KVM_XIVE_EAS_EISN_MASK;
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EAS, i, &kvm_eas, t=
rue,
+                          &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+}
+
 static void kvmppc_xive_get_eas_state(sPAPRXive *xive, Error **errp)
 {
     XiveSource *xsrc =3D &xive->source;
@@ -432,6 +549,74 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
     }
 }
=20
+int kvmppc_xive_pre_save(sPAPRXive *xive)
+{
+    Error *local_err =3D NULL;
+    CPUState *cs;
+
+    /* Grab the EAT */
+    kvmppc_xive_get_eas_state(xive, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -1;
+    }
+
+    /*
+     * Grab the ENDT. The EQ index and the toggle bit are what we want
+     * to capture.
+     */
+    CPU_FOREACH(cs) {
+        kvmppc_xive_get_eq_state(xive, cs, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+/*
+ * The sPAPRXive 'post_load' method is called by the sPAPR machine
+ * 'post_load' method, when all XIVE states have been transferred and
+ * loaded.
+ */
+int kvmppc_xive_post_load(sPAPRXive *xive, int version_id)
+{
+    Error *local_err =3D NULL;
+    CPUState *cs;
+
+    /* Restore the ENDT first. The targetting depends on it. */
+    CPU_FOREACH(cs) {
+        kvmppc_xive_set_eq_state(xive, cs, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+    }
+
+    /* Restore the EAT */
+    kvmppc_xive_set_eas_state(xive, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -1;
+    }
+
+    /* Restore the thread interrupt contexts */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        kvmppc_xive_cpu_set_state(XIVE_TCTX(cpu->intc), &local_err);
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
 void kvmppc_xive_synchronize_state(sPAPRXive *xive)
 {
     XiveSource *xsrc =3D &xive->source;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 12a931081cfc..cde46b5ca161 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -533,10 +533,27 @@ static void xive_tctx_unrealize(DeviceState *dev, E=
rror **errp)
     qemu_unregister_reset(xive_tctx_reset, dev);
 }
=20
+static int vmstate_xive_tctx_pre_save(void *opaque)
+{
+    Error *local_err =3D NULL;
+
+    if (kvmppc_xive_enabled()) {
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
index 94ee3ec6a9f4..7b401dc1d47c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -326,7 +326,7 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRMa=
chineState *spapr,
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
2.17.2
