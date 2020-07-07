Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C7120658
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2czEYgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C7120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqFx-0003xu-Rk
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7O-0002aD-Ic
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45427
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq79-0006ra-1I
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SajwbOA3q+BFVEaYguEWZE2v+qy5fEMthmeAVWqKVoo=;
 b=e2czEYgI+V81CqoDLy+xM8RN2C/tf5KvoXYtltqgLTvGlqm/jFqlcMgrocUOLW7+r9tQNa
 lGaw9FuqaYmcURcf3HatajgzcT5aWMiI4yoqczM+DJVjLa8R2OSSEHXMIHHRtxqreEJwXM
 +j6oJdVljtcYyPJ0b2S9m3KuEkxssBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-jMV7hr5cO8KFfhZUqSsTdw-1; Tue, 07 Jul 2020 12:06:29 -0400
X-MC-Unique: jMV7hr5cO8KFfhZUqSsTdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 558948C99E3;
 Tue,  7 Jul 2020 16:06:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6710100238E;
 Tue,  7 Jul 2020 16:06:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 106C011856E7; Tue,  7 Jul 2020 18:06:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 35/45] error: Eliminate error_propagate() with Coccinelle,
 part 2
Date: Tue,  7 Jul 2020 18:06:03 +0200
Message-Id: <20200707160613.848843-36-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When all we do with an Error we receive into a local variable is
propagating to somewhere else, we can just as well receive it there
right away.  The previous commit did that with a Coccinelle script I
consider fairly trustworthy.  This commit uses the same script with
the matching of return taken out, i.e. we convert

    if (!foo(..., &err)) {
        ...
        error_propagate(errp, err);
        ...
    }

to

    if (!foo(..., errp)) {
        ...
        ...
    }

This is unsound: @err could still be read between afterwards.  I don't
know how to express "no read of @err without an intervening write" in
Coccinelle.  Instead, I manually double-checked for uses of @err.

Suboptimal line breaks tweaked manually.  qdev_realize() simplified
further to placate scripts/checkpatch.pl.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c              |  6 ++----
 block/blkdebug.c     |  7 ++-----
 block/blklogwrites.c |  3 +--
 block/blkverify.c    |  3 +--
 block/crypto.c       |  4 +---
 block/file-posix.c   |  6 ++----
 block/file-win32.c   |  6 ++----
 block/gluster.c      |  4 +---
 block/iscsi.c        |  3 +--
 block/nbd.c          |  8 ++------
 block/qcow2.c        | 13 ++++---------
 block/raw-format.c   |  4 +---
 block/sheepdog.c     |  8 ++------
 block/ssh.c          |  3 +--
 block/throttle.c     |  4 +---
 block/vmdk.c         |  4 +---
 block/vpc.c          |  3 +--
 block/vvfat.c        |  3 +--
 blockdev.c           |  3 +--
 hw/intc/xics.c       |  4 +---
 hw/vfio/pci.c        |  3 +--
 net/tap.c            |  3 +--
 qom/object.c         |  4 +---
 23 files changed, 32 insertions(+), 77 deletions(-)

diff --git a/block.c b/block.c
index 7f3091da63..60d2945c2c 100644
--- a/block.c
+++ b/block.c
@@ -1629,8 +1629,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     assert(options != NULL && bs->options != options);
 
     opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto fail_opts;
     }
