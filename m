Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B281C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1DF20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZJDdI4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1DF20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48873 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOQK-0003S6-Ds
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMh-0005ln-0E
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMf-0008Sh-EC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBOMf-0008SO-9x
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583783220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHx+HaUnrWvyaU7nvo3TPlf+Bf0xEYTXHBkTZmfYO3Y=;
 b=YZJDdI4g95PDVNDNJSVPvwtLPZY0I00XwCzcRi4PtVkQw1yL4YaeZ/euJIn8xJJuJkmglE
 hZdtRsxlJjYsJlYH9BVWEpsgnEQy8SsHL/pd1AfFDq1LsoH/9d+gCrihykRpKLgPXWCQJF
 oeTDSaLdWSkafsw9OEboSHi4tLmxsX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-ONjEdDiTPlKNTVZ0H5CqQQ-1; Mon, 09 Mar 2020 15:46:59 -0400
X-MC-Unique: ONjEdDiTPlKNTVZ0H5CqQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58A681005509
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:46:58 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DDBE5C28D;
 Mon,  9 Mar 2020 19:46:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mlevitsk@redhat.com,
	thuth@redhat.com
Subject: [PULL 04/12] monitor/hmp: move hmp_drive_del and hmp_commit to
 block-hmp-cmds.c
Date: Mon,  9 Mar 2020 19:46:42 +0000
Message-Id: <20200309194650.160552-5-dgilbert@redhat.com>
In-Reply-To: <20200309194650.160552-1-dgilbert@redhat.com>
References: <20200309194650.160552-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200308092440.23564-5-mlevitsk@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 108 ++++++++++++++++++++++++++++++++-
 blockdev.c                     |  96 +----------------------------
 include/block/block-hmp-cmds.h |   4 ++
 include/sysemu/blockdev.h      |   4 --
 4 files changed, 111 insertions(+), 101 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index bcf35b4b44..ad727a6b08 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -1,7 +1,15 @@
 /*
  * Blockdev HMP commands
  *
- * Copyright (c) 2004 Fabrice Bellard
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
  *
  * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
  * of this software and associated documentation files (the "Software"), t=
o deal
@@ -26,6 +34,7 @@
 #include "hw/boards.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
+#include "qapi/qapi-commands-block.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
@@ -35,7 +44,6 @@
 #include "block/block_int.h"
 #include "block/block-hmp-cmds.h"
=20
-
 void hmp_drive_add(Monitor *mon, const QDict *qdict)
 {
     Error *err =3D NULL;
@@ -83,3 +91,99 @@ err:
         blk_unref(blk);
     }
 }
+
+void hmp_drive_del(Monitor *mon, const QDict *qdict)
+{
+    const char *id =3D qdict_get_str(qdict, "id");
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    AioContext *aio_context;
+    Error *local_err =3D NULL;
+
+    bs =3D bdrv_find_node(id);
+    if (bs) {
+        qmp_blockdev_del(id, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+        return;
+    }
+
+    blk =3D blk_by_name(id);
+    if (!blk) {
+        error_report("Device '%s' not found", id);
+        return;
+    }
+
+    if (!blk_legacy_dinfo(blk)) {
+        error_report("Deleting device added with blockdev-add"
+                     " is not supported");
+        return;
+    }
+
+    aio_context =3D blk_get_aio_context(blk);
+    aio_context_acquire(aio_context);
+
+    bs =3D blk_bs(blk);
+    if (bs) {
+        if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
+            error_report_err(local_err);
+            aio_context_release(aio_context);
+            return;
+        }
+
+        blk_remove_bs(blk);
+    }
+
+    /* Make the BlockBackend and the attached BlockDriverState anonymous *=
/
+    monitor_remove_blk(blk);
+
+    /*
+     * If this BlockBackend has a device attached to it, its refcount will=
 be
+     * decremented when the device is removed; otherwise we have to do so =
here.
+     */
+    if (blk_get_attached_dev(blk)) {
+        /* Further I/O must not pause the guest */
+        blk_set_on_error(blk, BLOCKDEV_ON_ERROR_REPORT,
+                         BLOCKDEV_ON_ERROR_REPORT);
+    } else {
+        blk_unref(blk);
+    }
+
+    aio_context_release(aio_context);
+}
+
+void hmp_commit(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    BlockBackend *blk;
+    int ret;
+
+    if (!strcmp(device, "all")) {
+        ret =3D blk_commit_all();
+    } else {
+        BlockDriverState *bs;
+        AioContext *aio_context;
+
+        blk =3D blk_by_name(device);
+        if (!blk) {
+            error_report("Device '%s' not found", device);
+            return;
+        }
+        if (!blk_is_available(blk)) {
+            error_report("Device '%s' has no medium", device);
+            return;
+        }
+
+        bs =3D blk_bs(blk);
+        aio_context =3D bdrv_get_aio_context(bs);
+        aio_context_acquire(aio_context);
+
+        ret =3D bdrv_commit(bs);
+
+        aio_context_release(aio_context);
+    }
+    if (ret < 0) {
+        error_report("'commit' error for '%s': %s", device, strerror(-ret)=
);
+    }
+}
diff --git a/blockdev.c b/blockdev.c
index 3e44fa766b..b38c247cdc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1039,41 +1039,6 @@ static BlockDriverState *qmp_get_root_bs(const char =
*name, Error **errp)
     return bs;
 }
