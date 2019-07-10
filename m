Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD08C74A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5443220665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5443220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlG20-0004Z4-8a
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 13:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41907)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hlG0d-0003yk-PM
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hlG0c-0008Sd-Hl
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:03:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hlG0Z-0008PJ-Vc; Wed, 10 Jul 2019 13:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C9493091740;
 Wed, 10 Jul 2019 17:03:54 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE2B31001B12;
 Wed, 10 Jul 2019 17:03:50 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 20:03:49 +0300
Message-Id: <20190710170349.1548-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 10 Jul 2019 17:03:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

preallocation=off and preallocation=metadata
both allocate luks header only, and preallocation=falloc/full
is passed to underlying file, with the given image size.

Note that the actual preallocated size is a bit smaller due
to luks header.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1534951

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/crypto.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 8237424ae6..74b789d278 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -251,6 +251,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 static int block_crypto_co_create_generic(BlockDriverState *bs,
                                           int64_t size,
                                           QCryptoBlockCreateOptions *opts,
+                                          PreallocMode prealloc,
                                           Error **errp)
 {
     int ret;
@@ -266,6 +267,13 @@ static int block_crypto_co_create_generic(BlockDriverState *bs,
         goto cleanup;
     }
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        ret = blk_truncate(blk, size, prealloc, errp);
+        if (ret < 0) {
+                goto cleanup;
+        }
+    }
+
     data = (struct BlockCryptoCreateData) {
         .blk = blk,
         .size = size,
@@ -516,7 +524,7 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     };
 
     ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
-                                         errp);
+                                         PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto fail;
     }
@@ -534,12 +542,28 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
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
+                                   PREALLOC_MODE_OFF, &local_err);
+    g_free(buf);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    if (prealloc == PREALLOC_MODE_METADATA) {
+        prealloc  = PREALLOC_MODE_OFF;
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
-- 
2.17.2


