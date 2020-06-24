Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A38C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21D22073E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJxyvpNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21D22073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8Yv-0000yN-5Y
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VD-0002yu-NP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:43:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8V6-00053y-EO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXTE73Qf40PfPxoDzgyk1MV10WFjaEhopvA6yEEFtDg=;
 b=IJxyvpNrt6li9KTR9ZQWbbVuvk9hQQEKiwowFuQO1iQeB3Dojsd5uK1bilW+tfpr6senmG
 UbrhkpCNsyeDOVKYAW+cjM6zN3n6qgehy4TayRUh+sp0r0CUCp3KjLR68vnYO8ufSQJ57d
 mJE/kPIkfLtjwYZ8SUQxtSkaYsyCWRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-2k-TKOI1N0uM7F6HKpPTeg-1; Wed, 24 Jun 2020 12:43:50 -0400
X-MC-Unique: 2k-TKOI1N0uM7F6HKpPTeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE3ED107ACF2;
 Wed, 24 Jun 2020 16:43:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F54C7A01A;
 Wed, 24 Jun 2020 16:43:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC3621138473; Wed, 24 Jun 2020 18:43:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/46] error: Avoid error_propagate() when error is not used
 here
Date: Wed, 24 Jun 2020 18:43:04 +0200
Message-Id: <20200624164344.3778251-7-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When all we do with an Error we receive into a local variable is
propagating to somewhere else, we can just as well receive it there
right away.  Coccinelle script:

    @@
    identifier fun, err, errp;
    expression list args;
    @@
    -    fun(args, &err);
    +    fun(args, errp);
         ... when != err
             when strict
    -    error_propagate(errp, err);

    @@
    identifier fun, err, errp;
    expression list args;
    expression ret;
    @@
    -    ret = fun(args, &err);
    +    ret = fun(args, errp);
         ... when != err
             when strict
    -    error_propagate(errp, err);

    @@
    identifier fun, err, errp;
    expression list args;
    expression ret;
    @@
    -    ret = fun(args, &err);
    +    ret = fun(args, errp);
         ... when != err
             when strict
         if (
    (
             ret
    |
             !ret
    |
             ret == 0
    |
             ret != 0
    |
             ret < 0
    |
             ret != NULL
    |
             ret == NULL
    )
            )
         {
             ... when != err
                 when strict
    -        error_propagate(errp, err);
             ...
         }

    @@
    identifier fun, err, errp;
    expression list args;
    @@
         if (
    (
    -        fun(args, &err)
    +        fun(args, errp)
    |
    -        !fun(args, &err)
    +        !fun(args, errp)
    |
    -        fun(args, &err) == 0
    +        fun(args, errp) == 0
    |
    -        fun(args, &err) != 0
    +        fun(args, errp) != 0
    |
    -        fun(args, &err) < 0
    +        fun(args, errp) < 0
    |
    -        fun(args, &err) == NULL
    +        fun(args, errp) == NULL
    |
    -        fun(args, &err) != NULL
    +        fun(args, errp) != NULL
    )
            )
         {
             ... when != err;
                 when strict
    -        error_propagate(errp, err);
             ...
         }

The first two rules are prone to fail with "error_propagate(...)
... reachable by inconsistent control-flow paths".  Script without
them re-run where that happens.

Manually double-check @err is not used afterwards.  Dereferencing it
would be use after free, but checking whether it's null would be
legitimate.  One such change to qbus_realize() backed out.

