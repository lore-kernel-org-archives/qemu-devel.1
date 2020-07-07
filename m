Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E589C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE299206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+oky5xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE299206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIG4-0001TU-3L
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHiB-0000MJ-Lx
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:34:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHi7-0002u8-9f
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mpIBSfF11A1KXjp6dxcI7HgHGwQLHrVM2GxSMgvrQ8=;
 b=G+oky5xnyJ2XkkDayShHyAcH/BHd1SnsE9emvVsnEwpzTIllBR5BRzHkRlox/fyJYcUYO7
 jZuaX+Vik211OUC02P3URk/JdFU5LMyZoTmZV1XERf3gwKP8ew9PAryNDgPqbTrhRGAFR1
 XWQX/JYSMshVcD+lt7kU3gS2S0tQXC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-CTb4cEDnNn-zx_fBU8iUIA-1; Tue, 07 Jul 2020 17:25:14 -0400
X-MC-Unique: CTb4cEDnNn-zx_fBU8iUIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD6ED800C64;
 Tue,  7 Jul 2020 21:25:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B035F6FEF4;
 Tue,  7 Jul 2020 21:25:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 180F1114209A; Tue,  7 Jul 2020 23:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/53] qemu-option: Use returned bool to check for failure
Date: Tue,  7 Jul 2020 23:24:24 +0200
Message-Id: <20200707212503.1495927-15-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit enables conversion of

    foo(..., &err);
    if (err) {
        ...
    }

to

    if (!foo(..., &err)) {
        ...
    }

for QemuOpts functions that now return true / false on success /
error.  Coccinelle script:

    @@
    identifier fun = {
        opts_do_parse, parse_option_bool, parse_option_number,
        parse_option_size, qemu_opt_parse, qemu_opt_rename, qemu_opt_set,
        qemu_opt_set_bool, qemu_opt_set_number, qemu_opts_absorb_qdict,
        qemu_opts_do_parse, qemu_opts_from_qdict_entry, qemu_opts_set,
        qemu_opts_validate
    };
    expression list args, args2;
    typedef Error;
    Error *err;
    @@
    -    fun(args, &err, args2);
    -    if (err)
    +    if (!fun(args, &err, args2))
         {
             ...
         }

A few line breaks tidied up manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200707160613.848843-15-armbru@redhat.com>
---
 block.c                       | 16 ++++++----------
 block/blkdebug.c              |  3 +--
 block/blklogwrites.c          |  3 +--
 block/blkverify.c             |  3 +--
 block/crypto.c                |  3 +--
 block/curl.c                  |  3 +--
 block/file-posix.c            |  6 ++----
 block/file-win32.c            |  6 ++----
 block/gluster.c               | 15 +++++----------
 block/iscsi.c                 |  3 +--
 block/nbd.c                   |  3 +--
 block/parallels.c             |  3 +--
 block/qcow2.c                 |  3 +--
 block/quorum.c                |  3 +--
 block/raw-format.c            |  3 +--
 block/replication.c           |  3 +--
 block/sheepdog.c              |  3 +--
 block/ssh.c                   |  3 +--
 block/throttle.c              |  3 +--
 block/vpc.c                   |  3 +--
 block/vvfat.c                 |  3 +--
 block/vxhs.c                  |  6 ++----
 blockdev.c                    | 11 ++++-------
 chardev/char.c                |  6 ++----
 contrib/ivshmem-server/main.c |  4 ++--
 hw/net/virtio-net.c           |  5 ++---
 hw/smbios/smbios.c            | 24 ++++++++----------------
 qapi/string-input-visitor.c   |  3 +--
 qemu-img.c                    | 19 +++++++------------
 tpm.c                         |  3 +--
 util/qemu-config.c            | 12 ++++--------
 util/qemu-option.c            | 16 ++++++----------
 32 files changed, 71 insertions(+), 132 deletions(-)

