Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179CFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEED72064C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WTue0Ys/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEED72064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkRX-0000LT-Pw
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkME-0000vO-Sf
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:18:42 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkM1-00068M-S7
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:18:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb0a2b50000>; Mon, 04 May 2020 16:18:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 04 May 2020 16:18:25 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 04 May 2020 16:18:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 23:18:25 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Mon, 4 May 2020 23:18:18 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v18 QEMU 02/18] vfio: Add function to unmap VFIO region
Date: Tue, 5 May 2020 04:14:37 +0530
Message-ID: <1588632293-18932-3-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588634293; bh=6OJdnDk2YoR/jMg1CiBocQhG0AxgzBkRxbI9Iez1jK8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=WTue0Ys/rthCU7TMRLB1jlfrqzK2AWid+A8+rwbJqXVjX5tnjPjRKD8lLpzHoVJx2
 xVfpu8pogRbjC4JiaDeVeFNQsK1n/zqlH7MnCy3X1UQeZhkQiphFcj8v2+3qvJC12m
 ExVyNtz5yTPzT0SXGypikohegk1B2+uzecl81mN9eAwSsBBd2NRjROQMYYzoLyHJ2n
 b3S39B4ifr8QmYfrPL+jhWwyF/fqjdRbj8uJYNl1W8ocBwwJb7ZODydkC5zANneXzL
 TNbkATiDeA/LC6F1vQ8XlrDeeK27Z8jBqHW14VM9z/O3mk2epxe0eR66iXm8FcpBTZ
 kNUDR30huEtUQ==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:18:18
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function will be used for migration region.
Migration region is mmaped when migration starts and will be unmapped when
migration is complete.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/common.c              | 20 ++++++++++++++++++++
 hw/vfio/trace-events          |  1 +
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b3c0c4..4a2f0d6a2233 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -983,6 +983,26 @@ int vfio_region_mmap(VFIORegion *region)
     return 0;
 }
 
+void vfio_region_unmap(VFIORegion *region)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        trace_vfio_region_unmap(memory_region_name(&region->mmaps[i].mem),
+                                region->mmaps[i].offset,
+                                region->mmaps[i].offset +
+                                region->mmaps[i].size - 1);
+        memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
+        munmap(region->mmaps[i].mmap, region->mmaps[i].size);
+        object_unparent(OBJECT(&region->mmaps[i].mem));
+        region->mmaps[i].mmap = NULL;
+    }
+}
+
 void vfio_region_exit(VFIORegion *region)
 {
     int i;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a33ffd..8cdc27946cb8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -111,6 +111,7 @@ vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Reg
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
 vfio_region_finalize(const char *name, int index) "Device %s, region %d"
 vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
+vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Region %s unmap [0x%lx - 0x%lx]"
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fd564209ac71..8d7a0fbb1046 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -171,6 +171,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
+void vfio_region_unmap(VFIORegion *region);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
-- 
2.7.0


