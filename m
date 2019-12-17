Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37702C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2ED2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KG9QV8+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2ED2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5IC-00023b-Qc
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jK-0001bf-JV
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jJ-00070S-6l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:06 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37427 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jI-0006Th-SR; Mon, 16 Dec 2019 23:45:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWb257xz9sTQ; Tue, 17 Dec 2019 15:43:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557819;
 bh=oFqXJ1bVqdgNlGJhZqQ6IZxCwNPyaxw8gt/RF4wb3xk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KG9QV8+OXaRx58yZUiHCwDPlhSt0j3Coq65NXD3zYd7aF0NanHpFL9luHSAIeCYRp
 hHsvWkdy+CFew+U24weuFXhcSHvD2nq8yoPppE5yNDYwWhkI1bhWnAg2B7+Zfemnre
 0s2i2w5hMdwE3D0107LGW2o+JHNwMcNpD7ehCZvM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 52/88] spapr: Don't trigger a CAS reboot for XICS/XIVE mode
 changeover
Date: Tue, 17 Dec 2019 15:42:46 +1100
Message-Id: <20191217044322.351838-53-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 Cedric Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PAPR allows the interrupt controller used on a POWER9 machine (XICS or
XIVE) to be selected by the guest operating system, by using the
ibm,client-architecture-support (CAS) feature negotiation call.

Currently, if the guest selects an interrupt controller different from th=
e
one selected at initial boot, this causes the system to be reset with the
new model and the boot starts again.  This means we run through the SLOF
boot process twice, as well as any other bootloader (e.g. grub) in use
before the OS calls CAS.  This can be confusing and/or inconvenient for
users.

Thanks to two fairly recent changes, we no longer need this reboot.  1) w=
e
now completely regenerate the device tree when CAS is called (meaning we
don't need special case updates for all the device tree changes caused by
the interrupt controller mode change),  2) we now have explicit code path=
s
to activate and deactivate the different interrupt controllers, rather th=
an
just implicitly calling those at machine reset time.

We can therefore eliminate the reboot for changing irq mode, simply by
putting a call to spapr_irq_update_active_intc() before we call
spapr_h_cas_compose_response() (which gives the updated device tree to
the guest firmware and OS).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Cedric Le Goater <clg@fr.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_hcall.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 140f05c1c6..05a7ca275b 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1767,21 +1767,10 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
     }
     spapr->cas_pre_isa3_guest =3D !spapr_ovec_test(ov1_guest, OV1_PPC_3_=
00);
     spapr_ovec_cleanup(ov1_guest);
-    if (!spapr->cas_reboot) {
-        /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
-         * (because the guest isn't going to use radix) then set it up h=
ere. */
-        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
-            /* legacy hash or new hash: */
-            spapr_setup_hpt_and_vrma(spapr);
-        }
-        spapr->cas_reboot =3D
-            (spapr_h_cas_compose_response(spapr, args[1], args[2],
-                                          ov5_updates) !=3D 0);
-    }
=20
     /*
-     * Ensure the guest asks for an interrupt mode we support; otherwise
-     * terminate the boot.
+     * Ensure the guest asks for an interrupt mode we support;
+     * otherwise terminate the boot.
      */
     if (guest_xive) {
         if (!spapr->irq->xive) {
@@ -1797,14 +1786,18 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
         }
     }
=20
-    /*
-     * Generate a machine reset when we have an update of the
-     * interrupt mode. Only required when the machine supports both
-     * modes.
-     */
+    spapr_irq_update_active_intc(spapr);
+
     if (!spapr->cas_reboot) {
-        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT)
-            && spapr->irq->xics && spapr->irq->xive;
+        /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
+         * (because the guest isn't going to use radix) then set it up h=
ere. */
+        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
+            /* legacy hash or new hash: */
+            spapr_setup_hpt_and_vrma(spapr);
+        }
+        spapr->cas_reboot =3D
+            (spapr_h_cas_compose_response(spapr, args[1], args[2],
+                                          ov5_updates) !=3D 0);
     }
=20
     spapr_ovec_cleanup(ov5_updates);
--=20
2.23.0


