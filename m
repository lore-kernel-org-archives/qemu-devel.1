Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BFC4360D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F68820B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hSPkDmka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F68820B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7txd-00060C-P7
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 00:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i7tsU-0000TR-1n
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i7tsP-0002pJ-JH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:05:08 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55205 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i7tsM-0002gc-AJ; Wed, 11 Sep 2019 00:05:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46SpFh1r6jz9sNk; Wed, 11 Sep 2019 14:04:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568174696;
 bh=raU0a+JnIcBoqXKDb0A97AqcM6JTh7CnyZizdQL7HOI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hSPkDmkaJpS5sopLCZALIxirddQxijU+6iAXbPC424i7KX52BR7SKEGqbXWAzgxhB
 7ydajdWwBYUsROz78QM1tAKFbnQjo8xnniNmu9fzL5XlJUAfNtfOF6Z+XCFh0AZiDl
 NUAxEYNIjI694Bb3gQhLZGyhNv8g86o2yjDb6KPU=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Date: Wed, 11 Sep 2019 14:04:52 +1000
Message-Id: <20190911040452.8341-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911040452.8341-1-david@gibson.dropbear.id.au>
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH 7/7] spapr: Perform machine reset in a more
 sensible order
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We've made several changes in the past to the machine reset order to fix
specific problems.  However, we've ended up with an order that doesn't ma=
ke
a lot of logical sense.  This is an attempt to rectify this.

First we reset global CAS options, since that should depend on nothing
else.  Then we reset the CPUs, which shouldn't depend on external devices=
.
Then the irq subsystem, then the bulk of devices (which might rely on
irqs).  Finally we set up the entry state ready for boot, which could
potentially rely on a bunch of other things.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5a919a6cc1..1560a11738 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1724,6 +1724,28 @@ static void spapr_machine_reset(MachineState *mach=
ine)
     void *fdt;
     int rc;
=20
+    /*
+     * If this reset wasn't generated by CAS, we should reset our
+     * negotiated options and start from scratch
+     */
+    if (!spapr->cas_reboot) {
+        spapr_ovec_cleanup(spapr->ov5_cas);
+        spapr->ov5_cas =3D spapr_ovec_new();
+
+        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
+    }
+
+    /*
+     * There is no CAS under qtest. Simulate one to please the code that
+     * depends on spapr->ov5_cas. This is especially needed to test devi=
ce
+     * unplug, so we do that before resetting the DRCs.
+     */
+    if (qtest_enabled()) {
+        spapr_ovec_cleanup(spapr->ov5_cas);
+        spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);
+    }
+
+    /* Reset the CPUs */
     spapr_caps_apply(spapr);
=20
     first_ppc_cpu =3D POWERPC_CPU(first_cpu);
@@ -1741,34 +1763,15 @@ static void spapr_machine_reset(MachineState *mac=
hine)
         spapr_setup_hpt_and_vrma(spapr);
     }
=20
-    qemu_devices_reset();
-
-    /*
-     * If this reset wasn't generated by CAS, we should reset our
-     * negotiated options and start from scratch
-     */
-    if (!spapr->cas_reboot) {
-        spapr_ovec_cleanup(spapr->ov5_cas);
-        spapr->ov5_cas =3D spapr_ovec_new();
-
-        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
-    }
-
+    /* Reset IRQ subsystem */
     /*
      * This is fixing some of the default configuration of the XIVE
      * devices. To be called after the reset of the machine devices.
      */
     spapr_irq_reset(spapr, &error_fatal);
=20
-    /*
-     * There is no CAS under qtest. Simulate one to please the code that
-     * depends on spapr->ov5_cas. This is especially needed to test devi=
ce
-     * unplug, so we do that before resetting the DRCs.
-     */
-    if (qtest_enabled()) {
-        spapr_ovec_cleanup(spapr->ov5_cas);
-        spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);
-    }
+    /* Reset other devices */
+    qemu_devices_reset();
=20
     /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
      * if this device is used by another device (eg, a running vhost bac=
kend
--=20
2.21.0


