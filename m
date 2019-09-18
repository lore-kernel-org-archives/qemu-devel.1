Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A7C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2EB207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2EB207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdZI-0004Ae-Tq
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcUC-0003BB-8E
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcUB-0002hF-7s
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:20 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:50293)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcUB-0002gC-2O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:19 -0400
Received: from player799.ha.ovh.net (unknown [10.109.143.201])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id C57AF24EF87
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:07:17 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 3CF3E9F0E44F;
 Wed, 18 Sep 2019 16:07:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:24 +0200
Message-Id: <20190918160645.25126-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6211871264849103846
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.132
Subject: [Qemu-devel] [PATCH v4 04/25] ppc/pnv: Introduce a
 pnv_xive_is_cpu_enabled() helper
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

and use this helper to exclude CPUs which were not enabled by the XIVE
controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index e1c15b6b5b71..5c97ccda1cad 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -408,6 +408,14 @@ static int cpu_chip_id(PowerPCCPU *cpu)
     CPU_FOREACH(cs)                                                     =
\
         if (chip->chip_id !=3D cpu_chip_id(POWERPC_CPU(cs))) {} else
=20
+static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
+{
+    int pir =3D cpu_pir(cpu);
+    int thrd_id =3D pir & 0x7f;
+
+    return xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(thrd_id);
+}
+
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool cam_ignore, uint8_t priority,
@@ -426,6 +434,10 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, u=
int8_t format,
         XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
         int ring;
=20
+        if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+            continue;
+        }
+
         /*
          * Check the thread context CAM lines and record matches.
          */
--=20
2.21.0


