Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8991EC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 05:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D5020856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 05:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="koGyTqw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D5020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36347 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTJk0-0003Wk-HF
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 01:24:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJ9v-0004HV-L0
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJ9u-0007Fd-1S
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:47:23 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34079 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTJ9t-00074v-Bu; Wed, 22 May 2019 00:47:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4580T2214wz9sPZ; Wed, 22 May 2019 14:46:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558500374;
	bh=wmdwXH0RdfJr/YIFMDSDOI+RE/CbuoxABGgSrIpiv3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koGyTqw5L9M6pqDDmLNdq8irPErglyxcECTAKYyZDiYA/ZTn0sg1JMoa//6IbATUj
	+6t7OESmE+YuTaqcDvEHTg3GOz0IvX3rRl2Q/gosLuVhRRBlJoTQ1DuFyeoo71endC
	saOa2RVB/f9aYTq/KhSVrNM9mfK3TcqTHd7ZPt0Y=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 22 May 2019 14:45:51 +1000
Message-Id: <20190522044600.16534-30-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522044600.16534-1-david@gibson.dropbear.id.au>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 29/38] spapr/xive: add migration support for KVM
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

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
Message-Id: <20190513084245.25755-7-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 24 ++++++++++
 hw/intc/spapr_xive_kvm.c    | 95 ++++++++++++++++++++++++++++++++++++-
 hw/intc/xive.c              | 17 +++++++
 hw/ppc/spapr_irq.c          |  2 +-
 include/hw/ppc/spapr_xive.h |  3 ++
 include/hw/ppc/xive.h       |  1 +
 6 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index e771db5fd0..0aa5d8a55e 100644
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
index 735577a6f8..3999e4b7ed 100644
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
index 7f1c54a7b5..b5ebb33527 100644
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
index 5c4a44855d..8d371523e6 100644
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
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 734662c12a..04294b0ca2 100644
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
index 78c919c4a5..edb8937f17 100644
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
--=20
2.21.0


