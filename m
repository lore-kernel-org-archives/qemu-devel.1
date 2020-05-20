Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19609C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD47B206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kIqNe1Z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD47B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbU4u-0000Hf-4u
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 15:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbTwc-0001Sg-OC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 14:59:58 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbTwb-0004vw-Nk
 for qemu-devel@nongnu.org; Wed, 20 May 2020 14:59:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec57ddd0000>; Wed, 20 May 2020 11:58:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 20 May 2020 11:59:56 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 20 May 2020 11:59:56 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 18:59:55 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 20 May 2020 18:59:48 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v23 14/18] vfio: Add function to start and stop dirty
 pages tracking
Date: Wed, 20 May 2020 23:54:44 +0530
Message-ID: <1589999088-31477-15-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590001117; bh=4gdrjyrC3hc3KSyx5UeTCRBLffkxwxxGH28JRpMXRn4=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=kIqNe1Z3eSHJCmUK4rwidmZ8aystrXvWCJuFb5pAKzutfWGLrU+FDBsmyVGzy/CV+
 luZK1WK+Ht2dRRpI7FgrE/Z4IyxP6+LHwGyj0a7DPIZOnwE3yTKt9uzGPDmSsfqdnA
 tjkfXrQxSSrBKspUZxr++CvgJlgPVxc0/KVwWIHbLC3DM/JhvT6k1lewB0EBAraxNd
 lXCGY5M+XGRdLYj8SkjdVimW2GIg1uQ6oWvQWT7KRqpB461cmq09ZIYWBOVQC22h0X
 ilF7W4GTXVZOBmHcGS1p7jj5pCGe6hediMY/BnaOhMquIAFbq+DC0dDF7IP8SXCNE/
 5F7riut4trGUg==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 14:41:20
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

Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
for VFIO devices.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 hw/vfio/migration.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b9bbe38e539c..7729c90782bd 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include <sys/ioctl.h>
 #include <linux/vfio.h>
 
 #include "sysemu/runstate.h"
@@ -297,6 +298,32 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     return qemu_file_get_error(f);
 }
 
+static int vfio_start_dirty_page_tracking(VFIODevice *vbasedev, bool start)
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
@@ -327,6 +354,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
+    ret = vfio_start_dirty_page_tracking(vbasedev, true);
+    if (ret) {
+        return ret;
+    }
+
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
     ret = qemu_file_get_error(f);
@@ -342,6 +374,8 @@ static void vfio_save_cleanup(void *opaque)
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
 
+    vfio_start_dirty_page_tracking(vbasedev, false);
+
     if (migration->region.mmaps) {
         vfio_region_unmap(&migration->region);
     }
@@ -676,6 +710,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
         if (ret) {
             error_report("%s: Failed to set state RUNNING", vbasedev->name);
         }
+
+        vfio_start_dirty_page_tracking(vbasedev, false);
     }
 }
 
-- 
2.7.0


