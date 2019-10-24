Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF126CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E1F205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jTjMZZr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E1F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYgt-0003Ci-Tq
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKw-0005ek-Ek
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKu-000636-A1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:19:14 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57411 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKt-0005LF-3G; Thu, 24 Oct 2019 04:19:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrc37hxz9sSF; Thu, 24 Oct 2019 19:18:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905120;
 bh=Ka1Ggpk4WXltmaabL+Ppf3sWhfAmXmA7mulQQ7mDOLQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jTjMZZr0CZYEV9ahAF1NGassMIDnFrT3XYqKNB4sIYH+Yd3rTCvKZOSBWghyvk8Mm
 F/sfZ9H56k7bAzL6F4p3Vfd5wPDDcgnEBKNS5zS4pJM5c81sAWRp29V+kE5yhgoQSA
 utCUzOMC+KtKtPZKeoZz5SReLHlnxx7nF6HDUVu0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 26/28] ppc: Reset the interrupt presenter from the CPU reset
 handler
Date: Thu, 24 Oct 2019 19:18:11 +1100
Message-Id: <20191024081813.2115-27-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

On the sPAPR machine and PowerNV machine, the interrupt presenters are
created by a machine handler at the core level and are reset
independently. This is not consistent and it raises issues when it
comes to handle hot-plugged CPUs. In that case, the presenters are not
reset. This is less of an issue in XICS, although a zero MFFR could
be a concern, but in XIVE, the OS CAM line is not set and this breaks
the presenting algorithm. The current code has workarounds which need
a global cleanup.

Extend the sPAPR IRQ backend and the PowerNV Chip class with a new
cpu_intc_reset() handler called by the CPU reset handler and remove
the XiveTCTX reset handler which is now redundant.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191022163812.330-6-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c       |  9 +++++++++
 hw/intc/xics.c             |  8 ++------
 hw/intc/xics_spapr.c       |  7 +++++++
 hw/intc/xive.c             | 12 +-----------
 hw/ppc/pnv.c               | 18 ++++++++++++++++++
 hw/ppc/pnv_core.c          |  7 +++++--
 hw/ppc/spapr_cpu_core.c    |  5 ++++-
 hw/ppc/spapr_irq.c         | 14 ++++++++++++++
 include/hw/ppc/pnv.h       |  1 +
 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xics.h      |  1 +
 include/hw/ppc/xive.h      |  1 +
 12 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index ba32d2cc5b..20a8d8285f 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -553,6 +553,14 @@ static int spapr_xive_cpu_intc_create(SpaprInterrupt=
Controller *intc,
     return 0;
 }
=20
+static void spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
+                                     PowerPCCPU *cpu)
+{
+    XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
+
+    xive_tctx_reset(tctx);
+}
+
 static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, =
int val)
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
@@ -697,6 +705,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     sicc->activate =3D spapr_xive_activate;
     sicc->deactivate =3D spapr_xive_deactivate;
     sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
+    sicc->cpu_intc_reset =3D spapr_xive_cpu_intc_reset;
     sicc->claim_irq =3D spapr_xive_claim_irq;
     sicc->free_irq =3D spapr_xive_free_irq;
     sicc->set_irq =3D spapr_xive_set_irq;
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index b5ac408f7b..6da05763f9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -274,10 +274,8 @@ static const VMStateDescription vmstate_icp_server =3D=
 {
     },
 };
=20
-static void icp_reset_handler(void *dev)
+void icp_reset(ICPState *icp)
 {
-    ICPState *icp =3D ICP(dev);
-
     icp->xirr =3D 0;
     icp->pending_priority =3D 0xff;
     icp->mfrr =3D 0xff;
@@ -288,7 +286,7 @@ static void icp_reset_handler(void *dev)
     if (kvm_irqchip_in_kernel()) {
         Error *local_err =3D NULL;
=20
-        icp_set_kvm_state(ICP(dev), &local_err);
+        icp_set_kvm_state(icp, &local_err);
         if (local_err) {
             error_report_err(local_err);
         }
@@ -351,7 +349,6 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
         }
     }
=20
-    qemu_register_reset(icp_reset_handler, dev);
     vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp)=
;
 }
=20
@@ -360,7 +357,6 @@ static void icp_unrealize(DeviceState *dev, Error **e=
rrp)
     ICPState *icp =3D ICP(dev);
=20
     vmstate_unregister(NULL, &vmstate_icp_server, icp);
-    qemu_unregister_reset(icp_reset_handler, dev);
 }
=20
 static void icp_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 4f64b9a9fc..7418fb9f37 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -346,6 +346,12 @@ static int xics_spapr_cpu_intc_create(SpaprInterrupt=
Controller *intc,
     return 0;
 }
=20
+static void xics_spapr_cpu_intc_reset(SpaprInterruptController *intc,
+                                     PowerPCCPU *cpu)
+{
+    icp_reset(spapr_cpu_state(cpu)->icp);
+}
+
 static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq,
                                 bool lsi, Error **errp)
 {
@@ -433,6 +439,7 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
     sicc->activate =3D xics_spapr_activate;
     sicc->deactivate =3D xics_spapr_deactivate;
     sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
+    sicc->cpu_intc_reset =3D xics_spapr_cpu_intc_reset;
     sicc->claim_irq =3D xics_spapr_claim_irq;
     sicc->free_irq =3D xics_spapr_free_irq;
     sicc->set_irq =3D xics_spapr_set_irq;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d420c6571e..f066be5eb5 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -547,10 +547,8 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon)
     }
 }
=20
-static void xive_tctx_reset(void *dev)
+void xive_tctx_reset(XiveTCTX *tctx)
 {
-    XiveTCTX *tctx =3D XIVE_TCTX(dev);
-
     memset(tctx->regs, 0, sizeof(tctx->regs));
=20
     /* Set some defaults */
@@ -607,13 +605,6 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
             return;
         }
     }