=20
-void hmp_commit(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    BlockBackend *blk;
-    int ret;
-
-    if (!strcmp(device, "all")) {
-        ret =3D blk_commit_all();
-    } else {
-        BlockDriverState *bs;
-        AioContext *aio_context;
-
-        blk =3D blk_by_name(device);
-        if (!blk) {
-            error_report("Device '%s' not found", device);
-            return;
-        }
-        if (!blk_is_available(blk)) {
-            error_report("Device '%s' has no medium", device);
-            return;
-        }
-
-        bs =3D blk_bs(blk);
-        aio_context =3D bdrv_get_aio_context(bs);
-        aio_context_acquire(aio_context);
-
-        ret =3D bdrv_commit(bs);
-
-        aio_context_release(aio_context);
-    }
-    if (ret < 0) {
-        error_report("'commit' error for '%s': %s", device, strerror(-ret)=
);
-    }
-}
-
 static void blockdev_do_action(TransactionAction *action, Error **errp)
 {
     TransactionActionList list;
@@ -2747,66 +2712,6 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitm=
ap_sha256(const char *node,
     return ret;
 }
=20
-void hmp_drive_del(Monitor *mon, const QDict *qdict)
-{
-    const char *id =3D qdict_get_str(qdict, "id");
-    BlockBackend *blk;
-    BlockDriverState *bs;
-    AioContext *aio_context;
-    Error *local_err =3D NULL;
-
-    bs =3D bdrv_find_node(id);
-    if (bs) {
-        qmp_blockdev_del(id, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
-        return;
-    }
-
-    blk =3D blk_by_name(id);
-    if (!blk) {
-        error_report("Device '%s' not found", id);
-        return;
-    }
-
-    if (!blk_legacy_dinfo(blk)) {
-        error_report("Deleting device added with blockdev-add"
-                     " is not supported");
-        return;
-    }
-
-    aio_context =3D blk_get_aio_context(blk);
-    aio_context_acquire(aio_context);
-
-    bs =3D blk_bs(blk);
-    if (bs) {
-        if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
-            error_report_err(local_err);
-            aio_context_release(aio_context);
-            return;
-        }
-
-        blk_remove_bs(blk);
-    }
-
-    /* Make the BlockBackend and the attached BlockDriverState anonymous *=
/
-    monitor_remove_blk(blk);
-
-    /* If this BlockBackend has a device attached to it, its refcount will=
 be
-     * decremented when the device is removed; otherwise we have to do so =
here.
-     */
-    if (blk_get_attached_dev(blk)) {
-        /* Further I/O must not pause the guest */
-        blk_set_on_error(blk, BLOCKDEV_ON_ERROR_REPORT,
-                         BLOCKDEV_ON_ERROR_REPORT);
-    } else {
-        blk_unref(blk);
-    }
-
-    aio_context_release(aio_context);
-}
-
 void qmp_block_resize(bool has_device, const char *device,
                       bool has_node_name, const char *node_name,
                       int64_t size, Error **errp)
@@ -3814,6 +3719,7 @@ out:
     aio_context_release(aio_context);
 }
=20
+
 void hmp_drive_add_node(Monitor *mon, const char *optstr)
 {
     QemuOpts *opts;
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.=
h
index 0db8a889a1..30b0f56415 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -1,6 +1,7 @@
 /*
  * HMP commands related to the block layer
  *
+ * Copyright (c) 2003-2008 Fabrice Bellard
  * Copyright (c) 2020 Red Hat, Inc.
  *
  * This work is licensed under the terms of the GNU GPL, version 2.
@@ -13,4 +14,7 @@
=20
 void hmp_drive_add(Monitor *mon, const QDict *qdict);
=20
+void hmp_commit(Monitor *mon, const QDict *qdict);
+void hmp_drive_del(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index d34c4920dc..a86d99b3d8 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -57,8 +57,4 @@ QemuOpts *drive_add(BlockInterfaceType type, int index, c=
onst char *file,
 DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_type,
                      Error **errp);
=20
-/* device-hotplug */
-
-void hmp_commit(Monitor *mon, const QDict *qdict);
-void hmp_drive_del(Monitor *mon, const QDict *qdict);
 #endif
--=20
2.24.1


