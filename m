Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12770C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29EA2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UrEh27Af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29EA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Cg-0001kl-9h
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iW-0000FG-RF
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iU-0005pz-Jt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:16 -0500
Received: from ozlabs.org ([203.11.71.1]:40659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iU-0005o2-89; Mon, 16 Dec 2019 23:44:14 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWW4sDKz9sSr; Tue, 17 Dec 2019 15:43:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557815;
 bh=b95cTm7gCSJ13xwayBFkUd+nNE6sdmf8MwHdEAUorT4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UrEh27AfcyP91DC69Xnk+ezS8ntDS77RZ86wBreiobiwVE6s5G5xOKTZtcnKlV285
 2CpRb8mgrpx7ItWxS+SAvRzdGTsu11jBevUWvAcOuYwG+d1KoD4dO/QbGTYmcJ6cEP
 hOg+fpW8qjtQCREbU9YU6q3qV2oyDb9+E+mT3myI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 36/88] ppc/spapr: Implement the XiveFabric interface
Date: Tue, 17 Dec 2019 15:42:30 +1100
Message-Id: <20191217044322.351838-37-david@gibson.dropbear.id.au>
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

From: C=C3=A9dric Le Goater <clg@kaod.org>

The CAM line matching sequence in the pseries machine does not change
much apart from the use of the new QOM interfaces. There is an extra
indirection because of the sPAPR IRQ backend of the machine. Only the
XIVE backend implements the new 'match_nvt' handler.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-11-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3ae7db1563..d9c9a2bcee 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4275,6 +4275,42 @@ static void spapr_pic_print_info(InterruptStatsPro=
vider *obj,
                    kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
 }
=20
+static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
+                           uint8_t nvt_blk, uint32_t nvt_idx,
+                           bool cam_ignore, uint8_t priority,
+                           uint32_t logic_serv, XiveTCTXMatch *match)
+{
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
+    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
+    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
+    int count;
+
+    /* This is a XIVE only operation */
+    assert(spapr->active_intc =3D=3D SPAPR_INTC(spapr->xive));
+
+    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
+                           priority, logic_serv, match);
+    if (count < 0) {
+        return count;
+    }
+
+    /*
+     * When we implement the save and restore of the thread interrupt
+     * contexts in the enter/exit CPU handlers of the machine and the
+     * escalations in QEMU, we should be able to handle non dispatched
+     * vCPUs.
+     *
+     * Until this is done, the sPAPR machine should find at least one
+     * matching context always.
+     */
+    if (count =3D=3D 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispatche=
d\n",
+                      nvt_blk, nvt_idx);
+    }
+
+    return count;
+}
+
 int spapr_get_vcpu_id(PowerPCCPU *cpu)
 {
     return cpu->vcpu_id;
@@ -4371,6 +4407,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
     XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
     InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
=20
     mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
     mc->ignore_boot_device_suffixes =3D true;
@@ -4447,6 +4484,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->linux_pci_probe =3D true;
     smc->smp_threads_vsmt =3D true;
     smc->nr_xirqs =3D SPAPR_NR_XIRQS;
+    xfc->match_nvt =3D spapr_match_nvt;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -4465,6 +4503,7 @@ static const TypeInfo spapr_machine_info =3D {
         { TYPE_PPC_VIRTUAL_HYPERVISOR },
         { TYPE_XICS_FABRIC },
         { TYPE_INTERRUPT_STATS_PROVIDER },
+        { TYPE_XIVE_FABRIC },
         { }
     },
 };
--=20
2.23.0


