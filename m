Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D80C74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 06:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A785521019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 06:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A785521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlST2-0001iv-Tw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 02:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hlSQL-0005d4-JQ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hlSQK-0000JY-Ja
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:19:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hlSQG-0000Ci-SS; Thu, 11 Jul 2019 02:19:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2252D2E97CD;
 Thu, 11 Jul 2019 06:19:16 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23C1E60A97;
 Thu, 11 Jul 2019 06:19:13 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com,
 pbonzini@redhat.com, alex.williamson@redhat.com
Date: Thu, 11 Jul 2019 08:18:54 +0200
Message-Id: <20190711061857.13086-3-eric.auger@redhat.com>
In-Reply-To: <20190711061857.13086-1-eric.auger@redhat.com>
References: <20190711061857.13086-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 11 Jul 2019 06:19:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v3 2/5] memory: Add
 IOMMU_ATTR_VFIO_NESTED IOMMU memory region attribute
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We introduce a new IOMMU Memory Region attribute,
IOMMU_ATTR_VFIO_NESTED that tells whether the virtual IOMMU
requires HW nested paging for VFIO integration.

Current Intel virtual IOMMU device supports "Caching
Mode" and does not require 2 stages at physical level to be
integrated with VFIO. However SMMUv3 does not implement such
"caching mode" and requires to use HW nested paging.

As such SMMUv3 is the first IOMMU device to advertise this
attribute.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c       | 12 ++++++++++++
 include/exec/memory.h |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e96d5beb9a..384c02cb91 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1490,6 +1490,17 @@ static void smmuv3_notify_flag_changed(IOMMUMemory=
Region *iommu,
     }
 }
=20
+static int smmuv3_get_attr(IOMMUMemoryRegion *iommu,
+                           enum IOMMUMemoryRegionAttr attr,
+                           void *data)
+{
+    if (attr =3D=3D IOMMU_ATTR_VFIO_NESTED) {
+        *(bool *) data =3D true;
+        return 0;
+    }
+    return -EINVAL;
+}
+
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
                                                   void *data)
 {
@@ -1497,6 +1508,7 @@ static void smmuv3_iommu_memory_region_class_init(O=
bjectClass *klass,
=20
     imrc->translate =3D smmuv3_translate;
     imrc->notify_flag_changed =3D smmuv3_notify_flag_changed;
+    imrc->get_attr =3D smmuv3_get_attr;
 }
=20
 static const TypeInfo smmuv3_type_info =3D {
diff --git a/include/exec/memory.h b/include/exec/memory.h
index a078cd033f..e477a630a8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -204,7 +204,8 @@ struct MemoryRegionOps {
 };
=20
 enum IOMMUMemoryRegionAttr {
-    IOMMU_ATTR_SPAPR_TCE_FD
+    IOMMU_ATTR_SPAPR_TCE_FD,
+    IOMMU_ATTR_VFIO_NESTED,
 };
=20
 /**
--=20
2.20.1


