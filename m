Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4611C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BCF20770
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ss6hrYIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BCF20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzoS-00031J-PB
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzSb-0008Np-8G
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:41 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzSY-0008C9-U0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:40 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f96a0a50000>; Mon, 26 Oct 2020 03:10:45 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 10:10:28 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 10:10:20 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v29 04/17] vfio: Add migration region initialization and
 finalize function
Date: Mon, 26 Oct 2020 15:06:14 +0530
Message-ID: <1603704987-20977-5-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603707045; bh=oOD0hvnyZ4ExpQVscA0M1yP+hP3NwO35YFSCX6A0PQQ=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=Ss6hrYIh8oQGOugUwJPgSTv6g92nanJGOcM2/FTZlcjzokJ/uBimPNT1hs28EiHYf
 7iKIMxA2oGvTeJxxq7SwnDMZJtWz0/94SAqxO6CcCfwfGjH7i7Qg1kdRhXi+Yzk72i
 +NOCW2hw4KrDHcQW0lqQ5E64E8O7ejo3nYqPG+HuXh1KEfrdPlPdcMw+nOqWcsj9VF
 c6wiVVNUq7ScXLKJpC9UAe1sBAdNr/+tZ+B+3CBPf0YzElVBH1eDzC/SCXv2qVPunc
 +Www1jXJfYXyGeh+Tu4SMUtvfnsBVr0wcnMVGXvvV+s9micALSCDwxIGMWzhWnoqbc
 Wzg0EJbAZrT+w==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 06:10:03
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: cohuck@redhat.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Whether the VFIO device supports migration or not is decided based of
migration region query. If migration region query is successful and migration
region initialization is successful then migration is supported else
migration is blocked.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/vfio/meson.build           |   1 +
 hw/vfio/migration.c           | 122 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |   3 ++
 include/hw/vfio/vfio-common.h |   9 ++++
 4 files changed, 135 insertions(+)
 create mode 100644 hw/vfio/migration.c

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 37efa74018bc..da9af297a0c5 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'common.c',
   'spapr.c',
+  'migration.c',
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
new file mode 100644
index 000000000000..fd7faf423cdc
--- /dev/null
+++ b/hw/vfio/migration.c
@@ -0,0 +1,122 @@
+/*
+ * Migration support for VFIO devices
+ *
+ * Copyright NVIDIA, Inc. 2020
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "cpu.h"
+#include "migration/migration.h"
+#include "migration/qemu-file.h"
+#include "migration/register.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
+#include "qapi/error.h"
+#include "exec/ramlist.h"
+#include "exec/ram_addr.h"
+#include "pci.h"
+#include "trace.h"
+
+static void vfio_migration_exit(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    vfio_region_exit(&migration->region);
+    vfio_region_finalize(&migration->region);
+    g_free(vbasedev->migration);
+    vbasedev->migration = NULL;
+}
+
+static int vfio_migration_init(VFIODevice *vbasedev,
+                               struct vfio_region_info *info)
+{
+    int ret;
+    Object *obj;
+
+    if (!vbasedev->ops->vfio_get_object) {
+        return -EINVAL;
+    }
+
+    obj = vbasedev->ops->vfio_get_object(vbasedev);
+    if (!obj) {
+        return -EINVAL;
+    }
+
+    vbasedev->migration = g_new0(VFIOMigration, 1);
+
+    ret = vfio_region_setup(obj, vbasedev, &vbasedev->migration->region,
+                            info->index, "migration");
+    if (ret) {
+        error_report("%s: Failed to setup VFIO migration region %d: %s",
+                     vbasedev->name, info->index, strerror(-ret));
+        goto err;
+    }
+
+    if (!vbasedev->migration->region.size) {
+        error_report("%s: Invalid zero-sized VFIO migration region %d",
+                     vbasedev->name, info->index);
+        ret = -EINVAL;
+        goto err;
+    }
+    return 0;
+
+err:
+    vfio_migration_exit(vbasedev);
+    return ret;
+}
+
+/* ---------------------------------------------------------------------- */
+
+int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_region_info *info = NULL;
+    Error *local_err = NULL;
+    int ret;
+
+    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
+                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
+    if (ret) {
+        goto add_blocker;
+    }
+
+    ret = vfio_migration_init(vbasedev, info);
+    if (ret) {
+        goto add_blocker;
+    }
+
+    g_free(info);
+    trace_vfio_migration_probe(vbasedev->name, info->index);
+    return 0;
+
+add_blocker:
+    error_setg(&vbasedev->migration_blocker,
+               "VFIO device doesn't support migration");
+    g_free(info);
+
+    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_free(vbasedev->migration_blocker);
+        vbasedev->migration_blocker = NULL;
+    }
+    return ret;
+}
+
+void vfio_migration_finalize(VFIODevice *vbasedev)
+{
+    if (vbasedev->migration) {
+        vfio_migration_exit(vbasedev);
+    }
+
+    if (vbasedev->migration_blocker) {
+        migrate_del_blocker(vbasedev->migration_blocker);
+        error_free(vbasedev->migration_blocker);
+        vbasedev->migration_blocker = NULL;
+    }
+}
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a0c7b49a2ebc..9ced5ec6277c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -145,3 +145,6 @@ vfio_display_edid_link_up(void) ""
 vfio_display_edid_link_down(void) ""
 vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
 vfio_display_edid_write_error(void) ""
+
+# migration.c
+vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ba6169cd926e..8275c4c68f45 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -57,6 +57,10 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
+typedef struct VFIOMigration {
+    VFIORegion region;
+} VFIOMigration;
+
 typedef struct VFIOAddressSpace {
     AddressSpace *as;
     QLIST_HEAD(, VFIOContainer) containers;
@@ -113,6 +117,8 @@ typedef struct VFIODevice {
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
+    VFIOMigration *migration;
+    Error *migration_blocker;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -204,4 +210,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
+int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
+void vfio_migration_finalize(VFIODevice *vbasedev);
+
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.7.0


