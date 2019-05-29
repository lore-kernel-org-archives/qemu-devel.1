Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97380C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F5F20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l6wcILbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F5F20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49047 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVt5E-0002c7-FN
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:33:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQq-0000q4-9l
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQp-000338-7S
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:28 -0400
Received: from ozlabs.org ([203.11.71.1]:54535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQo-0002uC-TI; Wed, 29 May 2019 02:51:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv72gNQz9sPp; Wed, 29 May 2019 16:50:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112627;
	bh=xA2qp10NXjLlhGmnbQPI2mA9u/k6rAV2rVRFrse9Px8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6wcILbFwDDw1uDYiOFFVLVdLWgzvXTa8RoqaG2Nvd+z7DdyOnID/VTJeve9mZGDL
	rzQQSj9AD/niEVPGZFWNYMIusIvov9zXwFpnpsJokxWobkoAsbMgS+qmN9yycjc+Xs
	9dDJYT3k7OLs/NGd6Ak2jks/F7nerHKRz5WUwoFY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:50:14 +1000
Message-Id: <20190529065017.15149-42-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 41/44] spapr: change default interrupt mode to
 'dual'
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Now that XIVE support is complete (QEMU emulated and KVM devices),
change the pseries machine to advertise both interrupt modes: XICS
(P7/P8) and XIVE (P9).

The machine default interrupt modes depends on the version. Current
settings are:

    pseries   default interrupt mode

    4.1       dual
    4.0       xics
    3.1       xics
    3.0       legacy xics (different IRQ number space layout)

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190522074016.10521-3-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 39e698e9b0..4fd16b43f0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4352,7 +4352,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
-    smc->irq =3D &spapr_irq_xics;
+    smc->irq =3D &spapr_irq_dual;
     smc->dr_phb_enabled =3D true;
 }
=20
@@ -4430,6 +4430,7 @@ static void spapr_machine_4_0_class_options(Machine=
Class *mc)
     spapr_machine_4_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len)=
;
     smc->phb_placement =3D phb_placement_4_0;
+    smc->irq =3D &spapr_irq_xics;
 }
=20
 DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
--=20
2.21.0


