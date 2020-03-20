Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C788EC4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982FA20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkKyj4xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982FA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLEr-0002PD-Qn
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFL3s-0001cE-6c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFL3q-0000ni-VA
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFL3q-0000m8-RQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWww6+PqmJiAFIVmlvqtkmV1JZxTd/zcad5G5lbKagI=;
 b=JkKyj4xsWJ5NY81+uPu5KxECysZoR3rIHNq5W30Ts1ZCpB7vh6ZN2ZEvZ8AZWBpw+ZEqWJ
 1wIIRTCFfCLMH1wKPnE0bNCyXBOUrpK1u7bFh5zVaKp9FcNopv5BdkrOuWeBbrd+HlyLue
 f7l2L8ajUX448fK37l7LQzFpUNFS/uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-c8zM9QDVOAmhH37NbACyAQ-1; Fri, 20 Mar 2020 13:03:50 -0400
X-MC-Unique: c8zM9QDVOAmhH37NbACyAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FF16100550E;
 Fri, 20 Mar 2020 17:03:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7338D19488;
 Fri, 20 Mar 2020 17:03:36 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 23/24] hw/arm/smmuv3: Implement fault injection
Date: Fri, 20 Mar 2020 17:58:39 +0100
Message-Id: <20200320165840.30057-24-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-1-eric.auger@redhat.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

We convert iommu_fault structs received from the kernel
into the data struct used by the emulation code and record
the evnts into the virtual event queue.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- fix compil issue on mingw

Exhaustive mapping remains to be done
---
 hw/arm/smmuv3.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7a805030e2..6db3d2f218 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1569,6 +1569,76 @@ static int smmuv3_get_attr(IOMMUMemoryRegion *iommu,
     return -EINVAL;
 }
=20
+struct iommu_fault;
+
+static inline int
+smmuv3_inject_faults(IOMMUMemoryRegion *iommu_mr, int count,
+                     struct iommu_fault *buf)
+{
+#ifdef __linux__
+    SMMUDevice *sdev =3D container_of(iommu_mr, SMMUDevice, iommu);
+    SMMUv3State *s3 =3D sdev->smmu;
+    uint32_t sid =3D smmu_get_sid(sdev);
+    int i;
+
+    for (i =3D 0; i < count; i++) {
+        SMMUEventInfo info =3D {};
+        struct iommu_fault_unrecoverable *record;
+
+        if (buf[i].type !=3D IOMMU_FAULT_DMA_UNRECOV) {
+            continue;
+        }
+
+        info.sid =3D sid;
+        record =3D &buf[i].event;
+
+        switch (record->reason) {
+        case IOMMU_FAULT_REASON_PASID_INVALID:
+            info.type =3D SMMU_EVT_C_BAD_SUBSTREAMID;
+            /* TODO further fill info.u.c_bad_substream */
+            break;
+        case IOMMU_FAULT_REASON_PASID_FETCH:
+            info.type =3D SMMU_EVT_F_CD_FETCH;
+            break;
+        case IOMMU_FAULT_REASON_BAD_PASID_ENTRY:
+            info.type =3D SMMU_EVT_C_BAD_CD;
+            /* TODO further fill info.u.c_bad_cd */
+            break;
+        case IOMMU_FAULT_REASON_WALK_EABT:
+            info.type =3D SMMU_EVT_F_WALK_EABT;
+            info.u.f_walk_eabt.addr =3D record->addr;
+            info.u.f_walk_eabt.addr2 =3D record->fetch_addr;
+            break;
+        case IOMMU_FAULT_REASON_PTE_FETCH:
+            info.type =3D SMMU_EVT_F_TRANSLATION;
+            info.u.f_translation.addr =3D record->addr;
+            break;
+        case IOMMU_FAULT_REASON_OOR_ADDRESS:
+            info.type =3D SMMU_EVT_F_ADDR_SIZE;
+            info.u.f_addr_size.addr =3D record->addr;
+            break;
+        case IOMMU_FAULT_REASON_ACCESS:
+            info.type =3D SMMU_EVT_F_ACCESS;
+            info.u.f_access.addr =3D record->addr;
+            break;
+        case IOMMU_FAULT_REASON_PERMISSION:
+            info.type =3D SMMU_EVT_F_PERMISSION;
+            info.u.f_permission.addr =3D record->addr;
+            break;
+        default:
+            warn_report("%s Unexpected fault reason received from host: %d=
",
+                        __func__, record->reason);
+            continue;
+        }
+
+        smmuv3_record_event(s3, &info);
+    }
+    return 0;
+#else
+    return -1;
+#endif
+}
+
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
                                                   void *data)
 {
@@ -1577,6 +1647,7 @@ static void smmuv3_iommu_memory_region_class_init(Obj=
ectClass *klass,
     imrc->translate =3D smmuv3_translate;
     imrc->notify_flag_changed =3D smmuv3_notify_flag_changed;
     imrc->get_attr =3D smmuv3_get_attr;
+    imrc->inject_faults =3D smmuv3_inject_faults;
 }
=20
 static const TypeInfo smmuv3_type_info =3D {
--=20
2.20.1


