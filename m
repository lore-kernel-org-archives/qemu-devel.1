Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D54C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B6520748
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6Iu/ZwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B6520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWenn-0002PS-1E
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iWeez-0001S4-N8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iWeex-0004P6-Ls
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iWeex-0004Or-GZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574074410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzS3Az8wk5urPTvK4sepmO4IZ0GOL+RERqiJYhBPr/w=;
 b=i6Iu/ZwUYmJBGgVKtHY9pmsUICpSuF7ERwyQibgAeP4P3DFmmvdZcudxec02fJjdrtegE9
 AXF29B6LOyKAXEfFs7k/clEghRQZ7D73n0p1u87bQCF8BS06HMYQ2VuTy1LWBKaOPhhyYC
 qeZiST0Tpwh4Q40qM+UK5bqU24vhH+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-VoUuKl0yMFWOmhjQCLzxBw-1; Mon, 18 Nov 2019 05:53:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B919FDB20;
 Mon, 18 Nov 2019 10:53:25 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-117-32.ams2.redhat.com [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1DA26090C;
 Mon, 18 Nov 2019 10:53:23 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/6] ppc: Add intc_destroy() handlers to
 SpaprInterruptController/PnvChip
Date: Mon, 18 Nov 2019 11:53:14 +0100
Message-Id: <20191118105319.7658-2-lvivier@redhat.com>
In-Reply-To: <20191118105319.7658-1-lvivier@redhat.com>
References: <20191118105319.7658-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VoUuKl0yMFWOmhjQCLzxBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

SpaprInterruptControllerClass and PnvChipClass have an intc_create() method
that calls the appropriate routine, ie. icp_create() or xive_tctx_create(),
to establish the link between the VCPU and the presenter component of the
interrupt controller during realize.

There aren't any symmetrical call to be called when the VCPU gets unrealize=
d
though. It is assumed that object_unparent() is the only thing to do.

This is questionable because the parenting logic around the CPU and
presenter objects is really an implementation detail of the interrupt
controller. It shouldn't be open-coded in the machine code.

Fix this by adding an intc_destroy() method that undoes what was done in
intc_create(). Also NULLify the presenter pointers to avoid having
stale pointers around. This will allow to reliably check if a vCPU has
a valid presenter.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157192724208.3146912.7254684777515287626.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/intc/spapr_xive.c       | 10 ++++++++++
 hw/intc/xics.c             |  5 +++++
 hw/intc/xics_spapr.c       | 10 ++++++++++
 hw/intc/xive.c             |  5 +++++
 hw/ppc/pnv.c               | 21 +++++++++++++++++++++
 hw/ppc/pnv_core.c          |  7 ++++---
 hw/ppc/spapr_cpu_core.c    |  7 +------
 hw/ppc/spapr_irq.c         | 14 ++++++++++++++
 include/hw/ppc/pnv.h       |  1 +
 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xics.h      |  1 +
 include/hw/ppc/xive.h      |  1 +
 12 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d8e1291905c3..9cb8d38a3bab 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -555,6 +555,15 @@ static void spapr_xive_cpu_intc_reset(SpaprInterruptCo=
ntroller *intc,
     xive_tctx_set_os_cam(tctx, xive_nvt_cam_line(nvt_blk, nvt_idx));
 }
=20
+static void spapr_xive_cpu_intc_destroy(SpaprInterruptController *intc,
+                                        PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
+
+    xive_tctx_destroy(spapr_cpu->tctx);
+    spapr_cpu->tctx =3D NULL;
+}
+
 static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, in=
t val)
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
@@ -692,6 +701,7 @@ static void spapr_xive_class_init(ObjectClass *klass, v=
oid *data)
     sicc->deactivate =3D spapr_xive_deactivate;
     sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
     sicc->cpu_intc_reset =3D spapr_xive_cpu_intc_reset;
