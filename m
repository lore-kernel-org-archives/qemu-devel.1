Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E8DC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3CA20723
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3CA20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVekf-00075V-6t
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVeQj-0001YQ-P5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVeQi-0001I3-Kh
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:26:41 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:43995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVeQi-0001HT-Ec
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:26:40 -0500
Received: from player787.ha.ovh.net (unknown [10.109.146.163])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3E82C14619A
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:26:39 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id CAF1BC444E38;
 Fri, 15 Nov 2019 16:26:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH for-5.0 v5 20/23] ppc/xive: Introduce a xive_tctx_ipb_update()
 helper
Date: Fri, 15 Nov 2019 17:24:33 +0100
Message-Id: <20191115162436.30548-21-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15113798877735193574
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeeg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.76.148
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

We will use it to resend missed interrupts when a vCPU context is
pushed on a HW thread.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  1 +
 hw/intc/xive.c        | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 24315480e7c2..9c0bf2c301e2 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -469,6 +469,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor=
 *mon);
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
+void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
=20
 /*
  * KVM XIVE device helpers
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index e576a1e4ba9c..840ab2a555e1 100644
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
@@ -135,6 +129,15 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8=
_t ring, uint8_t cppr)
     xive_tctx_notify(tctx, ring);
 }
=20
+void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
+{
+    uint8_t *regs =3D &tctx->regs[ring];
+
+    regs[TM_IPB] |=3D ipb;
+    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
+    xive_tctx_notify(tctx, ring);
+}
+
 static inline uint32_t xive_tctx_word2(uint8_t *ring)
 {
     return *((uint32_t *) &ring[TM_WORD2]);
@@ -336,8 +339,7 @@ static void xive_tm_set_os_cppr(XivePresenter *xptr, =
XiveTCTX *tctx,
 static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
                                    hwaddr offset, uint64_t value, unsign=
ed size)
 {
-    ipb_update(&tctx->regs[TM_QW1_OS], value & 0xff);
-    xive_tctx_notify(tctx, TM_QW1_OS);
+    xive_tctx_ipb_update(tctx, TM_QW1_OS, priority_to_ipb(value & 0xff))=
;
 }
=20
 static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
@@ -1429,8 +1431,7 @@ static bool xive_presenter_notify(uint8_t format,
=20
     /* handle CPU exception delivery */
     if (count) {
-        ipb_update(&match.tctx->regs[match.ring], priority);
-        xive_tctx_notify(match.tctx, match.ring);
+        xive_tctx_ipb_update(match.tctx, match.ring, priority_to_ipb(pri=
ority));
     }
=20
     return count;
--=20
2.21.0


