Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C2C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3107120705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="J/fOBO6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3107120705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3qB-0005mQ-PT
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oX-0003qJ-8n
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oW-0002ci-4z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:29 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33315 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oV-0002Ui-83; Wed, 08 Jan 2020 00:23:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syM96vZyz9sRh; Wed,  8 Jan 2020 16:23:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460997;
 bh=dodT1uscgQVznABK1X7L2iHrmYh5gDhROj4lKaOEfes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J/fOBO6ZlsL39NTzHEZXAYKMBHSfF+p14Djw/0YW2L9jwHlWqVHxxCEerAcg30jhg
 /Fy6mSVlUDYXDNPJ0ofws/W9KJspbmoYprJXQqsJ9N1yEYjqsX6jHYRMPuVupeqnXI
 fqMFlt2jqZmlkjGkFCNULq2yfZwda5oYwYrWZglo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/26] ppc/pnv: Modify the powerdown notifier to get the
 PowerNV machine
Date: Wed,  8 Jan 2020 16:22:51 +1100
Message-Id: <20200108052312.238710-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Use container_of() instead of qdev_get_machine()

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191219181155.32530-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f77e7ca84e..855254f282 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -561,7 +561,7 @@ static void *pnv_dt_create(MachineState *machine)
=20
 static void pnv_powerdown_notify(Notifier *n, void *opaque)
 {
-    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    PnvMachineState *pnv =3D container_of(n, PnvMachineState, powerdown_=
notifier);
=20
     if (pnv->bmc) {
         pnv_bmc_powerdown(pnv->bmc);
--=20
2.24.1


