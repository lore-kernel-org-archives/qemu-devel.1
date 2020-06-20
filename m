Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A918BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 20:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728442469D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 20:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l6Q27vqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728442469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkad-0004KR-NA
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 16:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkWL-0004Uv-IG
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:55:25 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkWJ-0000IO-BI
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:55:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eee77610000>; Sat, 20 Jun 2020 13:53:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sat, 20 Jun 2020 13:55:22 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sat, 20 Jun 2020 13:55:22 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 20 Jun
 2020 20:55:16 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Sat, 20 Jun 2020 20:55:08 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v25 05/17] vfio: Add VM state change handler to know
 state of VM
Date: Sun, 21 Jun 2020 01:51:14 +0530
Message-ID: <1592684486-18511-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592686433; bh=K1C65JoEPytQXZwdQnOSF4f//Ku2lRx1zrDleule5Gc=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=l6Q27vqbTBffrOHpYfCTJ1VHa2X6yGl5Wb75wpU4INkgFcqdIhuYc+Odr3oLKr33Q
 iDudc4exavlc3ILplsDxYUdL2dwXeU78l5/m12g5vpSZ7KaA4p6DuX+wq/3/HQc2PT
 psHVSq/IL73haV6fQY4HdSYZ9ScIfhDzPYnH1JCQY3TWyO4KRNXOY8TIde8fE2KyTN
 wfj7BOZVPQgtkfKCu1hXNFilKsWzYU9jp7jHiEvIKOIwWIfsHHAbrBctC8AxTSGtIV
 9NC7BzPv8sr1gaRvM4i50BlGTroMgAkPPCxta9wgNh6V16ai5XtvYMvX7O+KttA+O1
 OldhMcfDnk+fw==
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
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VM state change handler gets called on change in VM's state. This is used to set
VFIO device state to _RUNNING.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/vfio/migration.c           | 87 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |  2 +
 include/hw/vfio/vfio-common.h |  4 ++
 3 files changed, 93 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 48ac385d80a7..fcecc0bb0874 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include <linux/vfio.h>
 
+#include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "cpu.h"
 #include "migration/migration.h"
@@ -74,6 +75,85 @@ err:
     return ret;
 }
 
+static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
+                                    uint32_t value)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region;
+    uint32_t device_state;
+    int ret;
+
+    ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              device_state));
+    if (ret < 0) {
+        error_report("%s: Failed to read device state %d %s",
+                     vbasedev->name, ret, strerror(errno));
+        return ret;
+    }
+
+    device_state = (device_state & mask) | value;
+
+    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
+        return -EINVAL;
+    }
+
+    ret = pwrite(vbasedev->fd, &device_state, sizeof(device_state),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              device_state));
+    if (ret < 0) {
+        error_report("%s: Failed to set device state %d %s",
+                     vbasedev->name, ret, strerror(errno));
+
+        ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                device_state));
+        if (ret < 0) {
+            error_report("%s: On failure, failed to read device state %d %s",
+                    vbasedev->name, ret, strerror(errno));
+            return ret;
+        }
+
+        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
+            error_report("%s: Device is in error state 0x%x",
+                         vbasedev->name, device_state);
+            return -EFAULT;
+        }
+    }
+
+    vbasedev->device_state = device_state;
+    trace_vfio_migration_set_state(vbasedev->name, device_state);
+    return 0;
+}
+
+static void vfio_vmstate_change(void *opaque, int running, RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+
+    if ((vbasedev->vm_running != running)) {
+        int ret;
+        uint32_t value = 0, mask = 0;
+
+        if (running) {
+            value = VFIO_DEVICE_STATE_RUNNING;
+            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
+                mask = ~VFIO_DEVICE_STATE_RESUMING;
+            }
+        } else {
+            mask = ~VFIO_DEVICE_STATE_RUNNING;
+        }
+
+        ret = vfio_migration_set_state(vbasedev, mask, value);
+        if (ret) {
+            error_report("%s: Failed to set device state 0x%x",
+                         vbasedev->name, value & mask);
+        }
+        vbasedev->vm_running = running;
+        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
+                                  value & mask);
+    }
+}
+
 static int vfio_migration_init(VFIODevice *vbasedev,
                                struct vfio_region_info *info)
 {
@@ -87,8 +167,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
                      vbasedev->name);
         g_free(vbasedev->migration);
         vbasedev->migration = NULL;
+        return ret;
     }
 
+    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
+                                                          vbasedev);
     return ret;
 }
 
@@ -131,6 +214,10 @@ add_blocker:
 
 void vfio_migration_finalize(VFIODevice *vbasedev)
 {
+    if (vbasedev->vm_state) {
+        qemu_del_vm_change_state_handler(vbasedev->vm_state);
+    }
+
     if (vbasedev->migration_blocker) {
         migrate_del_blocker(vbasedev->migration_blocker);
         error_free(vbasedev->migration_blocker);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fd034ac53684..14b0a86c0035 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -146,3 +146,5 @@ vfio_display_edid_write_error(void) ""
 
 # migration.c
 vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
+vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
+vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d4b268641173..3d18eb146b33 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -29,6 +29,7 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
+#include "sysemu/sysemu.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -119,6 +120,9 @@ typedef struct VFIODevice {
     unsigned int flags;
     VFIOMigration *migration;
     Error *migration_blocker;
+    VMChangeStateEntry *vm_state;
+    uint32_t device_state;
+    int vm_running;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.7.0


