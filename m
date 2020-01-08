Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679FAC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F3D2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nm/hFH6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F3D2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip445-0001AU-V0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3od-0003uL-6X
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3ob-0002mm-HZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:34 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54195 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3ob-0002ie-5D; Wed, 08 Jan 2020 00:23:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMF0FHQz9sSW; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578461001;
 bh=mK5XU6p4s13EQ4Nm/HoejNWenGuyaWWXGFTWV8utYq4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nm/hFH6+lfue7R7etk4T7hSdLuF1DpQVP2RhZ8D4h2CGPBelubEaZjmWjEBoIPfbX
 Y1GyWl221ZYYL/2lxIxKS6os5746P2HbrR8TGuAvcYp5y8v4GxjwIAODHfyLvksYVI
 92vAXsOvMQJQWKzbop/xccqiZ2hfe4K4BmQOYA2E=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 17/26] xive: Use the XIVE fabric link under the XIVE router
Date: Wed,  8 Jan 2020 16:23:03 +1100
Message-Id: <20200108052312.238710-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Now that the spapr and pnv machines do set the "xive-fabric" link, the
use of the XIVE fabric pointer becomes mandatory. This is checked with
an assert() in a new realize hook. Since the XIVE router is realized at
machine init for the all the machine's life time, no risk to abort an
already running guest (ie. not a hotplug path).

This gets rid of a qdev_get_machine() call.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200106145645.4539-6-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 6df89b06da..12a362b681 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1378,6 +1378,13 @@ static int xive_router_get_block_id(XiveRouter *xr=
tr)
    return xrc->get_block_id(xrtr);
 }
=20
+static void xive_router_realize(DeviceState *dev, Error **errp)
+{
+    XiveRouter *xrtr =3D XIVE_ROUTER(dev);
+
+    assert(xrtr->xfb);
+}
+
 /*
  * Encode the HW CAM line in the block group mode format :
  *
@@ -1470,12 +1477,11 @@ int xive_presenter_tctx_match(XivePresenter *xptr=
, XiveTCTX *tctx,
  *
  * The parameters represent what is sent on the PowerBus
  */
-static bool xive_presenter_notify(uint8_t format,
+static bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                                   uint8_t nvt_blk, uint32_t nvt_idx,
                                   bool cam_ignore, uint8_t priority,
                                   uint32_t logic_serv)
 {
-    XiveFabric *xfb =3D XIVE_FABRIC(qdev_get_machine());
     XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
     XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
     int count;
@@ -1607,7 +1613,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
         return;
     }
=20
-    found =3D xive_presenter_notify(format, nvt_blk, nvt_idx,
+    found =3D xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
                           xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7));
@@ -1727,6 +1733,8 @@ static void xive_router_class_init(ObjectClass *kla=
ss, void *data)
=20
     dc->desc    =3D "XIVE Router Engine";
     dc->props   =3D xive_router_properties;
+    /* Parent is SysBusDeviceClass. No need to call its realize hook */
+    dc->realize =3D xive_router_realize;
     xnc->notify =3D xive_router_notify;
 }
=20
--=20
2.24.1


