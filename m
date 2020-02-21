Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA96FC11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855E8208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CzlokUDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855E8208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zEM-0004ov-MW
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7z-0002F9-KQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7x-0008Ml-R0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:23 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33791 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7x-00080P-Ez; Thu, 20 Feb 2020 22:37:21 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwG37Lgz9sSV; Fri, 21 Feb 2020 14:37:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256222;
 bh=oto2DP51lfwFNY8850lSwPwMGWIzyB8Fptb3GKQeMEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CzlokUDrjrdyR1xI8BDsyLYN7fvapZewHiN6SYWvCT3DqPzs6BnPF80r97DPGTKK+
 skZltN/BTjkp2wPSuuXMvOMAF1BL0wpTezZ3/D0zlG9RuH4neZPi4N0EaC1ziYgz3p
 Bl6DHdDDvROLhq9IZ7BNlRNvYorOs6jlekzcMeA4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 11/20] pnv/phb4: Fix error path in pnv_pec_realize()
Date: Fri, 21 Feb 2020 14:36:41 +1100
Message-Id: <20200221033650.444386-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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

From: Greg Kurz <groug@kaod.org>

Obviously, we want to pass &local_err so that we can check it then
line below, not errp.

Reported-by: Coverity CID 1419395 'Constant' variable guards dead code
Fixes: 4f9924c4d4cf "ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge=
"
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158153364605.3229002.2796177658957390343.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/pnv_phb4_pec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 68e1db3eac..911d147ffd 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -391,7 +391,7 @@ static void pnv_pec_realize(DeviceState *dev, Error *=
*errp)
=20
         object_property_set_int(stk_obj, i, "stack-no", &error_abort);
         object_property_set_link(stk_obj, OBJECT(pec), "pec", &error_abo=
rt);
-        object_property_set_bool(stk_obj, true, "realized", errp);
+        object_property_set_bool(stk_obj, true, "realized", &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
--=20
2.24.1


