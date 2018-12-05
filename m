Received: from eggs.gnu.org ([2001:4830:134:3::10]:44840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYA-0007vs-NY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgY6-0004FK-9f
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:50 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:55537)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgY5-00041i-Pu
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:46 -0500
Received: from player714.ha.ovh.net (unknown [10.109.159.69])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 606A6175D0E
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:25:19 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:39 +0100
Message-Id: <20181205232251.10446-26-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 25/37] spapr/xive: add state synchronization
 with KVM
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

This extends the KVM XIVE device backend with 'synchronize_state'
methods used to retrieve the state from KVM. The HW state of the
sources, the KVM device and the thread interrupt contexts are
collected for the monitor usage and also migration.

These get operations rely on their KVM counterpart in the host kernel
which acts as a proxy for OPAL, the host firmware. The set operations
will be added for migration support later.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |   9 ++
 include/hw/ppc/xive.h       |   1 +
 hw/intc/spapr_xive.c        |  20 ++--
 hw/intc/spapr_xive_kvm.c    | 198 ++++++++++++++++++++++++++++++++++++
 hw/intc/xive.c              |   4 +
 5 files changed, 223 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index ced187ee49e5..bd81bb4d7608 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -45,6 +45,14 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t li=
sn, bool lsi);
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
+bool spapr_xive_priority_is_reserved(uint8_t priority);
+
+void spapr_xive_cpu_to_nvt(sPAPRXive *xive, PowerPCCPU *cpu,
+                           uint8_t *out_nvt_blk, uint32_t *out_nvt_idx);
+void spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU *cpu, uint8_t pri=
o,
+                           uint8_t *out_end_blk, uint32_t *out_end_idx);
+int spapr_xive_target_to_end(sPAPRXive *xive, uint32_t target, uint8_t p=
rio,
+                             uint8_t *out_end_blk, uint32_t *out_end_idx=
);
=20
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
@@ -58,5 +66,6 @@ void spapr_xive_map_mmio(sPAPRXive *xive);
  * KVM XIVE device helpers
  */
 void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
+void kvmppc_xive_synchronize_state(sPAPRXive *xive);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 3684d8e4f6be..7330c11d31c8 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -447,5 +447,6 @@ static inline bool kvmppc_xive_enabled(void)
 void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
+void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx);
=20
 #endif /* PPC_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 256108914001..87f60dd4e453 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -48,8 +48,8 @@ static uint32_t spapr_xive_nvt_to_target(sPAPRXive *xiv=
e, uint8_t nvt_blk,
     return nvt_idx - SPAPR_XIVE_NVT_BASE;
 }
=20
-static void spapr_xive_cpu_to_nvt(sPAPRXive *xive, PowerPCCPU *cpu,
-                                  uint8_t *out_nvt_blk, uint32_t *out_nv=
t_idx)
+void spapr_xive_cpu_to_nvt(sPAPRXive *xive, PowerPCCPU *cpu,
+                           uint8_t *out_nvt_blk, uint32_t *out_nvt_idx)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
=20
@@ -82,9 +82,8 @@ static int spapr_xive_target_to_nvt(sPAPRXive *xive, ui=
nt32_t target,
  * sPAPR END indexing uses a simple mapping of the CPU vcpu_id, 8
  * priorities per CPU
  */
-static void spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU *cpu,
-                                  uint8_t prio, uint8_t *out_end_blk,
-                                  uint32_t *out_end_idx)
+void spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU *cpu, uint8_t pri=
o,
+                           uint8_t *out_end_blk, uint32_t *out_end_idx)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
=20
@@ -100,9 +99,8 @@ static void spapr_xive_cpu_to_end(sPAPRXive *xive, Pow=
erPCCPU *cpu,
     }
 }
=20
-static int spapr_xive_target_to_end(sPAPRXive *xive,
-                                    uint32_t target, uint8_t prio,
-                                    uint8_t *out_end_blk, uint32_t *out_=
end_idx)
+int spapr_xive_target_to_end(sPAPRXive *xive, uint32_t target, uint8_t p=
rio,
+                             uint8_t *out_end_blk, uint32_t *out_end_idx=
)
 {
    PowerPCCPU *cpu =3D spapr_find_cpu(target);
=20
@@ -141,6 +139,10 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Moni=
tor *mon)
     XiveSource *xsrc =3D &xive->source;
     int i;
=20
+    if (kvmppc_xive_enabled()) {
+        kvmppc_xive_synchronize_state(xive);
+    }
+
     monitor_printf(mon, "  LSIN         PQ    EISN     CPU/PRIO EQ\n");
