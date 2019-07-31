Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D66C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E481208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E481208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspUP-0001bW-NY
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hspNO-0002CU-Lm
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hspNM-0002k7-6i
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:14:45 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:57811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hspNJ-0002gS-Gi
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:14:41 -0400
Received: from player715.ha.ovh.net (unknown [10.109.143.201])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id EF3A612C4A6
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:14:36 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id 8646F850BE2D;
 Wed, 31 Jul 2019 14:14:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 31 Jul 2019 16:12:33 +0200
Message-Id: <20190731141233.1340-19-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731141233.1340-1-clg@kaod.org>
References: <20190731141233.1340-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11694722335611194342
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.19
Subject: [Qemu-devel] [PATCH v3 18/18] ppc/xive: Introduce a
 xive_os_cam_decode() helper
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

The OS CAM line has a special encoding exploited by the HW. Provide a
helper routine to hide the details to the TIMA command handlers. This
also clarifies the endianness of different variables : 'qw1w2' is
big-endian and 'cam' is native.

Also add a check on the V bit in the TM_PULL_POOL_CTX special
operation.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index e79439f6b940..bdc36f2a1b0b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -339,14 +339,34 @@ static void xive_tm_set_os_pending(XivePresenter *x=
ptr, XiveTCTX *tctx,
     xive_tctx_ipb_update(tctx, TM_QW1_OS, priority_to_ipb(value & 0xff))=
;
 }
=20
+static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
+                               uint32_t *nvt_idx, bool *vo)
+{
+    *nvt_blk =3D xive_nvt_blk(cam);
+    *nvt_idx =3D xive_nvt_idx(cam);
+    *vo =3D !!(cam & TM_QW1W2_VO);
+}
+
 static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                     hwaddr offset, unsigned size)
 {
-    uint32_t qw1w2_prev =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
-    uint32_t qw1w2;
+    uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
+    uint32_t qw1w2_new;
+    uint32_t cam =3D be32_to_cpu(qw1w2);
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    bool vo;
=20
-    qw1w2 =3D xive_set_field32(TM_QW1W2_VO, qw1w2_prev, 0);
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+    xive_os_cam_decode(cam, &nvt_blk, &nvt_idx, &vo);
+
+    if (!vo) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVT %x/%x =
!?\n",
+                      nvt_blk, nvt_idx);
+    }
+
+    /* Invalidate CAM line */
+    qw1w2_new =3D xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
+    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
     return qw1w2;
 }
=20
@@ -384,13 +404,15 @@ static void xive_tctx_need_resend(XiveRouter *xrtr,=
 XiveTCTX *tctx,
 static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                 hwaddr offset, uint64_t value, unsigned =
size)
 {
-    uint32_t qw1w2 =3D value;
-    uint8_t nvt_blk =3D xive_nvt_blk(qw1w2);
-    uint32_t nvt_idx =3D xive_nvt_idx(qw1w2);
-    bool vo =3D !!(qw1w2 & TM_QW1W2_VO);
+    uint32_t cam =3D value;
+    uint32_t qw1w2 =3D cpu_to_be32(cam);
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    bool vo;
+
+    xive_os_cam_decode(cam, &nvt_blk, &nvt_idx, &vo);
=20
     /* First update the registers */
-    qw1w2 =3D cpu_to_be32(qw1w2);
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
=20
     /* Check the interrupt pending bits */
--=20
2.21.0