-
-    qemu_register_reset(xive_tctx_reset, dev);
-}
-
-static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
-{
-    qemu_unregister_reset(xive_tctx_reset, dev);
 }
=20
 static int vmstate_xive_tctx_pre_save(void *opaque)
@@ -668,7 +659,6 @@ static void xive_tctx_class_init(ObjectClass *klass, =
void *data)
=20
     dc->desc =3D "XIVE Interrupt Thread Context";
     dc->realize =3D xive_tctx_realize;
-    dc->unrealize =3D xive_tctx_unrealize;
     dc->vmsd =3D &vmstate_xive_tctx;
     /*
      * Reason: part of XIVE interrupt controller, needs to be wired up
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7cf64b6d25..4a51fb65a8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -778,6 +778,13 @@ static void pnv_chip_power8_intc_create(PnvChip *chi=
p, PowerPCCPU *cpu,
     pnv_cpu->intc =3D obj;
 }
=20
+static void pnv_chip_power8_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
+
+    icp_reset(ICP(pnv_cpu->intc));
+}
+
 /*
  *    0:48  Reserved - Read as zeroes
  *   49:52  Node ID
@@ -815,6 +822,13 @@ static void pnv_chip_power9_intc_create(PnvChip *chi=
p, PowerPCCPU *cpu,
     pnv_cpu->intc =3D obj;
 }
=20
+static void pnv_chip_power9_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
+
+    xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -984,6 +998,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->cores_mask =3D POWER8E_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
+    k->intc_reset =3D pnv_chip_power8_intc_reset;
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1003,6 +1018,7 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
+    k->intc_reset =3D pnv_chip_power8_intc_reset;
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1022,6 +1038,7 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
+    k->intc_reset =3D pnv_chip_power8_intc_reset;
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1191,6 +1208,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
     k->cores_mask =3D POWER9_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p9;
     k->intc_create =3D pnv_chip_power9_intc_create;
+    k->intc_reset =3D pnv_chip_power9_intc_reset;
     k->isa_create =3D pnv_chip_power9_isa_create;
     k->dt_populate =3D pnv_chip_power9_dt_populate;
     k->pic_print_info =3D pnv_chip_power9_pic_print_info;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index cc17bbfed8..be0310ac03 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -40,10 +40,11 @@ static const char *pnv_core_cpu_typename(PnvCore *pc)
     return cpu_type;
 }
=20
-static void pnv_core_cpu_reset(PowerPCCPU *cpu)
+static void pnv_core_cpu_reset(PowerPCCPU *cpu, PnvChip *chip)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
=20
     cpu_reset(cs);
=20
@@ -54,6 +55,8 @@ static void pnv_core_cpu_reset(PowerPCCPU *cpu)
     env->gpr[3] =3D PNV_FDT_ADDR;
     env->nip =3D 0x10;
     env->msr |=3D MSR_HVB; /* Hypervisor mode */
+
+    pcc->intc_reset(chip, cpu);
 }
=20
 /*
@@ -200,7 +203,7 @@ static void pnv_core_reset(void *dev)
     int i;
=20
     for (i =3D 0; i < cc->nr_threads; i++) {
-        pnv_core_cpu_reset(pc->threads[i]);
+        pnv_core_cpu_reset(pc->threads[i], pc->chip);
     }
 }
=20
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 2e34832d0e..ef7b27a66d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -32,6 +32,7 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
     target_ulong lpcr;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
     cpu_reset(cs);
=20
@@ -76,9 +77,11 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
     spapr_cpu->dtl_addr =3D 0;
     spapr_cpu->dtl_size =3D 0;
=20
-    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
+    spapr_caps_cpu_apply(spapr, cpu);
=20
     kvm_check_mmu(cpu, &error_fatal);
+
+    spapr_irq_cpu_intc_reset(spapr, cpu);
 }
=20
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 234d1073e5..b941608b69 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -220,6 +220,20 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *spa=
pr,
     return 0;
 }
=20
+void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu)
+{
+    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
+        SpaprInterruptController *intc =3D intcs[i];
+        if (intc) {
+            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
+            sicc->cpu_intc_reset(intc, cpu);
+        }
+    }
+}
+
 static void spapr_set_irq(void *opaque, int irq, int level)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 1cdbe55bf8..2a780e633f 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -111,6 +111,7 @@ typedef struct PnvChipClass {
=20
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
+    void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 5e150a6679..09232999b0 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -52,6 +52,7 @@ typedef struct SpaprInterruptControllerClass {
      */
     int (*cpu_intc_create)(SpaprInterruptController *intc,
                             PowerPCCPU *cpu, Error **errp);
+    void (*cpu_intc_reset)(SpaprInterruptController *intc, PowerPCCPU *c=
pu);
     int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
                      Error **errp);
     void (*free_irq)(SpaprInterruptController *intc, int irq);
@@ -68,6 +69,7 @@ void spapr_irq_update_active_intc(SpaprMachineState *sp=
apr);
=20
 int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
+void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu)=
;
 void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
 void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1e6a9300eb..602173c122 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -161,6 +161,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
 uint32_t icp_accept(ICPState *ss);
 uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
 void icp_eoi(ICPState *icp, uint32_t xirr);
+void icp_reset(ICPState *icp);
=20
 void ics_write_xive(ICSState *ics, int nr, int server,
                     uint8_t priority, uint8_t saved_priority);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index fd3319bd32..99381639f5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -415,6 +415,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr off=
set, unsigned size);
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
+void xive_tctx_reset(XiveTCTX *tctx);
=20
 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
 {
--=20
2.21.0


