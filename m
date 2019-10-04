Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE827C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD6920867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JWGxY5zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD6920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKWv-0003Ml-8e
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2k-0005PO-II
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2j-0005Xd-2i
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39933 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2i-0005UW-Nc; Fri, 04 Oct 2019 05:38:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YM72pPz9sSF; Fri,  4 Oct 2019 19:37:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181879;
 bh=IGPINlnSSMKacgj4fwu7mrUtB2AZZ1pQo4uwnmR3KCk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JWGxY5zXvghBHO+dTz4SHUyidVPIsrv2dQIfo2RqhgtSJK2v4WI6IYyM6UCLkfDhu
 j7pSoYTA/4yTuOF/aMpnkzyktj3oc37Zamppp9V7GqK3if8YeY9F1pPPIPucqX52YW
 uGTtmrvtZUGyUrGoD72WQJ5yg7j81C9gazQ+55hE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 32/53] spapr/xive: skip partially initialized vCPUs in presenter
Date: Fri,  4 Oct 2019 19:37:26 +1000
Message-Id: <20191004093747.31350-33-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
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

When vCPUs are hotplugged, they are added to the QEMU CPU list before
being fully realized. This can crash the XIVE presenter because the
'tctx' pointer is not necessarily initialized when looking for a
matching target.

These vCPUs are not valid targets for the presenter. Skip them.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191001085722.32755-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xive.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b7417210d8..29df06df11 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1396,6 +1396,14 @@ static bool xive_presenter_match(XiveRouter *xrtr,=
 uint8_t format,
         XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
         int ring;
=20
+        /*
+         * Skip partially initialized vCPUs. This can happen when
+         * vCPUs are hotplugged.
+         */
+        if (!tctx) {
+            continue;
+        }
+
         /*
          * HW checks that the CPU is enabled in the Physical Thread
          * Enable Register (PTER).
--=20
2.21.0


