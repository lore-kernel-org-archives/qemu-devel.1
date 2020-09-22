Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA497C2D0E2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 00:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0002076B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 00:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Sy/N+jWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0002076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKsNk-0006N6-GZ
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 20:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kKsG9-0004Ma-7x
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 20:03:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kKsG6-0001DI-UN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 20:03:44 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f6a8fa30001>; Tue, 22 Sep 2020 16:58:28 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 23:58:34 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 22 Sep 2020 23:58:26 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v26 12/17] vfio: Add function to start and stop dirty pages
 tracking
Date: Wed, 23 Sep 2020 04:54:14 +0530
Message-ID: <1600817059-26721-13-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600819108; bh=KQNeKmVobDDnc4FBJBVSw+dTSvPqpsdz5wXJvSZjuuI=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=Sy/N+jWtjl9rltaJEZMETqDEwWF3mFSDoXLWiaEuOpbKFv0+uILakyjfLiKatBU5t
 eD4uiKJ7mAbPU9iuKgp71SG4ZsJqW2eekcPMkH+dky3XB0sO0UDwEQbUruLfvXGulQ
 s+0GEOLxDNwgELlQ03qkNuRjhFq2NdCSRroMM3Mli4LEeOlTiS7Ylj2zyfCD6JLIwH
 0lsQ4isozQI2Zfuf4cafS+A1atMcDNsDdH4ze3HkABleMqxKchezu244F7OLnuDkvJ
 k3vJfKj2UnXjY2354Q6ALy19AfLUakRiH2MTZc98WkAGgvb8gdudmdOPRIR0Rgoo/d
 HOo7Q0XUBz17g==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 19:57:16
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
for VFIO devices.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4306f6316417..822b68b4e015 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -11,6 +11,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/cutils.h"
 #include <linux/vfio.h>
+#include <sys/ioctl.h>
 
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
@@ -355,6 +356,32 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     return qemu_file_get_error(f);
 }
 
+static int vfio_set_dirty_page_tracking(VFIODevice *vbasedev, bool start)
+{
+    int ret;
+    VFIOContainer *container = vbasedev->group->container;
+    struct vfio_iommu_type1_dirty_bitmap dirty = {
+        .argsz = sizeof(dirty),
+    };
+
+    if (start) {
+        if (vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) {
+            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_START;
+        } else {
+            return -EINVAL;
+        }
+    } else {
+            dirty.flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP;
+    }
+
+    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
+    if (ret) {
+        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
+                     dirty.flags, errno);
+    }
+    return ret;
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
@@ -386,6 +413,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
+    ret = vfio_set_dirty_page_tracking(vbasedev, true);
+    if (ret) {
+        return ret;
+    }
+
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
     ret = qemu_file_get_error(f);
@@ -401,6 +433,8 @@ static void vfio_save_cleanup(void *opaque)
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
 
+    vfio_set_dirty_page_tracking(vbasedev, false);
+
     if (migration->region.mmaps) {
         vfio_region_unmap(&migration->region);
     }
@@ -734,6 +768,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
         if (ret) {
             error_report("%s: Failed to set state RUNNING", vbasedev->name);
         }
+
+        vfio_set_dirty_page_tracking(vbasedev, false);
     }
 }
 
-- 
2.7.0


