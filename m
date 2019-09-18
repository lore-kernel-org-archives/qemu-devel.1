Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A699CC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC5321848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC5321848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdsS-0006f8-Sp
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcVB-0004Zy-S1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcVA-0003Yv-IV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:21 -0400
Received: from 10.mo7.mail-out.ovh.net ([178.33.250.56]:46025)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcVA-0003YB-Bn
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:20 -0400
Received: from player799.ha.ovh.net (unknown [10.109.160.217])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0FEE71314B0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:08:19 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 9A3599F0E7E4;
 Wed, 18 Sep 2019 16:08:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:35 +0200
Message-Id: <20190918160645.25126-16-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6229322710203075558
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.250.56
Subject: [Qemu-devel] [PATCH v4 15/25] ppc/xive: Synthesize interrupt from
 the saved IPB in the NVT
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

When an interrupt can not be presented to a vCPU, the XIVE presenter
updates the Interrupt Pending Buffer of the XIVE NVT if backlog is
activated in the END.

Later, when the same vCPU is dispatched, its context is pushed in the
thread context registers and the VO bit is set in the CAM line word to
activate the context. The HW grabs the associated NVT to pull the
pending bits, and merges them with the IPB of the TIMA. If interrupts
were missed while the vCPU was not dispatched, these are synthesized
in this sequence.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h |  1 +
 hw/intc/xive.c             | 67 +++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 3d7b6fd09664..dea0318e7e89 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -235,6 +235,7 @@ typedef struct XiveNVT {
         uint32_t        w2;
         uint32_t        w3;
         uint32_t        w4;
+#define NVT_W4_IPB               PPC_BITMASK32(16, 23)
         uint32_t        w5;
         uint32_t        w6;
         uint32_t        w7;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5f7c37b091a7..f47b0cf2b053 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -47,12 +47,6 @@ static uint8_t ipb_to_pipr(uint8_t ibp)
     return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
 }
=20
-static void ipb_update(uint8_t *regs, uint8_t priority)
-{
-    regs[TM_IPB] |=3D priority_to_ipb(priority);
-    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
-}
-
 static uint8_t exception_mask(uint8_t ring)
 {
     switch (ring) {
@@ -359,6 +353,55 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *x=
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
+    uint32_t qw1w2 =3D value;
+    uint8_t nvt_blk =3D xive_nvt_blk(qw1w2);
+    uint32_t nvt_idx =3D xive_nvt_idx(qw1w2);
+    bool vo =3D !!(qw1w2 & TM_QW1W2_VO);
+
+    /* First update the registers */
+    qw1w2 =3D cpu_to_be32(qw1w2);
+    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
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
@@ -380,6 +423,7 @@ static const XiveTmOp xive_tm_operations[] =3D {
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
@@ -1523,14 +1567,21 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
      * - logical server : forward request to IVPE (not supported)
      */
     if (xive_end_is_backlog(&end)) {
+        uint8_t ipb;
+
         if (format =3D=3D 1) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "XIVE: END %x/%x invalid config: F1 & backlog\=
n",
                           end_blk, end_idx);
             return;
         }
-        /* Record the IPB in the associated NVT structure */
-        ipb_update((uint8_t *) &nvt.w4, priority);
+        /*
+         * Record the IPB in the associated NVT structure for later
+         * use. The presenter will resend the interrupt when the vCPU
+         * is dispatched again on a HW thread.
+         */
+        ipb =3D xive_get_field32(NVT_W4_IPB, nvt.w4) | priority_to_ipb(p=
riority);
+        nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, ipb);
         xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
=20
         /*
--=20
2.21.0


