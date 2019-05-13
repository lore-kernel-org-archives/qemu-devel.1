Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07076C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D4120989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D4120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6zu-0006zY-1V
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:11:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6oF-0006dg-5j
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6Yd-00046P-L6
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:43:41 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:51950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQ6Yd-00045x-DF
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:43:39 -0400
Received: from player778.ha.ovh.net (unknown [10.108.42.170])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id DD87A193FFE
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:43:36 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player778.ha.ovh.net (Postfix) with ESMTPSA id 19B3759C3E98;
	Mon, 13 May 2019 08:43:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 13 May 2019 10:42:37 +0200
Message-Id: <20190513084245.25755-7-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3330411926312029158
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.165.38
Subject: [Qemu-devel] [PATCH v4 06/14] spapr/xive: add migration support for
 KVM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the VM is stopped, the VM state handler stabilizes the XIVE IC
and marks the EQ pages dirty. These are then transferred to destination
before the transfer of the device vmstates starts.

The SpaprXive interrupt controller model captures the XIVE internal
tables, EAT and ENDT and the XiveTCTX model does the same for the
thread interrupt context registers.

At restart, the SpaprXive 'post_load' method restores all the XIVE
states. It is called by the sPAPR machine 'post_load' method, when all
XIVE states have been transferred and loaded.

Finally, the source states are restored in the VM change state handler
when the machine reaches the running state.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr_xive.h |  3 ++
 include/hw/ppc/xive.h       |  1 +
 hw/intc/spapr_xive.c        | 24 ++++++++++
 hw/intc/spapr_xive_kvm.c    | 95 ++++++++++++++++++++++++++++++++++++-
 hw/intc/xive.c              | 17 +++++++
 hw/ppc/spapr_irq.c          |  2 +-
 6 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 734662c12a10..04294b0ca266 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -55,6 +55,7 @@ typedef struct SpaprXive {
 bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
+int spapr_xive_post_load(SpaprXive *xive, int version_id);
=20
 void spapr_xive_hcall_init(SpaprMachineState *spapr);
 void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
@@ -83,5 +84,7 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, uint=
8_t end_blk,
                                  uint32_t end_idx, XiveEND *end,
                                  Error **errp);
 void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp);
+int kvmppc_xive_pre_save(SpaprXive *xive);
+int kvmppc_xive_post_load(SpaprXive *xive, int version_id);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 78c919c4a590..edb8937f17fb 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -436,5 +436,6 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, Error=
 **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
+void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
=20
 #endif /* PPC_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 84cd30e1faff..d02993f489df 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -472,10 +472,34 @@ static const VMStateDescription vmstate_spapr_xive_=
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
+int spapr_xive_post_load(SpaprXive *xive, int version_id)
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
         VMSTATE_UINT32_EQUAL(nr_irqs, SpaprXive, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, SpaprXive, nr_irqs,
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 735577a6f816..3999e4b7edfb 100644
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
@@ -60,7 +61,24 @@ static void kvm_cpu_enable(CPUState *cs)
 /*
  * XIVE Thread Interrupt Management context (KVM)
  */
-static void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
+
+static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
+{
+    uint64_t state[2];
+    int ret;
+
+    /* word0 and word1 of the OS ring. */
+    state[0] =3D *((uint64_t *) &tctx->regs[TM_QW1_OS]);
+
+    ret =3D kvm_set_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
+    if (ret !=3D 0) {
+        error_setg_errno(errp, errno,
+                         "XIVE: could not restore KVM state of CPU %ld",
+                         kvm_arch_vcpu_id(tctx->cs));
+    }
+}
+
+void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 {
     uint64_t state[2] =3D { 0 };
     int ret;
@@ -534,6 +552,81 @@ void kvmppc_xive_synchronize_state(SpaprXive *xive, =
Error **errp)
     kvmppc_xive_get_queues(xive, errp);
 }
=20
+/*
+ * The SpaprXive 'pre_save' method is called by the vmstate handler of
+ * the SpaprXive model, after the XIVE controller is synced in the VM
+ * change handler.
+ */
+int kvmppc_xive_pre_save(SpaprXive *xive)
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
+ * The SpaprXive 'post_load' method is not called by a vmstate
+ * handler. It is called at the sPAPR machine level at the end of the
+ * migration sequence by the sPAPR IRQ backend 'post_load' method,
+ * when all XIVE states have been transferred and loaded.
+ */
+int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
+{
+    Error *local_err =3D NULL;
+    CPUState *cs;
+    int i;
+
+    /* Restore the ENDT first. The targetting depends on it. */
+    for (i =3D 0; i < xive->nr_ends; i++) {
+        if (!xive_end_is_valid(&xive->endt[i])) {
+            continue;
+        }
+
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
+        if (!xive_eas_is_valid(&xive->eat[i])) {
+            continue;
+        }
+
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
 static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
                               Error **errp)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7f1c54a7b581..b5ebb33527e7 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -582,10 +582,27 @@ static void xive_tctx_unrealize(DeviceState *dev, E=
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
index 5c4a44855d0a..8d371523e66e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -350,7 +350,7 @@ static void spapr_irq_cpu_intc_create_xive(SpaprMachi=
neState *spapr,
=20
 static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int versio=
n_id)
 {
-    return 0;
+    return spapr_xive_post_load(spapr->xive, version_id);
 }
=20
 static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
--=20
2.20.1


