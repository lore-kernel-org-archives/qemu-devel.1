Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DCFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9F9221FC
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmbBxH81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9F9221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKTo-0005yh-Fz
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKS6-0004DZ-5a
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 15:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKS4-00058i-9n
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 15:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XE94pqoB7OjJCfXtMpOC8+9XOfDVwobB9fXwYDWxpQo=;
 b=LmbBxH813drFfe2MitC7+UlXtNhmHpubj8nyvPJQ0SrVmc+n2Ks49ebUOW1PgpnfVEid7O
 iYrdoMwzSUaxkTCOgSoau2GDt3qBb7v8qHVNMy9YKi3V2lQ9HUS6RcLA0TMM48idMRCHqM
 fJFb9zX7TSRfNXfsGWhnCIF8NgPHJOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-SQ8yx7O8NsC_xwtP6kiutg-1; Sun, 01 Nov 2020 15:59:45 -0500
X-MC-Unique: SQ8yx7O8NsC_xwtP6kiutg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21AB31842166;
 Sun,  1 Nov 2020 20:59:44 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75BD160C0F;
 Sun,  1 Nov 2020 20:59:40 +0000 (UTC)
Subject: [PULL v3 04/32] vfio: Add migration region initialization and
 finalize function
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 13:59:40 -0700
Message-ID: <160426438011.24886.10899498493892012350.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:46:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Cornelia Huck <cohuck@redhat.com>,
 Neo Jia <cjia@nvidia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kirti Wankhede <kwankhede@nvidia.com>

Whether the VFIO device supports migration or not is decided based of
migration region query. If migration region query is successful and migration
region initialization is successful then migration is supported else
migration is blocked.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/meson.build           |    1 
 hw/vfio/migration.c           |  122 +++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |    3 +
 include/hw/vfio/vfio-common.h |    9 +++
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


