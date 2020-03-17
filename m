Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD0C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E87F20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jpSo3RZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E87F20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Lz-0006rf-6l
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96A-0001ku-0R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE968-0005ul-OO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:21 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35837 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE968-0002yS-98; Tue, 17 Mar 2020 06:05:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKz1W4zz9sTM; Tue, 17 Mar 2020 21:04:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439479;
 bh=UKbkwRK7I1bLV959/gSC/rtFeiYnU4cghDHk8Er4hVE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jpSo3RZql7UljcEQwDrX8mYomfBCpGKDKHCn+gk/l2FNAOgLYGpLsLFx6Ugc8qwGO
 pPRb0xFpxK4Ih1YqJexipfHH+T1iHU+E/ZIYU2a6gOO4kPKzKdlQxKZKynBfRrsupS
 /cGumbvw1yYXEGTOZLg7kEtufo9pgrT8Unfsxlxs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 29/45] spapr/xive: use SPAPR_IRQ_IPI to define IPI ranges
 exposed to the guest
Date: Tue, 17 Mar 2020 21:04:07 +1100
Message-Id: <20200317100423.622643-30-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The "ibm,xive-lisn-ranges" defines ranges of interrupt numbers that
the guest can use to configure IPIs. It starts at 0 today but it could
change to some other offset. Make clear which IRQ range we are
exposing by using SPAPR_IRQ_IPI in the property definition.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200306123307.1348-1-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 20c8155557..6608d7220a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -677,8 +677,8 @@ static void spapr_xive_dt(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
     uint64_t timas[2 * 2];
     /* Interrupt number ranges for the IPIs */
     uint32_t lisn_ranges[] =3D {
-        cpu_to_be32(0),
-        cpu_to_be32(nr_servers),
+        cpu_to_be32(SPAPR_IRQ_IPI),
+        cpu_to_be32(SPAPR_IRQ_IPI + nr_servers),
     };
     /*
      * EQ size - the sizes of pages supported by the system 4K, 64K,
--=20
2.24.1


