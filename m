Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B26ACA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B58B20753
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsPkcGoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B58B20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpV1-0006u9-Vp
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDr-0002Lx-6o
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55012
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDo-0003Us-S2
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0hMSx+psIQ+rlHFKOJP2UFr6KU9b+WirKBdrbWwhWI=;
 b=BsPkcGoqxmUc9c73j8SUxBokmSieczB227jtYd4GDoZQR3oEsoPzLd0fzC/kB6ts5wze6k
 FXV+g+Xgj9sVOdb1qNnkBNJwIC4Xc/zhKydlP0BRi9m4Yke+Be0yB4lsnIpAdvHA2TuEPj
 cUZguw1kSNCdzBLuP/g2KhZP+S+EVLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-verTINHyN6mOLDoavIHM7Q-1; Wed, 13 May 2020 07:06:42 -0400
X-MC-Unique: verTINHyN6mOLDoavIHM7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DDA91009610;
 Wed, 13 May 2020 11:06:40 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 202BE1002382;
 Wed, 13 May 2020 11:06:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 20/34] raw-format: Split raw_read_options()
Date: Wed, 13 May 2020 13:05:30 +0200
Message-Id: <20200513110544.176672-21-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split raw_read_options() into one function that actually just reads the
options, and another that applies them.  This will allow us to detect
whether the user has specified any options before attaching the file
child (so we can decide on its role based on the options).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/raw-format.c | 110 ++++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 4b8d4ce8be..824fe70686 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -71,20 +71,13 @@ static QemuOptsList raw_create_opts = {
     }
 };
 
-static int raw_read_options(QDict *options, BlockDriverState *bs,
-    BDRVRawState *s, Error **errp)
+static int raw_read_options(QDict *options, uint64_t *offset, bool *has_size,
+                            uint64_t *size, Error **errp)
 {
     Error *local_err = NULL;
     QemuOpts *opts = NULL;
-    int64_t real_size = 0;
     int ret;
 
-    real_size = bdrv_getlength(bs->file->bs);
-    if (real_size < 0) {
-        error_setg_errno(errp, -real_size, "Could not get image size");
-        return real_size;
-    }
-
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -93,64 +86,84 @@ static int raw_read_options(QDict *options, BlockDriverState *bs,
         goto end;
     }
 
-    s->offset = qemu_opt_get_size(opts, "offset", 0);
-    if (s->offset > real_size) {
-        error_setg(errp, "Offset (%" PRIu64 ") cannot be greater than "
-            "size of the containing file (%" PRId64 ")",
-            s->offset, real_size);
-        ret = -EINVAL;
-        goto end;
-    }
+    *offset = qemu_opt_get_size(opts, "offset", 0);
+    *has_size = qemu_opt_find(opts, "size");
+    *size = qemu_opt_get_size(opts, "size", 0);
 
-    if (qemu_opt_find(opts, "size") != NULL) {
-        s->size = qemu_opt_get_size(opts, "size", 0);
-        s->has_size = true;
-    } else {
-        s->has_size = false;
-        s->size = real_size - s->offset;
+    ret = 0;
+end:
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static int raw_apply_options(BlockDriverState *bs, BDRVRawState *s,
+                             uint64_t offset, bool has_size, uint64_t size,
+                             Error **errp)
+{
+    int64_t real_size = 0;
+
+    real_size = bdrv_getlength(bs->file->bs);
+    if (real_size < 0) {
+        error_setg_errno(errp, -real_size, "Could not get image size");
+        return real_size;
     }
 
     /* Check size and offset */
-    if ((real_size - s->offset) < s->size) {
+    if (offset > real_size) {
+        error_setg(errp, "Offset (%" PRIu64 ") cannot be greater than "
+                   "size of the containing file (%" PRId64 ")",
+                   s->offset, real_size);
+        return -EINVAL;
+    }
+
+    if (has_size && (real_size - offset) < size) {
         error_setg(errp, "The sum of offset (%" PRIu64 ") and size "
-            "(%" PRIu64 ") has to be smaller or equal to the "
-            " actual size of the containing file (%" PRId64 ")",
-            s->offset, s->size, real_size);
-        ret = -EINVAL;
-        goto end;
+                   "(%" PRIu64 ") has to be smaller or equal to the "
+                   " actual size of the containing file (%" PRId64 ")",
+                   s->offset, s->size, real_size);
+        return -EINVAL;
     }
 
     /* Make sure size is multiple of BDRV_SECTOR_SIZE to prevent rounding
      * up and leaking out of the specified area. */
-    if (s->has_size && !QEMU_IS_ALIGNED(s->size, BDRV_SECTOR_SIZE)) {
+    if (has_size && !QEMU_IS_ALIGNED(size, BDRV_SECTOR_SIZE)) {
         error_setg(errp, "Specified size is not multiple of %llu",
-            BDRV_SECTOR_SIZE);
-        ret = -EINVAL;
-        goto end;
+                   BDRV_SECTOR_SIZE);
+        return -EINVAL;
     }
 
-    ret = 0;
-
-end:
+    s->offset = offset;
+    s->has_size = has_size;
+    s->size = has_size ? size : real_size - offset;
 
-    qemu_opts_del(opts);
-
-    return ret;
+    return 0;
 }
 
 static int raw_reopen_prepare(BDRVReopenState *reopen_state,
                               BlockReopenQueue *queue, Error **errp)
 {
+    bool has_size;
+    uint64_t offset, size;
+    int ret;
+
     assert(reopen_state != NULL);
     assert(reopen_state->bs != NULL);
 
     reopen_state->opaque = g_new0(BDRVRawState, 1);
 
-    return raw_read_options(
-        reopen_state->options,
-        reopen_state->bs,
-        reopen_state->opaque,
-        errp);
+    ret = raw_read_options(reopen_state->options, &offset, &has_size, &size,
+                           errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = raw_apply_options(reopen_state->bs, reopen_state->opaque,
+                            offset, has_size, size, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
 }
 
 static void raw_reopen_commit(BDRVReopenState *state)
@@ -426,8 +439,15 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
     BDRVRawState *s = bs->opaque;
+    bool has_size;
+    uint64_t offset, size;
     int ret;
 
+    ret = raw_read_options(options, &offset, &has_size, &size, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
                                false, errp);
     if (!bs->file) {
@@ -455,7 +475,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                 bs->file->bs->filename);
     }
 
-    ret = raw_read_options(options, bs, s, errp);
+    ret = raw_apply_options(bs, s, offset, has_size, size, errp);
     if (ret < 0) {
         return ret;
     }
-- 
2.26.2


