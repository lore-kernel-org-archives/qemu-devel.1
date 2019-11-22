Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C2C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED062071B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANdVbvNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED062071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYCyP-0004J5-Rp
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6b-0005ra-RA
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6a-00047w-EQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6Y-00047C-IE
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GCovs3esI15RS6WE7LkKVOifRB6723Wo1B6O2zewfs=;
 b=ANdVbvNw71nLqJKkmz2DYJj0H4L8ShP03MqkPdFYIeUF3FqGhFxB/zkO9YvLBBh9exGCvs
 CvTYpfsopyQCCkI5cqy+qyKYuopwO2emXWQewIHqqsrn6RK1KqxauPryAp5jLjz5sbKGMD
 Hfe3T/+Syw4yoEmWbTfZ9PcVoo/G+LM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-7lkAvJxLOW-x9I-tw_IYOA-1; Fri, 22 Nov 2019 11:48:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E57B2107ACC5;
 Fri, 22 Nov 2019 16:48:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2140B66094;
 Fri, 22 Nov 2019 16:48:15 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] monitor/hmp: move hmp_drive_del and hmp_commit to
 block-hmp-cmds.c
Date: Fri, 22 Nov 2019 18:48:01 +0200
Message-Id: <20191122164807.27938-4-mlevitsk@redhat.com>
In-Reply-To: <20191122164807.27938-1-mlevitsk@redhat.com>
References: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7lkAvJxLOW-x9I-tw_IYOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 97 +++++++++++++++++++++++++++++++++-
 blockdev.c                     | 95 ---------------------------------
 2 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index 21ff6fa9a9..8884618238 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -33,7 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "block/block_int.h"
-
+#include "qapi/qapi-commands-block.h"
=20
 void hmp_drive_add(Monitor *mon, const QDict *qdict)
 {
@@ -82,3 +82,98 @@ err:
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
+    /* If this BlockBackend has a device attached to it, its refcount will=
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
index 8e029e9c01..df43e0aaef 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1074,41 +1074,6 @@ static BlockBackend *qmp_get_blk(const char *blk_nam=
e, const char *qdev_id,
     return blk;
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
@@ -3101,66 +3066,6 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitm=
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
--=20
2.17.2


