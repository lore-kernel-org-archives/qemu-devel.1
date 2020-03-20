Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B02C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2032072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW/6ULhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2032072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLDR-00006P-C6
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFL3W-000148-3T
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFL3U-0000Ca-QT
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFL3U-0000CR-Ln
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vzp+F6vAldmJw6exxR9tZgfk3Xr/nfVts1Z1VwA0O4=;
 b=XW/6ULhRWRDvK8C5uCzO2IanBJBEHJHQWp7fLCgTGr59eN30/eSciynf1bTs4bMfrAyb++
 I+Y25AsCG5es9reA0tyd6B9i7qgWfxgThgmXT0KgGNaHv0OXLKh3PF9Zk2tRJjkl5mLdN8
 16JaHv/nK7n26/LjlVq/KEz4+0G/1hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-vZZY1qEpMFqQ6-rAUBm-9Q-1; Fri, 20 Mar 2020 13:03:30 -0400
X-MC-Unique: vZZY1qEpMFqQ6-rAUBm-9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FF98100550D;
 Fri, 20 Mar 2020 17:03:28 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46FB016D22;
 Fri, 20 Mar 2020 17:03:17 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 21/24] hw/arm/smmuv3: Fill the IOTLBEntry leaf field on NH_VA
 invalidation
Date: Fri, 20 Mar 2020 17:58:37 +0100
Message-Id: <20200320165840.30057-22-eric.auger@redhat.com>
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

Let's propagate the leaf attribute throughout the invalidation path.
This hint is used to reduce the scope of the invalidations to the
last level of translation. Not enforcing it induces large performance
penalties in nested mode.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c     | 16 +++++++++-------
 hw/arm/trace-events |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 66603c1fde..edd76bce4c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -811,8 +811,7 @@ epilogue:
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
-                               int asid,
-                               dma_addr_t iova)
+                               int asid, dma_addr_t iova, bool leaf)
 {
     SMMUDevice *sdev =3D container_of(mr, SMMUDevice, iommu);
     SMMUEventInfo event =3D {.inval_ste_allowed =3D true};
@@ -839,12 +838,14 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
     entry.addr_mask =3D (1 << tt->granule_sz) - 1;
     entry.perm =3D IOMMU_NONE;
     entry.arch_id =3D asid;
+    entry.leaf =3D leaf;
=20
     memory_region_notify_one(n, &entry);
 }
=20
 /* invalidate an asid/iova tuple in all mr's */
-static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t i=
ova)
+static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid,
+                                      dma_addr_t iova, bool leaf)
 {
     SMMUDevice *sdev;
=20
@@ -855,7 +856,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int=
 asid, dma_addr_t iova)
         trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova);
=20
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, iova);
+            smmuv3_notify_iova(mr, n, asid, iova, leaf);
         }
     }
 }
@@ -993,9 +994,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         {
             dma_addr_t addr =3D CMD_ADDR(&cmd);
             uint16_t vmid =3D CMD_VMID(&cmd);
+            bool leaf =3D CMD_LEAF(&cmd);
=20
-            trace_smmuv3_cmdq_tlbi_nh_vaa(vmid, addr);
-            smmuv3_inv_notifiers_iova(bs, -1, addr);
+            trace_smmuv3_cmdq_tlbi_nh_vaa(vmid, addr, leaf);
+            smmuv3_inv_notifiers_iova(bs, -1, addr, leaf);
             smmu_iotlb_inv_all(bs);
             break;
         }
@@ -1007,7 +1009,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             bool leaf =3D CMD_LEAF(&cmd);
=20
             trace_smmuv3_cmdq_tlbi_nh_va(vmid, asid, addr, leaf);
-            smmuv3_inv_notifiers_iova(bs, asid, addr);
+            smmuv3_inv_notifiers_iova(bs, asid, addr, leaf);
             smmu_iotlb_inv_iova(bs, asid, addr);
             break;
         }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 0acedcedc6..3809005cba 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -43,7 +43,7 @@ smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid =3D %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint=
32_t perc) "Config cache HIT for sid %d (hits=3D%d, misses=3D%d, hit rate=
=3D%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uin=
t32_t perc) "Config cache MISS for sid %d (hits=3D%d, misses=3D%d, hit rate=
=3D%d)"
 smmuv3_cmdq_tlbi_nh_va(int vmid, int asid, uint64_t addr, bool leaf) "vmid=
 =3D%d asid =3D%d addr=3D0x%"PRIx64" leaf=3D%d"
-smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr) "vmid =3D%d addr=3D0x%"PR=
Ix64
+smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr, bool leaf) "vmid =3D%d ad=
dr=3D0x%"PRIx64" leaf=3D%d"
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=3D%d"
 smmu_iotlb_cache_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t =
miss, uint32_t p) "IOTLB cache HIT asid=3D%d addr=3D0x%"PRIx64" hit=3D%d mi=
ss=3D%d hit rate=3D%d"
--=20
2.20.1


