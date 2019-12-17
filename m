Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5408C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13652072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HMxjXq9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13652072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Cz-0002Ac-9H
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4k9-0002ME-Gf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4k6-00082N-0S
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:55 -0500
Received: from ozlabs.org ([203.11.71.1]:39273)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4k4-0007Xd-Ek; Mon, 16 Dec 2019 23:45:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWh0trzz9sTW; Tue, 17 Dec 2019 15:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557824;
 bh=1amkbfv/C6Cb1XKFIBX0BD98zbGySF/FrizpzYukWV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HMxjXq9vQfEbE1NXt7Z7vgA+k+bbVHG391rl7/UOIPwYO4f2b3R6YZb1YakK+oP+/
 bGHE+hJFlbn+UOHlANiU5XBoNcPEekU/p3SDO9LBKN8Spa1nhHechMiVYs0SvWSuGc
 rqzjcLxA9eYBZM2jR97R6Eydxzd6pT9ewcS2DqaY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 70/88] ppc/pnv: Loop on the whole hierarchy to populate the DT
 with the XSCOM nodes
Date: Tue, 17 Dec 2019 15:43:04 +1100
Message-Id: <20191217044322.351838-71-david@gibson.dropbear.id.au>
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

Some PnvXScomInterface objects lie a bit deeper (PnvPBCQState) than
the first layer, so we need to loop on the whole object hierarchy to
catch them.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191210135845.19773-2-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
[dwg: Corrected error in comment]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_xscom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index b3d3b6e350..760571037b 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -358,7 +358,12 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_=
offset)
     args.fdt =3D fdt;
     args.xscom_offset =3D xscom_offset;
=20
-    object_child_foreach(OBJECT(chip), xscom_dt_child, &args);
+    /*
+     * Loop on the whole object hierarchy to catch all
+     * PnvXScomInterface objects which can lie a bit deeper than the
+     * first layer.
+     */
+    object_child_foreach_recursive(OBJECT(chip), xscom_dt_child, &args);
     return 0;
 }
=20
--=20
2.23.0


