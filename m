Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EFBC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42A0223BF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EQveibdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42A0223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZ77-0005V2-F6
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVZ2I-0000yG-Va
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:45:39 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVZ1a-00074a-GM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:45:38 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f9170840000>; Thu, 22 Oct 2020 04:44:04 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 11:44:46 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 22 Oct 2020 11:44:38 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v27 01/17] vfio: Add function to unmap VFIO region
Date: Thu, 22 Oct 2020 16:41:51 +0530
Message-ID: <1603365127-14202-2-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603367044; bh=xtSQlqXVxqY0Ii7mEm8QI0dDKK/m5fS9hZu49+0IBfE=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=EQveibdv51pMclqzF19MWG8ONzfJtsmAMWNIivVvauqJwQBjnx1ba/0BHb1O1DKlo
 OOBYIVCre7vpf2XQlEO7G0tYjm8UWqmuB2p+sKubS2tqCzBYHAq1N57VJoylwA2ebI
 fCZ0S1gRC4AQNuQBRWDTZrAT4rTdgye5+8DPMJTnLfKk9p8jGM2IdQTTPnEyBGvNrP
 hK/zQIyCyJCwlzBbl5AuhFH15NVx23+vVHsdwRoiiezCYuGZjddv8JRbAh4HzF7Qzv
 s3NrSQl3anfVDU05ze4VFGDS0ZgROiZCoOyCWBtRtT2RetHSHmDir5EhM8jMcUDOoY
 M5Z9f7EYS453A==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 07:44:53
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: cohuck@redhat.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, mcrossley@nvidia.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com, dnigam@nvidia.com
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
 hw/vfio/common.c              | 32 ++++++++++++++++++++++++++++----
 hw/vfio/trace-events          |  1 +
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 13471ae29436..c6e98b8d61be 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -924,6 +924,18 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     return 0;
 }
 
+static void vfio_subregion_unmap(VFIORegion *region, int index)
+{
+    trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
+                            region->mmaps[index].offset,
+                            region->mmaps[index].offset +
+                            region->mmaps[index].size - 1);
+    memory_region_del_subregion(region->mem, &region->mmaps[index].mem);
+    munmap(region->mmaps[index].mmap, region->mmaps[index].size);
+    object_unparent(OBJECT(&region->mmaps[index].mem));
+    region->mmaps[index].mmap = NULL;
+}
+
 int vfio_region_mmap(VFIORegion *region)
 {
     int i, prot = 0;
@@ -954,10 +966,7 @@ int vfio_region_mmap(VFIORegion *region)
             region->mmaps[i].mmap = NULL;
 
             for (i--; i >= 0; i--) {
-                memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
-                munmap(region->mmaps[i].mmap, region->mmaps[i].size);
-                object_unparent(OBJECT(&region->mmaps[i].mem));
-                region->mmaps[i].mmap = NULL;
+                vfio_subregion_unmap(region, i);
             }
 
             return ret;
@@ -982,6 +991,21 @@ int vfio_region_mmap(VFIORegion *region)
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
+        if (region->mmaps[i].mmap) {
+            vfio_subregion_unmap(region, i);
+        }
+    }
+}
+
 void vfio_region_exit(VFIORegion *region)
 {
     int i;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 93a0bc2522f8..a0c7b49a2ebc 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -113,6 +113,7 @@ vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Reg
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
 vfio_region_finalize(const char *name, int index) "Device %s, region %d"
 vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
+vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Region %s unmap [0x%lx - 0x%lx]"
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c78f3ff5593c..dc95f527b583 100644
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


