Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7592C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB51E206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EjnYYDDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB51E206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHLGa-0004Ef-Ta
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 01:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHLFb-00039i-Nz
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHLFa-0000pb-JJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:40:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44919 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHLFZ-0000o0-Vj; Thu, 26 Mar 2020 01:40:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nv2l1DcCz9sSQ; Thu, 26 Mar 2020 16:40:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585201215;
 bh=fEyZvtCfABdffElGrSpl0Px+yuvrrBN6GboJ+tRarjY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EjnYYDDJl98k1BqlP8LVfG14o+c8T/8qtrzsmDngBEa75nuQUz1NW63t5pDrz6EeJ
 HsL9bNBE/Y1o7Kx+l94ySJCHe/6S/yHMu1zYW5YIy3tZFKG9Z0kX1TPfeUNzKXBw4g
 TAh5cGhoSGP4AHx0gKEW+k9ozvW+AiLKLdC4e5sU=
From: David Gibson <david@gibson.dropbear.id.au>
To: aik@ozlabs.ru,
	groug@kaod.org
Subject: [RFC for-5.1 4/4] spapr: Don't allow unplug of NVLink2 devices
Date: Thu, 26 Mar 2020 16:40:09 +1100
Message-Id: <20200326054009.454477-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326054009.454477-1-david@gibson.dropbear.id.au>
References: <20200326054009.454477-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, we can't properly handle unplug of NVLink2 devices, because we
don't have code to tear down their special memory resources.  There's not
a lot of impetus to implement that. Since hardware NVLink2 devices can't
be hot unplugged, the guest side drivers don't usually support unplug
anyway.

Therefore, simply prevent unplug of NVLink2 devices.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 55ca9dee1e..5c8262413a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1666,6 +1666,11 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
             return;
         }
=20
+        if (spapr_phb_is_nvlink_dev(pdev, phb)) {
+            error_setg(errp, "PCI: Cannot unplug NVLink2 devices");
+            return;
+        }
+
         /* ensure any other present functions are pending unplug */
         if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
             for (i =3D 1; i < 8; i++) {
--=20
2.25.1


