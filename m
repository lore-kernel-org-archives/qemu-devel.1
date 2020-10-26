Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50927C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D4E20795
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un8veSEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D4E20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8ZZ-00008p-HY
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX8FQ-00025K-Mj
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX8FM-0001wd-Ed
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603740815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RB29zN2ZLmvhaOvbSEqXVHJFtZe9IUk8oVxnDNFzGFw=;
 b=Un8veSEusEPTU/yaHxhHuqLBfc/YGnjVpq55yoX7f3iN5hESGhLr1Di2C7xvbKVCcoUC/M
 qSUxKw5cp2RxQ2t8pFiQ+6m5hwft3AJcarPaIYLTFxftQGTXS40U6kDojD3Q+rbj8YWK1t
 b19ajQU/Wzr/7mXUiAHdkeNeuUbGcF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-7knpQNVhORias_HSJZ0WYQ-1; Mon, 26 Oct 2020 15:33:33 -0400
X-MC-Unique: 7knpQNVhORias_HSJZ0WYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 667311084C96;
 Mon, 26 Oct 2020 19:33:32 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CEA95C1BB;
 Mon, 26 Oct 2020 19:33:26 +0000 (UTC)
Subject: [PULL 07/32] vfio: Register SaveVMHandlers for VFIO device
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Oct 2020 13:33:26 -0600
Message-ID: <160374080595.22414.14518375812756765441.stgit@gimli.home>
In-Reply-To: <160374054442.22414.10832953989449611268.stgit@gimli.home>
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Cornelia Huck <cohuck@redhat.com>, Neo Jia <cjia@nvidia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kirti Wankhede <kwankhede@nvidia.com>

Define flags to be used as delimiter in migration stream for VFIO devices.
Added .save_setup and .save_cleanup functions. Map & unmap migration
region from these functions at source during saving or pre-copy phase.

Set VFIO device state depending on VM's state. During live migration, VM is
running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
device. During save-restore, VM is paused, _SAVING state is set for VFIO device.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/migration.c  |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |    2 +
 2 files changed, 104 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 888a615d39ea..d3ef9e18f39c 100644
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
@@ -129,6 +148,75 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
     return 0;
 }
 
+static void vfio_migration_cleanup(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (migration->region.mmaps) {
+        vfio_region_unmap(&migration->region);
+    }
+}
+
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
+         * Calling vfio_region_mmap() from migration thread. Memory API called
+         * from this function require locking the iothread when called from
+         * outside the main loop thread.
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
+
+    vfio_migration_cleanup(vbasedev);
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
@@ -215,6 +303,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
     int ret;
     Object *obj;
     VFIOMigration *migration;
+    char id[256] = "";
+    g_autofree char *path = NULL, *oid = NULL;
 
     if (!vbasedev->ops->vfio_get_object) {
         return -EINVAL;
@@ -244,6 +334,18 @@ static int vfio_migration_init(VFIODevice *vbasedev,
 
     migration = vbasedev->migration;
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