=20
     for (i =3D 0; i < xive->nr_irqs; i++) {
@@ -539,7 +541,7 @@ qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t li=
sn)
  * interrupts (DD2.X POWER9). So we only allow the guest to use
  * priorities [0..6].
  */
-static bool spapr_xive_priority_is_reserved(uint8_t priority)
+bool spapr_xive_priority_is_reserved(uint8_t priority)
 {
     switch (priority) {
     case 0 ... 6:
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 8f773646aa3a..7cdf08ca368c 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -60,6 +60,39 @@ static void kvm_cpu_enable(CPUState *cs)
 /*
  * XIVE Thread Interrupt Management context (KVM)
  */
+static void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
+{
+    uint64_t state[4] =3D { 0 };
+    int ret;
+
+    ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
+    if (ret !=3D 0) {
+        error_setg_errno(errp, errno, "Could capture KVM XIVE CPU %ld st=
ate",
+                         kvm_arch_vcpu_id(tctx->cs));
+        return;
+    }
+
+    /* word0 and word1 of the OS ring. */
+    *((uint64_t *) &tctx->regs[TM_QW1_OS]) =3D state[0];
+
+    /*
+     * KVM also returns word2 containing the OS CAM line which is
+     * interesting to print out in the QEMU monitor.
+     */
+    *((uint64_t *) &tctx->regs[TM_QW1_OS + TM_WORD2]) =3D state[1];
+}
+
+static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
+                                              run_on_cpu_data arg)
+{
+    kvmppc_xive_cpu_get_state(arg.host_ptr, &error_fatal);
+}
+
+void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx)
+{
+    run_on_cpu(tctx->cs, kvmppc_xive_cpu_do_synchronize_state,
+               RUN_ON_CPU_HOST_PTR(tctx));
+}
=20
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 {
@@ -119,6 +152,34 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, Erro=
r **errp)
     }
 }