@@ -4090,8 +4089,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     /* Process generic block layer options */
     opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, reopen_state->options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, reopen_state->options, errp)) {
         ret = -EINVAL;
         goto error;
     }
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 3c0a9d45cc..9c08d8a005 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -359,7 +359,6 @@ static int blkdebug_parse_perm_list(uint64_t *dest, QDict *options,
     QObject *crumpled_subqdict = NULL;
     Visitor *v = NULL;
     BlockPermissionList *perm_list = NULL, *element;
-    Error *local_err = NULL;
 
     *dest = 0;
 
@@ -375,8 +374,7 @@ static int blkdebug_parse_perm_list(uint64_t *dest, QDict *options,
     }
 
     v = qobject_input_visitor_new(crumpled_subqdict);
-    if (!visit_type_BlockPermissionList(v, NULL, &perm_list, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_BlockPermissionList(v, NULL, &perm_list, errp)) {
         ret = -EINVAL;
         goto out;
     }
@@ -471,8 +469,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t align;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto out;
     }
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 0c93e926b1..57315f56b4 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -149,9 +149,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     bool log_append;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/blkverify.c b/block/blkverify.c
index 666d626c57..4aed53ab59 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -116,8 +116,7 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/crypto.c b/block/crypto.c
index 301fa4da8e..5b2b97ea2f 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -212,7 +212,6 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 {
     BlockCrypto *crypto = bs->opaque;
     QemuOpts *opts = NULL;
-    Error *local_err = NULL;
     int ret = -EINVAL;
     QCryptoBlockOpenOptions *open_opts = NULL;
     unsigned int cflags = 0;
@@ -228,8 +227,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         bs->file->bs->supported_write_flags;
 
     opts = qemu_opts_create(opts_spec, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         goto cleanup;
     }
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 78f9dc8ab4..70cbb8460c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -490,8 +490,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     OnOffAuto locking;
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto fail;
     }
@@ -999,8 +998,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
 
     /* Handle options changes */
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, state->options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, state->options, errp)) {
         ret = -EINVAL;
         goto out;
     }
diff --git a/block/file-win32.c b/block/file-win32.c
index 5f8015319a..ab69bd811a 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -338,8 +338,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     s->type = FTYPE_FILE;
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto fail;
     }
@@ -738,8 +737,7 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
 
     QemuOpts *opts = qemu_opts_create(&raw_runtime_opts, NULL, 0,
                                       &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto done;
     }
diff --git a/block/gluster.c b/block/gluster.c
index b68bd32d47..c620880f27 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -811,12 +811,10 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
     int ret = 0;
     BlockdevOptionsGluster *gconf = NULL;
     QemuOpts *opts;
-    Error *local_err = NULL;
     const char *filename, *logfile;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto out;
     }
diff --git a/block/iscsi.c b/block/iscsi.c
index a4383150d4..78d58ff400 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1792,8 +1792,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     int i, ret = 0, timeout = 0, lun;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto out;
     }
diff --git a/block/nbd.c b/block/nbd.c
index 1331307ffb..6876da04a7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1726,7 +1726,6 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
     SocketAddress *saddr = NULL;
     QDict *addr = NULL;
     Visitor *iv = NULL;
-    Error *local_err = NULL;
 
     qdict_extract_subqdict(options, &addr, "server.");
     if (!qdict_size(addr)) {
@@ -1739,8 +1738,7 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
         goto done;
     }
 
