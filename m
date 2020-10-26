Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A55C20720
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="phkP5Frq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A55C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzxJ-0007TU-Jm
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzSv-0000DE-NQ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:11:01 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzSt-0008N8-OY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:11:01 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f96a0b90000>; Mon, 26 Oct 2020 03:11:05 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 10:10:46 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 10:10:38 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v29 06/17] vfio: Add migration state change notifier
Date: Mon, 26 Oct 2020 15:06:16 +0530
Message-ID: <1603704987-20977-7-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603707065; bh=twUU0vJpHbpkbAsxZP8KcwT8PcCtOQKmeRTWhgvrErw=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=phkP5FrqrroKS56L70cQ5F+QBlw3y1p7J1Dy0xpAzMJWBcnoqelRd6viwUJMOC+Ea
 4kMzhUqiBM+9FY/wR4VYjMz+DbiqpSh+oyoNZfGW6hnWOOxuiGMxEThZcUUeMKJqm1
 NGdg/OQXAEE08u7vBI2YUXvsnaRuKMUAwGgm1+fO8zRqQnJ6UCGZnAy/zVeC2qXlY/
 2/wAS8qjw2AAo8eRhxY6SlfaxIaC/UPoNcFmrPqRN63E7Fyi+PrIw9kzK7e7PqnCap
 XtbzF/uOlLE7XlrdGaEhf1lcC3u9tErin+i2u3EBX2XOW1asUG1dXNytqJjG1CnUZl
 RsB5/OSwKF5yg==
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

Added migration state change notifier to get notification on migration state
change. These states are translated to VFIO device state and conveyed to
vendor driver.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/migration.c           | 30 ++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |  1 +
 include/hw/vfio/vfio-common.h |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 65ce735d667b..888a615d39ea 100644
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
 static void vfio_migration_exit(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -190,6 +214,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
 {
     int ret;
     Object *obj;
+    VFIOMigration *migration;
 
     if (!vbasedev->ops->vfio_get_object) {
         return -EINVAL;
@@ -217,8 +242,12 @@ static int vfio_migration_init(VFIODevice *vbasedev,
         goto err;
     }
 
+    migration = vbasedev->migration;
+    migration->vbasedev = vbasedev;
     migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
                                                            vbasedev);
+    migration->migration_state.notify = vfio_migration_state_notifier;
+    add_migration_state_change_notifier(&migration->migration_state);
     return 0;
 
 err:
@@ -268,6 +297,7 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
     if (vbasedev->migration) {
         VFIOMigration *migration = vbasedev->migration;
 
+        remove_migration_state_change_notifier(&migration->migration_state);
         qemu_del_vm_change_state_handler(migration->vm_state);
         vfio_migration_exit(vbasedev);
     }
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


