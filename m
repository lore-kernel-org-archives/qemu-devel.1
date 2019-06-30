Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C3FC5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0A92089F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0A92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhgnD-0005Gl-Nt
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 16:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35935)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhgiW-0008FZ-Ev
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhgiV-0001wg-9q
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:32 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:32912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhgiU-0001v0-Sz
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:31 -0400
Received: from player157.ha.ovh.net (unknown [10.109.159.20])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id BA2521F985C
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 22:46:28 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 653587575A3A;
 Sun, 30 Jun 2019 20:46:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 30 Jun 2019 22:45:53 +0200
Message-Id: <20190630204601.30574-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630204601.30574-1-clg@kaod.org>
References: <20190630204601.30574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2279947311805008870
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeggdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.57.129
Subject: [Qemu-devel] [PATCH 02/10] ppc/xive: Make the PIPR register readonly
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

When the hypervisor (KVM) dispatches a vCPU on a HW thread, it restores
its thread interrupt context. The Pending Interrupt Priority Register
(PIPR) is computed from the Interrupt Pending Buffer (IPB) and stores
should not be allowed to change its value.

Fixes: 207d9fe98510 ("ppc/xive: introduce the XIVE interrupt thread conte=
xt")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3b1f9520ae9f..534f56f86bd5 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -182,31 +182,31 @@ static uint64_t xive_tm_vt_poll(XiveTCTX *tctx, hwa=
ddr offset, unsigned size)
  */
=20
 static const uint8_t xive_tm_hw_view[] =3D {
-    /* QW-0 User */   3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0,=
 0,
-    /* QW-1 OS   */   3, 3, 3, 3,   3, 3, 0, 3,   3, 3, 3, 3,   0, 0, 0,=
 0,
-    /* QW-2 POOL */   0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0,=
 0,
-    /* QW-3 PHYS */   3, 3, 3, 3,   0, 3, 0, 3,   3, 0, 0, 3,   3, 3, 3,=
 0,
+    3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User *=
/
+    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   *=
/
+    0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL *=
/
+    3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS *=
/
 };
=20
 static const uint8_t xive_tm_hv_view[] =3D {
-    /* QW-0 User */   3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0,=
 0,
-    /* QW-1 OS   */   3, 3, 3, 3,   3, 3, 0, 3,   3, 3, 3, 3,   0, 0, 0,=
 0,
-    /* QW-2 POOL */   0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0,=
 0,
-    /* QW-3 PHYS */   3, 3, 3, 3,   0, 3, 0, 3,   3, 0, 0, 3,   0, 0, 0,=
 0,
+    3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User *=
/
+    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   *=
/
+    0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL *=
/
+    3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS *=
/
 };
=20
 static const uint8_t xive_tm_os_view[] =3D {
-    /* QW-0 User */   3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0,=
 0,
-    /* QW-1 OS   */   2, 3, 2, 2,   2, 2, 0, 2,   0, 0, 0, 0,   0, 0, 0,=
 0,
-    /* QW-2 POOL */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
-    /* QW-3 PHYS */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
+    3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User *=
/
+    2, 3, 2, 2,   2, 2, 0, 2,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-1 OS   *=
/
+    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-2 POOL *=
/
+    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-3 PHYS *=
/
 };
=20
 static const uint8_t xive_tm_user_view[] =3D {
-    /* QW-0 User */   3, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
-    /* QW-1 OS   */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
-    /* QW-2 POOL */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
-    /* QW-3 PHYS */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
+    3, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-0 User *=
/
+    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-1 OS   *=
/
+    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-2 POOL *=
/
+    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-3 PHYS *=
/
 };
=20
 /*
--=20
2.21.0


