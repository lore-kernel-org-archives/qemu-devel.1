Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24606C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2933206E9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PArd/K+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2933206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClR4-00029o-31
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2341787188=bbhushan2@marvell.com>)
 id 1jCeYB-00075J-Nh
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2341787188=bbhushan2@marvell.com>)
 id 1jCeYA-0004pH-EP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:16:07 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2341787188=bbhushan2@marvell.com>)
 id 1jCeY8-0004k4-5R; Fri, 13 Mar 2020 03:16:04 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02D79r9J009668; Fri, 13 Mar 2020 00:16:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=d2iWCXJz4dJ2g2X4/WjavG5MxgCZeaMWghSwegVnILA=;
 b=PArd/K+BkD/XsObelYEAfWosEeMZz1gcSAQ8drWcaPIpaWJZD78821PON1ooeMvKtyyp
 AOEPT/xXKwhq3PUxu1n6XWhLO0UH9uFkwy0mUl2ub0W/rdpo/jVSCCIgW+WlNsMa1X09
 jj/BfEZfQ+Eb2EzDaKP1wBg1GZB1/bAafObBTAGpFZ123Klx6KWd4f8aUI02Dbwk3JU5
 yPI2x63mqGlpAKhm7sFAAwhT6Vhc0aVMLKus6JP5RTYPjybMCPKcG/4/hvBD01wL54rl
 xS8x7WxtWNm46nO9Q7ao5ZykO1WqnAEbk4D1e498qXDyuV1X7Vr06kdC9UQKNeGSe1Q9 QA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 2yqt7f2s70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2020 00:16:02 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Mar
 2020 00:15:59 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Mar 2020 00:15:56 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <eric.auger.pro@gmail.com>, <alex.williamson@redhat.com>,
 <kevin.tian@intel.com>, <mst@redhat.com>, <tnowicki@marvell.com>,
 <drjones@redhat.com>, <linuc.decode@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <bharatb.linux@gmail.com>
Subject: [PATCH v6 5/5] virtio-iommu: add iommu notifier memory-region
Date: Fri, 13 Mar 2020 12:45:32 +0530
Message-ID: <20200313071532.26533-5-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313071532.26533-1-bbhushan2@marvell.com>
References: <20200313071532.26533-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_02:2020-03-11,
 2020-03-13 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.156.173
X-Mailman-Approved-At: Fri, 13 Mar 2020 10:36:05 -0400
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
Cc: Bharat Bhushan <bbhushan2@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finally add notify_flag_changed() to for memory-region
access flag iommu flag change notifier

Finally add the memory notifier

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 hw/virtio/trace-events   |  2 ++
 hw/virtio/virtio-iommu.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8bae651191..a486adcf6d 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -76,3 +76,5 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uin
 virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, uint64_t map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64
 virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64
 virtio_iommu_remap(uint64_t iova, uint64_t pa, uint64_t size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
+virtio_iommu_notify_flag_add(const char *iommu) "Add virtio-iommu notifier node for memory region %s"
+virtio_iommu_notify_flag_del(const char *iommu) "Del virtio-iommu notifier node for memory region %s"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index bcc9895b76..7744410f72 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -803,6 +803,37 @@ unlock:
     qemu_mutex_unlock(&s->mutex);
 }
 
+static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
+                                             IOMMUNotifierFlag old,
+                                             IOMMUNotifierFlag new,
+                                             Error **errp)
+{
+    IOMMUDevice *sdev = container_of(iommu_mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    VirtioIOMMUNotifierNode *node = NULL;
+    VirtioIOMMUNotifierNode *next_node = NULL;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        trace_virtio_iommu_notify_flag_add(iommu_mr->parent_obj.name);
+        node = g_malloc0(sizeof(*node));
+        node->iommu_dev = sdev;
+        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
+        return 0;
+    }
+
+    /* update notifier node with new flags */
+    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
+        if (node->iommu_dev == sdev) {
+            if (new == IOMMU_NOTIFIER_NONE) {
+                trace_virtio_iommu_notify_flag_del(iommu_mr->parent_obj.name);
+                QLIST_REMOVE(node, next);
+                g_free(node);
+            }
+        }
+    }
+    return 0;
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1020,6 +1051,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = virtio_iommu_translate;
     imrc->replay = virtio_iommu_replay;
+    imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
 }
 
 static const TypeInfo virtio_iommu_info = {
-- 
2.17.1


