Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78484C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E75A207DD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E75A207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeTY-0004EU-0y
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVePW-00084w-Iq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVePV-0000hl-Be
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:26 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:35504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVePV-0000hS-66
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:25 -0500
Received: from player787.ha.ovh.net (unknown [10.109.159.154])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 70D2B1E6D83
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:25:22 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id DA838C4448DE;
 Fri, 15 Nov 2019 16:25:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH for-5.0 v5 06/23] ppc/xive: Introduce OS CAM line helpers
Date: Fri, 15 Nov 2019 17:24:19 +0100
Message-Id: <20191115162436.30548-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15092125305479400422
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.54.31
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

The OS CAM line has a special encoding exploited by the HW. Provide
helper routines to hide the details to the TIMA command handlers. This
also clarifies the endianness of different variables : 'qw1w2' is
big-endian and 'cam' is native.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 177663d2b43e..42e9a11ef731 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -337,14 +337,49 @@ static void xive_tm_set_os_pending(XiveTCTX *tctx, =
hwaddr offset,
     xive_tctx_notify(tctx, TM_QW1_OS);
 }
=20
+static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
+                               uint32_t *nvt_idx, bool *vo)
+{
+    if (nvt_blk) {
+        *nvt_blk =3D xive_nvt_blk(cam);
+    }
+    if (nvt_idx) {
+        *nvt_idx =3D xive_nvt_idx(cam);
+    }
+    if (vo) {
+        *vo =3D !!(cam & TM_QW1W2_VO);
+    }
+}
+
+static uint32_t xive_tctx_get_os_cam(XiveTCTX *tctx, uint8_t *nvt_blk,
+                                     uint32_t *nvt_idx, bool *vo)
+{
+    uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
+    uint32_t cam =3D be32_to_cpu(qw1w2);
+
+    xive_os_cam_decode(cam, nvt_blk, nvt_idx, vo);
+    return qw1w2;
+}
+
+static void xive_tctx_set_os_cam(XiveTCTX *tctx, uint32_t qw1w2)
+{
+    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+}
+
 static uint64_t xive_tm_pull_os_ctx(XiveTCTX *tctx, hwaddr offset,
                                     unsigned size)
 {
-    uint32_t qw1w2_prev =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
     uint32_t qw1w2;
+    uint32_t qw1w2_new;
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    bool vo;
=20
-    qw1w2 =3D xive_set_field32(TM_QW1W2_VO, qw1w2_prev, 0);
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+    qw1w2 =3D xive_tctx_get_os_cam(tctx, &nvt_blk, &nvt_idx, &vo);
+
+    /* Invalidate CAM line */
+    qw1w2_new =3D xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
+    xive_tctx_set_os_cam(tctx, qw1w2_new);
     return qw1w2;
 }
=20
--=20
2.21.0


