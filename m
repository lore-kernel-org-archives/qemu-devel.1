Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2A7C11D27
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A32720679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e+OptBxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A32720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zGB-0008Px-Kn
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z81-0002HJ-Oo
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7z-0008OX-En
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:24 -0500
Received: from ozlabs.org ([203.11.71.1]:45095)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7x-00080S-Ks; Thu, 20 Feb 2020 22:37:21 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwG0HH8z9sSS; Fri, 21 Feb 2020 14:37:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256222;
 bh=d0KQZORobL/dk3lddVEZ96kD6QJ1/UwrnRoH/kYdVkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e+OptBxoC8HW1e2rtvdhy1p5ZRKND+DNoWJNqnlDbHq8L4zdQn6AXxTVYhIr7fh09
 PaQTiECWAC59qES4qdeKF8TeAcYyRXbCfBrY5CkvCBFVij4PQdsFGQR0lDEpbZpDIC
 /55/hksPkyNYQ4yvbILWrmXvhzf4rYQkzlMOOaf8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 10/20] pnv/phb3: Convert 1u to 1ull
Date: Fri, 21 Feb 2020 14:36:40 +1100
Message-Id: <20200221033650.444386-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

As reported by Coverity defect CID 1419397, the 'j' variable goes up to
63 and shouldn't be used to left shift a 32-bit integer.

The result of the operation goes to a 64-bit integer : use a 64-bit
constant.

Reported-by: Coverity CID 1419397 Bad bit shift operation
Fixes: 9ae1329ee2fe "ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge=
"
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158153364010.3229002.8004283672455615950.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/pnv_phb3_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index ecfc1b2c4e..d645468f4a 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -220,7 +220,7 @@ static void phb3_msi_resend(ICSState *ics)
             if ((msi->rba[i] & (1ull << j)) =3D=3D 0) {
                 continue;
             }
-            msi->rba[i] &=3D ~(1u << j);
+            msi->rba[i] &=3D ~(1ull << j);
             phb3_msi_try_send(msi, i * 64 + j, true);
         }
     }
--=20
2.24.1


