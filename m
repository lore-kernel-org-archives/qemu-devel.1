Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C52C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EF22146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NcN0rpFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EF22146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCfp-0007Jv-0m
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzk-0005mR-IX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzi-0003RE-Bx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40791 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBze-0003GZ-Jj; Tue, 02 Jul 2019 02:10:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMm6Kl8z9sQq; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047748;
 bh=Tm555N7dVkHTYYPR8IMk3G+8BdypPkk+dPLL2ehx51Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NcN0rpFvu76s/y14SoYjWploAEdot7+11VY/Cd4YDRP+jAIDsv2LBtQ0Lo3DxI5p1
 g8HKHkDG80RqeWZ8nhApLHlYQudpFLvzrfK0EpzEK080Savw9f9xATiC/dZF03z5et
 FSj7b61Rp0A7GcE04SkmmLUOpUnAzI/V0g7PA0Og=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:52 +1000
Message-Id: <20190702060857.3926-45-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 44/49] spapr/xive: simplify
 spapr_irq_init_device() to remove the emulated init
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

From: C=C3=A9dric Le Goater <clg@kaod.org>

The init_emu() handles are now empty. Remove them and rename
spapr_irq_init_device() to spapr_irq_init_kvm().

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190614165920.12670-3-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 20 +++-----------------
 include/hw/ppc/spapr_irq.h |  1 -
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 02bc5e8c3d..ff3df0bbd8 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -62,7 +62,7 @@ void spapr_irq_msi_reset(SpaprMachineState *spapr)
     bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
 }
=20
-static void spapr_irq_init_device(SpaprMachineState *spapr,
+static void spapr_irq_init_kvm(SpaprMachineState *spapr,
                                   SpaprIrq *irq, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -88,8 +88,6 @@ static void spapr_irq_init_device(SpaprMachineState *sp=
apr,
         error_prepend(&local_err, "kernel_irqchip allowed but unavailabl=
e: ");
         warn_report_err(local_err);
     }
-
-    irq->init_emu(spapr, errp);
 }
=20
 /*
@@ -224,7 +222,7 @@ static void spapr_irq_reset_xics(SpaprMachineState *s=
papr, Error **errp)
 {
     Error *local_err =3D NULL;
=20
-    spapr_irq_init_device(spapr, &spapr_irq_xics, &local_err);
+    spapr_irq_init_kvm(spapr, &spapr_irq_xics, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -236,10 +234,6 @@ static const char *spapr_irq_get_nodename_xics(Spapr=
MachineState *spapr)
     return XICS_NODENAME;
 }
=20
-static void spapr_irq_init_emu_xics(SpaprMachineState *spapr, Error **er=
rp)
-{
-}
-
 static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
@@ -267,7 +261,6 @@ SpaprIrq spapr_irq_xics =3D {
     .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
-    .init_emu    =3D spapr_irq_init_emu_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
=20
@@ -385,7 +378,7 @@ static void spapr_irq_reset_xive(SpaprMachineState *s=
papr, Error **errp)
         spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
     }
=20
-    spapr_irq_init_device(spapr, &spapr_irq_xive, &local_err);
+    spapr_irq_init_kvm(spapr, &spapr_irq_xive, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -411,10 +404,6 @@ static const char *spapr_irq_get_nodename_xive(Spapr=
MachineState *spapr)
     return spapr->xive->nodename;
 }
=20
-static void spapr_irq_init_emu_xive(SpaprMachineState *spapr, Error **er=
rp)
-{
-}
-
 static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
 {
     if (kvm_enabled()) {
@@ -446,7 +435,6 @@ SpaprIrq spapr_irq_xive =3D {
     .reset       =3D spapr_irq_reset_xive,
     .set_irq     =3D spapr_irq_set_irq_xive,
     .get_nodename =3D spapr_irq_get_nodename_xive,
-    .init_emu    =3D spapr_irq_init_emu_xive,
     .init_kvm    =3D spapr_irq_init_kvm_xive,
 };
=20
@@ -624,7 +612,6 @@ SpaprIrq spapr_irq_dual =3D {
     .reset       =3D spapr_irq_reset_dual,
     .set_irq     =3D spapr_irq_set_irq_dual,
     .get_nodename =3D spapr_irq_get_nodename_dual,
-    .init_emu    =3D NULL, /* should not be used */
     .init_kvm    =3D NULL, /* should not be used */
 };
=20
@@ -840,6 +827,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
-    .init_emu    =3D spapr_irq_init_emu_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
 };
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 14cab73c9c..f965a58f89 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -48,7 +48,6 @@ typedef struct SpaprIrq {
     void (*reset)(SpaprMachineState *spapr, Error **errp);
     void (*set_irq)(void *opaque, int srcno, int val);
     const char *(*get_nodename)(SpaprMachineState *spapr);
-    void (*init_emu)(SpaprMachineState *spapr, Error **errp);
     void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
 } SpaprIrq;
=20
--=20
2.21.0


