Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E48C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E152071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E152071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ8bn-0003JI-8w
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 02:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZ8LN-0002p1-Tf
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZ8LM-0001i2-NR
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:33 -0500
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:38379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZ8LM-0001h9-Hh
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:32 -0500
Received: from player697.ha.ovh.net (unknown [10.109.160.244])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2980E25BE33
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 07:59:31 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 96283C809587;
 Mon, 25 Nov 2019 06:59:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v6 10/20] ppc/spapr: Implement the XiveFabric interface
Date: Mon, 25 Nov 2019 07:58:10 +0100
Message-Id: <20191125065820.927-11-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191125065820.927-1-clg@kaod.org>
References: <20191125065820.927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8922475289809095654
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeitddggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedv
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.111.247
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CAM line matching sequence in the pseries machine does not change
much apart from the use of the new QOM interfaces. There is an extra
indirection because of the sPAPR IRQ backend of the machine. Only the
XIVE backend implements the new 'match_nvt' handler.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e076f6023c73..2687bbac37eb 100644
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
2.21.0