=20
+/*
+ * This is used to perform the magic loads on the ESB pages, described
+ * in xive.h.
+ */
+static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t offse=
t)
+{
+    unsigned long addr =3D (unsigned long) xsrc->esb_mmap +
+        xive_source_esb_mgmt(xsrc, srcno) + offset;
+
+    /* Prevent the compiler from optimizing away the load */
+    volatile uint64_t value =3D *((uint64_t *) addr);
+
+    return be64_to_cpu(value) & 0x3;
+}
+
+static void kvmppc_xive_source_get_state(XiveSource *xsrc)
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
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
 {
     XiveSource *xsrc =3D opaque;
@@ -149,6 +210,143 @@ void kvmppc_xive_source_set_irq(void *opaque, int s=
rcno, int val)
 /*
  * sPAPR XIVE interrupt controller (KVM)
  */
+static int kvmppc_xive_get_eq_state(sPAPRXive *xive, CPUState *cs,
+                                       Error **errp)
+{
+    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
+    int ret;
+    int i;
+
+    for (i =3D 0; i < XIVE_PRIORITY_MAX + 1; i++) {
+        Error *local_err =3D NULL;
+        struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
+        uint64_t kvm_eq_idx;
+        XiveEND end =3D { 0 };
+        uint8_t end_blk, nvt_blk;
+        uint32_t end_idx, nvt_idx;
+
+        /* Skip priorities reserved for the hypervisor */
+        if (spapr_xive_priority_is_reserved(i)) {
+            continue;
+        }
+
+        /* Encode the tuple (server, prio) as a KVM EQ index */
+        kvm_eq_idx =3D i << KVM_XIVE_EQ_PRIORITY_SHIFT &
+            KVM_XIVE_EQ_PRIORITY_MASK;
+        kvm_eq_idx |=3D vcpu_id << KVM_XIVE_EQ_SERVER_SHIFT &
+            KVM_XIVE_EQ_SERVER_MASK;
+
+        ret =3D kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ, kvm_eq_=
idx,
+                                &kvm_eq, false, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return ret;
+        }
+
+        if (!(kvm_eq.flags & KVM_XIVE_EQ_FLAG_ENABLED)) {
+            continue;
+        }
+
+        /* Update the local END structure with the KVM input */
+        if (kvm_eq.flags & KVM_XIVE_EQ_FLAG_ENABLED) {
+            end.w0 |=3D cpu_to_be32(END_W0_VALID | END_W0_ENQUEUE);
+        }
+        if (kvm_eq.flags & KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY) {
+            end.w0 |=3D cpu_to_be32(END_W0_UCOND_NOTIFY);
+        }
+        if (kvm_eq.flags & KVM_XIVE_EQ_FLAG_ESCALATE) {
+            end.w0 |=3D cpu_to_be32(END_W0_ESCALATE_CTL);
+        }
+        end.w0 |=3D SETFIELD_BE32(END_W0_QSIZE, 0ul, kvm_eq.qsize - 12);
+
+        end.w1 =3D SETFIELD_BE32(END_W1_GENERATION, 0ul, kvm_eq.qtoggle)=
 |
+            SETFIELD_BE32(END_W1_PAGE_OFF, 0ul, kvm_eq.qindex);
+        end.w2 =3D cpu_to_be32((kvm_eq.qpage >> 32) & 0x0fffffff);
+        end.w3 =3D cpu_to_be32(kvm_eq.qpage & 0xffffffff);
+        end.w4 =3D 0;
+        end.w5 =3D 0;
+
+        spapr_xive_cpu_to_nvt(xive, POWERPC_CPU(cs), &nvt_blk, &nvt_idx)=
;
+
+        end.w6 =3D SETFIELD_BE32(END_W6_NVT_BLOCK, 0ul, nvt_blk) |
+            SETFIELD_BE32(END_W6_NVT_INDEX, 0ul, nvt_idx);
+        end.w7 =3D SETFIELD_BE32(END_W7_F0_PRIORITY, 0ul, i);
+
+        spapr_xive_cpu_to_end(xive, POWERPC_CPU(cs), i, &end_blk, &end_i=
dx);
+
+        assert(end_idx < xive->nr_ends);
+        memcpy(&xive->endt[end_idx], &end, sizeof(XiveEND));
+    }
+
+    return 0;
+}
+
+static void kvmppc_xive_get_eas_state(sPAPRXive *xive, Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    int i;
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        XiveEAS *eas =3D &xive->eat[i];
+        XiveEAS new_eas;
+        uint64_t kvm_eas;
+        uint8_t priority;
+        uint32_t server;
+        uint32_t end_idx;
+        uint8_t end_blk;
+        uint32_t eisn;
+        Error *local_err =3D NULL;
+
+        if (!xive_eas_is_valid(eas)) {
+            continue;
+        }
+
+        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EAS, i, &kvm_eas, f=
alse,
+                          &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        priority =3D (kvm_eas & KVM_XIVE_EAS_PRIORITY_MASK) >>
+            KVM_XIVE_EAS_PRIORITY_SHIFT;
+        server =3D (kvm_eas & KVM_XIVE_EAS_SERVER_MASK) >>
+            KVM_XIVE_EAS_SERVER_SHIFT;
+        eisn =3D (kvm_eas & KVM_XIVE_EAS_EISN_MASK) >> KVM_XIVE_EAS_EISN=
_SHIFT;
+
+        if (spapr_xive_target_to_end(xive, server, priority, &end_blk,
+                                     &end_idx)) {
+            error_setg(errp, "XIVE: invalid tuple CPU %d priority %d", s=
erver,
+                       priority);
+            return;
+        }
+
+        new_eas.w =3D cpu_to_be64(EAS_VALID);
+        if (kvm_eas & KVM_XIVE_EAS_MASK_MASK) {
+            new_eas.w |=3D cpu_to_be64(EAS_MASKED);
+        }
+
+        new_eas.w =3D SETFIELD_BE64(EAS_END_INDEX, new_eas.w, end_idx);
+        new_eas.w =3D SETFIELD_BE64(EAS_END_BLOCK, new_eas.w, end_blk);
+        new_eas.w =3D SETFIELD_BE64(EAS_END_DATA, new_eas.w, eisn);
+
+        *eas =3D new_eas;
+    }
+}
+
+void kvmppc_xive_synchronize_state(sPAPRXive *xive)
+{
+    XiveSource *xsrc =3D &xive->source;
+    CPUState *cs;
+
+    kvmppc_xive_source_get_state(xsrc);
+
+    kvmppc_xive_get_eas_state(xive, &error_fatal);
+
+    CPU_FOREACH(cs) {
+        kvmppc_xive_get_eq_state(xive, cs, &error_fatal);
+    }
+}
=20
 static void *kvmppc_xive_mmap(sPAPRXive *xive, int ctrl, size_t len,
                                  Error **errp)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2788f9210144..12a931081cfc 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -427,6 +427,10 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon)
     int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
     int i;
=20
+    if (kvmppc_xive_enabled()) {
+        kvmppc_xive_cpu_synchronize_state(tctx);
+    }
+
     monitor_printf(mon, "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# INC A=
GE PIPR"
                    "  W2\n", cpu_index);
=20
--=20
2.17.2
