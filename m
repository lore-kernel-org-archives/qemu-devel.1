Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F87C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E5321019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SunNSyiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E5321019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48699 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVslN-0001kE-NR
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:12:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQn-0000mn-TO
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQm-000316-RS
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:25 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35887 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQm-0002r4-E6; Wed, 29 May 2019 02:51:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv70LlFz9sPc; Wed, 29 May 2019 16:50:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112627;
	bh=Slm6kw9RPZToEV2z3ODo3MPSUQ2me32jV07w5nNpeO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SunNSyiOn1WF2RmuqwEdAFJIUnww2eXCgLZ1Xa1xOlJ4n4Cg9h/vEL90UFPQZpyUj
	5DX0G5pfUwXSvN987d2ickIdRV7Ph/3kxikqoCitzEdSkxZdZ0a1yO/X4GWiTTeVDr
	1ZJo5q/UbH2Uxo6KuxNhhQ444uHU4qhZuuOkhZoA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:50:17 +1000
Message-Id: <20190529065017.15149-45-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 44/44] ppc/pnv: add dummy XSCOM registers for
 PRD initialization
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
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

PRD (Processor recovery diagnostics) is a service available on
OpenPower systems. The opal-prd daemon initializes the PowerPC
Processor through the XSCOM bus and then waits for hardware diagnostic
events.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190527071722.31424-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_xscom.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index c285ef514e..f53a6d7a94 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -29,6 +29,12 @@
=20
 #include <libfdt.h>
=20
+/* PRD registers */
+#define PRD_P8_IPOLL_REG_MASK           0x01020013
+#define PRD_P8_IPOLL_REG_STATUS         0x01020014
+#define PRD_P9_IPOLL_REG_MASK           0x000F0033
+#define PRD_P9_IPOLL_REG_STATUS         0x000F0034
+
 static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
 {
     /*
@@ -70,6 +76,12 @@ static uint64_t xscom_read_default(PnvChip *chip, uint=
32_t pcba)
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
=20
+        /* PRD registers */
+    case PRD_P8_IPOLL_REG_MASK:
+    case PRD_P8_IPOLL_REG_STATUS:
+    case PRD_P9_IPOLL_REG_MASK:
+    case PRD_P9_IPOLL_REG_STATUS:
+
         /* P9 xscom reset */
     case 0x0090018:     /* Receive status reg */
     case 0x0090012:     /* log register */
@@ -124,6 +136,12 @@ static bool xscom_write_default(PnvChip *chip, uint3=
2_t pcba, uint64_t val)
     case 0x201302a:     /* CAPP stuff */
     case 0x2013801:     /* CAPP stuff */
     case 0x2013802:     /* CAPP stuff */
+
+        /* P8 PRD registers */
+    case PRD_P8_IPOLL_REG_MASK:
+    case PRD_P8_IPOLL_REG_STATUS:
+    case PRD_P9_IPOLL_REG_MASK:
+    case PRD_P9_IPOLL_REG_STATUS:
         return true;
     default:
         return false;
--=20
2.21.0


