Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8AFC388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239D62085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqVml7bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239D62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8HT-0004me-15
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX8G3-0002vf-0N
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX8G1-000234-8q
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603740856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RY4iawfzxdC9jpmHJQ/CjB7Vgk6Rr4Z0BCUCzKC7fMM=;
 b=hqVml7bIC636pPtCuHe3BmAICW4jtUVS76oteEk+OH+fzGUA7FfcC2IUjOCUhrEISfv45w
 L2j6OsoUverbRPpaeQEJS/z4b02wOIH1OKeyy9TDaNr8MouhUGyPpekfwMR+kPNJSDlkXH
 z8z7SRWudiTZuLGHnwXB+jdtpe9MLO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-9oWWcQQtPBCuuW6YI_10Og-1; Mon, 26 Oct 2020 15:34:12 -0400
X-MC-Unique: 9oWWcQQtPBCuuW6YI_10Og-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15C0487507C;
 Mon, 26 Oct 2020 19:34:11 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C281D5C1BB;
 Mon, 26 Oct 2020 19:34:10 +0000 (UTC)
Subject: [PULL 12/32] vfio: Add function to start and stop dirty pages tracking
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Oct 2020 13:34:10 -0600
Message-ID: <160374085041.22414.4311280121325823797.stgit@gimli.home>
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kirti Wankhede <kwankhede@nvidia.com>

Call VFIO_IOMMU_DIRTY_PAGES ioctl to start and stop dirty pages tracking
for VFIO devices.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/migration.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 93f8fe7bd869..ffedbcca179d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -11,6 +11,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/cutils.h"
 #include <linux/vfio.h>
+#include <sys/ioctl.h>
 
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
@@ -391,10 +392,40 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     return qemu_file_get_error(f);
 }
 
+static int vfio_set_dirty_page_tracking(VFIODevice *vbasedev, bool start)
+{
+    int ret;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOContainer *container = vbasedev->group->container;
+    struct vfio_iommu_type1_dirty_bitmap dirty = {
+        .argsz = sizeof(dirty),
+    };
+
+    if (start) {
+        if (migration->device_state & VFIO_DEVICE_STATE_SAVING) {
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
+        return -errno;
+    }
+    return ret;
+}
+
 static void vfio_migration_cleanup(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
 
+    vfio_set_dirty_page_tracking(vbasedev, false);
+
     if (migration->region.mmaps) {
         vfio_region_unmap(&migration->region);
     }
@@ -435,6 +466,11 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
+    ret = vfio_set_dirty_page_tracking(vbasedev, true);
+    if (ret) {
+        return ret;
+    }
+
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
     ret = qemu_file_get_error(f);


