Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1365BC41514
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D662D233A2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kP4hUtTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D662D233A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0L5X-0001dA-GJ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0G-0004Om-3x
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0E-0007sh-V1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:25:56 -0400
Received: from ozlabs.org ([203.11.71.1]:43207)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0D-0007qP-V0; Wed, 21 Aug 2019 03:25:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Czj849S9z9s3Z; Wed, 21 Aug 2019 17:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372348;
 bh=tOgL0zA9mNz9NzT5lhKuhdF4GsWgGJewvlTBKf1VtdM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kP4hUtTROjjme6uoTqs6rZQHroIXJYZgKYMlxo4Nt4i9m2DjeVYZS91wIfpWJ0wVC
 jwyqWhbOst3Xp2KEX66Bx0QFO+3cqGZJlWJtIVkq7HXj4mUnTT83nMLvhoznsLAsbl
 I/Fusyb22Ii6xC2YH7plC5chwZcyB7cUVXnTX2Qs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:02 +1000
Message-Id: <20190821072542.23090-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 02/42] spapr_iommu: Fix xlate trace to print
 translated address
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
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

Currently we basically print IO address twice, fix this.

Fixes: 7e472264e9e2 ("PPC: spapr: iommu: rework traces")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190812054202.125492-1-aik@ozlabs.ru>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index ce85f8ac63..e87b3d50f7 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -136,7 +136,7 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUM=
emoryRegion *iommu,
         ret.addr_mask =3D ~page_mask;
         ret.perm =3D spapr_tce_iommu_access_flags(tce);
     }
-    trace_spapr_iommu_xlate(tcet->liobn, addr, ret.iova, ret.perm,
+    trace_spapr_iommu_xlate(tcet->liobn, addr, ret.translated_addr, ret.=
perm,
                             ret.addr_mask);
=20
     return ret;
--=20
2.21.0


