Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B40C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E9C20724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDK4i9Xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E9C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFL4L-0001lQ-QV
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFL0z-0005Hj-Az
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFL0y-0005Rg-1v
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:00:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFL0x-0005Q5-Tc
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02BJtmu2O0MAYVDAv96+wX90SDBllBZ9UcQUnCwYiy8=;
 b=SDK4i9XcVAu2wkMc5rz7Tit+ybg+nupzpD5Vn46/LkIWvebzCbJLJWTbptKUN7avpSWhTK
 sZqmi0hwvw9a86yU/nOLfQx0a1Cs0tyjY5rL6kAD01fbYVry01IbTkgSgF9kwWbqcqaQs4
 hMHrrpA78LO1dbU0EUqFWOHhr/w0r0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-rANHI_eKMNCKKY8lghVg3w-1; Fri, 20 Mar 2020 13:00:50 -0400
X-MC-Unique: rANHI_eKMNCKKY8lghVg3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50457800D5A;
 Fri, 20 Mar 2020 17:00:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A8A916D22;
 Fri, 20 Mar 2020 17:00:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 09/24] vfio: Force nested if iommu requires it
Date: Fri, 20 Mar 2020 17:58:25 +0100
Message-Id: <20200320165840.30057-10-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-1-eric.auger@redhat.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 zhangfei.gao@foxmail.com, peterx@redhat.com,
 shameerali.kolothum.thodi@huawei.com, zhangfei.gao@linaro.org,
 bbhushan2@marvell.com, will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case we detect the address space is translated by
a virtual IOMMU which requires HW nested paging to
integrate with VFIO, let's set up the container with
the VFIO_TYPE1_NESTING_IOMMU iommu_type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4 -> v5:
- fail immediatly if nested is wanted but not supported

v2 -> v3:
- add "nested only is selected if requested by @force_nested"
  comment in this patch
---
 hw/vfio/common.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b3c0..ac417b5dbd 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1155,27 +1155,38 @@ static void vfio_put_address_space(VFIOAddressSpace=
 *space)
  * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
  */
 static int vfio_get_iommu_type(VFIOContainer *container,
+                               bool want_nested,
                                Error **errp)
 {
-    int iommu_types[] =3D { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
+    int iommu_types[] =3D { VFIO_TYPE1_NESTING_IOMMU,
+                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
                           VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
-    int i;
+    int i, ret =3D -EINVAL;
=20
     for (i =3D 0; i < ARRAY_SIZE(iommu_types); i++) {
         if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
-            return iommu_types[i];
+            if (iommu_types[i] =3D=3D VFIO_TYPE1_NESTING_IOMMU && !want_ne=
sted) {
+                continue;
+            }
+            ret =3D iommu_types[i];
+            break;
         }
     }
-    error_setg(errp, "No available IOMMU models");
-    return -EINVAL;
+    if (ret < 0) {
+        error_setg(errp, "No available IOMMU models");
+    } else if (want_nested && ret !=3D VFIO_TYPE1_NESTING_IOMMU) {
+        error_setg(errp, "Nested mode requested but not supported");
+        ret =3D -EINVAL;
+    }
+    return ret;
 }
=20
 static int vfio_init_container(VFIOContainer *container, int group_fd,
-                               Error **errp)
+                               bool want_nested, Error **errp)
 {
     int iommu_type, ret;
=20
-    iommu_type =3D vfio_get_iommu_type(container, errp);
+    iommu_type =3D vfio_get_iommu_type(container, want_nested, errp);
     if (iommu_type < 0) {
         return iommu_type;
     }
@@ -1211,6 +1222,14 @@ static int vfio_connect_container(VFIOGroup *group, =
AddressSpace *as,
     VFIOContainer *container;
     int ret, fd;
     VFIOAddressSpace *space;
+    IOMMUMemoryRegion *iommu_mr;
+    bool nested =3D false;
+
+    if (as !=3D &address_space_memory && memory_region_is_iommu(as->root))=
 {
+        iommu_mr =3D IOMMU_MEMORY_REGION(as->root);
+        memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
+                                     (void *)&nested);
+    }
=20
     space =3D vfio_get_address_space(as);
=20
@@ -1272,12 +1291,13 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
=20
-    ret =3D vfio_init_container(container, group->fd, errp);
+    ret =3D vfio_init_container(container, group->fd, nested, errp);
     if (ret) {
         goto free_container_exit;
     }
=20
     switch (container->iommu_type) {
+    case VFIO_TYPE1_NESTING_IOMMU:
     case VFIO_TYPE1v2_IOMMU:
     case VFIO_TYPE1_IOMMU:
     {
--=20
2.20.1


