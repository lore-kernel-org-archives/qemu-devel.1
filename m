Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A28DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03498205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UosDykEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03498205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYk3-0000M2-Gx
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKY-0004vY-Q8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKV-0005Gi-Gt
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50791 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKU-000597-Re; Thu, 24 Oct 2019 04:18:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrZ2qTLz9sRm; Thu, 24 Oct 2019 19:18:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905118;
 bh=zWVhbYOZmUnJ8e+Ef4VJMXT3ETq6nGVuOZb+Xr8IZzc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UosDykEZ8xLi6r5OKSCZJCuN7xvvp4LL0zQ2KPLkgbCnMRrZCTEYyZKdcukSTaa5b
 9P6aMjXMrzpHVemtZVXkBojKr+Bz4O3C/jR9IM6WkuWtHdCDQ9kt71vMIsK+O+dPlS
 GrtNIb+fiXkTUq3o9KiGP8dXaac3UCw18HFBcKF4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 13/28] spapr, xics,
 xive: Move dt_populate from SpaprIrq to SpaprInterruptController
Date: Thu, 24 Oct 2019 19:17:58 +1100
Message-Id: <20191024081813.2115-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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

This method depends only on the active irq controller.  Now that we've
formalized the notion of active controller we can dispatch directly
through that, rather than dispatching via SpaprIrq with the dual
version having to do a second conditional dispatch.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 125 ++++++++++++++++++------------------
 hw/intc/xics_spapr.c        |   5 +-
 hw/ppc/spapr.c              |   3 +-
 hw/ppc/spapr_irq.c          |  20 +++---
 include/hw/ppc/spapr_irq.h  |   6 +-
 include/hw/ppc/spapr_xive.h |   2 -
 include/hw/ppc/xics_spapr.h |   2 -
 7 files changed, 80 insertions(+), 83 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 700ec5c9c1..37ffb74ca5 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -578,6 +578,68 @@ static void spapr_xive_print_info(SpaprInterruptCont=
roller *intc, Monitor *mon)
     spapr_xive_pic_print_info(xive, mon);
 }
=20
+static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_se=
rvers,
+                          void *fdt, uint32_t phandle)
+{
+    SpaprXive *xive =3D SPAPR_XIVE(intc);
+    int node;
+    uint64_t timas[2 * 2];
+    /* Interrupt number ranges for the IPIs */
+    uint32_t lisn_ranges[] =3D {
+        cpu_to_be32(0),
+        cpu_to_be32(nr_servers),
+    };
+    /*
+     * EQ size - the sizes of pages supported by the system 4K, 64K,
+     * 2M, 16M. We only advertise 64K for the moment.
+     */
+    uint32_t eq_sizes[] =3D {
+        cpu_to_be32(16), /* 64K */
+    };
+    /*
+     * The following array is in sync with the reserved priorities
+     * defined by the 'spapr_xive_priority_is_reserved' routine.
+     */
+    uint32_t plat_res_int_priorities[] =3D {
+        cpu_to_be32(7),    /* start */
+        cpu_to_be32(0xf8), /* count */
+    };
+
+    /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) =
*/
+    timas[0] =3D cpu_to_be64(xive->tm_base +
+                           XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
+    timas[1] =3D cpu_to_be64(1ull << TM_SHIFT);
+    timas[2] =3D cpu_to_be64(xive->tm_base +
+                           XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
+    timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
+
+    _FDT(node =3D fdt_add_subnode(fdt, 0, xive->nodename));
+
+    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
+    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
+
+    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
+    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
+                     sizeof(eq_sizes)));
+    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
+                     sizeof(lisn_ranges)));
+
+    /* For Linux to link the LSIs to the interrupt controller. */
+    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
+    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
+
+    /* For SLOF */
+    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
+    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
+
+    /*
+     * The "ibm,plat-res-int-priorities" property defines the priority
+     * ranges reserved by the hypervisor
+     */
+    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
+                     plat_res_int_priorities, sizeof(plat_res_int_priori=
ties)));
+}
+
 static void spapr_xive_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -601,6 +663,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     sicc->free_irq =3D spapr_xive_free_irq;
     sicc->set_irq =3D spapr_xive_set_irq;
     sicc->print_info =3D spapr_xive_print_info;
+    sicc->dt =3D spapr_xive_dt;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
@@ -1601,65 +1664,3 @@ void spapr_xive_hcall_init(SpaprMachineState *spap=
r)
     spapr_register_hypercall(H_INT_SYNC, h_int_sync);
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
-
-void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
-                   uint32_t phandle)
-{
-    SpaprXive *xive =3D spapr->xive;
-    int node;
-    uint64_t timas[2 * 2];
-    /* Interrupt number ranges for the IPIs */
-    uint32_t lisn_ranges[] =3D {
-        cpu_to_be32(0),
-        cpu_to_be32(nr_servers),
-    };
-    /*
-     * EQ size - the sizes of pages supported by the system 4K, 64K,
-     * 2M, 16M. We only advertise 64K for the moment.
-     */
-    uint32_t eq_sizes[] =3D {
-        cpu_to_be32(16), /* 64K */
-    };
-    /*
-     * The following array is in sync with the reserved priorities
-     * defined by the 'spapr_xive_priority_is_reserved' routine.
-     */
-    uint32_t plat_res_int_priorities[] =3D {
-        cpu_to_be32(7),    /* start */
-        cpu_to_be32(0xf8), /* count */
-    };
-
-    /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) =
*/
-    timas[0] =3D cpu_to_be64(xive->tm_base +
-                           XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
-    timas[1] =3D cpu_to_be64(1ull << TM_SHIFT);
-    timas[2] =3D cpu_to_be64(xive->tm_base +
-                           XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
-    timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
-
-    _FDT(node =3D fdt_add_subnode(fdt, 0, xive->nodename));
-
-    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
-    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
-
-    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
-    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
-                     sizeof(eq_sizes)));
-    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
-                     sizeof(lisn_ranges)));
-
-    /* For Linux to link the LSIs to the interrupt controller. */
-    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
-    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
-
-    /* For SLOF */
-    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
-    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
-
-    /*
-     * The "ibm,plat-res-int-priorities" property defines the priority
-     * ranges reserved by the hypervisor
-     */
-    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
-                     plat_res_int_priorities, sizeof(plat_res_int_priori=
ties)));
-}
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 415defe394..4eabafc7e1 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -308,8 +308,8 @@ static void ics_spapr_realize(DeviceState *dev, Error=
 **errp)
     spapr_register_hypercall(H_IPOLL, h_ipoll);
 }
