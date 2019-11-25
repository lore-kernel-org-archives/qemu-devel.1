Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5962C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFAF2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFAF2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ8Y0-0007un-Uo
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 02:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZ8Kz-0002JT-KK
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZ8Ky-0001Qj-Hp
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:09 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:54080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZ8Ky-0001Pj-Bn
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:08 -0500
Received: from player697.ha.ovh.net (unknown [10.109.146.175])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id DE5CF1B5BFA
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 07:59:06 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 4EDC1C8094A4;
 Mon, 25 Nov 2019 06:59:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v6 06/20] ppc/pnv: Introduce a pnv_xive_is_cpu_enabled() helper
Date: Mon, 25 Nov 2019 07:58:06 +0100
Message-Id: <20191125065820.927-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191125065820.927-1-clg@kaod.org>
References: <20191125065820.927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8915438412849712102
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeitddggeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.63.121
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

and use this helper to exclude CPUs which are not enabled in the XIVE
controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  5 +++++
 hw/intc/pnv_xive.c   | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 03cb429f2131..12b0169a4010 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -99,6 +99,11 @@ typedef struct Pnv9Chip {
     PnvQuad      *quads;
 } Pnv9Chip;
=20
+/*
+ * A SMT8 fused core is a pair of SMT4 cores.
+ */
+#define PNV9_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
+
 typedef struct PnvChipClass {
     /*< private >*/
     SysBusDeviceClass parent_class;
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 9798bd9e729f..ec8349ee4a1f 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -372,6 +372,21 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
     return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
 }
=20
+/*
+ * One bit per thread id. The first register PC_THREAD_EN_REG0 covers
+ * the first cores 0-15 (normal) of the chip or 0-7 (fused). The
+ * second register covers cores 16-23 (normal) or 8-11 (fused).
+ */
+static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
+{
+    int pir =3D ppc_cpu_pir(cpu);
+    uint32_t fc =3D PNV9_PIR2FUSEDCORE(pir);
+    uint64_t reg =3D fc < 8 ? PC_THREAD_EN_REG0 : PC_THREAD_EN_REG1;
+    uint32_t bit =3D pir & 0x3f;
+
+    return xive->regs[reg >> 3] & PPC_BIT(bit);
+}
+
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool cam_ignore, uint8_t priority,
@@ -391,6 +406,10 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, u=
int8_t format,
             XiveTCTX *tctx;
             int ring;
=20
+            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+                continue;
+            }
+
             tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
=20
             /*
--=20
2.21.0


