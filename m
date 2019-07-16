Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A44DC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621C02145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621C02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnId7-000265-H6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33345)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnIcW-00005N-TD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnIcU-0006iu-IN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:15:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnIcN-0006W1-Ek; Tue, 16 Jul 2019 04:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AB8983F42;
 Tue, 16 Jul 2019 08:15:21 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E45E60C05;
 Tue, 16 Jul 2019 08:15:19 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 11:15:16 +0300
Message-Id: <20190716081516.27374-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 16 Jul 2019 08:15:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4] LUKS: support preallocation
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
 block/crypto.c       | 29 ++++++++++++++++++++++++++---
 qapi/block-core.json |  5 ++++-
 2 files changed, 30 insertions(+), 4 deletions(-)


Changes from V3: updated the blockdev-create description

diff --git a/block/crypto.c b/block/crypto.c
index 8237424ae6..034a645652 100644
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
@@ -515,8 +523,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         .u.luks = *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
     };
 
+    if (luks_opts->has_preallocation)
+        preallocation = luks_opts->preallocation;
+
     ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
-                                         errp);
+                                         preallocation, errp);
     if (ret < 0) {
         goto fail;
     }
@@ -534,12 +545,24 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
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
@@ -565,7 +588,7 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
     }
 
     /* Create format layer */
-    ret = block_crypto_co_create_generic(bs, size, create_opts, errp);
+    ret = block_crypto_co_create_generic(bs, size, create_opts, prealloc, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..9c04d83fa2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4205,13 +4205,16 @@
 #
 # @file             Node to create the image format on
 # @size             Size of the virtual disk in bytes
+# @preallocation    Preallocation mode for the new image (default: off;
+#                   allowed values: off/metadata/falloc/full (since: 4.2)
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