diff --git a/block.c b/block.c
index 6dbcb7e083..8d478bdc51 100644
--- a/block.c
+++ b/block.c
@@ -1629,8 +1629,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     assert(options != NULL && bs->options != options);
 
     opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail_opts;
@@ -4091,8 +4090,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     /* Process generic block layer options */
     opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, reopen_state->options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, reopen_state->options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto error;
@@ -6078,8 +6076,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
 
     /* Parse -o options */
     if (options) {
-        qemu_opts_do_parse(opts, options, NULL, &local_err);
-        if (local_err) {
+        if (!qemu_opts_do_parse(opts, options, NULL, &local_err)) {
             goto out;
         }
     }
@@ -6092,8 +6089,8 @@ void bdrv_img_create(const char *filename, const char *fmt,
     }
 
     if (base_filename) {
-        qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename, &local_err);
-        if (local_err) {
+        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename,
+                          &local_err)) {
             error_setg(errp, "Backing file not supported for file format '%s'",
                        fmt);
             goto out;
@@ -6101,8 +6098,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
     }
 
     if (base_fmt) {
-        qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &local_err);
-        if (local_err) {
+        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &local_err)) {
             error_setg(errp, "Backing file format not supported for file "
                              "format '%s'", fmt);
             goto out;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 7194bc7f06..d473dcf8c7 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -472,8 +472,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t align;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto out;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 6753bd9a3e..0c93e926b1 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -149,8 +149,7 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     bool log_append;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         ret = -EINVAL;
         error_propagate(errp, local_err);
         goto fail;
diff --git a/block/blkverify.c b/block/blkverify.c
index 2f261de24b..666d626c57 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -116,8 +116,7 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
diff --git a/block/crypto.c b/block/crypto.c
index 973b57b3eb..301fa4da8e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -228,8 +228,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         bs->file->bs->supported_write_flags;
 
     opts = qemu_opts_create(opts_spec, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         goto cleanup;
     }
diff --git a/block/curl.c b/block/curl.c
index 6e325901dc..d9552efe52 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -695,8 +695,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
 
     qemu_mutex_init(&s->mutex);
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         goto out_noclean;
     }
