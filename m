Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48657C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1AE2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gW8GXowS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1AE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6az-0006lw-BK
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6Jz-0000lH-Gm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Jx-00018l-S9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27003
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jx-00016c-Ms
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9Nd35jhdm8gVascpo1WYQoMoWHudRbAkRHhYSsuGv0=;
 b=gW8GXowSqrJpRR57YZO9OY9YL5UFTniyN/tML0CGJ4SvzZn97IRY8C4+c5C8baXnqXqVG6
 lEyn90wKHevARSfJ2hiGyFn2sLG9c1ttbQYMOGSD/HC22xUs3jk3bmKcS4MyKSbClrSvDM
 cobSs90CEVB3+PCWkYMgpoZzmaopAU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-RkD2KOd7OXyKFhLIHgNW_g-1; Tue, 17 Dec 2019 01:26:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04639107ACCA;
 Tue, 17 Dec 2019 06:26:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9B2268863;
 Tue, 17 Dec 2019 06:26:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9365B1136428; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/34] hw/i386/amd_iommu: rename Error ** parameter to more
 common errp
Date: Tue, 17 Dec 2019 07:26:41 +0100
Message-Id: <20191217062651.9687-25-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: RkD2KOd7OXyKFhLIHgNW_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20191205174635.18758-12-vsementsov@virtuozzo.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/amd_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d55dbf07fc..b1175e52c7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1533,7 +1533,7 @@ static void amdvi_reset(DeviceState *dev)
     amdvi_init(s);
 }
=20
-static void amdvi_realize(DeviceState *dev, Error **err)
+static void amdvi_realize(DeviceState *dev, Error **errp)
 {
     int ret =3D 0;
     AMDVIState *s =3D AMD_IOMMU_DEVICE(dev);
@@ -1549,21 +1549,21 @@ static void amdvi_realize(DeviceState *dev, Error *=
*err)
     /* This device should take care of IOMMU PCI properties */
     x86_iommu->type =3D TYPE_AMD;
     qdev_set_parent_bus(DEVICE(&s->pci), &bus->qbus);
-    object_property_set_bool(OBJECT(&s->pci), true, "realized", err);
+    object_property_set_bool(OBJECT(&s->pci), true, "realized", errp);
     ret =3D pci_add_capability(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
-                                         AMDVI_CAPAB_SIZE, err);
+                                         AMDVI_CAPAB_SIZE, errp);
     if (ret < 0) {
         return;
     }
     s->capab_offset =3D ret;
=20
     ret =3D pci_add_capability(&s->pci.dev, PCI_CAP_ID_MSI, 0,
-                             AMDVI_CAPAB_REG_SIZE, err);
+                             AMDVI_CAPAB_REG_SIZE, errp);
     if (ret < 0) {
         return;
     }
     ret =3D pci_add_capability(&s->pci.dev, PCI_CAP_ID_HT, 0,
-                             AMDVI_CAPAB_REG_SIZE, err);
+                             AMDVI_CAPAB_REG_SIZE, errp);
     if (ret < 0) {
         return;
     }
@@ -1578,8 +1578,8 @@ static void amdvi_realize(DeviceState *dev, Error **e=
rr)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
     pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
-    s->devid =3D object_property_get_int(OBJECT(&s->pci), "addr", err);
-    msi_init(&s->pci.dev, 0, 1, true, false, err);
+    s->devid =3D object_property_get_int(OBJECT(&s->pci), "addr", errp);
+    msi_init(&s->pci.dev, 0, 1, true, false, errp);
     amdvi_init(s);
 }
=20
--=20
2.21.0


