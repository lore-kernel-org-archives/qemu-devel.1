Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09668C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BF821848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BF821848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdu5-0007jF-H1
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcVp-0005OK-MH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcVo-0003wr-J1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:09:01 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:36417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcVo-0003w3-D5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:09:00 -0400
Received: from player799.ha.ovh.net (unknown [10.109.159.222])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id D0EBB24BFBC
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:08:58 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id AAED89F0EADB;
 Wed, 18 Sep 2019 16:08:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:42 +0200
Message-Id: <20190918160645.25126-23-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6240300235906649062
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.51.82
Subject: [Qemu-devel] [PATCH v4 22/25] ppc/xive: Introduce a
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The OS CAM line has a special encoding exploited by the HW. Provide a
helper routine to hide the details to the TIMA command handlers. This
also clarifies the endian ness of different variables : 'qw1w2' is
big-endian and 'cam' is native.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index dfae584a319f..cdc4ea8b0e51 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -342,14 +342,29 @@ static void xive_tm_set_os_pending(XivePresenter *x=
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
+    /* Invalidate CAM line */
+    qw1w2_new =3D xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
+    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
     return qw1w2;
 }
=20
@@ -387,13 +402,15 @@ static void xive_tctx_need_resend(XiveRouter *xrtr,=
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


