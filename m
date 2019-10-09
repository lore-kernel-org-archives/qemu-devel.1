Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B309ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13F320B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="othFgXRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13F320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFSf-0004Qw-FY
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59K-0001Yh-2r
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59I-0006dr-1I
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45563 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI59H-0006Zx-IZ; Wed, 09 Oct 2019 02:08:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p3gG28KMz9sRY; Wed,  9 Oct 2019 17:08:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570601306;
 bh=Kuc1pbdxxbDbylKP4SVx8Y6ay10yqb5zujtXnKhy4EE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=othFgXRGFot13/pBUQXCtcSm+rRQyQ7zrI1qI49/R02SekkahWHyt7G6rDESRnnkP
 neZOvozUizj4WoX+NovtCvU23g8L/nn/ykmj5Qu9f97kGTVH8xzldeR20+IJNRhTXT
 2SWBLNkoUljo4JiVyJX5/BatEoUYJKUpliQzr1Xw=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v4 18/19] spapr: Handle irq backend changes with VFIO PCI
 devices
Date: Wed,  9 Oct 2019 17:08:17 +1100
Message-Id: <20191009060818.29719-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, groug@kaod.org,
 Laurent Vivier <laurent@vivier.eu>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pseries machine type can have one of two different interrupt controllers =
in
use depending on feature negotiation with the guest.  Usually this is
invisible to devices, because they route to a common set of qemu_irqs whi=
ch
in turn dispatch to the correct back end.

VFIO passthrough devices, however, wire themselves up directly to the KVM
irqchip for performance, which means they are affected by this change in
interrupt controller.

Luckily, there's a notifier chain that will tell VFIO devices to update
their mappings - we just need to call it whenever the intc backend might
change.

In addition, we make sure we set an active intc earlier, because otherwis=
e
vfio can issue a false warning, because it doesn't think a KVM irqchip is
in use (which is essentially for good INTx performance).

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c     | 6 ++++++
 hw/ppc/spapr_pci.c     | 9 +++++++++
 include/hw/ppc/spapr.h | 1 +
 3 files changed, 16 insertions(+)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 473fc8780a..7964e4a1b8 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -409,6 +409,12 @@ static void set_active_intc(SpaprMachineState *spapr=
,
     }
=20
     spapr->active_intc =3D new_intc;
+
+    /*
+     * We've changed the interrupt routing at the KVM level, let VFIO
+     * devices know they need to readjust.
+     */
+    spapr_pci_fire_intx_routing_notifiers(spapr);
 }
=20
 void spapr_irq_update_active_intc(SpaprMachineState *spapr)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index cc0e7829b6..3bcf6325d4 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -93,6 +93,15 @@ PCIDevice *spapr_pci_find_dev(SpaprMachineState *spapr=
, uint64_t buid,
     return pci_find_device(phb->bus, bus_num, devfn);
 }
=20
+void spapr_pci_fire_intx_routing_notifiers(SpaprMachineState *spapr)
+{
+    SpaprPhbState *sphb;
+
+    QLIST_FOREACH(sphb, &spapr->phbs, list) {
+        pci_bus_fire_intx_routing_notifier(PCI_HOST_BRIDGE(sphb)->bus);
+    }
+}
+
 static uint32_t rtas_pci_cfgaddr(uint32_t arg)
 {
     /* This handles the encoding of extended config space addresses */
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d3b4dd7de3..66b68fdd5e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -805,6 +805,7 @@ void spapr_clear_pending_events(SpaprMachineState *sp=
apr);
 int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
+void spapr_pci_fire_intx_routing_notifiers(SpaprMachineState *spapr);
=20
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
--=20
2.21.0