=20
-void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
-                   uint32_t phandle)
+static void xics_spapr_dt(SpaprInterruptController *intc, uint32_t nr_se=
rvers,
+                          void *fdt, uint32_t phandle)
 {
     uint32_t interrupt_server_ranges_prop[] =3D {
         0, cpu_to_be32(nr_servers),
@@ -408,6 +408,7 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
     sicc->free_irq =3D xics_spapr_free_irq;
     sicc->set_irq =3D xics_spapr_set_irq;
     sicc->print_info =3D xics_spapr_print_info;
+    sicc->dt =3D xics_spapr_dt;
 }
=20
 static const TypeInfo ics_spapr_info =3D {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 24fe12b244..c9623600c2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1247,8 +1247,7 @@ static void *spapr_build_fdt(SpaprMachineState *spa=
pr)
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
-                          PHANDLE_INTC);
+    spapr_irq_dt(spapr, spapr_max_server_number(spapr), fdt, PHANDLE_INT=
C);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a29b527232..a8005072e6 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -134,7 +134,6 @@ SpaprIrq spapr_irq_xics =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
@@ -184,7 +183,6 @@ SpaprIrq spapr_irq_xive =3D {
     .xics        =3D false,
     .xive        =3D true,
=20
-    .dt_populate =3D spapr_dt_xive,
     .post_load   =3D spapr_irq_post_load_xive,
     .reset       =3D spapr_irq_reset_xive,
     .init_kvm    =3D spapr_irq_init_kvm_xive,
@@ -209,13 +207,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState=
 *spapr)
         &spapr_irq_xive : &spapr_irq_xics;
 }
=20
-static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
-                                       uint32_t nr_servers, void *fdt,
-                                       uint32_t phandle)
-{
-    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandl=
e);
-}
-
 static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int versio=
n_id)
 {
     /*
@@ -270,7 +261,6 @@ SpaprIrq spapr_irq_dual =3D {
     .xics        =3D true,
     .xive        =3D true,
=20
-    .dt_populate =3D spapr_irq_dt_populate_dual,
     .post_load   =3D spapr_irq_post_load_dual,
     .reset       =3D spapr_irq_reset_dual,
     .init_kvm    =3D NULL, /* should not be used */
@@ -377,6 +367,15 @@ void spapr_irq_print_info(SpaprMachineState *spapr, =
Monitor *mon)
     sicc->print_info(spapr->active_intc, mon);
 }
=20
+void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
+                  void *fdt, uint32_t phandle)
+{
+    SpaprInterruptControllerClass *sicc
+        =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
+
+    sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
+}
+
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -686,7 +685,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .xics        =3D true,
     .xive        =3D false,
=20
-    .dt_populate =3D spapr_dt_xics,
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index bdfeb3b107..0df95e1b5a 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -60,6 +60,8 @@ typedef struct SpaprInterruptControllerClass {
     /* These methods should only be called on the active intc */
     void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
     void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
+    void (*dt)(SpaprInterruptController *intc, uint32_t nr_servers,
+               void *fdt, uint32_t phandle);
 } SpaprInterruptControllerClass;
=20
 void spapr_irq_update_active_intc(SpaprMachineState *spapr);
@@ -67,6 +69,8 @@ void spapr_irq_update_active_intc(SpaprMachineState *sp=
apr);
 int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
 void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
+void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
+                  void *fdt, uint32_t phandle);
=20
 void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
 int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool ali=
gn,
@@ -79,8 +83,6 @@ typedef struct SpaprIrq {
     bool        xics;
     bool        xive;
=20
-    void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
-                        void *fdt, uint32_t phandle);
     int (*post_load)(SpaprMachineState *spapr, int version_id);
     void (*reset)(SpaprMachineState *spapr, Error **errp);
     void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 8f875673f5..ebe156eb30 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -58,8 +58,6 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Monitor=
 *mon);
 int spapr_xive_post_load(SpaprXive *xive, int version_id);
=20
 void spapr_xive_hcall_init(SpaprMachineState *spapr);
-void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
-                   uint32_t phandle);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
 void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
 void spapr_xive_map_mmio(SpaprXive *xive);
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 0b35e85c26..8e4fb6adce 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -32,8 +32,6 @@
 #define TYPE_ICS_SPAPR "ics-spapr"
 #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
=20
-void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
-                   uint32_t phandle);
 int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
 bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
--=20
2.21.0