Suboptimal line breaks tweaked manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/cryptodev-vhost-user.c |  3 +--
 block.c                         |  3 +--
 block/file-posix.c              |  8 ++------
 block/parallels.c               |  3 +--
 block/qcow.c                    |  3 +--
 block/qcow2.c                   | 10 +++-------
 block/qed.c                     |  3 +--
 block/replication.c             |  4 +---
 block/vhdx.c                    |  3 +--
 block/vmdk.c                    |  7 ++-----
 block/vpc.c                     |  3 +--
 blockdev.c                      | 10 +++-------
 dump/dump.c                     |  7 ++-----
 hw/intc/xics_kvm.c              |  3 +--
 hw/s390x/s390-pci-bus.c         |  4 +---
 hw/usb/bus.c                    |  4 +---
 hw/vfio/pci.c                   | 10 +++-------
 iothread.c                      |  3 +--
 qdev-monitor.c                  |  3 +--
 qga/commands-win32.c            |  3 +--
 util/main-loop.c                |  4 +---
 util/qemu-option.c              |  3 +--
 22 files changed, 31 insertions(+), 73 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 8b8cbc4223..dbe5a8aae6 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -209,8 +209,7 @@ static void cryptodev_vhost_user_init(
         backend->conf.peers.ccs[i] = cc;
 
         if (i == 0) {
-            if (!qemu_chr_fe_init(&s->chr, chr, &local_err)) {
-                error_propagate(errp, local_err);
+            if (!qemu_chr_fe_init(&s->chr, chr, errp)) {
                 return;
             }
         }
diff --git a/block.c b/block.c
index 6dbcb7e083..30a72bc4c2 100644
--- a/block.c
+++ b/block.c
@@ -5680,10 +5680,9 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
     if (bs->open_flags & BDRV_O_INACTIVE) {
         bs->open_flags &= ~BDRV_O_INACTIVE;
         bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-        ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &local_err);
+        ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
-            error_propagate(errp, local_err);
             return;
         }
         bdrv_set_perm(bs, perm, shared_perm);
diff --git a/block/file-posix.c b/block/file-posix.c
index 3ab8f5a0fa..2294bf5d00 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3336,7 +3336,6 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp)
 {
     BDRVRawState *s = bs->opaque;
-    Error *local_err = NULL;
     int ret;
 
 #if defined(__APPLE__) && defined(__MACH__)
@@ -3401,9 +3400,8 @@ hdev_open_Mac_error:
 
     s->type = FTYPE_FILE;
 
-    ret = raw_open_common(bs, options, flags, 0, true, &local_err);
+    ret = raw_open_common(bs, options, flags, 0, true, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
 #if defined(__APPLE__) && defined(__MACH__)
         if (*bsd_path) {
             filename = bsd_path;
@@ -3679,14 +3677,12 @@ static int cdrom_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
     BDRVRawState *s = bs->opaque;
-    Error *local_err = NULL;
     int ret;
 
     s->type = FTYPE_CD;
 
-    ret = raw_open_common(bs, options, flags, 0, true, &local_err);
+    ret = raw_open_common(bs, options, flags, 0, true, errp);
     if (ret) {
-        error_propagate(errp, local_err);
         return ret;
     }
 
diff --git a/block/parallels.c b/block/parallels.c
index 63a1cde8af..a84ec6a518 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -646,9 +646,8 @@ static int coroutine_fn parallels_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto done;
     }
 
diff --git a/block/qcow.c b/block/qcow.c
index ee5d35fe20..dca2a1fe7d 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -973,9 +973,8 @@ static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 0cd2e6757e..e81c284319 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1583,8 +1583,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     /* read qcow2 extensions */
     if (qcow2_read_extensions(bs, header.header_length, ext_end, NULL,
-                              flags, &update_header, &local_err)) {
-        error_propagate(errp, local_err);
+                              flags, &update_header, errp)) {
         ret = -EINVAL;
         goto fail;
     }
@@ -3356,7 +3355,6 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     int version;
     int refcount_order;
     uint64_t* refcount_table;
-    Error *local_err = NULL;
     int ret;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
@@ -3582,9 +3580,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
     blk = blk_new_open(NULL, NULL, options,
                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH,
-                       &local_err);
+                       errp);
     if (blk == NULL) {
-        error_propagate(errp, local_err);
         ret = -EIO;
         goto out;
     }
@@ -3664,9 +3661,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
     blk = blk_new_open(NULL, NULL, options,
                        BDRV_O_RDWR | BDRV_O_NO_BACKING | BDRV_O_NO_IO,
-                       &local_err);
+                       errp);
     if (blk == NULL) {
-        error_propagate(errp, local_err);
         ret = -EIO;
         goto out;
     }
