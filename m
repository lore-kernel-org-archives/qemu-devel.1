Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CCCC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BB52072C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BB52072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNx1k-0004NQ-3I
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jNx0u-0002iU-24
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jNx0s-0000hw-D4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:40330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jNx0s-0000g0-5u
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:26 -0400
Received: from vgpu0.qa.sw.ru ([10.94.1.107])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jNx0h-0002VQ-TU; Mon, 13 Apr 2020 14:12:16 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC patch v1 3/3] migration/savevm: use qemu-file buffered mode for
 non-cached bdrv
Date: Mon, 13 Apr 2020 14:12:14 +0300
Message-Id: <1586776334-641239-4-git-send-email-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: den@openvz.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes internal snapshots of HDD placed qcow2 images opened with
O_DIRECT flag 4 times faster.

The test:
   creates 500M internal snapshot for a cow2 image placed on HDD
Result times:
   with the patch: ~6 sec
   without patch: ~24 sec

This happens because the internal snapshot saving produces a lot of
pwrites, because of flushing the internal buffers with non-aligned
io vectors and direct calling qemu_fflush.

To fix it, we introduce an internal pointer and size aligned buffer.
The most of the time the buffer is flushed only when it's full regardless
of direct calling qemu_fflush. When the buffer is full, it is written
asynchronously.

This gives us a cople of advantages leading to performance improvement:

1. beacause of pointer and size aligned buffers we can use asynchronous
   os write syscall, like io_submit
2. when some buffer is being written, another buffer is filled with
   data.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/savevm.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c00a680..db0cac9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -63,6 +63,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "block/block_int.h"
 
 const unsigned int postcopy_ram_discard_version = 0;
 
@@ -153,6 +154,12 @@ static int bdrv_fclose(void *opaque, Error **errp)
     return bdrv_flush(opaque);
 }
 
+static bool qemu_file_is_buffered(void *opaque)
+{
+    BlockDriverState *bs = (BlockDriverState *) opaque;
+    return !!(bs->open_flags & BDRV_O_NOCACHE);
+}
+
 static const QEMUFileOps bdrv_read_ops = {
     .get_buffer = block_get_buffer,
     .close =      bdrv_fclose
@@ -160,7 +167,8 @@ static const QEMUFileOps bdrv_read_ops = {
 
 static const QEMUFileOps bdrv_write_ops = {
     .writev_buffer  = block_writev_buffer,
-    .close          = bdrv_fclose
+    .close          = bdrv_fclose,
+    .enable_buffered = qemu_file_is_buffered
 };
 
 static QEMUFile *qemu_fopen_bdrv(BlockDriverState *bs, int is_writable)
@@ -2624,7 +2632,7 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
-int save_snapshot(const char *name, Error **errp)
+static int coroutine_fn save_snapshot_fn(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2747,6 +2755,32 @@ int save_snapshot(const char *name, Error **errp)
     return ret;
 }
 
+ typedef struct SaveVMParams {
+     const char *name;
+     Error **errp;
+     int ret;
+ } SaveVMParams;
+
+static void coroutine_fn save_snapshot_entry(void *opaque)
+{
+    SaveVMParams *p = (SaveVMParams *) opaque;
+    p->ret = save_snapshot_fn(p->name, p->errp);
+}
+
+int save_snapshot(const char *name, Error **errp)
+{
+    SaveVMParams p = (SaveVMParams) {
+        .name = name,
+        .errp = errp,
+        .ret = -EINPROGRESS,
+    };
+
+    Coroutine *co = qemu_coroutine_create(save_snapshot_entry, &p);
+    aio_co_enter(qemu_get_aio_context(), co);
+    AIO_WAIT_WHILE(qemu_get_aio_context(), p.ret == -EINPROGRESS);
+    return p.ret;
+}
+
 void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
                                 Error **errp)
 {
-- 
1.8.3.1


