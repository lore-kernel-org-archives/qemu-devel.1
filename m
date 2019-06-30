Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CF9C5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E678A2086D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E678A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhgpU-0008Hc-8K
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 16:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhgis-0008RZ-Lg
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhgir-0002DW-Gt
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:54 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:56125)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhgir-00025x-4S
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:53 -0400
Received: from player157.ha.ovh.net (unknown [10.108.54.87])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 912E911EC66
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 22:46:41 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id B226D7575A87;
 Sun, 30 Jun 2019 20:46:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 30 Jun 2019 22:45:55 +0200
Message-Id: <20190630204601.30574-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630204601.30574-1-clg@kaod.org>
References: <20190630204601.30574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2283606489384782822
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeggdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.173.157
Subject: [Qemu-devel] [PATCH 04/10] ppc/xive: Fix TM_PULL_POOL_CTX special
 operation
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
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a CPU is reseted, the hypervisor (Linux or OPAL) invalidates the
POOL interrupt context of a CPU with this special command. It returns
the POOL CAM line value and resets the VP bit.

Fixes: 4836b45510aa ("ppc/xive: activate HV support")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 534f56f86bd5..cf77bdb7d34a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -132,6 +132,11 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8=
_t ring, uint8_t cppr)
     xive_tctx_notify(tctx, ring);
 }
=20
+static inline uint32_t xive_tctx_word2(uint8_t *ring)
+{
+    return *((uint32_t *) &ring[TM_WORD2]);
+}
+
 /*
  * XIVE Thread Interrupt Management Area (TIMA)
  */
@@ -150,11 +155,12 @@ static uint64_t xive_tm_ack_hv_reg(XiveTCTX *tctx, =
hwaddr offset, unsigned size)
 static uint64_t xive_tm_pull_pool_ctx(XiveTCTX *tctx, hwaddr offset,
                                       unsigned size)
 {
-    uint64_t ret;
+    uint32_t qw2w2_prev =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL])=
;
+    uint32_t qw2w2;
=20
-    ret =3D tctx->regs[TM_QW2_HV_POOL + TM_WORD2] & TM_QW2W2_POOL_CAM;
-    tctx->regs[TM_QW2_HV_POOL + TM_WORD2] &=3D ~TM_QW2W2_POOL_CAM;
-    return ret;
+    qw2w2 =3D xive_set_field32(TM_QW2W2_VP, qw2w2_prev, 0);
+    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
+    return qw2w2;
 }
=20
 static void xive_tm_vt_push(XiveTCTX *tctx, hwaddr offset,
@@ -484,11 +490,6 @@ const MemoryRegionOps xive_tm_ops =3D {
     },
 };
=20
-static inline uint32_t xive_tctx_word2(uint8_t *ring)
-{
-    return *((uint32_t *) &ring[TM_WORD2]);
-}
-
 static char *xive_tctx_ring_print(uint8_t *ring)
 {
     uint32_t w2 =3D xive_tctx_word2(ring);
--=20
2.21.0


