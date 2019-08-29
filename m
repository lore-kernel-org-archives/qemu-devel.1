Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B18CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7C423429
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CC24AIYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7C423429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Ddt-0006Ca-5U
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbw-0004CN-SS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbu-0003aP-Fp
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:44 -0400
Received: from ozlabs.org ([203.11.71.1]:37933)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3Dbt-0003Wv-FA; Thu, 29 Aug 2019 02:08:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscM1DQSz9sMr; Thu, 29 Aug 2019 16:08:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058915;
 bh=V/Zfp67/iq6KWTKIKpQ6RPh2BzF2cTYSd2pn1KZUde8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CC24AIYbIk4TjsqUXe+W3SklQqux1k9tXTCOMcoMZXgaRKmZhEd6nDx8FSAuHKPfG
 6YCLynAsln93xc805lqswYzRwZ+GPF/L8SeRvrbKAPPeFP++78oQoyofSpd3/oLXIS
 dyoQxtDGGeu1cVGS8lVR/ptVA9NK2LukPC8nBVJQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:09 +1000
Message-Id: <20190829060827.25731-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829060827.25731-1-david@gibson.dropbear.id.au>
References: <20190829060827.25731-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 01/19] ppc/pnv: Set default ram size to 1.75GB
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

This makes the powernv machine easier for end users as the default
initrd address (1.5GB) is now within RAM.

This uses less than 2GB of RAM to ensure 32 bit Qemu still works.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-Id: <20190821030945.473-1-joel@jms.id.au>
[dwg: Fix comment style for checkpatch]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d95086fbbd..6ead82aaa7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1361,7 +1361,11 @@ static void pnv_machine_class_init(ObjectClass *oc=
, void *data)
                                       * storage */
     mc->no_parallel =3D 1;
     mc->default_boot_order =3D NULL;
-    mc->default_ram_size =3D 1 * GiB;
+    /*
+     * RAM defaults to less than 2048 for 32-bit hosts, and large
+     * enough to fit the maximum initrd size at it's load address
+     */
+    mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
     xic->icp_get =3D pnv_icp_get;
     xic->ics_get =3D pnv_ics_get;
     xic->ics_resend =3D pnv_ics_resend;
--=20
2.21.0