+    sicc->cpu_intc_destroy =3D spapr_xive_cpu_intc_destroy;
     sicc->claim_irq =3D spapr_xive_claim_irq;
     sicc->free_irq =3D spapr_xive_free_irq;
     sicc->set_irq =3D spapr_xive_set_irq;
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 6da05763f9db..935f325749cb 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -401,6 +401,11 @@ Object *icp_create(Object *cpu, const char *type, XICS=
Fabric *xi, Error **errp)
     return obj;
 }
=20
+void icp_destroy(ICPState *icp)
+{
+    object_unparent(OBJECT(icp));
+}
+
 /*
  * ICS: Source layer
  */
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 7418fb9f370c..b3705dab0e8a 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -352,6 +352,15 @@ static void xics_spapr_cpu_intc_reset(SpaprInterruptCo=
ntroller *intc,
     icp_reset(spapr_cpu_state(cpu)->icp);
 }
=20
+static void xics_spapr_cpu_intc_destroy(SpaprInterruptController *intc,
+                                        PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
+
+    icp_destroy(spapr_cpu->icp);
+    spapr_cpu->icp =3D NULL;
+}
+
 static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq,
                                 bool lsi, Error **errp)
 {
@@ -440,6 +449,7 @@ static void ics_spapr_class_init(ObjectClass *klass, vo=
id *data)
     sicc->deactivate =3D xics_spapr_deactivate;
     sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
     sicc->cpu_intc_reset =3D xics_spapr_cpu_intc_reset;
+    sicc->cpu_intc_destroy =3D xics_spapr_cpu_intc_destroy;
     sicc->claim_irq =3D xics_spapr_claim_irq;
     sicc->free_irq =3D xics_spapr_free_irq;
     sicc->set_irq =3D xics_spapr_set_irq;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f066be5eb5e3..38257aa02083 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -696,6 +696,11 @@ error:
     return NULL;
 }
=20
+void xive_tctx_destroy(XiveTCTX *tctx)
+{
+    object_unparent(OBJECT(tctx));
+}
+
 /*
  * XIVE ESB helpers
  */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 60632720ef6f..627c08e5b985 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -778,6 +778,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip, =
PowerPCCPU *cpu,
     pnv_cpu->intc =3D obj;
 }
=20
+
 static void pnv_chip_power8_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
 {
     PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
@@ -785,6 +786,14 @@ static void pnv_chip_power8_intc_reset(PnvChip *chip, =
PowerPCCPU *cpu)
     icp_reset(ICP(pnv_cpu->intc));
 }
