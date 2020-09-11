Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E49CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8189221ED
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="laj7zX+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8189221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmFV-0001Rz-Q9
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kGmEi-0000Gp-QO; Fri, 11 Sep 2020 12:49:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kGmEg-0003PF-Q2; Fri, 11 Sep 2020 12:49:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08BGYdkn080509; Fri, 11 Sep 2020 12:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=nGBiEEpsxp30x8Ee8UDnroA0IMwpuDTcpw8muL+CzMY=;
 b=laj7zX+mdU4n8xG7V7ikjhl4rPOVpgUkjhUobIlM1flUWNSO/qBOlOcEGhdDI2Yj0KAM
 sniVrbykp+LFoJli8kx0u469YorW6P0pC87SIbQhsCN1AbhQx0zooyminI1Rxd53qlVQ
 CAZmRVsrI6duS/aNHgwrIaBc1XB7DkUZ9jraDXCkQOnADSOu29l7m/JYtW06qbMQHOUu
 qvEMmSgebJvFA2YefgaUIJb4kOeX+v5QPI8OmHbmzaggS2FR/X8yQsrmFvKqbpq+j1qp
 gJJqajWWmNQ8pMt/HKY0OGSavXpVUg6tgQsEpTCBiO3tRwzMk9gtD7POiGsLNN3RcMmz Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33gcrugem6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 12:49:16 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BGYmFV081573;
 Fri, 11 Sep 2020 12:49:16 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33gcrugekq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 12:49:16 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BGm1tx017348;
 Fri, 11 Sep 2020 16:49:15 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 33d46ngaq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 16:49:15 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08BGn9W529819222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2020 16:49:09 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27F3C6A054;
 Fri, 11 Sep 2020 16:49:13 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18FA36A051;
 Fri, 11 Sep 2020 16:49:12 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.91.207])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2020 16:49:11 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: alex.williamson@redhat.com, cohuck@redhat.com
Subject: [PATCH 1/3] vfio: Get DMA limit information
Date: Fri, 11 Sep 2020 12:49:05 -0400
Message-Id: <1599842947-4051-2-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1599842947-4051-1-git-send-email-mjrosato@linux.ibm.com>
References: <1599842947-4051-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-11_08:2020-09-10,
 2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 suspectscore=2 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110131
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 12:49:17
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The underlying host may be limiting the number of outstanding DMA
requests for type 1 IOMMU.  Determine if this is the case and if
so retrieve the number of outstanding mappings allowed.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/vfio/common.c              | 76 ++++++++++++++++++++++++++++++++++++++-----
 include/hw/vfio/vfio-common.h |  1 +
 2 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3335714..84ac3be 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -844,6 +844,41 @@ vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
     return NULL;
 }
 
+static struct vfio_info_cap_header *
+vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
+{
+    struct vfio_info_cap_header *hdr;
+    void *ptr = info;
+
+    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
+        return NULL;
+    }
+
+    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
+        if (hdr->id == id) {
+            return hdr;
+        }
+    }
+
+    return NULL;
+}
+
+static unsigned int vfio_get_info_dma_limit(struct vfio_iommu_type1_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_dma_limit *cap;
+
+    /* If the capability cannot be found, assume no DMA limiting */
+    hdr = vfio_get_iommu_type1_info_cap(info,
+                                        VFIO_IOMMU_TYPE1_INFO_DMA_LIMIT);
+    if (hdr == NULL) {
+        return 0;
+    }
+
+    cap = (void *) hdr;
+    return cap->max;
+}
+
 static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                           struct vfio_region_info *info)
 {
@@ -1285,7 +1320,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     case VFIO_TYPE1v2_IOMMU:
     case VFIO_TYPE1_IOMMU:
     {
-        struct vfio_iommu_type1_info info;
+        struct vfio_iommu_type1_info *info;
+        uint32_t argsz;
 
         /*
          * FIXME: This assumes that a Type1 IOMMU can map any 64-bit
@@ -1294,15 +1330,37 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
          * existing Type1 IOMMUs generally support any IOVA we're
          * going to actually try in practice.
          */
-        info.argsz = sizeof(info);
-        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, &info);
-        /* Ignore errors */
-        if (ret || !(info.flags & VFIO_IOMMU_INFO_PGSIZES)) {
-            /* Assume 4k IOVA page size */
-            info.iova_pgsizes = 4096;
+        argsz = sizeof(struct vfio_iommu_type1_info);
+        info = g_malloc0(argsz);
+        info->argsz = argsz;
+        /*
+         * If the specified argsz is not large enough to contain all
+         * capabilities it will be updated upon return.  In this case
+         * use the updated value to get the entire capability chain.
+         */
+        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
+        if (argsz != info->argsz) {
+            argsz = info->argsz;
+            info = g_realloc(info, argsz);
+            info->argsz = argsz;
+            ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
+        }
+        /* Set defaults on error */
+        if (ret) {
+            /* Assume 4k IOVA page size and no DMA limiting */
+            info->iova_pgsizes = 4096;
+            container->dma_limit = 0;
+        } else {
+            if (!(info->flags & VFIO_IOMMU_INFO_PGSIZES)) {
+                /* Assume 4k IOVA page size */
+                info->iova_pgsizes = 4096;
+            }
+            /* Obtain DMA limit from capability chain */
+            container->dma_limit = vfio_get_info_dma_limit(info);
         }
-        vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
-        container->pgsizes = info.iova_pgsizes;
+        vfio_host_win_add(container, 0, (hwaddr)-1, info->iova_pgsizes);
+        container->pgsizes = info->iova_pgsizes;
+        g_free(info);
         break;
     }
     case VFIO_SPAPR_TCE_v2_IOMMU:
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c78f3ff..0ee4af0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -74,6 +74,7 @@ typedef struct VFIOContainer {
     Error *error;
     bool initialized;
     unsigned long pgsizes;
+    unsigned int dma_limit;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
-- 
1.8.3.1


