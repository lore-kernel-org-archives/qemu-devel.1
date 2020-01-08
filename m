Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A81C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CEC206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eSQkt3Ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CEC206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip48r-00087k-F0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oy-0004T2-OE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ox-0003L1-Hw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:56 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41053 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3ox-0002mS-6D; Wed, 08 Jan 2020 00:23:55 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMF2rBhz9sSc; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578461001;
 bh=DofJhxtpmIKnTqtj9CNLAQXbsiC/mOgeOIPt8kusFHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eSQkt3IhvfEaMU1kMztptQ1qc/ouMllwOmuwNveZRTTqbpZs5SQdYIxaaGGzQMixx
 rKKFPLn67UD54ic0MdWxxYqKkXzbwjt0rPuTDaxkrukK3Xg1S5reVCOFBc3xR60h4G
 7D9gbHsMUYqpCAwOoQia3falgPbWXm5u3PhCTBZA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 12/26] spapr/xive: remove redundant check in spapr_match_nvt()
Date: Wed,  8 Jan 2020 16:22:58 +1100
Message-Id: <20200108052312.238710-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

spapr_match_nvt() is a XIVE operation and is used by the machine to
look for a matching target when an event notification is being
delivered. An assert checks that spapr_match_nvt() is called only when
the machine has selected the XIVE interrupt mode but it is redundant
with the XIVE_PRESENTER() dynamic cast.

Apply the cast to spapr->active_intc and remove the assert.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200106163207.4608-1-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index eb0b84d300..30a5fbd3be 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4195,19 +4195,19 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
                    kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
 }
=20
+/*
+ * This is a XIVE only operation
+ */
 static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
                            bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, XiveTCTXMatch *match)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
-    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
+    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->active_intc);
     XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
     int count;
=20
-    /* This is a XIVE only operation */
-    assert(spapr->active_intc =3D=3D SPAPR_INTC(spapr->xive));
-
     count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
                            priority, logic_serv, match);
     if (count < 0) {
--=20
2.24.1