diff --git a/block/qed.c b/block/qed.c
index c0c65015c7..e369fd360a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -749,9 +749,8 @@ static int coroutine_fn bdrv_qed_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/replication.c b/block/replication.c
index ccf7b78160..aa7164dbe3 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -369,7 +369,6 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
 {
     BDRVReplicationState *s = bs->opaque;
     BlockReopenQueue *reopen_queue = NULL;
-    Error *local_err = NULL;
 
     if (writable) {
         s->orig_hidden_read_only = bdrv_is_read_only(s->hidden_disk->bs);
@@ -394,8 +393,7 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     }
 
     if (reopen_queue) {
-        bdrv_reopen_multiple(reopen_queue, &local_err);
-        error_propagate(errp, local_err);
+        bdrv_reopen_multiple(reopen_queue, errp);
     }
 
     bdrv_subtree_drained_end(s->hidden_disk->bs);
diff --git a/block/vhdx.c b/block/vhdx.c
index fa9e544a5e..ac5a9094c4 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2086,9 +2086,8 @@ static int coroutine_fn vhdx_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/vmdk.c b/block/vmdk.c
index 62da465126..9a09193f3b 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2250,19 +2250,16 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
 {
     int ret;
     BlockBackend *blk = NULL;
-    Error *local_err = NULL;
 
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto exit;
     }
 
     blk = blk_new_open(filename, NULL, NULL,
                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                       &local_err);
+                       errp);
     if (blk == NULL) {
-        error_propagate(errp, local_err);
         ret = -EIO;
         goto exit;
     }
diff --git a/block/vpc.c b/block/vpc.c
index c055591641..36412f764d 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1115,9 +1115,8 @@ static int coroutine_fn vpc_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/blockdev.c b/blockdev.c
index 31d5eaf6bf..b66863c42a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3147,9 +3147,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
                            arg->has_copy_mode, arg->copy_mode,
                            arg->has_auto_finalize, arg->auto_finalize,
                            arg->has_auto_dismiss, arg->auto_dismiss,
-                           &local_err);
+                           errp);
     bdrv_unref(target_bs);
-    error_propagate(errp, local_err);
 out:
     aio_context_release(aio_context);
 }
@@ -3177,7 +3176,6 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     AioContext *aio_context;
     AioContext *old_context;
     BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
-    Error *local_err = NULL;
     bool zero_target;
     int ret;
 
@@ -3219,8 +3217,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                            has_copy_mode, copy_mode,
                            has_auto_finalize, auto_finalize,
                            has_auto_dismiss, auto_dismiss,
-                           &local_err);
-    error_propagate(errp, local_err);
+                           errp);
 out:
     aio_context_release(aio_context);
 }
@@ -3439,8 +3436,7 @@ void qmp_change_backing_file(const char *device,
     }
 
     if (ro) {
-        bdrv_reopen_set_read_only(image_bs, true, &local_err);
-        error_propagate(errp, local_err);
+        bdrv_reopen_set_read_only(image_bs, true, errp);
     }
 
 out:
diff --git a/dump/dump.c b/dump/dump.c
index 248ea06370..383bc7876b 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1031,14 +1031,11 @@ out:
 
 static void write_dump_header(DumpState *s, Error **errp)
 {
-     Error *local_err = NULL;
-
     if (s->dump_info.d_class == ELFCLASS32) {
-        create_header32(s, &local_err);
+        create_header32(s, errp);
     } else {
-        create_header64(s, &local_err);
+        create_header64(s, errp);
     }
-    error_propagate(errp, local_err);
 }
 
 static size_t dump_bitmap_get_bufsize(DumpState *s)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 8d6156578f..6705220380 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -316,9 +316,8 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
             continue;
         }
 
-        ret = ics_set_kvm_state_one(ics, i, &local_err);
+        ret = ics_set_kvm_state_one(ics, i, errp);
         if (ret < 0) {
-            error_propagate(errp, local_err);
             return ret;
         }
     }
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 0517901024..be8535304e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -741,7 +741,6 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     BusState *bus;
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
-    Error *local_err = NULL;
 
     DPRINTF("host_init\n");
 
