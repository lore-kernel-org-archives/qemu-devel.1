Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C338AC433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 06:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924F0214C6
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 06:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gaQA3oOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924F0214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrcvM-0005PL-TV
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 02:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hrcub-0003xI-Ti
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 02:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hrcua-0000xB-Ms
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 02:44:05 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52927 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hrcuZ-0000wC-P5; Sun, 28 Jul 2019 02:44:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45xCvz3XQ4z9sBZ; Sun, 28 Jul 2019 16:43:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564296239;
 bh=atB4xTwVLsInpndsct/mtvdqulF48I7MHFoHS8zHoZg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gaQA3oOP9eBJOH4oPNF6P9V85ta7Ex4P/QyJxuufYRoBQ8nQphcUyUNsfNwNj9drZ
 MwMpA2CAIcHTncVaYbHq+cjWC8ptHJrIsRHLkXRL4S/fHkiswqO7kQCr/6xVstbR0v
 xEkz3Vw/iGMQJHkzuC8ZAESRGow9we2yuHmxRJuc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Sun, 28 Jul 2019 16:43:55 +1000
Message-Id: <20190728064355.2605-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190728064355.2605-1-david@gibson.dropbear.id.au>
References: <20190728064355.2605-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 2/2] xics/kvm: Fix fallback to emulated XICS
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Commit 4812f2615288 tried to fix rollback path of xics_kvm_connect() but
it isn't enough. If we fail to create the KVM device, the guest fails
to boot later on with:

[    0.010817] pci 0000:00:00.0: Adding to iommu group 0
[    0.010863] irq: unknown-1 didn't like hwirq-0x1200 to VIRQ17 mapping =
(rc=3D-22)
[    0.010923] pci 0000:00:01.0: Adding to iommu group 0
[    0.010968] irq: unknown-1 didn't like hwirq-0x1201 to VIRQ17 mapping =
(rc=3D-22)
[    0.011543] EEH: No capable adapters found
[    0.011597] irq: unknown-1 didn't like hwirq-0x1000 to VIRQ17 mapping =
(rc=3D-22)
[    0.011651] audit: type=3D2000 audit(1563977526.000:1): state=3Dinitia=
lized audit_enabled=3D0 res=3D1
[    0.011703] ------------[ cut here ]------------
[    0.011729] event-sources: Unable to allocate interrupt number for /ev=
ent-sources/epow-events
[    0.011776] WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/pseries/e=
vent_sources.c:34 request_event_sources_irqs+0xbc/0x150
[    0.011828] Modules linked in:
[    0.011850] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.17-300.fc30.=
ppc64le #1
[    0.011886] NIP:  c0000000000d4fac LR: c0000000000d4fa8 CTR: c00000000=
18f0000
[    0.011923] REGS: c00000001e4c38d0 TRAP: 0700   Not tainted  (5.1.17-3=
00.fc30.ppc64le)
[    0.011966] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 280=
00284  XER: 20040000
[    0.012012] CFAR: c00000000011b42c IRQMASK: 0
[    0.012012] GPR00: c0000000000d4fa8 c00000001e4c3b60 c0000000015fc400 =
0000000000000051
[    0.012012] GPR04: 0000000000000001 0000000000000000 0000000000000081 =
772d6576656e7473
[    0.012012] GPR08: 000000001edf0000 c0000000014d4830 c0000000014d4830 =
6e6576652f20726f
[    0.012012] GPR12: 0000000000000000 c0000000018f0000 c000000000010bf0 =
0000000000000000
[    0.012012] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
[    0.012012] GPR20: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
[    0.012012] GPR24: 0000000000000000 0000000000000000 c000000000ebbf00 =
c0000000000d5570
[    0.012012] GPR28: c000000000ebc008 c00000001fff8248 0000000000000000 =
0000000000000000
[    0.012372] NIP [c0000000000d4fac] request_event_sources_irqs+0xbc/0x1=
50
[    0.012409] LR [c0000000000d4fa8] request_event_sources_irqs+0xb8/0x15=
0
[    0.012445] Call Trace:
[    0.012462] [c00000001e4c3b60] [c0000000000d4fa8] request_event_source=
s_irqs+0xb8/0x150 (unreliable)
[    0.012513] [c00000001e4c3bf0] [c000000001042848] __machine_initcall_p=
series_init_ras_IRQ+0xc8/0xf8
[    0.012563] [c00000001e4c3c20] [c000000000010810] do_one_initcall+0x60=
/0x254
[    0.012611] [c00000001e4c3cf0] [c000000001024538] kernel_init_freeable=
+0x35c/0x444
[    0.012655] [c00000001e4c3db0] [c000000000010c14] kernel_init+0x2c/0x1=
48
[    0.012693] [c00000001e4c3e20] [c00000000000bdc4] ret_from_kernel_thre=
ad+0x5c/0x78
[    0.012736] Instruction dump:
[    0.012759] 38a00000 7c7f1b78 7f64db78 2c1f0000 2fbf0000 78630020 4180=
002c 409effa8
[    0.012805] 7fa4eb78 7f43d378 48046421 60000000 <0fe00000> 3bde0001 2c=
1e0010 7fde07b4
[    0.012851] ---[ end trace aa5785707323fad3 ]---

This happens because QEMU fell back on XICS emulation but didn't unregist=
er
the RTAS calls from KVM. The emulated RTAS calls are hence never called a=
nd
the KVM ones return an error to the guest since the KVM device is absent.

The sanity checks in xics_kvm_disconnect() are abusive since we're freein=
g
the KVM device. Simply drop them.

Fixes: 4812f2615288 "xics/kvm: Add proper rollback to xics_kvm_init()"
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156398744035.546975.7029414194633598474.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 2df1f3e92c..65c35f90f9 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -430,17 +430,6 @@ fail:
=20
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
 {
-    /* The KVM XICS device is not in use */
-    if (kernel_xics_fd =3D=3D -1) {
-        return;
-    }
-
-    if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
-        error_setg(errp,
-                   "KVM and IRQ_XICS capability must be present for KVM =
XICS device");
-        return;
-    }
-
     /*
      * Only on P9 using the XICS-on XIVE KVM device:
      *
--=20
2.21.0


