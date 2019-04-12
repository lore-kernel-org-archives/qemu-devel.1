Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D463C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C09F2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C09F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtOC-0004dM-E6
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:26:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt55-0003Kr-OX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt54-0005Qb-SD
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt52-0005OJ-JR; Fri, 12 Apr 2019 06:06:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1489C062ED6;
	Fri, 12 Apr 2019 10:06:43 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3A72119C65;
	Fri, 12 Apr 2019 10:06:41 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:50 +0200
Message-Id: <20190412100354.6409-24-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 12 Apr 2019 10:06:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 23/27] memory: Introduce IOMMU Memory Region
 inject_faults API
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
Message-ID: <20190412100350.YDRIRQKgUzsbizQTRSLbIBb6IhFCHw4IEgsMXW7uLjE@z>

This new API allows to inject @count iommu_faults into
the IOMMU memory region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/exec/memory.h | 26 ++++++++++++++++++++++++++
 memory.c              | 12 ++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index aedebc8471..6262de1684 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -400,6 +400,20 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+#ifdef CONFIG_LINUX
+    /* Inject @count faults into the IOMMU memory region
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
+#endif
 } IOMMUMemoryRegionClass;
=20
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1216,6 +1230,18 @@ int memory_region_iommu_attrs_to_index(IOMMUMemory=
Region *iommu_mr,
  */
 int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
=20
+#ifdef CONFIG_LINUX
+/**
+ * memory_region_inject_faults : inject @count faults stored in @buf
+ *
+ * @iommu_mr: the IOMMU memory region
+ * @count: number of faults to be injected
+ * @buf: buffer containing the faults
+ */
+int memory_region_inject_faults(IOMMUMemoryRegion *iommu_mr, int count,
+                                struct iommu_fault *buf);
+#endif
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/memory.c b/memory.c
index 8cd3c65872..2eac24cb80 100644
--- a/memory.c
+++ b/memory.c
@@ -2037,6 +2037,18 @@ int memory_region_iommu_num_indexes(IOMMUMemoryReg=
ion *iommu_mr)
     return imrc->num_indexes(iommu_mr);
 }
=20
+#ifdef CONFIG_LINUX
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
+#endif
+
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 {
     uint8_t mask =3D 1 << client;
--=20
2.20.1