@@ -765,8 +764,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     QTAILQ_INIT(&s->zpci_devs);
 
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
-                             S390_ADAPTER_SUPPRESSIBLE, &local_err);
-    error_propagate(errp, local_err);
+                             S390_ADAPTER_SUPPRESSIBLE, errp);
 }
 
 static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index ba27afe9f2..b17bda3b29 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -723,15 +723,13 @@ static bool usb_get_attached(Object *obj, Error **errp)
 static void usb_set_attached(Object *obj, bool value, Error **errp)
 {
     USBDevice *dev = USB_DEVICE(obj);
-    Error *err = NULL;
 
     if (dev->attached == value) {
         return;
     }
 
     if (value) {
-        usb_device_attach(dev, &err);
-        error_propagate(errp, err);
+        usb_device_attach(dev, errp);
     } else {
         usb_device_detach(dev);
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6838bcc4b3..fb51fc9f6e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -116,7 +116,6 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
-    Error *err = NULL;
 
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
@@ -147,8 +146,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                VFIO_IRQ_SET_ACTION_UNMASK,
                                event_notifier_get_fd(&vdev->intx.unmask),
-                               &err)) {
-        error_propagate(errp, err);
+                               errp)) {
         goto fail_vfio;
     }
 
@@ -294,8 +292,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
 
     if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
-        error_propagate(errp, err);
+                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->intx.interrupt);
         return -errno;
@@ -2741,9 +2738,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (!pdev->failover_pair_id) {
         error_setg(&vdev->migration_blocker,
                 "VFIO device doesn't support migration");
-        ret = migrate_add_blocker(vdev->migration_blocker, &err);
+        ret = migrate_add_blocker(vdev->migration_blocker, errp);
         if (ret) {
-            error_propagate(errp, err);
             error_free(vdev->migration_blocker);
             vdev->migration_blocker = NULL;
             return;
diff --git a/iothread.c b/iothread.c
index cb082b9b26..6f7ac976de 100644
--- a/iothread.c
+++ b/iothread.c
@@ -169,9 +169,8 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
 
     iothread->stopping = false;
     iothread->running = true;
-    iothread->ctx = aio_context_new(&local_error);
+    iothread->ctx = aio_context_new(errp);
     if (!iothread->ctx) {
-        error_propagate(errp, local_error);
         return;
     }
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 13a13a811a..e38030429b 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -808,9 +808,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         qemu_opts_del(opts);
         return;
     }
-    dev = qdev_device_add(opts, &local_err);
+    dev = qdev_device_add(opts, errp);
     if (!dev) {
-        error_propagate(errp, local_err);
         qemu_opts_del(opts);
         return;
     }
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 5ba56327dd..49dd792d2c 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2202,9 +2202,8 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
     }
 
     server = os_version.wProductType != VER_NT_WORKSTATION;
-    product_name = ga_get_win_product_name(&local_err);
+    product_name = ga_get_win_product_name(errp);
     if (product_name == NULL) {
-        error_propagate(errp, local_err);
         return NULL;
     }
 
diff --git a/util/main-loop.c b/util/main-loop.c
index eda63fe4e0..f69f055013 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -148,7 +148,6 @@ int qemu_init_main_loop(Error **errp)
 {
     int ret;
     GSource *src;
-    Error *local_error = NULL;
 
     init_clocks(qemu_timer_notify_cb);
 
@@ -157,9 +156,8 @@ int qemu_init_main_loop(Error **errp)
         return ret;
     }
 
-    qemu_aio_context = aio_context_new(&local_error);
+    qemu_aio_context = aio_context_new(errp);
     if (!qemu_aio_context) {
-        error_propagate(errp, local_error);
         return -EMFILE;
     }
     qemu_notify_bh = qemu_bh_new(notify_event_cb, NULL);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 0ebfd97a98..fd667ea523 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -899,10 +899,9 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
      * (if unlikely) future misuse:
      */
     assert(!defaults || list->merge_lists);
-    opts = qemu_opts_create(list, id, !defaults, &local_err);
+    opts = qemu_opts_create(list, id, !defaults, errp);
     g_free(id);
     if (opts == NULL) {
-        error_propagate(errp, local_err);
         return NULL;
     }
 
-- 
2.26.2


