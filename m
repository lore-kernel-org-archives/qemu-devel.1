Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF94C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF2C20748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MuR1+ga9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF2C20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLfzX-0001QH-Ix
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyK-0007xr-4j
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyI-0004AI-Pv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40749 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLfyH-00045P-Hp; Tue, 07 Apr 2020 00:36:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xF3K17Xkz9sSM; Tue,  7 Apr 2020 14:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586234173;
 bh=wHn1JzecR9WBH37KuCbf5xiT7j7lqDDU4hZhIafKUII=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MuR1+ga9CypNOZPJUydw3KR+swa7KTDGsu6rREC25IwzuO4yyPfpWebBBwbv1tIm7
 Kjhl+146k6s4/oyuDQv8/+KKhTqKt5h6qNzpamt4kgG7SHZvadxwvVpkp6wAYWa14K
 ikg0GX2kB52NsJpflbG+ouaaMWOfM7v6/mYDFDGs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 02/10] vfio/spapr: Fix page size calculation
Date: Tue,  7 Apr 2020 14:35:58 +1000
Message-Id: <20200407043606.291546-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200407043606.291546-1-david@gibson.dropbear.id.au>
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

Coverity detected an issue (CID 1421903) with potential call of clz64(0)
which returns 64 which make it do "<<" with a negative number.

This checks the mask and avoids undefined behaviour.

In practice pgsizes and memory_region_iommu_get_min_page_size() always
have some common page sizes and even if they did not, the resulting page
size would be 0x8000.0000.0000.0000 (gcc 9.2) and
ioctl(VFIO_IOMMU_SPAPR_TCE_CREATE) would fail anyway.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20200324063912.25063-1-aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/vfio/spapr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 33692fc86f..2900bd1941 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -147,7 +147,7 @@ int vfio_spapr_create_window(VFIOContainer *container=
,
 {
     int ret =3D 0;
     IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
-    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
+    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
), pgmask;
     unsigned entries, bits_total, bits_per_level, max_levels;
     struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
     long rampagesize =3D qemu_minrampagesize();
@@ -159,8 +159,8 @@ int vfio_spapr_create_window(VFIOContainer *container=
,
     if (pagesize > rampagesize) {
         pagesize =3D rampagesize;
     }
-    pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
-                                   (pagesize | (pagesize - 1))));
+    pgmask =3D container->pgsizes & (pagesize | (pagesize - 1));
+    pagesize =3D pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
     if (!pagesize) {
         error_report("Host doesn't support page size 0x%"PRIx64
                      ", the supported mask is 0x%lx",
--=20
2.25.2