=20
+static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
+
+    icp_destroy(ICP(pnv_cpu->intc));
+    pnv_cpu->intc =3D NULL;
+}
+
 /*
  *    0:48  Reserved - Read as zeroes
  *   49:52  Node ID
@@ -829,6 +838,14 @@ static void pnv_chip_power9_intc_reset(PnvChip *chip, =
PowerPCCPU *cpu)
     xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
 }
=20
+static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
+{
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
+
+    xive_tctx_destroy(XIVE_TCTX(pnv_cpu->intc));
+    pnv_cpu->intc =3D NULL;
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -999,6 +1016,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *k=
lass, void *data)
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->intc_reset =3D pnv_chip_power8_intc_reset;
+    k->intc_destroy =3D pnv_chip_power8_intc_destroy;
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1019,6 +1037,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->intc_reset =3D pnv_chip_power8_intc_reset;
+    k->intc_destroy =3D pnv_chip_power8_intc_destroy;
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1039,6 +1058,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->intc_create =3D pnv_chip_power8_intc_create;
     k->intc_reset =3D pnv_chip_power8_intc_reset;
+    k->intc_destroy =3D pnv_chip_power8_intc_destroy;
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
@@ -1209,6 +1229,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     k->core_pir =3D pnv_chip_core_pir_p9;
     k->intc_create =3D pnv_chip_power9_intc_create;
     k->intc_reset =3D pnv_chip_power9_intc_reset;
+    k->intc_destroy =3D pnv_chip_power9_intc_destroy;
     k->isa_create =3D pnv_chip_power9_isa_create;
     k->dt_populate =3D pnv_chip_power9_dt_populate;
     k->pic_print_info =3D pnv_chip_power9_pic_print_info;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e81cd3a3e047..61b3d3ce2250 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -269,11 +269,12 @@ err:
     error_propagate(errp, local_err);
 }
=20
-static void pnv_core_cpu_unrealize(PowerPCCPU *cpu)
+static void pnv_core_cpu_unrealize(PowerPCCPU *cpu, PnvChip *chip)
 {
     PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
=20
-    object_unparent(OBJECT(pnv_cpu_state(cpu)->intc));
+    pcc->intc_destroy(chip, cpu);
     cpu_remove_sync(CPU(cpu));
     cpu->machine_data =3D NULL;
     g_free(pnv_cpu);
@@ -289,7 +290,7 @@ static void pnv_core_unrealize(DeviceState *dev, Error =
**errp)
     qemu_unregister_reset(pnv_core_reset, pc);
=20
     for (i =3D 0; i < cc->nr_threads; i++) {
-        pnv_core_cpu_unrealize(pc->threads[i]);
+        pnv_core_cpu_unrealize(pc->threads[i], pc->chip);
     }
     g_free(pc->threads);
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ef7b27a66d56..8339c4c0f86b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -195,12 +195,7 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, Spap=
rCpuCore *sc)
     if (!sc->pre_3_0_migration) {
         vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_da=
ta);
     }
-    if (spapr_cpu_state(cpu)->icp) {
-        object_unparent(OBJECT(spapr_cpu_state(cpu)->icp));
-    }
-    if (spapr_cpu_state(cpu)->tctx) {
-        object_unparent(OBJECT(spapr_cpu_state(cpu)->tctx));
-    }
+    spapr_irq_cpu_intc_destroy(SPAPR_MACHINE(qdev_get_machine()), cpu);
     cpu_remove_sync(CPU(cpu));
     object_unparent(OBJECT(cpu));
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b941608b69ba..168044be853a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -234,6 +234,20 @@ void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr=
, PowerPCCPU *cpu)
     }
 }
=20
+void spapr_irq_cpu_intc_destroy(SpaprMachineState *spapr, PowerPCCPU *cpu)
+{
+    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
+        SpaprInterruptController *intc =3D intcs[i];
+        if (intc) {
+            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(i=
ntc);
+            sicc->cpu_intc_destroy(intc, cpu);
+        }
+    }
+}
+
 static void spapr_set_irq(void *opaque, int irq, int level)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 2a780e633f23..0b4c722e6b48 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -112,6 +112,7 @@ typedef struct PnvChipClass {
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
+    void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 09232999b07e..ff814d13de37 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -53,6 +53,7 @@ typedef struct SpaprInterruptControllerClass {
     int (*cpu_intc_create)(SpaprInterruptController *intc,
                             PowerPCCPU *cpu, Error **errp);
     void (*cpu_intc_reset)(SpaprInterruptController *intc, PowerPCCPU *cpu=
);
+    void (*cpu_intc_destroy)(SpaprInterruptController *intc, PowerPCCPU *c=
pu);
     int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
                      Error **errp);
     void (*free_irq)(SpaprInterruptController *intc, int irq);
@@ -70,6 +71,7 @@ void spapr_irq_update_active_intc(SpaprMachineState *spap=
r);
 int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
 void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu);
+void spapr_irq_cpu_intc_destroy(SpaprMachineState *spapr, PowerPCCPU *cpu)=
;
 void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
 void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 602173c12250..48a75aa4ab75 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -181,6 +181,7 @@ void icp_resend(ICPState *ss);
=20
 Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
                    Error **errp);
+void icp_destroy(ICPState *icp);
=20
 /* KVM */
 void icp_get_kvm_state(ICPState *icp);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 99381639f50c..8fd439ec9bba 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -416,6 +416,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offse=
t, unsigned size);
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
+void xive_tctx_destroy(XiveTCTX *tctx);
=20
 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_idx=
)
 {
--=20
2.23.0


