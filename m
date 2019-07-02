Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF21C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856232146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="huHV2b0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856232146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCsR-0002Qm-Iy
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC07-0006Eu-Ug
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC06-0003gC-Iz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37983 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiC05-0003Rk-Vd; Tue, 02 Jul 2019 02:10:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMp39hWz9sQr; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047750;
 bh=FbysbQgbStZWf/v2s3Sj+D/Di4SHoaN3wcJOzUpaWgg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=huHV2b0kWwMvsJewxFMMzsi6MKpLUU5dqF2/3Z2i81tpofLGC5wUAprD4vP4F8uBh
 LxcoRwGy4AhqAr/pKftkdbmWKZmD0GSECesxNZosrBvBwyowY8z7r1pQD7P31MRGCC
 /eU0ZXxgtME8kWQ4BzknZgX5WC9VwgCQrX8k++YY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:54 +1000
Message-Id: <20190702060857.3926-47-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 46/49] ppc/xive: Make the PIPR register readonly
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When the hypervisor (KVM) dispatches a vCPU on a HW thread, it restores
its thread interrupt context. The Pending Interrupt Priority Register
(PIPR) is computed from the Interrupt Pending Buffer (IPB) and stores
should not be allowed to change its value.

Fixes: 207d9fe98510 ("ppc/xive: introduce the XIVE interrupt thread conte=
xt")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190630204601.30574-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3b1f9520ae..534f56f86b 100644
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


