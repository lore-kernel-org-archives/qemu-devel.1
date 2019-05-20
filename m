Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFE7C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF0020657
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="P8BsOlHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF0020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58507 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSbTi-00042q-7Z
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:08:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbR1-0002UJ-4Y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbQz-0006uu-Ib
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:06:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43917 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSbQy-0006sV-I3; Mon, 20 May 2019 02:06:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 456pKt1Rbrz9s9N; Mon, 20 May 2019 16:05:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558332354;
	bh=DRw1tnaS7Zhh+M3o3db/LrmhVnucQH8IfA+GZrw+sSM=;
	h=From:To:Cc:Subject:Date:From;
	b=P8BsOlHu0NLDWQojxW0pmSCOA3OkM6U6aIuBeu4WakdF3ybeja3L6ZOWb/Vsvc9Xy
	80lrOYqhWA4YZBubQbAo0b+nBjgrDRvjdQcYf7MUrlSdiZOjn8tLsWxgsCx9vJaT6r
	j1tcJpt1jiKEdfm4vmWTtpVO/BzGCUJLoXt9g34Y=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	aik@ozlabs.ru,
	lvivier@redhat.com
Date: Mon, 20 May 2019 16:05:50 +1000
Message-Id: <20190520060550.29481-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH] Fix phb_placement backwards compatibility
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
	alex.williamson@redhat.com, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we added support for NVLink2 passthrough devices, we changed the
phb_placement hook to handle the placement of NVLink2 bridges' specific
resources.  For compatibility we use a version that doesn't do this
allocation  for old machine types.

However, because of the delay between when the patch was posted and when
it was merged, we ended up with that compatibility hook applying for
machine versions 3.1 and earlier whereas it should apply for 4.0 and
earlier (since the patch was applied early in the 4.1 tree).

Fixes: ec132efaa81 "spapr: Support NVIDIA V100 GPU with NVLink2"

Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bcae30ad26..39e698e9b0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4411,18 +4411,7 @@ DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
 /*
  * pseries-4.0
  */
-static void spapr_machine_4_0_class_options(MachineClass *mc)
-{
-    spapr_machine_4_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len)=
;
-}
-
-DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
-
-/*
- * pseries-3.1
- */
-static void phb_placement_3_1(SpaprMachineState *spapr, uint32_t index,
+static void phb_placement_4_0(SpaprMachineState *spapr, uint32_t index,
                               uint64_t *buid, hwaddr *pio,
                               hwaddr *mmio32, hwaddr *mmio64,
                               unsigned n_dma, uint32_t *liobns,
@@ -4434,6 +4423,20 @@ static void phb_placement_3_1(SpaprMachineState *s=
papr, uint32_t index,
     *nv2atsd =3D 0;
 }
=20
+static void spapr_machine_4_0_class_options(MachineClass *mc)
+{
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
+    spapr_machine_4_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len)=
;
+    smc->phb_placement =3D phb_placement_4_0;
+}
+
+DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
+
+/*
+ * pseries-3.1
+ */
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
     SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
@@ -4449,7 +4452,6 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
     smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
-    smc->phb_placement =3D phb_placement_3_1;
 }
=20
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
--=20
2.21.0


