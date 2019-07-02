Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDCBC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A950E21721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GZ0dLL3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A950E21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCjG-0002RG-UW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59018)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzk-0005mN-IB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzi-0003RB-Cj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54353 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBze-0003Ge-MY; Tue, 02 Jul 2019 02:10:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMn47LLz9sR0; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047749;
 bh=L8RTgpO7LVRVvS97dvoPx+3IeaI/B7AJ/BHfgV0BYv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GZ0dLL3GtuH4Ys4iH/V9Moa1/U14bauUO0P3WfgxoJy5GoWiSi1o5PasNcCZRyXKL
 FaUawGKkzL0/8pD8pePbIgIXQ5/qi+64JLGDHws+ogQ0CXkzzkA0/9MSXrNF23Q+pj
 2LEgi32czC0aZlYwv0SWhv+UhGHGqKmYDD9ftBao=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:53 +1000
Message-Id: <20190702060857.3926-46-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 45/49] ppc/xive: Force the Physical CAM line
 value to group mode
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

When an interrupt needs to be delivered, the XIVE interrupt controller
presenter scans the CAM lines of the thread interrupt contexts of the
HW threads of the chip to find a matching vCPU. The interrupt context
is composed of 4 different sets of registers: Physical, HV, OS and
User.

The encoding of the Physical CAM line depends on the mode in which the
interrupt controller is operating: CAM mode or block group mode.
Block group mode being the default configuration today on POWER9 and
the only one available on the next POWER10 generation, enforce this
encoding in the Physical CAM line :

    chip << 19 | 0000000 0 0001 thread (7Bit)

It fits the overall encoding of the NVT ids and simplifies the matching
algorithm in the presenter.

Fixes: d514c48d41fb ("ppc/xive: hardwire the Physical CAM line of the thr=
ead context")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190630204601.30574-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 6250c0414d..3b1f9520ae 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1229,27 +1229,16 @@ XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, =
CPUState *cs)
 }
=20
 /*
- * By default on P9, the HW CAM line (23bits) is hardwired to :
+ * Encode the HW CAM line in the block group mode format :
  *
- *   0x000||0b1||4Bit chip number||7Bit Thread number.
- *
- * When the block grouping is enabled, the CAM line is changed to :
- *
- *   4Bit chip number||0x001||7Bit Thread number.
+ *   chip << 19 | 0000000 0 0001 thread (7Bit)
  */
-static uint32_t hw_cam_line(uint8_t chip_id, uint8_t tid)
-{
-    return 1 << 11 | (chip_id & 0xf) << 7 | (tid & 0x7f);
-}
-
-static bool xive_presenter_tctx_match_hw(XiveTCTX *tctx,
-                                         uint8_t nvt_blk, uint32_t nvt_i=
dx)
+static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx)
 {
     CPUPPCState *env =3D &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
=20
-    return hw_cam_line((pir >> 8) & 0xf, pir & 0x7f) =3D=3D
-        hw_cam_line(nvt_blk, nvt_idx);
+    return xive_nvt_cam_line((pir >> 8) & 0xf, 1 << 7 | (pir & 0x7f));
 }
=20
 /*
@@ -1285,7 +1274,7 @@ static int xive_presenter_tctx_match(XiveTCTX *tctx=
, uint8_t format,
=20
         /* PHYS ring */
         if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
-            xive_presenter_tctx_match_hw(tctx, nvt_blk, nvt_idx)) {
+            cam =3D=3D xive_tctx_hw_cam_line(tctx)) {
             return TM_QW3_HV_PHYS;
         }
=20
--=20
2.21.0


