Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBABFC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A361A21019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A361A21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho59g-0001pO-7R
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 08:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59410)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho510-0000VU-9x
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho50y-0002ao-NG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:56:01 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:57616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho50y-0002Y8-Gs
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:56:00 -0400
Received: from player778.ha.ovh.net (unknown [10.108.35.119])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 542B413CE19
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:55:57 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 913B3801F61E;
 Thu, 18 Jul 2019 11:55:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:18 +0200
Message-Id: <20190718115420.19919-16-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6795087416839801830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.52.162
Subject: [Qemu-devel] [PATCH v2 15/17] ppc/pnv: Grab the XiveRouter object
 from XiveTCTX in pnv_xive_get_tctx()
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

It removes a useless call to pnv_xive_get_ic() which is making some
assumption on the chip_id format.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index a48f6750154e..403e8c8ca5b4 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -370,22 +370,13 @@ static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr=
, CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
     XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-    PnvXive *xive =3D NULL;
+    PnvXive *xive =3D PNV_XIVE(tctx->xrtr);
     CPUPPCState *env =3D &cpu->env;
     int pir =3D env->spr_cb[SPR_PIR].default_value;
=20
     /*
      * Perform an extra check on the HW thread enablement.
-     *
-     * The TIMA is shared among the chips and to identify the chip
-     * from which the access is being done, we extract the chip id
-     * from the PIR.
      */
-    xive =3D pnv_xive_get_ic((pir >> 8) & 0xf);
-    if (!xive) {
-        return NULL;
-    }
-
     if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
         xive_error(PNV_XIVE(xrtr), "IC: CPU %x is not enabled", pir);
     }
--=20
2.21.0


