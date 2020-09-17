Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFF8C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16F52075B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IlMQ03Lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16F52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIurB-0001GD-Mr
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIumd-00032l-U7; Thu, 17 Sep 2020 10:21:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIumb-0003E0-Mm; Thu, 17 Sep 2020 10:21:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08HEKWrQ089509; Thu, 17 Sep 2020 10:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=HrOG73Xu/7JUcc3vBp0EmxzkDtGg1qQbREzhmSBIwoc=;
 b=IlMQ03Lt5NFVED8y0zkQO0cs97XC92IPZEq0mgcPP7AD3qbZAQpy9yvGqCReS/NbJNJf
 NZM6N8GvQE34zaYTgb399dGvI95FA1SQM8W623yrfr3ObI/Gw1EdqwxkBJ086xVk2YtK
 0EUtCya5tjYU/e8xIRJYtAb+dVRR4hsgHQEm53gFfMy61tUrEI6buCgcEDB9wGTtITbh
 PKCB13PeUrH5Y4YJBAXMxLt4T5pLhHmLZaMRZeYWaXZZkekN3gtYuWjp35YNgROfP5HS
 mSTKUtWokwKfJd/cdyeGLsW1zCKCsmxGFzFRkGptclw6ZfECShNmFSkxLhoUyfRMD2iU KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33m9fmr0fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 10:21:08 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HEL1aw092477;
 Thu, 17 Sep 2020 10:21:07 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33m9fmr0f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 10:21:07 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HEHqFC008209;
 Thu, 17 Sep 2020 14:21:06 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04wdc.us.ibm.com with ESMTP id 33k6hecudh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 14:21:06 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08HEL5TC40829212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2020 14:21:05 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEA0DAC059;
 Thu, 17 Sep 2020 14:21:05 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A65B3AC05B;
 Thu, 17 Sep 2020 14:21:01 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2020 14:21:01 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: alex.williamson@redhat.com, cohuck@redhat.com
Subject: [PATCH v4 3/5] vfio: Find DMA available capability
Date: Thu, 17 Sep 2020 10:20:43 -0400
Message-Id: <1600352445-21110-4-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600352445-21110-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600352445-21110-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-17_09:2020-09-16,
 2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=868
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170104
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 10:20:55
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mst@redhat.com, pbonzini@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The underlying host may be limiting the number of outstanding DMA
requests for type 1 IOMMU.  Add helper functions to check for the
DMA available capability and retrieve the current number of DMA
mappings allowed.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/common.c              | 31 +++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e47a4d7..20914bf 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -849,6 +849,37 @@ vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
     return vfio_get_cap((void *)info, info->cap_offset, id);
 }
 
+static struct vfio_info_cap_header *
+vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
+{
+    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
+        return NULL;
+    }
+
+    return vfio_get_cap((void *)info, info->cap_offset, id);
+}
+
+bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
+                             unsigned int *avail)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_dma_avail *cap;
+
+    /* If the capability cannot be found, assume no DMA limiting */
+    hdr = vfio_get_iommu_type1_info_cap(info,
+                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
+    if (hdr == NULL) {
+        return false;
+    }
+
+    if (avail != NULL) {
+        cap = (void *) hdr;
+        *avail = cap->avail;
+    }
+
+    return true;
+}
+
 static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                           struct vfio_region_info *info)
 {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c78f3ff..661a380 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -178,6 +178,8 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
+bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
+                             unsigned int *avail);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
-- 
1.8.3.1


