Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5842071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5842071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ8fq-00010S-9p
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 02:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZ8M9-0003b3-VC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZ8M8-000253-1G
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:00:21 -0500
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:38647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZ8M7-00022n-QG
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:00:19 -0500
Received: from player697.ha.ovh.net (unknown [10.109.143.136])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8DA9414BC51
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 08:00:13 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id B26BDC809797;
 Mon, 25 Nov 2019 07:00:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v6 17/20] ppc/xive: Synthesize interrupt from the saved IPB in
 the NVT
Date: Mon, 25 Nov 2019 07:58:17 +0100
Message-Id: <20191125065820.927-18-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191125065820.927-1-clg@kaod.org>
References: <20191125065820.927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8934297236856736742
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeitddggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.250.45
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

When a vCPU is dispatched on a HW thread, its context is pushed in the
thread registers and it is activated by setting the VO bit in the CAM
line word2. The HW grabs the associated NVT, pulls the IPB bits and
merges them with the IPB of the new context. If interrupts were missed
while the vCPU was not dispatched, these are synthesized in this
sequence.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7047e45daca1..e022bb7afd28 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -393,6 +393,57 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *x=
ptr, XiveTCTX *tctx,
     return qw1w2;
 }
=20
+static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
+                                  uint8_t nvt_blk, uint32_t nvt_idx)
+{
+    XiveNVT nvt;
+    uint8_t ipb;
+
+    /*
+     * Grab the associated NVT to pull the pending bits, and merge
+     * them with the IPB of the thread interrupt context registers
+     */
+    if (xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVT %x/%x\n",
+                          nvt_blk, nvt_idx);
+        return;
+    }
+
+    ipb =3D xive_get_field32(NVT_W4_IPB, nvt.w4);
+
+    if (ipb) {
+        /* Reset the NVT value */
+        nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, 0);
+        xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
+
+        /* Merge in current context */
+        xive_tctx_ipb_update(tctx, TM_QW1_OS, ipb);
+    }
+}
+
+/*
+ * Updating the OS CAM line can trigger a resend of interrupt
+ */
+static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, uint64_t value, unsigned =
size)
+{
+    uint32_t cam =3D value;
+    uint32_t qw1w2 =3D cpu_to_be32(cam);
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    bool vo;
+
+    xive_os_cam_decode(cam, &nvt_blk, &nvt_idx, &vo);
+
+    /* First update the registers */
+    xive_tctx_set_os_cam(tctx, qw1w2);
+
+    /* Check the interrupt pending bits */
+    if (vo) {
+        xive_tctx_need_resend(XIVE_ROUTER(xptr), tctx, nvt_blk, nvt_idx)=
;
+    }
+}
+
 /*
  * Define a mapping of "special" operations depending on the TIMA page
  * offset and the size of the operation.
@@ -414,6 +465,7 @@ static const XiveTmOp xive_tm_operations[] =3D {
      * effects
      */
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NU=
LL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,     4, xive_tm_push_os_ctx,=
 NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr,=
 NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NU=
LL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_po=
ll },
--=20
2.21.0


