Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B540C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3494620644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YI2O5IDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3494620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxQo1-0006tb-B2
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 03:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hxQmI-0004z1-QY
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hxQmH-0003M7-Cx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:59:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60877)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hxQmG-0003JG-KT; Tue, 13 Aug 2019 02:59:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4673VM6VF1z9sNk; Tue, 13 Aug 2019 16:59:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565679563;
 bh=9y0WaK5rfiuDHqIDJtUaKVJD71EgDPNCe5GIyMLdzw4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YI2O5IDDIXiVlXrwPPwCqPPMZMRHOHUjaCzswojpcIPDJQb9AExkaNkv/0NG6ZZgg
 ahpsH+w8uPqSXbrAB7i65RD/e2r3bEpG5eEeiPfCCUY/9aAWpAJ/O0Ds2cGEnZe4fT
 080WLAzu5vPND77fPLzBhOiJiAzX8wxxCNt7EibI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue, 13 Aug 2019 16:59:19 +1000
Message-Id: <20190813065920.23203-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813065920.23203-1-david@gibson.dropbear.id.au>
References: <20190813065920.23203-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 1/2] spapr: Reset CAS & IRQ subsystem after
 devices
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
Cc: clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes a nasty regression in qemu-4.1 for the 'pseries' machine,
caused by the new "dual" interrupt controller model.  Specifically,
qemu can crash when used with KVM if a 'system_reset' is requested
while there's active I/O in the guest.

The problem is that in spapr_machine_reset() we:

1. Reset the CAS vector state
	spapr_ovec_cleanup(spapr->ov5_cas);

2. Reset all devices
	qemu_devices_reset()

3. Reset the irq subsystem
	spapr_irq_reset();

However (1) implicitly changes the interrupt delivery mode, because
whether we're using XICS or XIVE depends on the CAS state.  We don't
properly initialize the new irq mode until (3) though - in particular
setting up the KVM devices.

During (2), we can temporarily drop the BQL allowing some irqs to be
delivered which will go to an irq system that's not properly set up.

Specifically, if the previous guest was in (KVM) XIVE mode, the CAS
reset will put us back in XICS mode.  kvm_kernel_irqchip() still
returns true, because XIVE was using KVM, however XICs doesn't have
its KVM components intialized and kernel_xics_fd =3D=3D -1.  When the irq
is delivered it goes via ics_kvm_set_irq() which assert()s that
kernel_xics_fd !=3D -1.

This change addresses the problem by delaying the CAS reset until
after the devices reset.  The device reset should quiesce all the
devices so we won't get irqs delivered while we mess around with the
IRQ.  The CAS reset and irq re-initialize should also now be under the
same BQL critical section so nothing else should be able to interrupt
it either.

We also move the spapr_irq_msi_reset() used in one of the legacy irq
modes, since it logically makes sense at the same point as the
spapr_irq_reset() (it's essentially an equivalent operation for older
machine types).  Since we don't need to switch between different
interrupt controllers for those old machine types it shouldn't
actually be broken in those cases though.

Cc: C=C3=A9dric Le Goater <clg@kaod.org>

Fixes: b2e22477 "spapr: add a 'reset' method to the sPAPR IRQ backend"
Fixes: 13db0cd9 "spapr: introduce a new sPAPR IRQ backend supporting
                 XIVE and XICS"
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49..12ed4b065c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1726,6 +1726,18 @@ static void spapr_machine_reset(MachineState *mach=
ine)
         spapr_setup_hpt_and_vrma(spapr);
     }
=20
+    /*
+     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA n=
ode.
+     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() whic=
h is
+     * called from vPHB reset handler so we initialize the counter here.
+     * If no NUMA is configured from the QEMU side, we start from 1 as G=
PU RAM
+     * must be equally distant from any other node.
+     * The final value of spapr->gpu_numa_id is going to be written to
+     * max-associativity-domains in spapr_build_fdt().
+     */
+    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
+    qemu_devices_reset();
+
     /*
      * If this reset wasn't generated by CAS, we should reset our
      * negotiated options and start from scratch
@@ -1741,18 +1753,6 @@ static void spapr_machine_reset(MachineState *mach=
ine)
         spapr_irq_msi_reset(spapr);
     }
=20
-    /*
-     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA n=
ode.
-     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() whic=
h is
-     * called from vPHB reset handler so we initialize the counter here.
-     * If no NUMA is configured from the QEMU side, we start from 1 as G=
PU RAM
-     * must be equally distant from any other node.
-     * The final value of spapr->gpu_numa_id is going to be written to
-     * max-associativity-domains in spapr_build_fdt().
-     */
-    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
-    qemu_devices_reset();
-
     /*
      * This is fixing some of the default configuration of the XIVE
      * devices. To be called after the reset of the machine devices.
--=20
2.21.0


