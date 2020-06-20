Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C9C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F9B2469D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GGD3yn0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F9B2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkay-00051i-SN
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 17:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkWW-0004sc-KU
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:55:36 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkWU-0000Ie-Fs
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:55:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eee77980000>; Sat, 20 Jun 2020 13:54:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sat, 20 Jun 2020 13:55:33 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sat, 20 Jun 2020 13:55:33 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 20 Jun
 2020 20:55:24 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Sat, 20 Jun 2020 20:55:16 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v25 06/17] vfio: Add migration state change notifier
Date: Sun, 21 Jun 2020 01:51:15 +0530
Message-ID: <1592684486-18511-7-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592686489; bh=qu8o0x/bVhJn93/HxYrWJNXqh84qn3ie+3sErzCpLWU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=GGD3yn0n6lZfucr4KclVNHSHUVFfZW1nnAMXtuIVOknTNkyit+woeiuhchL1iMEHk
 2h1BprTxQh44P/Gp/BY6eIe5yvsZQSu+vJZUXCvg8w0EtoaHqrlUXWITqwdx86MSM7
 CZ7ykJR1t89GgjzGwGW4kEJAk88PRNLfWzs8GFDYRTjlbz+SbjLhhp9e/4E4h5Jz6p
 LrSnuyge3kMh6OD3pAYTsiF/7G1uXVNrcpKTfqks9Vw31MbIwVFZQyf0uBvmrSN0FE
 I4FgU3IEBSvVsXZeolM+SAQyagVBwJA1wGRVk6qhmzSJIKd9liV4kPeh3Riah+oyfO
 TG4akA2AjKVAw==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 16:55:03
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

Added migration state change notifier to get notification on migration state
change. These states are translated to VFIO device state and conveyed to vendor
driver.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/vfio/migration.c           | 29 +++++++++++++++++++++++++++++
 hw/vfio/trace-events          |  5 +++--
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index fcecc0bb0874..e30bd8768701 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -154,6 +154,28 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
     }
 }
 
+static void vfio_migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s = data;
+    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
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
 static int vfio_migration_init(VFIODevice *vbasedev,
                                struct vfio_region_info *info)
 {
@@ -172,6 +194,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
 
     vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
                                                           vbasedev);
+    vbasedev->migration_state.notify = vfio_migration_state_notifier;
+    add_migration_state_change_notifier(&vbasedev->migration_state);
     return ret;
 }
 
@@ -214,6 +238,11 @@ add_blocker:
 
 void vfio_migration_finalize(VFIODevice *vbasedev)
 {
+
+    if (vbasedev->migration_state.notify) {
+        remove_migration_state_change_notifier(&vbasedev->migration_state);
+    }
+
     if (vbasedev->vm_state) {
         qemu_del_vm_change_state_handler(vbasedev->vm_state);
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 14b0a86c0035..bd3d47b005cb 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -146,5 +146,6 @@ vfio_display_edid_write_error(void) ""
 
 # migration.c
 vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
-vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
-vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
+vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
+vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
+vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3d18eb146b33..28f55f66d019 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -123,6 +123,7 @@ typedef struct VFIODevice {
     VMChangeStateEntry *vm_state;
     uint32_t device_state;
     int vm_running;
+    Notifier migration_state;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.7.0


