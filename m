Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE52C74A5B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958FC20863
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958FC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcw0-0007PQ-1G
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hlctd-0007eM-3n
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hlctb-0002ZY-V3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:30:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33590)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hlctY-0002Wx-3E; Thu, 11 Jul 2019 13:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4FDC2307D915;
 Thu, 11 Jul 2019 17:30:11 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E54EF5C1B4;
 Thu, 11 Jul 2019 17:30:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Thu, 11 Jul 2019 19:28:26 +0200
Message-Id: <20190711172845.31035-11-eric.auger@redhat.com>
In-Reply-To: <20190711172845.31035-1-eric.auger@redhat.com>
References: <20190711172845.31035-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 11 Jul 2019 17:30:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 10/29] memory: Introduce IOMMU Memory Region
 inject_faults API
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
Cc: drjones@redhat.com, yi.l.liu@intel.com, mst@redhat.com,
 jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com, peterx@redhat.com,
 alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new API allows to inject @count iommu_faults into
the IOMMU memory region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/exec/memory.h | 25 +++++++++++++++++++++++++
 memory.c              | 10 ++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 593ef947c6..d0de192887 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -54,6 +54,8 @@ struct MemoryRegionMmio {
     CPUWriteMemoryFunc *write[3];
 };
=20
+struct iommu_fault;
+
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
=20
 /* See address_space_translate: bit 0 is read, bit 1 is write.  */
@@ -342,6 +344,19 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+    /*
+     * Inject @count faults into the IOMMU memory region
+     *
+     * Optional method: if this method is not provided, then
+     * memory_region_injection_faults() will return -ENOENT
+     *
+     * @iommu: the IOMMU memory region to inject the faults in
+     * @count: number of faults to inject
+     * @buf: fault buffer
+     */
+    int (*inject_faults)(IOMMUMemoryRegion *iommu, int count,
+                         struct iommu_fault *buf);
 } IOMMUMemoryRegionClass;
=20
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1123,6 +1138,16 @@ int memory_region_iommu_attrs_to_index(IOMMUMemory=
Region *iommu_mr,
  */
 int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
=20
+/**
+ * memory_region_inject_faults : inject @count faults stored in @buf
+ *
+ * @iommu_mr: the IOMMU memory region
+ * @count: number of faults to be injected
+ * @buf: buffer containing the faults
+ */
+int memory_region_inject_faults(IOMMUMemoryRegion *iommu_mr, int count,
+                                struct iommu_fault *buf);
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/memory.c b/memory.c
index 90967b579d..d81525fe11 100644
--- a/memory.c
+++ b/memory.c
@@ -2000,6 +2000,16 @@ int memory_region_iommu_num_indexes(IOMMUMemoryReg=
ion *iommu_mr)
     return imrc->num_indexes(iommu_mr);
 }
=20
+int memory_region_inject_faults(IOMMUMemoryRegion *iommu_mr, int count,
+                                struct iommu_fault *buf)
+{
+    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_GET_CLASS(iommu=
_mr);
+    if (!imrc->inject_faults) {
+        return -ENOENT;
+    }
+    return imrc->inject_faults(iommu_mr, count, buf);
+}
+
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 {
     uint8_t mask =3D 1 << client;
--=20
2.20.1


