Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004F620656
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TUcPwJBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004F620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUCg-0002iy-HK
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 01:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZU8z-0007Ip-2n
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZTvI-0004P2-Or
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:02:05 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54781 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZTvI-0004NM-DQ; Tue, 26 Nov 2019 01:02:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47MYFd0yGmz9sR7; Tue, 26 Nov 2019 17:01:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574748117;
 bh=SxK6+XV9oC+qJiIgiSf0DCPEib3NB/uxEW2Hla1LRZc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TUcPwJBO+jIcmbBolMyUcx/sFb25lAdjRP48mt9mRMCwQ7m8od/Tg6Kf5o32wsKtp
 ExepQNiUR9SSLTjPAf+uMjAjp1ShKAb2PyJrhA9zqL2mmiMO3borZsJBM/DSQ6StsI
 +/ZL/W5TSX2tlUmoo3qE/GFxVCtUIsCFKBqIJHEk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 5/8] spapr: Handle irq backend changes with VFIO PCI devices
Date: Tue, 26 Nov 2019 17:01:48 +1100
Message-Id: <20191126060151.729845-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126060151.729845-1-david@gibson.dropbear.id.au>
References: <20191126060151.729845-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel@nongnu.org, groug@kaod.org,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
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
interrupt controller.  To get them to adjust correctly for the change in
irqchip, we need to fire the kvm irqchip change notifier.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/ppc/spapr_irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 168044be85..1d27034962 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -508,6 +508,12 @@ static void set_active_intc(SpaprMachineState *spapr=
,
     }
=20
     spapr->active_intc =3D new_intc;
+
+    /*
+     * We've changed the kernel irqchip, let VFIO devices know they
+     * need to readjust.
+     */
+    kvm_irqchip_change_notify();
 }
=20
 void spapr_irq_update_active_intc(SpaprMachineState *spapr)
--=20
2.23.0


