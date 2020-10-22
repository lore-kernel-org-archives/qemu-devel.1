Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B51C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F55F223FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oLbZCCdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F55F223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZGI-0002Tw-Ag
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVZ2f-0001IV-At
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:46:05 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVZ2U-0007Mw-R5
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:46:01 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f9170de0000>; Thu, 22 Oct 2020 04:45:34 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 11:45:37 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 22 Oct 2020 11:45:29 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v27 07/17] vfio: Register SaveVMHandlers for VFIO device
Date: Thu, 22 Oct 2020 16:41:57 +0530
Message-ID: <1603365127-14202-8-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603367134; bh=3Qu1gjBeyA2yFsqSJXKPIpQstRrwi9t0ZpKM1JWSgWA=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=oLbZCCdWBOGcZ+ntUJhaVjcXwXnCL3jwO2mp+zEdzlIfHzQ32EGnq1UampQFwRggl
 xnaA/m8f91nf9tUQ1n8JkKz4BvP+kuu5PxPZHSCQpc3nvj8t28h6dy02cwP0PNqEEe
 76texbTj6m4CKKANai/im8NbjBOgUE/eaOEsayRCx0H+BlJFFQf2xxbG5Ol4UbCeFk
 MUlL4Xv9uodDlVvJkEY4u2XIEe1vl019YxPco9WUY0SMZzm8rPa9cj37Cw+9RkNU9o
 wq7PSOtad5RrCX+E00O7DWW5Mq718HPZ8+7kJzbbUOBNDq/sCuEP5aqPSLXdNOUMAu
 6Uj/hLhVHnKZQ==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 07:45:39
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

Define flags to be used as delimiter in migration stream for VFIO devices.
Added .save_setup and .save_cleanup functions. Map & unmap migration
region from these functions at source during saving or pre-copy phase.

Set VFIO device state depending on VM's state. During live migration, VM is
running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
device. During save-restore, VM is paused, _SAVING state is set for VFIO device.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c  | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |  2 ++
 2 files changed, 98 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 7c4fa0d08ea6..2e1054bf7f43 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -8,12 +8,15 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/cutils.h"
 #include <linux/vfio.h>
 
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "cpu.h"
 #include "migration/migration.h"
+#include "migration/vmstate.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "migration/blocker.h"
@@ -25,6 +28,22 @@
 #include "trace.h"
 #include "hw/hw.h"
 
+/*
+ * Flags to be used as unique delimiters for VFIO devices in the migration
+ * stream. These flags are composed as:
+ * 0xffffffff => MSB 32-bit all 1s
+ * 0xef10     => Magic ID, represents emulated (virtual) function IO
+ * 0x0000     => 16-bits reserved for flags
+ *
+ * The beginning of state information is marked by _DEV_CONFIG_STATE,
+ * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
+ * certain state information is marked by _END_OF_STATE.
+ */
+#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
+#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
+#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
+#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+
 static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
                                   off_t off, bool iswrite)
 {
@@ -129,6 +148,69 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
     return 0;
 }
 
+/* ---------------------------------------------------------------------- */
+
+static int vfio_save_setup(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    trace_vfio_save_setup(vbasedev->name);
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
+
+    if (migration->region.mmaps) {
+        /*
+         * vfio_region_mmap() called from migration thread. Memory API called
+         * from vfio_regio_mmap() need it when called from outdide the main loop
+         * thread.
+         */
+        qemu_mutex_lock_iothread();
+        ret = vfio_region_mmap(&migration->region);
+        qemu_mutex_unlock_iothread();
+        if (ret) {
+            error_report("%s: Failed to mmap VFIO migration region: %s",
+                         vbasedev->name, strerror(-ret));
+            error_report("%s: Falling back to slow path", vbasedev->name);
+        }
+    }
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_MASK,
+                                   VFIO_DEVICE_STATE_SAVING);
+    if (ret) {
+        error_report("%s: Failed to set state SAVING", vbasedev->name);
+        return ret;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
+static void vfio_save_cleanup(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (migration->region.mmaps) {
+        vfio_region_unmap(&migration->region);
+    }
+    trace_vfio_save_cleanup(vbasedev->name);
+}
+
+static SaveVMHandlers savevm_vfio_handlers = {
+    .save_setup = vfio_save_setup,
+    .save_cleanup = vfio_save_cleanup,
+};
+
+/* ---------------------------------------------------------------------- */
+
 static void vfio_vmstate_change(void *opaque, int running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
@@ -219,6 +301,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
     int ret;
     Object *obj;
     VFIOMigration *migration;
+    char id[256] = "";
+    g_autofree char *path = NULL, *oid;
 
     if (!vbasedev->ops->vfio_get_object) {
         return -EINVAL;
@@ -248,6 +332,18 @@ static int vfio_migration_init(VFIODevice *vbasedev,
 
     vbasedev->migration = migration;
     migration->vbasedev = vbasedev;
+
+    oid = vmstate_if_get_id(VMSTATE_IF(DEVICE(obj)));
+    if (oid) {
+        path = g_strdup_printf("%s/vfio", oid);
+    } else {
+        path = g_strdup("vfio");
+    }
+    strpadcpy(id, sizeof(id), path, '\0');
+
+    register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
+                         vbasedev);
+
     migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
                                                           vbasedev);
     migration->migration_state.notify = vfio_migration_state_notifier;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 78d7d83b5ef8..f148b5e828c1 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -151,3 +151,5 @@ vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
 vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
 vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
+vfio_save_setup(const char *name) " (%s)"
+vfio_save_cleanup(const char *name) " (%s)"
-- 
2.7.0


