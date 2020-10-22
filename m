Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A55C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5326F222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WYGt/TOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5326F222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZ7b-0006PM-5v
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVZ2Z-0001Eh-MX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:45:59 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVZ2L-0007JQ-6e
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:45:53 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f9170d70001>; Thu, 22 Oct 2020 04:45:27 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 11:45:29 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 22 Oct 2020 11:45:21 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v27 06/17] vfio: Add migration state change notifier
Date: Thu, 22 Oct 2020 16:41:56 +0530
Message-ID: <1603365127-14202-7-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603367127; bh=PZx0vwb5+/oem8Fj22SPkzrd6LJO+TSfiDJ78tPQ7LU=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=WYGt/TOgluupD15h+b4gVvYX6gKae3ILwJce7jqTuluUYf1jrHbOCkdIasYd3vdkD
 YArSQCgxy0P9mihDCTxxSyidfp2WKrB8jGffZRIFIU/buJBtrehq4UrM9V9/nGpdHt
 1vJPadfcB8rFkPS8bk6UEKjJ1AgH22pdbvMyg6/iJD+2i3X6osB6g2otT93dpyLJ/b
 CPQV2pCRIEMIUbELakpNBuICY8DFFdpWBr3XWeB3kduRp9xAYIIlcCo5Y7k17y6vwq
 KgS8reYZm2maEbsS+xMVJ/JRbfmx7kyOZzPbt2VMnZ+UFV1W7bMLjj5SH4zltAkyH5
 bKP0txd7dAyIw==
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

Added migration state change notifier to get notification on migration state
change. These states are translated to VFIO device state and conveyed to
vendor driver.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/vfio/migration.c           | 37 +++++++++++++++++++++++++++++++++++--
 hw/vfio/trace-events          |  1 +
 include/hw/vfio/vfio-common.h |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 34f39c7e2e28..7c4fa0d08ea6 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -175,6 +175,30 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
             (migration->device_state & mask) | value);
 }
 
+static void vfio_migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s = data;
+    VFIOMigration *migration = container_of(notifier, VFIOMigration,
+                                            migration_state);
+    VFIODevice *vbasedev = migration->vbasedev;
+    int ret;
+
+    trace_vfio_migration_state_notifier(vbasedev->name,
+                                        MigrationStatus_str(s->state));
+
+    switch (s->state) {
+    case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_FAILED:
+        ret = vfio_migration_set_state(vbasedev,
+                      ~(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING),
+                      VFIO_DEVICE_STATE_RUNNING);
+        if (ret) {
+            error_report("%s: Failed to set state RUNNING", vbasedev->name);
+        }
+    }
+}
+
 static void vfio_migration_region_exit(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -223,8 +247,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
     }
 
     vbasedev->migration = migration;
+    migration->vbasedev = vbasedev;
     migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
                                                           vbasedev);
+    migration->migration_state.notify = vfio_migration_state_notifier;
+    add_migration_state_change_notifier(&migration->migration_state);
     return 0;
 
 err:
@@ -272,8 +299,14 @@ add_blocker:
 
 void vfio_migration_finalize(VFIODevice *vbasedev)
 {
-    if (vbasedev->migration->vm_state) {
-        qemu_del_vm_change_state_handler(vbasedev->migration->vm_state);
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (migration->migration_state.notify) {
+        remove_migration_state_change_notifier(&migration->migration_state);
+    }
+
+    if (migration->vm_state) {
+        qemu_del_vm_change_state_handler(migration->vm_state);
     }
 
     if (vbasedev->migration_blocker) {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 41de81f12f60..78d7d83b5ef8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -150,3 +150,4 @@ vfio_display_edid_write_error(void) ""
 vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
 vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
+vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9a571f1fb552..2bd593ba38bb 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -59,10 +59,12 @@ typedef struct VFIORegion {
 } VFIORegion;
 
 typedef struct VFIOMigration {
+    struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
     VFIORegion region;
     uint32_t device_state;
     int vm_running;
+    Notifier migration_state;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
-- 
2.7.0


