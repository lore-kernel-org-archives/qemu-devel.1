Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73998C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D18C2082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aGD8BR9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D18C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Wb-0006l4-MQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kL-0002c8-I9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kK-0008MI-CK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:09 -0500
Received: from ozlabs.org ([203.11.71.1]:49031)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4kK-0007xM-0h; Mon, 16 Dec 2019 23:46:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWh66Wmz9sTZ; Tue, 17 Dec 2019 15:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557824;
 bh=eOGD8QwMNRe7LTWiMEshk2Ag9kxPUIVvcEXGfVAnae0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aGD8BR9wclJpDi2Fbf8BTwDV3UhIeg0OVXD3zybczDCzs0nCp3YIRUfhEE8hVIU7p
 v+c1WgeWWvcZtyOiGhOM1MC9kD2N+8mkgQjMjskVjbFcae69f33isjZuLPrWTsgiDS
 xoEe2e0gzWMDoN916vheJxsTcusWNeOYq9oN7OZ8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 71/88] ppc/pnv: populate the DT with realized XSCOM devices
Date: Tue, 17 Dec 2019 15:43:05 +1100
Message-Id: <20191217044322.351838-72-david@gibson.dropbear.id.au>
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
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Some devices could be initialized in the instance_init handler but not
realized for configuration reasons. Nodes should not be added in the DT
for such devices.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191210135845.19773-3-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_xscom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 760571037b..fd48d4ee37 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -304,7 +304,10 @@ static int xscom_dt_child(Object *child, void *opaqu=
e)
         PnvXScomInterface *xd =3D PNV_XSCOM_INTERFACE(child);
         PnvXScomInterfaceClass *xc =3D PNV_XSCOM_INTERFACE_GET_CLASS(xd)=
;
=20
-        if (xc->dt_xscom) {
+        /*
+         * Only "realized" devices should be configured in the DT
+         */
+        if (xc->dt_xscom && DEVICE(child)->realized) {
             _FDT((xc->dt_xscom(xd, args->fdt, args->xscom_offset)));
         }
     }
--=20
2.23.0


