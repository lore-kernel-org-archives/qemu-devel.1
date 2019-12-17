Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BCFC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A541B2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GLrd+IAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A541B2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5AD-0006IR-Cz
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iT-0000BR-Uj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iS-0005oo-S7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:13 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45237 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iS-0005Pr-I7; Mon, 16 Dec 2019 23:44:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWS1cnDz9sSm; Tue, 17 Dec 2019 15:43:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557812;
 bh=pepwT/pUYDx/GUmEQo/uunQvZUzzeXQhKHZYA4EiAUU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GLrd+IAlG/GsubjIeT8gx3BUy5KFq6n1O6umPxJCbz9ogKA6p29GXFXb5CET0bcbr
 NbCUMABpgtcc3I6XFubM2O1nKzew2IPwvQYHaYLyYMWBG85tspDqqp4Sl4XQNMHug4
 i/NuKd+TTQmrqQsyluZM7pwCExv2qEu98ASkq4t4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 22/88] ppc/xive: Introduce OS CAM line helpers
Date: Tue, 17 Dec 2019 15:42:16 +1100
Message-Id: <20191217044322.351838-23-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The OS CAM line has a special encoding exploited by the HW. Provide
helper routines to hide the details to the TIMA command handlers. This
also clarifies the endianness of different variables : 'qw1w2' is
big-endian and 'cam' is native.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191115162436.30548-7-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 177663d2b4..42e9a11ef7 100644
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
2.23.0


