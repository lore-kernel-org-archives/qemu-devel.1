Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E909CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35CA205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WbJ4FuHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35CA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYgJ-0000pg-N8
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKY-0004u9-BD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKV-0005GF-Cp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:49 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56399 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKU-00059Q-W3; Thu, 24 Oct 2019 04:18:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrb1QMMz9sRt; Thu, 24 Oct 2019 19:18:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905119;
 bh=0xroAoogH/n6iQTehhcMVK4LTjQRlDojtcSKJlA+WKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WbJ4FuHUJ4l/T5eajcucLh2PDpoY14y8uADQA5E3W8QB4H8lF/GYiYbXCkq8BqvrU
 bL1BMxEbuHFi2Hs5H7Pk7+CON5vyGdjGlORyw6de3c7lzlx3p9259KLL+EY+JuK2K7
 rxvY/qqD+Y2YWid4CPD0zwilKfbwWa2AQLYN6RVU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 18/28] spapr: Remove SpaprIrq::nr_msis
Date: Thu, 24 Oct 2019 19:18:03 +1100
Message-Id: <20191024081813.2115-19-david@gibson.dropbear.id.au>
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The nr_msis value we use here has to line up with whether we're using
legacy or modern irq allocation.  Therefore it's safer to derive it based
on legacy_irq_allocation rather than having SpaprIrq contain a canned
value.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c              |  5 ++---
 hw/ppc/spapr_irq.c          | 26 +++++++++++++++++---------
 hw/ppc/spapr_pci.c          |  7 ++++---
 include/hw/pci-host/spapr.h |  4 ++--
 include/hw/ppc/spapr_irq.h  |  4 +---
 5 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c9623600c2..99867b5e6d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1267,7 +1267,7 @@ static void *spapr_build_fdt(SpaprMachineState *spa=
pr)
     }
=20
     QLIST_FOREACH(phb, &spapr->phbs, list) {
-        ret =3D spapr_dt_phb(phb, PHANDLE_INTC, fdt, spapr->irq->nr_msis=
, NULL);
+        ret =3D spapr_dt_phb(spapr, phb, PHANDLE_INTC, fdt, NULL);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
             exit(1);
@@ -3905,8 +3905,7 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachi=
neState *spapr,
         return -1;
     }
=20
-    if (spapr_dt_phb(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
-                     fdt_start_offset)) {
+    if (spapr_dt_phb(spapr, sphb, intc_phandle, fdt, fdt_start_offset)) =
{
         error_setg(errp, "unable to create FDT node for PHB %d", sphb->i=
ndex);
         return -1;
     }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index f3d18b1dad..be90d36333 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -29,9 +29,14 @@ static const TypeInfo spapr_intc_info =3D {
     .class_size =3D sizeof(SpaprInterruptControllerClass),
 };
=20
-void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis)
+static void spapr_irq_msi_init(SpaprMachineState *spapr)
 {
-    spapr->irq_map_nr =3D nr_msis;
+    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        /* Legacy mode doesn't use this allocator */
+        return;
+    }
+
+    spapr->irq_map_nr =3D spapr_irq_nr_msis(spapr);
     spapr->irq_map =3D bitmap_new(spapr->irq_map_nr);
 }
=20
@@ -102,7 +107,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptContro=
ller *, Error **),
=20
 SpaprIrq spapr_irq_xics =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
-    .nr_msis     =3D SPAPR_NR_MSIS,
     .xics        =3D true,
     .xive        =3D false,
 };
@@ -113,7 +117,6 @@ SpaprIrq spapr_irq_xics =3D {
=20
 SpaprIrq spapr_irq_xive =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
-    .nr_msis     =3D SPAPR_NR_MSIS,
     .xics        =3D false,
     .xive        =3D true,
 };
@@ -132,7 +135,6 @@ SpaprIrq spapr_irq_xive =3D {
  */
 SpaprIrq spapr_irq_dual =3D {
     .nr_xirqs    =3D SPAPR_NR_XIRQS,
-    .nr_msis     =3D SPAPR_NR_MSIS,
     .xics        =3D true,
     .xive        =3D true,
 };
@@ -247,6 +249,15 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t=
 nr_servers,
     sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
 }
=20
+uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
+{
+    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        return spapr->irq->nr_xirqs;
+    } else {
+        return SPAPR_XIRQ_BASE + spapr->irq->nr_xirqs - SPAPR_IRQ_MSI;
+    }
+}
+
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -267,9 +278,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
     }
=20
     /* Initialize the MSI IRQ allocator. */
-    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
-    }
+    spapr_irq_msi_init(spapr);
=20
     if (spapr->irq->xics) {
         Error *local_err =3D NULL;
@@ -551,7 +560,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int num,=
 bool align, Error **errp)
=20
 SpaprIrq spapr_irq_xics_legacy =3D {
     .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
-    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
     .xics        =3D true,
     .xive        =3D false,
 };
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 01ff41d4c4..cc0e7829b6 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2277,8 +2277,8 @@ static void spapr_phb_pci_enumerate(SpaprPhbState *=
phb)
=20
 }
=20
-int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
-                 uint32_t nr_msis, int *node_offset)
+int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
+                 uint32_t intc_phandle, void *fdt, int *node_offset)
 {
     int bus_off, i, j, ret;
     uint32_t bus_range[] =3D { cpu_to_be32(0), cpu_to_be32(0xff) };
@@ -2343,7 +2343,8 @@ int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_=
phandle, void *fdt,
     _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
     _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1=
));
-    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", nr_msis));
+    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
+                          spapr_irq_nr_msis(spapr)));
=20
     /* Dynamic DMA window */
     if (phb->ddw_enabled) {
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 23506f05d9..8877ff51fb 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -128,8 +128,8 @@ struct SpaprPhbState {
 #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * =
\
                                       64 * KiB)
=20
-int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
-                 uint32_t nr_msis, int *node_offset);
+int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
+                 uint32_t intc_phandle, void *fdt, int *node_offset);
=20
 void spapr_pci_rtas_init(void);
=20
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 08173e714c..befe8e01dc 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -27,7 +27,6 @@
 #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
=20
 #define SPAPR_NR_XIRQS       0x1000
-#define SPAPR_NR_MSIS        (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR_I=
RQ_MSI)
=20
 typedef struct SpaprMachineState SpaprMachineState;
=20
@@ -73,14 +72,13 @@ void spapr_irq_print_info(SpaprMachineState *spapr, M=
onitor *mon);
 void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
=20
-void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
+uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr);
 int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool ali=
gn,
                         Error **errp);
 void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)=
;
=20
 typedef struct SpaprIrq {
     uint32_t    nr_xirqs;
-    uint32_t    nr_msis;
     bool        xics;
     bool        xive;
 } SpaprIrq;
--=20
2.21.0


