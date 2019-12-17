Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A964C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C012072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cV2iCQoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C012072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Rj-0008Ig-Ke
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jE-0001Sf-K6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jD-0006rU-EI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:00 -0500
Received: from ozlabs.org ([203.11.71.1]:34267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jD-0006KY-2e; Mon, 16 Dec 2019 23:44:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWZ45MKz9sT9; Tue, 17 Dec 2019 15:43:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557818;
 bh=gc2VEHorOGzr/BBnU0/1bboHzXgl+whXQBs70dr1m+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cV2iCQoHoeZEZxPwM7YrJQzhDql/IHZf7FSqXeCrudnMRlZk4YP0sJVf3XlzXkGMa
 omNZB4n0X/kVEyFyKAU3RLgYUpEqZ1x0neE4isRg1RbXU4l4DCpcdk6Meuv9Jz/85H
 jzrw87jXwOwGF1a89P3iNsKLfHZU+6xOq6uDPRls=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 46/88] ppc/xive: Introduce a xive_tctx_ipb_update() helper
Date: Tue, 17 Dec 2019 15:42:40 +1100
Message-Id: <20191217044322.351838-47-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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

We will use it to resend missed interrupts when a vCPU context is
pushed on a HW thread.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-17-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 21 +++++++++++----------
 include/hw/ppc/xive.h |  1 +
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 4bff3abdc3..7047e45dac 100644
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
     return !!count;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 24315480e7..9c0bf2c301 100644
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
--=20
2.23.0


