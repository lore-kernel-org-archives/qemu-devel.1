Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE88C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2466D2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2466D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33855 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtN3-0003RK-CB
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:25:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt47-0001yY-5E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt46-0004aD-3O
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt42-0004Xy-6M; Fri, 12 Apr 2019 06:05:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A3AA3001C60;
	Fri, 12 Apr 2019 10:05:41 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F081D19C65;
	Fri, 12 Apr 2019 10:05:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:42 +0200
Message-Id: <20190412100354.6409-16-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 12 Apr 2019 10:05:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 15/27] hw/arm/smmuv3: Fill the IOTLBEntry leaf
 field on NH_VA invalidation
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
Cc: yi.l.liu@intel.com, mst@redhat.com, jean-philippe.brucker@arm.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412100342.FC3LWk4frdYVegGLO1Eo2uccGz4DNvopLdT_enYGYaM@z>

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
index b6eb61304d..f2f3724686 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -792,8 +792,7 @@ epilogue:
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
-                               int asid,
-                               dma_addr_t iova)
+                               int asid, dma_addr_t iova, bool leaf)
 {
     SMMUDevice *sdev =3D container_of(mr, SMMUDevice, iommu);
     SMMUEventInfo event =3D {};
@@ -823,12 +822,14 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *m=
r,
     entry.addr_mask =3D (1 << tt->granule_sz) - 1;
     entry.perm =3D IOMMU_NONE;
     entry.arch_id =3D asid;
+    entry.leaf =3D leaf;
=20
     memory_region_iotlb_notify_one(n, &entry);
 }
=20
 /* invalidate an asid/iova tuple in all mr's */
-static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t=
 iova)
+static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid,
+                                      dma_addr_t iova, bool leaf)
 {
     SMMUDevice *sdev;
=20
@@ -840,7 +841,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, i=
nt asid, dma_addr_t iova)
=20
         IOMMU_NOTIFIER_FOREACH(n, mr) {
             if (n->notifier_flags & IOMMU_NOTIFIER_IOTLB_UNMAP) {
-                smmuv3_notify_iova(mr, n, asid, iova);
+                smmuv3_notify_iova(mr, n, asid, iova, leaf);
             }
         }
     }
@@ -979,9 +980,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
@@ -993,7 +995,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, ui=
nt32_t perc) "Config cache HIT for sid %d (hits=3D%d, misses=3D%d, hit ra=
te=3D%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, u=
int32_t perc) "Config cache MISS for sid %d (hits=3D%d, misses=3D%d, hit =
rate=3D%d)"
 smmuv3_cmdq_tlbi_nh_va(int vmid, int asid, uint64_t addr, bool leaf) "vm=
id =3D%d asid =3D%d addr=3D0x%"PRIx64" leaf=3D%d"
-smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr) "vmid =3D%d addr=3D0x%"=
PRIx64
+smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr, bool leaf) "vmid =3D%d =
addr=3D0x%"PRIx64" leaf=3D%d"
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=3D%d"
 smmu_iotlb_cache_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_=
t miss, uint32_t p) "IOTLB cache HIT asid=3D%d addr=3D0x%"PRIx64" hit=3D%=
d miss=3D%d hit rate=3D%d"
--=20
2.20.1


