Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC24C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073532072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JJhjjU2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073532072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih55r-0007wy-Sb
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iq-0000p9-DI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ip-0006HD-4O
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:36 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45673 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4io-0005pB-Pz; Mon, 16 Dec 2019 23:44:35 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWW6tTnz9sT0; Tue, 17 Dec 2019 15:43:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557815;
 bh=wPQbnCmTulcBaUJR53le06ApidmfEUZ/0yBK/Wsb83g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JJhjjU2YeKbZh4EgzcEZ+ex8I2rsii36PMc0oe07lzc1ryZcLKQ3JqD8boPz4ufjl
 X9jXJO7AX7nEX5Jauk6kLKLPMBm0LuZIw5OiR0kWIBJjYwrASOaIQezJ1Lro56RaPY
 8GwmsiXoWA+UDFDCrwTOJy/NlZ6MApQHmfbYAOJ4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 37/88] ppc/xive: Use the XiveFabric and XivePresenter interfaces
Date: Tue, 17 Dec 2019 15:42:31 +1100
Message-Id: <20191217044322.351838-38-david@gibson.dropbear.id.au>
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

Now that the machines have handlers implementing the XiveFabric and
XivePresenter interfaces, remove xive_presenter_match() and make use
of the 'match_nvt' handler of the machine.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-12-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 48 +++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 1c9e58f8de..8e683847bf 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1423,30 +1423,6 @@ int xive_presenter_tctx_match(XivePresenter *xptr,=
 XiveTCTX *tctx,
     return -1;
 }
=20
-static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
-                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                 bool cam_ignore, uint8_t priority,
-                                 uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
-{
-    XivePresenter *xptr =3D XIVE_PRESENTER(xrtr);
-    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
-    int count;
-
-    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
-                           priority, logic_serv, match);
-    if (count < 0) {
-        return false;
-    }
-
-    if (!match->tctx) {
-        qemu_log_mask(LOG_UNIMP, "XIVE: NVT %x/%x is not dispatched\n",
-                      nvt_blk, nvt_idx);
-        return false;
-    }
-
-    return true;
-}
-
 /*
  * This is our simple Xive Presenter Engine model. It is merged in the
  * Router as it does not require an extra object.
@@ -1462,22 +1438,32 @@ static bool xive_presenter_match(XiveRouter *xrtr=
, uint8_t format,
  *
  * The parameters represent what is sent on the PowerBus
  */
-static bool xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
+static bool xive_presenter_notify(uint8_t format,
                                   uint8_t nvt_blk, uint32_t nvt_idx,
                                   bool cam_ignore, uint8_t priority,
                                   uint32_t logic_serv)
 {
+    XiveFabric *xfb =3D XIVE_FABRIC(qdev_get_machine());
+    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
     XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
-    bool found;
+    int count;
=20
-    found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
-                                 priority, logic_serv, &match);
-    if (found) {
+    /*
+     * Ask the machine to scan the interrupt controllers for a match
+     */
+    count =3D xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
+                           priority, logic_serv, &match);
+    if (count < 0) {
+        return false;
+    }
+
+    /* handle CPU exception delivery */
+    if (count) {
         ipb_update(&match.tctx->regs[match.ring], priority);
         xive_tctx_notify(match.tctx, match.ring);
     }
=20
-    return found;
+    return !!count;
 }
=20
 /*
@@ -1590,7 +1576,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
         return;
     }
=20
-    found =3D xive_presenter_notify(xrtr, format, nvt_blk, nvt_idx,
+    found =3D xive_presenter_notify(format, nvt_blk, nvt_idx,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
                           xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7));
--=20
2.23.0


