Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D57C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932212146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="REVhtQNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932212146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCjc-0003E9-SC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC07-0006Cw-4a
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiC06-0003g4-0X
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54135 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiC05-0003Rj-L7; Tue, 02 Jul 2019 02:10:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMp3qRcz9sRD; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047750;
 bh=O0BwGIFtuIEU4BNo5FlE86BSBTHsHhMIiptJ5Ab7+DE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=REVhtQNa5tJEbL9nHBikuvwitgdSyVAJ4bqoK7l65/0YZwbDrTA5OdAlk5snrGWwt
 Iqo2tvxaRTosN+8XotqRk7aQsEP5IF7Ns7UvXBgkiBw8oiecTYbrqVAOjh/o6cHcmh
 9koFDj6QTZwh6LadNxXTI6jCbI9vuxbgqd0zkw24=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:56 +1000
Message-Id: <20190702060857.3926-49-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 48/49] ppc/xive: Fix TM_PULL_POOL_CTX special
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When a CPU is reseted, the hypervisor (Linux or OPAL) invalidates the
POOL interrupt context of a CPU with this special command. It returns
the POOL CAM line value and resets the VP bit.

Fixes: 4836b45510aa ("ppc/xive: activate HV support")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190630204601.30574-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 534f56f86b..cf77bdb7d3 100644
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


