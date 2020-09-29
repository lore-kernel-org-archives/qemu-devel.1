Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223FBC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A216206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfOv4JZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A216206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBSq-0002oN-NJ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNBQn-0000vn-0h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNBQk-0000EU-Ke
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:56:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601369772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOpLCl232BV1cFhR67SrTPAGiW78Gwt9UKIEAZc/kEI=;
 b=LfOv4JZV//to2xJWLBBYC/RPt8++TNdFYwUZ8DWE3nJYrd3ARKHN0sHooWQAO2M1n60o6H
 FR0ZcFp4VpBynwcI9FLvdYP7ycrcP+TzkvfvnryONa/lLQhrG1TlMu1ih5F2yR+n3of0u9
 suioLFfRk5BNzwFXaqIyuOOTYpuqgpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-sZ2w6PzuN4u-EoQzHRny-A-1; Tue, 29 Sep 2020 04:56:11 -0400
X-MC-Unique: sZ2w6PzuN4u-EoQzHRny-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F14E5104D3E4;
 Tue, 29 Sep 2020 08:56:09 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D3B83782;
 Tue, 29 Sep 2020 08:56:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 philmd@redhat.com, alex.williamson@redhat.com
Subject: [PATCH v2 1/2] util/vfio-helpers: Collect IOVA reserved regions
Date: Tue, 29 Sep 2020 10:55:49 +0200
Message-Id: <20200929085550.30926-2-eric.auger@redhat.com>
In-Reply-To: <20200929085550.30926-1-eric.auger@redhat.com>
References: <20200929085550.30926-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, kwolf@redhat.com, cohuck@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The IOVA allocator currently ignores host reserved regions.
As a result some chosen IOVAs may collide with some of them,
resulting in VFIO MAP_DMA errors later on. This happens on ARM
where the MSI reserved window quickly is encountered:
[0x8000000, 0x8100000]. since 5.4 kernel, VFIO returns the usable
IOVA regions. So let's enumerate them in the prospect to avoid
them, later on.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- fix the loop on caps
- set s->usable_iova_ranges=NULL to avoid double free
---
 util/vfio-helpers.c | 72 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 583bdfb36f..ba0ee6e21c 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -40,6 +40,11 @@ typedef struct {
     uint64_t iova;
 } IOVAMapping;
 
+struct IOVARange {
+    uint64_t start;
+    uint64_t end;
+};
+
 struct QEMUVFIOState {
     QemuMutex lock;
 
@@ -49,6 +54,8 @@ struct QEMUVFIOState {
     int device;
     RAMBlockNotifier ram_notifier;
     struct vfio_region_info config_region_info, bar_region_info[6];
+    struct IOVARange *usable_iova_ranges;
+    uint8_t nb_iova_ranges;
 
     /* These fields are protected by @lock */
     /* VFIO's IO virtual address space is managed by splitting into a few
@@ -236,6 +243,35 @@ static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int
     return ret == size ? 0 : -errno;
 }
 
+static void collect_usable_iova_ranges(QEMUVFIOState *s, void *buf)
+{
+    struct vfio_iommu_type1_info *info = (struct vfio_iommu_type1_info *)buf;
+    struct vfio_info_cap_header *cap = (void *)buf + info->cap_offset;
+    struct vfio_iommu_type1_info_cap_iova_range *cap_iova_range;
+    int i;
+
+    while (cap->id != VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE) {
+        if (!cap->next) {
+            return;
+        }
+        cap = (struct vfio_info_cap_header *)(buf + cap->next);
+    }
+
+    cap_iova_range = (struct vfio_iommu_type1_info_cap_iova_range *)cap;
+
+    s->nb_iova_ranges = cap_iova_range->nr_iovas;
+    if (s->nb_iova_ranges > 1) {
+        s->usable_iova_ranges =
+            g_realloc(s->usable_iova_ranges,
+                      s->nb_iova_ranges * sizeof(struct IOVARange));
+    }
+
+    for (i = 0; i < s->nb_iova_ranges; i++) {
+        s->usable_iova_ranges[i].start = cap_iova_range->iova_ranges[i].start;
+        s->usable_iova_ranges[i].end = cap_iova_range->iova_ranges[i].end;
+    }
+}
+
 static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
                               Error **errp)
 {
@@ -243,10 +279,13 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     int i;
     uint16_t pci_cmd;
     struct vfio_group_status group_status = { .argsz = sizeof(group_status) };
-    struct vfio_iommu_type1_info iommu_info = { .argsz = sizeof(iommu_info) };
+    struct vfio_iommu_type1_info *iommu_info = NULL;
+    size_t iommu_info_size = sizeof(*iommu_info);
     struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
     char *group_file = NULL;
 
+    s->usable_iova_ranges = NULL;
+
     /* Create a new container */
     s->container = open("/dev/vfio/vfio", O_RDWR);
 
@@ -310,13 +349,35 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         goto fail;
     }
 
+    iommu_info = g_malloc0(iommu_info_size);
+    iommu_info->argsz = iommu_info_size;
+
     /* Get additional IOMMU info */
-    if (ioctl(s->container, VFIO_IOMMU_GET_INFO, &iommu_info)) {
+    if (ioctl(s->container, VFIO_IOMMU_GET_INFO, iommu_info)) {
         error_setg_errno(errp, errno, "Failed to get IOMMU info");
         ret = -errno;
         goto fail;
     }
 
+    /*
+     * if the kernel does not report usable IOVA regions, choose
+     * the legacy [QEMU_VFIO_IOVA_MIN, QEMU_VFIO_IOVA_MAX -1] region
+     */
+    s->nb_iova_ranges = 1;
+    s->usable_iova_ranges = g_new0(struct IOVARange, 1);
+    s->usable_iova_ranges[0].start = QEMU_VFIO_IOVA_MIN;
+    s->usable_iova_ranges[0].end = QEMU_VFIO_IOVA_MAX - 1;
+
+    if (iommu_info->argsz > iommu_info_size) {
+        iommu_info_size = iommu_info->argsz;
+        iommu_info = g_realloc(iommu_info, iommu_info_size);
+        if (ioctl(s->container, VFIO_IOMMU_GET_INFO, iommu_info)) {
+            ret = -errno;
+            goto fail;
+        }
+        collect_usable_iova_ranges(s, iommu_info);
+    }
+
     s->device = ioctl(s->group, VFIO_GROUP_GET_DEVICE_FD, device);
 
     if (s->device < 0) {
@@ -365,8 +426,13 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     if (ret) {
         goto fail;
     }
+    g_free(iommu_info);
     return 0;
 fail:
+    g_free(s->usable_iova_ranges);
+    s->usable_iova_ranges = NULL;
+    s->nb_iova_ranges = 0;
+    g_free(iommu_info);
     close(s->group);
 fail_container:
     close(s->container);
@@ -716,6 +782,8 @@ void qemu_vfio_close(QEMUVFIOState *s)
         qemu_vfio_undo_mapping(s, &s->mappings[i], NULL);
     }
     ram_block_notifier_remove(&s->ram_notifier);
+    g_free(s->usable_iova_ranges);
+    s->nb_iova_ranges = 0;
     qemu_vfio_reset(s);
     close(s->device);
     close(s->group);
-- 
2.21.3


