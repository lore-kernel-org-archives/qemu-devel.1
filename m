Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA30C2D0E2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 00:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D0920757
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 00:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D2xyqNxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D0920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKsIO-0006wK-DG
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 20:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kKsFH-00030X-07
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 20:02:51 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kKsFE-0001A9-Q1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 20:02:50 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f6a8f6c0003>; Tue, 22 Sep 2020 16:57:32 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 23:57:35 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 22 Sep 2020 23:57:27 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v26 05/17] vfio: Add VM state change handler to know state of
 VM
Date: Wed, 23 Sep 2020 04:54:07 +0530
Message-ID: <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600819052; bh=pS2lzl3wGvfvvw14J04f3Hh1oA7ekgCbp5LTVJUVOns=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=D2xyqNxpo09f+FpiLPfK2Tq2yEB/fy9Q1eZXeipXrLV1xXYuxhtxspyhqfRt3Xijx
 Ai9aRPEvJGZyNQ7IG27zw1TzPjXx0IQE45PS6EiEj8p4DrVFMPEhObKUy9X9/i/bXN
 XUx6kUw1v0XdNhTAQH/MamJ/dMo07L7h3R5/UbQA4CsCGmK3dy9QB9lihCtVGN5v8s
 As2xp5o7/IGNdHzpQo3degYYVqXUB7Bdt9r7evos22OOF6qbmlSbeA6vxuRJ0LCn9G
 +v+lRYxFtIV5pNxuLMJr0cqd6BllUO5CVV3YR7apyOfz5IfalfdvT1FIv3XVPu0KDD
 gAOPr4JVshqIg==
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

VM state change handler gets called on change in VM's state. This is used to set
VFIO device state to _RUNNING.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/vfio/migration.c           | 136 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |   3 +-
 include/hw/vfio/vfio-common.h |   4 ++
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2f760f1f9c47..a30d628ba963 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include <linux/vfio.h>
 
+#include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "cpu.h"
 #include "migration/migration.h"
@@ -22,6 +23,58 @@
 #include "exec/ram_addr.h"
 #include "pci.h"
 #include "trace.h"
+#include "hw/hw.h"
+
+static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
+                                  off_t off, bool iswrite)
+{
+    int ret;
+
+    ret = iswrite ? pwrite(vbasedev->fd, val, count, off) :
+                    pread(vbasedev->fd, val, count, off);
+    if (ret < count) {
+        error_report("vfio_mig_%s%d %s: failed at offset 0x%lx, err: %s",
+                     iswrite ? "write" : "read", count * 8,
+                     vbasedev->name, off, strerror(errno));
+        return (ret < 0) ? ret : -EINVAL;
+    }
+    return 0;
+}
+
+static int vfio_mig_rw(VFIODevice *vbasedev, __u8 *buf, size_t count,
+                       off_t off, bool iswrite)
+{
+    int ret, done = 0;
+    __u8 *tbuf = buf;
+
+    while (count) {
+        int bytes = 0;
+
+        if (count >= 8 && !(off % 8)) {
+            bytes = 8;
+        } else if (count >= 4 && !(off % 4)) {
+            bytes = 4;
+        } else if (count >= 2 && !(off % 2)) {
+            bytes = 2;
+        } else {
+            bytes = 1;
+        }
+
+        ret = vfio_mig_access(vbasedev, tbuf, bytes, off, iswrite);
+        if (ret) {
+            return ret;
+        }
+
+        count -= bytes;
+        done += bytes;
+        off += bytes;
+        tbuf += bytes;
+    }
+    return done;
+}
+
+#define vfio_mig_read(f, v, c, o)       vfio_mig_rw(f, (__u8 *)v, c, o, false)
+#define vfio_mig_write(f, v, c, o)      vfio_mig_rw(f, (__u8 *)v, c, o, true)
 
 static void vfio_migration_region_exit(VFIODevice *vbasedev)
 {
@@ -70,6 +123,82 @@ err:
     return ret;
 }
 
+static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
+                                    uint32_t value)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region;
+    off_t dev_state_off = region->fd_offset +
+                      offsetof(struct vfio_device_migration_info, device_state);
+    uint32_t device_state;
+    int ret;
+
+    ret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
+                        dev_state_off);
+    if (ret < 0) {
+        return ret;
+    }
+
+    device_state = (device_state & mask) | value;
+
+    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
+        return -EINVAL;
+    }
+
+    ret = vfio_mig_write(vbasedev, &device_state, sizeof(device_state),
+                         dev_state_off);
+    if (ret < 0) {
+        ret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
+                          dev_state_off);
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
+            hw_error("%s: Device is in error state 0x%x",
+                     vbasedev->name, device_state);
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
+            /*
+             * vm_state_notify() doesn't support reporting failure. If such
+             * error reporting support added in furure, migration should be
+             * aborted.
+             */
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
@@ -87,8 +216,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
                      vbasedev->name);
         g_free(vbasedev->migration);
         vbasedev->migration = NULL;
+        return ret;
     }
 
+    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
+                                                          vbasedev);
     return ret;
 }
 
@@ -131,6 +263,10 @@ add_blocker:
 
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
index 8fe913175d85..6524734bf7b4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -149,4 +149,5 @@ vfio_display_edid_write_error(void) ""
 
 # migration.c
 vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
-
+vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
+vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8275c4c68f45..25e3b1a3b90a 100644
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


