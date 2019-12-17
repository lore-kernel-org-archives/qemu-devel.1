Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BCDC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D72E2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JwQiLSDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D72E2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Co-0001tX-GS
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iy-00011S-FN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iw-0006SM-Se
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:44 -0500
Received: from ozlabs.org ([203.11.71.1]:36259)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iw-0005xo-Gs; Mon, 16 Dec 2019 23:44:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWY231Mz9sT8; Tue, 17 Dec 2019 15:43:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557817;
 bh=nv2sfMu4exbWQFeK7G3IiZ7uOvCpR+2vpj7MWBUe+D4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JwQiLSDKsC3Uy0NpWG33BnYXxdOHij68wkos6zxswhGfd3WgsHlzPYRXsV3AzPN2K
 xNBEJvOrR6eA8nUf+uu7jhw8ddTdSpdtZSeTFKanP1sYMhyN2aN6qoMNwggQmgCfXH
 imgAKoJES6HCTe6TFZnN07Bt0VbTlB71fenOKzwo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 40/88] spapr: Pass the maximum number of vCPUs to the KVM
 interrupt controller
Date: Tue, 17 Dec 2019 15:42:34 +1100
Message-Id: <20191217044322.351838-41-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The XIVE and XICS-on-XIVE KVM devices on POWER9 hosts can greatly reduce
their consumption of some scarce HW resources, namely Virtual Presenter
identifiers, if they know the maximum number of vCPUs that may run in the
VM.

Prepare ground for this by passing the value down to xics_kvm_connect()
and kvmppc_xive_connect(). This is purely mechanical, no functional
change.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157478678301.67101.2717368060417156338.stgit@bahia.tlslab.ib=
m.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        |  6 ++++--
 hw/intc/spapr_xive_kvm.c    |  3 ++-
 hw/intc/xics_kvm.c          |  3 ++-
 hw/intc/xics_spapr.c        |  5 +++--
 hw/ppc/spapr_irq.c          |  8 +++++---
 include/hw/ppc/spapr_irq.h  | 10 ++++++++--
 include/hw/ppc/spapr_xive.h |  3 ++-
 include/hw/ppc/xics_spapr.h |  3 ++-
 8 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index bb3b2dfdb7..18a043a277 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -697,12 +697,14 @@ static void spapr_xive_dt(SpaprInterruptController =
*intc, uint32_t nr_servers,
                      plat_res_int_priorities, sizeof(plat_res_int_priori=
ties)));
 }
=20
-static int spapr_xive_activate(SpaprInterruptController *intc, Error **e=
rrp)
+static int spapr_xive_activate(SpaprInterruptController *intc,
+                               uint32_t nr_servers, Error **errp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
=20
     if (kvm_enabled()) {
-        int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp);
+        int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, nr_serv=
ers,
+                                    errp);
         if (rc < 0) {
             return rc;
         }
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 69e73552f1..46c7609bd8 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -728,7 +728,8 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int pg=
off, size_t len,
  * All the XIVE memory regions are now backed by mappings from the KVM
  * XIVE device.
  */
-int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp)
+int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_serv=
ers,
+                        Error **errp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
     XiveSource *xsrc =3D &xive->source;
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 954c424b36..a1f1b7b0d3 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -342,7 +342,8 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int va=
l)
     }
 }
=20
-int xics_kvm_connect(SpaprInterruptController *intc, Error **errp)
+int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers=
,
+                     Error **errp)
 {
     ICSState *ics =3D ICS_SPAPR(intc);
     int rc;
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index b3705dab0e..8ae4f41459 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -422,10 +422,11 @@ static int xics_spapr_post_load(SpaprInterruptContr=
oller *intc, int version_id)
     return 0;
 }
=20
-static int xics_spapr_activate(SpaprInterruptController *intc, Error **e=
rrp)
+static int xics_spapr_activate(SpaprInterruptController *intc,
+                               uint32_t nr_servers, Error **errp)
 {
     if (kvm_enabled()) {
-        return spapr_irq_init_kvm(xics_kvm_connect, intc, errp);
+        return spapr_irq_init_kvm(xics_kvm_connect, intc, nr_servers, er=
rp);
     }
     return 0;
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d4a54afc86..07e08d6544 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -70,15 +70,16 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int=
 irq, uint32_t num)
     bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
 }
=20
-int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
+int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
                        SpaprInterruptController *intc,
+                       uint32_t nr_servers,
                        Error **errp)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
     Error *local_err =3D NULL;
=20
     if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
-        if (fn(intc, &local_err) < 0) {
+        if (fn(intc, nr_servers, &local_err) < 0) {
             if (machine_kernel_irqchip_required(machine)) {
                 error_prepend(&local_err,
                               "kernel_irqchip requested but unavailable:=
 ");
@@ -481,6 +482,7 @@ static void set_active_intc(SpaprMachineState *spapr,
                             SpaprInterruptController *new_intc)
 {
     SpaprInterruptControllerClass *sicc;
+    uint32_t nr_servers =3D spapr_max_server_number(spapr);
=20
     assert(new_intc);
=20
@@ -498,7 +500,7 @@ static void set_active_intc(SpaprMachineState *spapr,
=20
     sicc =3D SPAPR_INTC_GET_CLASS(new_intc);
     if (sicc->activate) {
-        sicc->activate(new_intc, &error_fatal);
+        sicc->activate(new_intc, nr_servers, &error_fatal);
     }
=20
     spapr->active_intc =3D new_intc;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ff814d13de..ca8cb44213 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -43,7 +43,8 @@ typedef struct SpaprInterruptController SpaprInterruptC=
ontroller;
 typedef struct SpaprInterruptControllerClass {
     InterfaceClass parent;
=20
-    int (*activate)(SpaprInterruptController *intc, Error **errp);
+    int (*activate)(SpaprInterruptController *intc, uint32_t nr_servers,
+                    Error **errp);
     void (*deactivate)(SpaprInterruptController *intc);
=20
     /*
@@ -98,8 +99,13 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)=
;
 int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
 void spapr_irq_reset(SpaprMachineState *spapr, Error **errp);
 int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **e=
rrp);
-int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
+
+typedef int (*SpaprInterruptControllerInitKvm)(SpaprInterruptController =
*,
+                                               uint32_t, Error **);
+
+int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
                        SpaprInterruptController *intc,
+                       uint32_t nr_servers,
                        Error **errp);
=20
 /*
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 742b7e834f..3a103c224d 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -66,7 +66,8 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t =
end_idx,
 /*
  * KVM XIVE device helpers
  */
-int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp);
+int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_serv=
ers,
+                        Error **errp);
 void kvmppc_xive_disconnect(SpaprInterruptController *intc);
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
 void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveE=
AS *eas,
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 28b87038c8..1c65c96e3c 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -32,7 +32,8 @@
 #define TYPE_ICS_SPAPR "ics-spapr"
 #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
=20
-int xics_kvm_connect(SpaprInterruptController *intc, Error **errp);
+int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers=
,
+                     Error **errp);
 void xics_kvm_disconnect(SpaprInterruptController *intc);
 bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
=20
--=20
2.23.0


