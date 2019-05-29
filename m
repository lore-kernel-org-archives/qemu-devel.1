Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226BBC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57CB21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IQBOubMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57CB21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsiP-0007Ko-UO
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:09:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQQ-0000L6-V9
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQQ-0002qT-1s
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:02 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56907 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQP-0002e0-M5; Wed, 29 May 2019 02:51:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv62HCLz9sPJ; Wed, 29 May 2019 16:50:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112626;
	bh=siwZger9wRnZvOxEZY9u/KjVe/b0SGHKQBk2SghV9nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQBOubMJHzYeVJzElLwr+8g7hR6yqC++i67lrYv1i847pmy7tRScY7w+JsUBvarpe
	NqDtPTVZ/PFTJBwYdoDaluGUX8EjGYVEH4nhc4HmBb9k32nD2oUfq/0IShNBAT7ZVI
	YwgiPEUR6FTizcsTJR7hAH4eJxe07pHLCK3sn9E8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:49:58 +1000
Message-Id: <20190529065017.15149-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 25/44] spapr: Print out extra hints when CAS
 negotiation of interrupt mode fails
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Let's suggest to the user how the machine should be configured to allow
the guest to boot successfully.

Suggested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155799221739.527449.14907564571096243745.stgit@bahia.lan>
Reviewed-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
[dwg: Adjusted for style error]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 63a55614b8..0a050ad3d8 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1646,12 +1646,14 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
      */
     if (guest_xive) {
         if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_LEGACY) {
-            error_report("Guest requested unavailable interrupt mode (XI=
VE)");
+            error_report(
+"Guest requested unavailable interrupt mode (XIVE), try the ic-mode=3Dxi=
ve or ic-mode=3Ddual machine property");
             exit(EXIT_FAILURE);
         }
     } else {
         if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
-            error_report("Guest requested unavailable interrupt mode (XI=
CS)");
+            error_report(
+"Guest requested unavailable interrupt mode (XICS), either don't set the=
 ic-mode machine property or try ic-mode=3Dxics or ic-mode=3Ddual");
             exit(EXIT_FAILURE);
         }
     }
--=20
2.21.0