-    if (!visit_type_SocketAddress(iv, NULL, &saddr, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_SocketAddress(iv, NULL, &saddr, errp)) {
         goto done;
     }
 
@@ -1835,12 +1833,10 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
 {
     BDRVNBDState *s = bs->opaque;
     QemuOpts *opts;
-    Error *local_err = NULL;
     int ret = -EINVAL;
 
     opts = qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         goto error;
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index d9e64f51ad..a9137a535b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -977,8 +977,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     encryptfmt = qdict_get_try_str(encryptopts, "format");
 
     opts = qemu_opts_create(&qcow2_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto fail;
     }
@@ -1582,8 +1581,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     /* read qcow2 extensions */
     if (qcow2_read_extensions(bs, header.header_length, ext_end, NULL,
-                              flags, &update_header, &local_err)) {
-        error_propagate(errp, local_err);
+                              flags, &update_header, errp)) {
         ret = -EINVAL;
         goto fail;
     }
@@ -3355,7 +3353,6 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     int version;
     int refcount_order;
     uint64_t* refcount_table;
-    Error *local_err = NULL;
     int ret;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
@@ -3581,9 +3578,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3663,9 +3659,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
diff --git a/block/raw-format.c b/block/raw-format.c
index a66fbe77c7..42ec50802b 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -74,13 +74,11 @@ static QemuOptsList raw_create_opts = {
 static int raw_read_options(QDict *options, uint64_t *offset, bool *has_size,
                             uint64_t *size, Error **errp)
 {
-    Error *local_err = NULL;
     QemuOpts *opts = NULL;
     int ret;
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto end;
     }
diff --git a/block/sheepdog.c b/block/sheepdog.c
index e3bcb05f60..a6a91442c9 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -532,7 +532,6 @@ static SocketAddress *sd_server_config(QDict *options, Error **errp)
     QDict *server = NULL;
     Visitor *iv = NULL;
     SocketAddress *saddr = NULL;
-    Error *local_err = NULL;
 
     qdict_extract_subqdict(options, &server, "server.");
 
@@ -541,8 +540,7 @@ static SocketAddress *sd_server_config(QDict *options, Error **errp)
         goto done;
     }
 
-    if (!visit_type_SocketAddress(iv, NULL, &saddr, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_SocketAddress(iv, NULL, &saddr, errp)) {
         goto done;
     }
 
@@ -1549,14 +1547,12 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t snap_id;
     char *buf = NULL;
     QemuOpts *opts;
-    Error *local_err = NULL;
 
     s->bs = bs;
     s->aio_context = bdrv_get_aio_context(bs);
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto err_no_fd;
     }
diff --git a/block/ssh.c b/block/ssh.c
index 13a2964621..f00b89684a 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -622,8 +622,7 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
 
     /* Translate legacy options */
     opts = qemu_opts_create(&ssh_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         goto fail;
     }
 
diff --git a/block/throttle.c b/block/throttle.c
index c0802addbb..1c1ac57bee 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -46,11 +46,9 @@ static int throttle_parse_options(QDict *options, char **group, Error **errp)
 {
     int ret;
     const char *group_name;
-    Error *local_err = NULL;
     QemuOpts *opts = qemu_opts_create(&throttle_opts, NULL, 0, &error_abort);
 
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto fin;
     }
diff --git a/block/vmdk.c b/block/vmdk.c
index 4d42d2fbe1..9a09193f3b 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2250,7 +2250,6 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
 {
     int ret;
     BlockBackend *blk = NULL;
-    Error *local_err = NULL;
 
     ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
@@ -2259,9 +2258,8 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
 
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
index a5bab92f64..c8cf3957bc 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -235,8 +235,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     opts = qemu_opts_create(&vpc_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/vvfat.c b/block/vvfat.c
index e3e27e0d6c..24d36220d3 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1149,8 +1149,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 #endif
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/blockdev.c b/blockdev.c
index 705869d849..1f254e7110 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -863,8 +863,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
 
     legacy_opts = qemu_opts_create(&qemu_legacy_drive_opts, NULL, 0,
                                    &error_abort);
-    if (!qemu_opts_absorb_qdict(legacy_opts, bs_opts, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(legacy_opts, bs_opts, errp)) {
         goto fail;
     }
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c1feb649fb..68f9d44feb 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -376,7 +376,6 @@ static const TypeInfo icp_info = {
 
 Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
 {
-    Error *local_err = NULL;
     Object *obj;
 
     obj = object_new(type);
@@ -384,9 +383,8 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     object_unref(obj);
     object_property_set_link(obj, ICP_PROP_XICS, OBJECT(xi), &error_abort);
     object_property_set_link(obj, ICP_PROP_CPU, cpu, &error_abort);
-    if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
+    if (!qdev_realize(DEVICE(obj), NULL, errp)) {
         object_unparent(obj);
-        error_propagate(errp, local_err);
         obj = NULL;
     }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c1802441d9..fb51fc9f6e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -292,8 +292,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
 
     if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
-        error_propagate(errp, err);
+                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->intx.interrupt);
         return -errno;
diff --git a/net/tap.c b/net/tap.c
index 2d8d83a30b..f9dcc2ef51 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -836,9 +836,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         for (i = 0; i < nfds; i++) {
-            fd = monitor_fd_param(cur_mon, fds[i], &err);
+            fd = monitor_fd_param(cur_mon, fds[i], errp);
             if (fd == -1) {
-                error_propagate(errp, err);
                 ret = -1;
                 goto free_fail;
             }
diff --git a/qom/object.c b/qom/object.c
index 84b7b52dda..6b0d06c4fa 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1585,11 +1585,9 @@ char *object_property_print(Object *obj, const char *name, bool human,
 {
     Visitor *v;
     char *string = NULL;
-    Error *local_err = NULL;
 
     v = string_output_visitor_new(human, &string);
-    if (!object_property_get(obj, name, v, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!object_property_get(obj, name, v, errp)) {
         goto out;
     }
 
-- 
2.26.2