diff --git a/block/file-posix.c b/block/file-posix.c
index 3ab8f5a0fa..ca896d5b33 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -490,8 +490,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     OnOffAuto locking;
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
@@ -1000,8 +999,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
 
     /* Handle options changes */
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, state->options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, state->options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto out;
diff --git a/block/file-win32.c b/block/file-win32.c
index 221aaf713e..5f8015319a 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -338,8 +338,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     s->type = FTYPE_FILE;
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
@@ -739,8 +738,7 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
 
     QemuOpts *opts = qemu_opts_create(&raw_runtime_opts, NULL, 0,
                                       &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto done;
diff --git a/block/gluster.c b/block/gluster.c
index 31233cac69..b68bd32d47 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -523,8 +523,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
     /* create opts info from runtime_json_opts list */
     opts = qemu_opts_create(&runtime_json_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         goto out;
     }
 
@@ -555,8 +554,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
         /* create opts info from runtime_type_opts list */
         opts = qemu_opts_create(&runtime_type_opts, NULL, 0, &error_abort);
-        qemu_opts_absorb_qdict(opts, backing_options, &local_err);
-        if (local_err) {
+        if (!qemu_opts_absorb_qdict(opts, backing_options, &local_err)) {
             goto out;
         }
 
@@ -586,8 +584,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         if (gsconf->type == SOCKET_ADDRESS_TYPE_INET) {
             /* create opts info from runtime_inet_opts list */
             opts = qemu_opts_create(&runtime_inet_opts, NULL, 0, &error_abort);
-            qemu_opts_absorb_qdict(opts, backing_options, &local_err);
-            if (local_err) {
+            if (!qemu_opts_absorb_qdict(opts, backing_options, &local_err)) {
                 goto out;
             }
 
@@ -635,8 +632,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         } else {
             /* create opts info from runtime_unix_opts list */
             opts = qemu_opts_create(&runtime_unix_opts, NULL, 0, &error_abort);
-            qemu_opts_absorb_qdict(opts, backing_options, &local_err);
-            if (local_err) {
+            if (!qemu_opts_absorb_qdict(opts, backing_options, &local_err)) {
                 goto out;
             }
 
@@ -819,8 +815,7 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
     const char *filename, *logfile;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto out;
diff --git a/block/iscsi.c b/block/iscsi.c
index a8b76979d8..a4383150d4 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1792,8 +1792,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     int i, ret = 0, timeout = 0, lun;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto out;
diff --git a/block/nbd.c b/block/nbd.c
index eed160c5cd..1b30d96a4f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1840,8 +1840,7 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
     int ret = -EINVAL;
 
     opts = qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         goto error;
     }
diff --git a/block/parallels.c b/block/parallels.c
index f26f03c926..32d0ecd398 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -829,8 +829,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail_options;
     }
 
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err != NULL) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         goto fail_options;
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 0cd2e6757e..d9e64f51ad 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -977,8 +977,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     encryptfmt = qdict_get_try_str(encryptopts, "format");
 
     opts = qemu_opts_create(&qcow2_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
diff --git a/block/quorum.c b/block/quorum.c
index 7cf7ab1546..beb3b6dbcc 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -922,8 +922,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     opts = qemu_opts_create(&quorum_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         ret = -EINVAL;
         goto exit;
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index 233d019ca3..a66fbe77c7 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -79,8 +79,7 @@ static int raw_read_options(QDict *options, uint64_t *offset, bool *has_size,
     int ret;
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto end;
diff --git a/block/replication.c b/block/replication.c
index ccf7b78160..5701eeb9e8 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -99,8 +99,7 @@ static int replication_open(BlockDriverState *bs, QDict *options,
 
     ret = -EINVAL;
     opts = qemu_opts_create(&replication_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         goto fail;
     }
 
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 27a30d17f4..a8d396dcdf 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1556,8 +1556,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     s->aio_context = bdrv_get_aio_context(bs);
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto err_no_fd;
diff --git a/block/ssh.c b/block/ssh.c
index 098dbe03c1..13a2964621 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -622,8 +622,7 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
 
     /* Translate legacy options */
     opts = qemu_opts_create(&ssh_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         goto fail;
     }
diff --git a/block/throttle.c b/block/throttle.c
index 0ebbad0743..c0802addbb 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -49,8 +49,7 @@ static int throttle_parse_options(QDict *options, char **group, Error **errp)
     Error *local_err = NULL;
     QemuOpts *opts = qemu_opts_create(&throttle_opts, NULL, 0, &error_abort);
 
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fin;
diff --git a/block/vpc.c b/block/vpc.c
index c055591641..64493f8434 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -235,8 +235,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     opts = qemu_opts_create(&vpc_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
diff --git a/block/vvfat.c b/block/vvfat.c
index 2eb8cbb19f..e3e27e0d6c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1149,8 +1149,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 #endif
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
diff --git a/block/vxhs.c b/block/vxhs.c
index d79fc97df6..237df4f185 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -318,8 +318,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     tcp_opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
 
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
         ret = -EINVAL;
         goto out;
     }
@@ -346,8 +345,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     /* get the 'server.' arguments */
     qdict_extract_subqdict(options, &backing_options, VXHS_OPT_SERVER".");
 
-    qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
-    if (local_err != NULL) {
+    if (!qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err)) {
         ret = -EINVAL;
         goto out;
     }
diff --git a/blockdev.c b/blockdev.c
index 39e12a62b3..625c8ff3f2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -509,8 +509,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         goto err_no_opts;
     }
 
-    qemu_opts_absorb_qdict(opts, bs_opts, &error);
-    if (error) {
+    if (!qemu_opts_absorb_qdict(opts, bs_opts, &error)) {
         error_propagate(errp, error);
         goto early_err;
     }
@@ -827,9 +826,8 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
     };
 
     for (i = 0; i < ARRAY_SIZE(opt_renames); i++) {
-        qemu_opt_rename(all_opts, opt_renames[i].from, opt_renames[i].to,
-                        &local_err);
-        if (local_err) {
+        if (!qemu_opt_rename(all_opts, opt_renames[i].from,
+                             opt_renames[i].to, &local_err)) {
             error_propagate(errp, local_err);
             return NULL;
         }
@@ -867,8 +865,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
 
     legacy_opts = qemu_opts_create(&qemu_legacy_drive_opts, NULL, 0,
                                    &error_abort);
-    qemu_opts_absorb_qdict(legacy_opts, bs_opts, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(legacy_opts, bs_opts, &local_err)) {
         error_propagate(errp, local_err);
         goto fail;
     }
diff --git a/chardev/char.c b/chardev/char.c
index e3051295ac..2fc720fb07 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -444,8 +444,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
         qemu_opt_set(opts, "host", host, &error_abort);
         qemu_opt_set(opts, "port", port, &error_abort);
         if (p[pos] == ',') {
-            qemu_opts_do_parse(opts, p+pos+1, NULL, &local_err);
-            if (local_err) {
+            if (!qemu_opts_do_parse(opts, p + pos + 1, NULL, &local_err)) {
                 error_report_err(local_err);
                 goto fail;
             }
@@ -484,8 +483,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
     }
     if (strstart(filename, "unix:", &p)) {
         qemu_opt_set(opts, "backend", "socket", &error_abort);
-        qemu_opts_do_parse(opts, p, "path", &local_err);
-        if (local_err) {
+        if (!qemu_opts_do_parse(opts, p, "path", &local_err)) {
             error_report_err(local_err);
             goto fail;
         }
diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
index e4cd35f74c..ee08c4ced0 100644
--- a/contrib/ivshmem-server/main.c
+++ b/contrib/ivshmem-server/main.c
@@ -103,8 +103,8 @@ ivshmem_server_parse_args(IvshmemServerArgs *args, int argc, char *argv[])
             break;
 
         case 'l': /* shm size */
-            parse_option_size("shm_size", optarg, &args->shm_size, &err);
-            if (err) {
+            if (!parse_option_size("shm_size", optarg, &args->shm_size,
+                                   &err)) {
                 error_report_err(err);
                 ivshmem_server_help(argv[0]);
                 exit(1);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1596cb1397..48b07eb921 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3137,9 +3137,8 @@ static bool failover_replug_primary(VirtIONet *n, Error **errp)
     }
     qdev_set_parent_bus(n->primary_dev, n->primary_bus);
     n->primary_should_be_hidden = false;
-    qemu_opt_set_bool(n->primary_device_opts,
-                      "partially_hotplugged", true, &err);
-    if (err) {
+    if (!qemu_opt_set_bool(n->primary_device_opts,
+                           "partially_hotplugged", true, &err)) {
         goto out;
     }
     hotplug_ctrl = qdev_get_hotplug_handler(n->primary_dev);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index ffd98727ee..87afcf9142 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -964,8 +964,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
         int size;
         struct smbios_table *table; /* legacy mode only */
 
-        qemu_opts_validate(opts, qemu_smbios_file_opts, &err);
-        if (err) {
+        if (!qemu_opts_validate(opts, qemu_smbios_file_opts, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -1051,8 +1050,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
 
         switch (type) {
         case 0:
-            qemu_opts_validate(opts, qemu_smbios_type0_opts, &err);
-            if (err) {
+            if (!qemu_opts_validate(opts, qemu_smbios_type0_opts, &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -1071,8 +1069,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             }
             return;
         case 1:
-            qemu_opts_validate(opts, qemu_smbios_type1_opts, &err);
-            if (err) {
+            if (!qemu_opts_validate(opts, qemu_smbios_type1_opts, &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -1093,8 +1090,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             }
             return;
         case 2:
-            qemu_opts_validate(opts, qemu_smbios_type2_opts, &err);
-            if (err) {
+            if (!qemu_opts_validate(opts, qemu_smbios_type2_opts, &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -1106,8 +1102,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type2.location, opts, "location");
             return;
         case 3:
-            qemu_opts_validate(opts, qemu_smbios_type3_opts, &err);
-            if (err) {
+            if (!qemu_opts_validate(opts, qemu_smbios_type3_opts, &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -1118,8 +1113,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type3.sku, opts, "sku");
             return;
         case 4:
-            qemu_opts_validate(opts, qemu_smbios_type4_opts, &err);
-            if (err) {
+            if (!qemu_opts_validate(opts, qemu_smbios_type4_opts, &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -1131,16 +1125,14 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type4.part, opts, "part");
             return;
         case 11:
-            qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
-            if (err) {
+            if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, &err)) {
                 error_propagate(errp, err);
                 return;
             }
             save_opt_list(&type11.nvalues, &type11.values, opts, "value");
             return;
         case 17:
-            qemu_opts_validate(opts, qemu_smbios_type17_opts, &err);
-            if (err) {
+            if (!qemu_opts_validate(opts, qemu_smbios_type17_opts, &err)) {
                 error_propagate(errp, err);
                 return;
             }
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 9be418b6d6..730fa4630d 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -318,8 +318,7 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
     uint64_t val;
 
     assert(siv->lm == LM_NONE);
-    parse_option_size(name, siv->string, &val, &err);
-    if (err) {
+    if (!parse_option_size(name, siv->string, &val, &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/qemu-img.c b/qemu-img.c
index bdb9f6aa46..fc405ee171 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -467,8 +467,8 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
     Error *err = NULL;
 
     if (base_filename) {
-        qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename, &err);
-        if (err) {
+        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename,
+                          &err)) {
             error_report("Backing file not supported for file format '%s'",
                          fmt);
             error_free(err);
@@ -476,8 +476,7 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
         }
     }
     if (base_fmt) {
-        qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &err);
-        if (err) {
+        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &err)) {
             error_report("Backing file format not supported for file "
                          "format '%s'", fmt);
             error_free(err);
@@ -2487,8 +2486,7 @@ static int img_convert(int argc, char **argv)
 
         opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
         if (options) {
-            qemu_opts_do_parse(opts, options, NULL, &local_err);
-            if (local_err) {
+            if (!qemu_opts_do_parse(opts, options, NULL, &local_err)) {
                 error_report_err(local_err);
                 ret = -1;
                 goto out;
@@ -3964,8 +3962,7 @@ static int img_resize(int argc, char **argv)
 
     /* Parse size */
     param = qemu_opts_create(&resize_options, NULL, 0, &error_abort);
-    qemu_opt_set(param, BLOCK_OPT_SIZE, size, &err);
-    if (err) {
+    if (!qemu_opt_set(param, BLOCK_OPT_SIZE, size, &err)) {
         error_report_err(err);
         ret = -1;
         qemu_opts_del(param);
@@ -4212,8 +4209,7 @@ static int img_amend(int argc, char **argv)
 
     create_opts = qemu_opts_append(create_opts, bs->drv->create_opts);
     opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
-    qemu_opts_do_parse(opts, options, NULL, &err);
-    if (err) {
+    if (!qemu_opts_do_parse(opts, options, NULL, &err)) {
         error_report_err(err);
         ret = -1;
         goto out;
@@ -5345,8 +5341,7 @@ static int img_measure(int argc, char **argv)
     create_opts = qemu_opts_append(create_opts, bdrv_file.create_opts);
     opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
     if (options) {
-        qemu_opts_do_parse(opts, options, NULL, &local_err);
-        if (local_err) {
+        if (!qemu_opts_do_parse(opts, options, NULL, &local_err)) {
             error_report_err(local_err);
             error_report("Invalid options for file format '%s'", out_fmt);
             goto out;
diff --git a/tpm.c b/tpm.c
index 9c9e20bbb7..75bc937812 100644
--- a/tpm.c
+++ b/tpm.c
@@ -116,8 +116,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     }
 
     /* validate backend specific opts */
-    qemu_opts_validate(opts, be->opts, &local_err);
-    if (local_err) {
+    if (!qemu_opts_validate(opts, be->opts, &local_err)) {
         error_propagate(errp, local_err);
         return 1;
     }
diff --git a/util/qemu-config.c b/util/qemu-config.c
index c0d0e9b8ef..7229c79cc7 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -339,8 +339,7 @@ int qemu_set_option(const char *str)
         return -1;
     }
 
-    qemu_opt_set(opts, arg, str + offset + 1, &local_err);
-    if (local_err) {
+    if (!qemu_opt_set(opts, arg, str + offset + 1, &local_err)) {
         error_report_err(local_err);
         return -1;
     }
@@ -441,8 +440,7 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
                 error_report("no group defined");
                 goto out;
             }
-            qemu_opt_set(opts, arg, value, &local_err);
-            if (local_err) {
+            if (!qemu_opt_set(opts, arg, value, &local_err)) {
                 error_report_err(local_err);
                 goto out;
             }
@@ -498,8 +496,7 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
         goto out;
     }
 
-    qemu_opts_absorb_qdict(subopts, subqdict, &local_err);
-    if (local_err) {
+    if (!qemu_opts_absorb_qdict(subopts, subqdict, &local_err)) {
         error_propagate(errp, local_err);
         goto out;
     }
@@ -543,8 +540,7 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
                 goto out;
             }
 
-            qemu_opts_absorb_qdict(subopts, section, &local_err);
-            if (local_err) {
+            if (!qemu_opts_absorb_qdict(subopts, section, &local_err)) {
                 error_propagate(errp, local_err);
                 qemu_opts_del(subopts);
                 goto out;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 2f4fb62120..1dd14a0634 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -536,8 +536,7 @@ static bool opt_validate(QemuOpt *opt, bool *help_wanted,
     }
 
     opt->desc = desc;
-    qemu_opt_parse(opt, &local_err);
-    if (local_err) {
+    if (!qemu_opt_parse(opt, &local_err)) {
         error_propagate(errp, local_err);
         return false;
     }
@@ -929,8 +928,8 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
         return NULL;
     }
 
-    opts_do_parse(opts, params, firstname, defaults, help_wanted, &local_err);
-    if (local_err) {
+    if (!opts_do_parse(opts, params, firstname, defaults, help_wanted,
+                       &local_err)) {
         error_propagate(errp, local_err);
         qemu_opts_del(opts);
         return NULL;
@@ -1045,8 +1044,7 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
     for (entry = qdict_first(qdict);
          entry;
          entry = qdict_next(qdict, entry)) {
-        qemu_opts_from_qdict_entry(opts, entry, &local_err);
-        if (local_err) {
+        if (!qemu_opts_from_qdict_entry(opts, entry, &local_err)) {
             error_propagate(errp, local_err);
             qemu_opts_del(opts);
             return NULL;
@@ -1073,8 +1071,7 @@ bool qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp)
         next = qdict_next(qdict, entry);
 
         if (find_desc_by_name(opts->list->desc, entry->key)) {
-            qemu_opts_from_qdict_entry(opts, entry, &local_err);
-            if (local_err) {
+            if (!qemu_opts_from_qdict_entry(opts, entry, &local_err)) {
                 error_propagate(errp, local_err);
                 return false;
             }
@@ -1158,8 +1155,7 @@ bool qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
             return false;
         }
 
-        qemu_opt_parse(opt, &local_err);
-        if (local_err) {
+        if (!qemu_opt_parse(opt, &local_err)) {
             error_propagate(errp, local_err);
             return false;
         }
-- 
2.26.2


