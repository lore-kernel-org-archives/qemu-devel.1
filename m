Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3710C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6B221479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B0/GHdap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6B221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCXp-00022n-Ng
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58464)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByl-00051Z-NB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByk-0002wM-82
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:23 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33785 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByj-0002tX-HP; Tue, 02 Jul 2019 02:09:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMk0svbz9sPY; Tue,  2 Jul 2019 16:09:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047746;
 bh=2nJOrSX7TAIqpWh5QCL4SMs7wiJ5bhkcxATACsAlos0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B0/GHdapugIt/h87WkS/wnlPj/mdip7fOlIsTtLUoxDYmoNf76AcAzdKE1/BmS81g
 KHeFO6CiyHvcN3Nfs3yF0dNRYbDRo0+2x+qu/vcn3eVfB2FXuFt4Vjs6nhDe8h5FkR
 iHkgVu/FZfdE9DhyvI6G7u5HdcRrcPaNVqwydq8E=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:33 +1000
Message-Id: <20190702060857.3926-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 25/49] xics/kvm: Add error propagation to
 ic*_set_kvm_state() functions
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

This allows errors happening there to be propagated up to spapr_irq,
just like XIVE already does.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156077921763.433243.4614327010172954196.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 39 ++++++++++++++++++++++++++++++++++-----
 hw/intc/xics_kvm.c    | 37 ++++++++++++++++++++++---------------
 include/hw/ppc/xics.h |  6 +++---
 3 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 978d7f0886..faa976e2f8 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -267,7 +267,14 @@ static int icp_post_load(void *opaque, int version_i=
d)
     ICPState *icp =3D opaque;
=20
     if (kvm_irqchip_in_kernel()) {
-        return icp_set_kvm_state(icp);
+        Error *local_err =3D NULL;
+        int ret;
+
+        ret =3D icp_set_kvm_state(icp, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            return ret;
+        }
     }
=20
     return 0;
@@ -300,7 +307,12 @@ static void icp_reset_handler(void *dev)
     qemu_set_irq(icp->output, 0);
=20
     if (kvm_irqchip_in_kernel()) {
-        icp_set_kvm_state(ICP(dev));
+        Error *local_err =3D NULL;
+
+        icp_set_kvm_state(ICP(dev), &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
=20
@@ -564,7 +576,12 @@ static void ics_simple_reset(DeviceState *dev)
     icsc->parent_reset(dev);
=20
     if (kvm_irqchip_in_kernel()) {
-        ics_set_kvm_state(ICS_BASE(dev));
+        Error *local_err =3D NULL;
+
+        ics_set_kvm_state(ICS_BASE(dev), &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
=20
@@ -680,7 +697,14 @@ static int ics_base_post_load(void *opaque, int vers=
ion_id)
     ICSState *ics =3D opaque;
=20
     if (kvm_irqchip_in_kernel()) {
-        return ics_set_kvm_state(ics);
+        Error *local_err =3D NULL;
+        int ret;
+
+        ret =3D ics_set_kvm_state(ics, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            return ret;
+        }
     }
=20
     return 0;
@@ -766,8 +790,13 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool=
 lsi)
         lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
=20
     if (kvm_irqchip_in_kernel()) {
+        Error *local_err =3D NULL;
+
         ics_reset_irq(ics->irqs + srcno);
-        ics_set_kvm_state_one(ics, srcno);
+        ics_set_kvm_state_one(ics, srcno, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
=20
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index c9e25fb051..4bfbe1a840 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -106,7 +106,7 @@ void icp_synchronize_state(ICPState *icp)
     }
 }
=20
-int icp_set_kvm_state(ICPState *icp)
+int icp_set_kvm_state(ICPState *icp, Error **errp)
 {
     uint64_t state;
     int ret;
@@ -126,10 +126,11 @@ int icp_set_kvm_state(ICPState *icp)
         | ((uint64_t)icp->pending_priority << KVM_REG_PPC_ICP_PPRI_SHIFT=
);
=20
     ret =3D kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
-    if (ret !=3D 0) {
-        error_report("Unable to restore KVM interrupt controller state (=
0x%"
-                PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(icp-=
>cs),
-                strerror(errno));
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Unable to restore KVM interrupt controller sta=
te (0x%"
+                         PRIx64 ") for CPU %ld", state,
+                         kvm_arch_vcpu_id(icp->cs));
         return ret;
     }
=20
@@ -240,10 +241,9 @@ void ics_synchronize_state(ICSState *ics)
     ics_get_kvm_state(ics);
 }
=20
-int ics_set_kvm_state_one(ICSState *ics, int srcno)
+int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp)
 {
     uint64_t state;
-    Error *local_err =3D NULL;
     ICSIRQState *irq =3D &ics->irqs[srcno];
     int ret;
=20
@@ -278,16 +278,15 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno)
     }
=20
     ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
-                            srcno + ics->offset, &state, true, &local_er=
r);
-    if (local_err) {
-        error_report_err(local_err);
+                            srcno + ics->offset, &state, true, errp);
+    if (ret < 0) {
         return ret;
     }
=20
     return 0;
 }
=20
-int ics_set_kvm_state(ICSState *ics)
+int ics_set_kvm_state(ICSState *ics, Error **errp)
 {
     int i;
=20
@@ -297,10 +296,12 @@ int ics_set_kvm_state(ICSState *ics)
     }
=20
     for (i =3D 0; i < ics->nr_irqs; i++) {
+        Error *local_err =3D NULL;
         int ret;
=20
-        ret =3D ics_set_kvm_state_one(ics, i);
-        if (ret) {
+        ret =3D ics_set_kvm_state_one(ics, i, &local_err);
+        if (ret < 0) {
+            error_propagate(errp, local_err);
             return ret;
         }
     }
@@ -402,12 +403,18 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
     }
=20
     /* Update the KVM sources */
-    ics_set_kvm_state(spapr->ics);
+    ics_set_kvm_state(spapr->ics, &local_err);
+    if (local_err) {
+        goto fail;
+    }
=20
     /* Connect the presenters to the initial VCPUs of the machine */
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-        icp_set_kvm_state(spapr_cpu_state(cpu)->icp);
+        icp_set_kvm_state(spapr_cpu_state(cpu)->icp, &local_err);
+        if (local_err) {
+            goto fail;
+        }
     }
=20
     return 0;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index eb65ad7e43..1eb7b5cd68 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -190,13 +190,13 @@ Object *icp_create(Object *cpu, const char *type, X=
ICSFabric *xi,
=20
 /* KVM */
 void icp_get_kvm_state(ICPState *icp);
-int icp_set_kvm_state(ICPState *icp);
+int icp_set_kvm_state(ICPState *icp, Error **errp);
 void icp_synchronize_state(ICPState *icp);
 void icp_kvm_realize(DeviceState *dev, Error **errp);
=20
 void ics_get_kvm_state(ICSState *ics);
-int ics_set_kvm_state_one(ICSState *ics, int srcno);
-int ics_set_kvm_state(ICSState *ics);
+int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp);
+int ics_set_kvm_state(ICSState *ics, Error **errp);
 void ics_synchronize_state(ICSState *ics);
 void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
=20
--=20
2.21.0


