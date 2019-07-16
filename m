Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C515C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BD4205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BD4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQAq-0004Ki-HC
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnQAc-0003qj-Tq
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnQAa-0002tQ-FL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:19:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnQAW-0002nu-Eu; Tue, 16 Jul 2019 12:19:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B6AB73087930;
 Tue, 16 Jul 2019 16:19:07 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A0D45D71D;
 Tue, 16 Jul 2019 16:19:03 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 19:19:01 +0300
Message-Id: <20190716161901.1430-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 16 Jul 2019 16:19:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5] LUKS: support preallocation
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
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

preallocation=off and preallocation=metadata
both allocate luks header only, and preallocation=falloc/full
is passed to underlying file.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1534951

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---

This is hopefully a revision without coding style violations.

Note that I still haven't tested the blockdev-create code, other that
compile testing it.

Best regards,
	Maxim Levitsky


 block/crypto.c       | 30 +++++++++++++++++++++++++++---
 qapi/block-core.json |  6 +++++-
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 8237424ae6..7eb698774e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -74,6 +74,7 @@ static ssize_t block_crypto_read_func(QCryptoBlock *block,
 struct BlockCryptoCreateData {
     BlockBackend *blk;
     uint64_t size;
+    PreallocMode prealloc;
 };
 
 
@@ -112,7 +113,7 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
-    return blk_truncate(data->blk, data->size + headerlen, PREALLOC_MODE_OFF,
+    return blk_truncate(data->blk, data->size + headerlen, data->prealloc,
                         errp);
 }
 
@@ -251,6 +252,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 static int block_crypto_co_create_generic(BlockDriverState *bs,
                                           int64_t size,
                                           QCryptoBlockCreateOptions *opts,
+                                          PreallocMode prealloc,
                                           Error **errp)
 {
     int ret;
@@ -266,9 +268,14 @@ static int block_crypto_co_create_generic(BlockDriverState *bs,
         goto cleanup;
     }
 
+    if (prealloc == PREALLOC_MODE_METADATA) {
+        prealloc = PREALLOC_MODE_OFF;
+    }
+
     data = (struct BlockCryptoCreateData) {
         .blk = blk,
         .size = size,
+        .prealloc = prealloc,
     };
 
     crypto = qcrypto_block_create(opts, NULL,
@@ -500,6 +507,7 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     BlockdevCreateOptionsLUKS *luks_opts;
     BlockDriverState *bs = NULL;
     QCryptoBlockCreateOptions create_opts;
+    PreallocMode preallocation = PREALLOC_MODE_OFF;
     int ret;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
@@ -515,8 +523,12 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         .u.luks = *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
     };
 
+    if (luks_opts->has_preallocation) {
+        preallocation = luks_opts->preallocation;
+    }
+
     ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
-                                         errp);
+                                         preallocation, errp);
     if (ret < 0) {
         goto fail;
     }
@@ -534,12 +546,24 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
     QCryptoBlockCreateOptions *create_opts = NULL;
     BlockDriverState *bs = NULL;
     QDict *cryptoopts;
+    PreallocMode prealloc;
+    char *buf = NULL;
     int64_t size;
     int ret;
+    Error *local_err = NULL;
 
     /* Parse options */
     size = qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
 
+    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
+                               PREALLOC_MODE_OFF, &local_err);
+    g_free(buf);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
     cryptoopts = qemu_opts_to_qdict_filtered(opts, NULL,
                                              &block_crypto_create_opts_luks,
                                              true);
@@ -565,7 +589,7 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
     }
 
     /* Create format layer */
-    ret = block_crypto_co_create_generic(bs, size, create_opts, errp);
+    ret = block_crypto_co_create_generic(bs, size, create_opts, prealloc, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..3840c99cbe 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4205,13 +4205,17 @@
 #
 # @file             Node to create the image format on
 # @size             Size of the virtual disk in bytes
+# @preallocation    Preallocation mode for the new image
+#                   (since: 4.2)
+#                   (default: off; allowed values: off, metadata, falloc, full)
 #
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
   'data': { 'file':             'BlockdevRef',
-            'size':             'size' } }
+            'size':             'size',
+            '*preallocation':   'PreallocMode' } }
 
 ##
 # @BlockdevCreateOptionsNfs:
-- 
2.17.2


