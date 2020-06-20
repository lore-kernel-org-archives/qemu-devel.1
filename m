Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F1C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78CF246A0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CgIuFMoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78CF246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkeF-0002pZ-5L
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 17:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkXG-00064D-7c
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:56:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkXD-0000Rq-PQ
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:56:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eee77990000>; Sat, 20 Jun 2020 13:54:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Sat, 20 Jun 2020 13:56:18 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Sat, 20 Jun 2020 13:56:18 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 20 Jun
 2020 20:56:05 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Sat, 20 Jun 2020 20:55:57 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v25 11/17] vfio: Get migration capability flags for
 container
Date: Sun, 21 Jun 2020 01:51:20 +0530
Message-ID: <1592684486-18511-12-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592686489; bh=aKZUgPnC6agty/TggaOBTbqItryyZyuaUmorDKodvOQ=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=CgIuFMoB30DuUrOaulsFZljPpbJvFjejPUPWjJLFvKHkkiIFVUMyaXz+d5fN0K9dT
 FCJCPO2U1ORkHCnaqJvkOFFeHLRDPtFSYomrHUPKyoldhneGTcUvHNaZ9I58QCzch7
 2J9+AJy5q72es/kDT2VgLTm/tnAf2mqkenBelQdyj7gJ6+Mb94bvl699yCWj/jEGMd
 zoj8ViGIFWOuAWw5m1utdyOuJKffzhb2kO+5688HhI95VypyjbGur3ppUj9OL/8Rkh
 9qBU0xg4AmBghel1D8vhSr7rTPVgGEjv8cgZ/rhEhEQb8W1Q2cKu174J+lswGXPgQR
 ScznLOSBCQaZg==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 16:54:43
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, Eric Auger <eric.auger@redhat.com>,
 changpeng.liu@intel.com, eskultet@redhat.com, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added helper functions to get IOMMU info capability chain.
Added function to get migration capability information from that
capability chain for IOMMU container.

Similar change was proposed earlier:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg03759.html

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c              | 91 +++++++++++++++++++++++++++++++++++++++----
 include/hw/vfio/vfio-common.h |  3 ++
 2 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 90e9a854d82c..e0d3d4585a65 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1229,6 +1229,75 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
     return 0;
 }
 
+static int vfio_get_iommu_info(VFIOContainer *container,
+                               struct vfio_iommu_type1_info **info)
+{
+
+    size_t argsz = sizeof(struct vfio_iommu_type1_info);
+
+    *info = g_new0(struct vfio_iommu_type1_info, 1);
+again:
+    (*info)->argsz = argsz;
+
+    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
+        g_free(*info);
+        *info = NULL;
+        return -errno;
+    }
+
+    if (((*info)->argsz > argsz)) {
+        argsz = (*info)->argsz;
+        *info = g_realloc(*info, argsz);
+        goto again;
+    }
+
+    return 0;
+}
+
+static struct vfio_info_cap_header *
+vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
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
+static void vfio_get_iommu_info_migration(VFIOContainer *container,
+                                         struct vfio_iommu_type1_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_cap_migration *cap_mig;
+
+    hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
+    if (!hdr) {
+        return;
+    }
+
+    cap_mig = container_of(hdr, struct vfio_iommu_type1_info_cap_migration,
+                            header);
+
+    container->dirty_pages_supported = true;
+    container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
+    container->dirty_pgsizes = cap_mig->pgsize_bitmap;
+
+    /*
+     * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
+     * TARGET_PAGE_SIZE to mark those dirty.
+     */
+    assert(container->dirty_pgsizes & TARGET_PAGE_SIZE);
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -1293,6 +1362,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->space = space;
     container->fd = fd;
     container->error = NULL;
+    container->dirty_pages_supported = false;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
 
@@ -1305,7 +1375,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     case VFIO_TYPE1v2_IOMMU:
     case VFIO_TYPE1_IOMMU:
     {
-        struct vfio_iommu_type1_info info;
+        struct vfio_iommu_type1_info *info;
 
         /*
          * FIXME: This assumes that a Type1 IOMMU can map any 64-bit
@@ -1314,15 +1384,20 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
          * existing Type1 IOMMUs generally support any IOVA we're
          * going to actually try in practice.
          */
-        info.argsz = sizeof(info);
-        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, &info);
-        /* Ignore errors */
-        if (ret || !(info.flags & VFIO_IOMMU_INFO_PGSIZES)) {
+        ret = vfio_get_iommu_info(container, &info);
+        if (ret) {
+                goto free_container_exit;
+        }
+
+        if (!(info->flags & VFIO_IOMMU_INFO_PGSIZES)) {
             /* Assume 4k IOVA page size */
-            info.iova_pgsizes = 4096;
+            info->iova_pgsizes = 4096;
         }
-        vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
-        container->pgsizes = info.iova_pgsizes;
+        vfio_host_win_add(container, 0, (hwaddr)-1, info->iova_pgsizes);
+        container->pgsizes = info->iova_pgsizes;
+
+        vfio_get_iommu_info_migration(container, info);
+        g_free(info);
         break;
     }
     case VFIO_SPAPR_TCE_v2_IOMMU:
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c78033e4149d..5a57a78ec517 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -79,6 +79,9 @@ typedef struct VFIOContainer {
     unsigned iommu_type;
     Error *error;
     bool initialized;
+    bool dirty_pages_supported;
+    uint64_t dirty_pgsizes;
+    uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
-- 
2.7.0


