Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A92CC072B1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 11:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6682120883
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 11:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6682120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVECP-00036N-Jk
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 07:53:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVE2m-0003sB-Vl
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVE2m-0003wl-4k
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hVE2k-0003uw-0s; Mon, 27 May 2019 07:43:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C1F05946A;
	Mon, 27 May 2019 11:43:53 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38D285D962;
	Mon, 27 May 2019 11:43:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Mon, 27 May 2019 13:41:49 +0200
Message-Id: <20190527114203.2762-14-eric.auger@redhat.com>
In-Reply-To: <20190527114203.2762-1-eric.auger@redhat.com>
References: <20190527114203.2762-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 27 May 2019 11:43:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 13/27] hw/arm/smmuv3: Implement dummy replay
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
Cc: drjones@redhat.com, yi.l.liu@intel.com, mst@redhat.com,
	jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default implementation of memory_region_iommu_replay() shall
not be used as it forces the translation of the whole RAM range.
The purpose of this function is to update the shadow page tables.
However in case of nested stage, there is no shadow page table so
we can simply return.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 96d4147533..8db605adab 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1507,6 +1507,11 @@ static int smmuv3_get_attr(IOMMUMemoryRegion *iomm=
u,
     return -EINVAL;
 }
=20
+static inline void
+smmuv3_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
+{
+}
+
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
                                                   void *data)
 {
@@ -1515,6 +1520,7 @@ static void smmuv3_iommu_memory_region_class_init(O=
bjectClass *klass,
     imrc->translate =3D smmuv3_translate;
     imrc->notify_flag_changed =3D smmuv3_notify_flag_changed;
     imrc->get_attr =3D smmuv3_get_attr;
+    imrc->replay =3D smmuv3_replay;
 }
=20
 static const TypeInfo smmuv3_type_info =3D {
--=20
2.20.1


