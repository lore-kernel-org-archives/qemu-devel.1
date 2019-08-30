Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A090C3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF262070B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF262070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3o6f-0003DO-Di
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 17:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwv-0003Oz-U9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwu-0001d0-H7
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i3nwq-0001Za-Vk; Fri, 30 Aug 2019 16:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D00018F3521;
 Fri, 30 Aug 2019 20:56:44 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 012115D9CA;
 Fri, 30 Aug 2019 20:56:41 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 23:56:06 +0300
Message-Id: <20190830205608.18192-9-mlevitsk@redhat.com>
In-Reply-To: <20190830205608.18192-1-mlevitsk@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 30 Aug 2019 20:56:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 08/10] block/crypto: implement blockdev-amend
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/crypto.c       | 86 +++++++++++++++++++++++++++++++++-----------
 qapi/block-core.json |  4 +--
 2 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index dbd95a99ba..9cb668ff0e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -534,6 +534,17 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
     luks_opts = &create_options->u.luks;
 
+    if (!luks_opts->has_size) {
+        error_setg(errp, "'size' is manadatory for image creation");
+        return -EINVAL;
+    }
+
+    if (!luks_opts->has_file) {
+        error_setg(errp, "'file' is manadatory for image creation");
+        return -EINVAL;
+    }
+
+
     bs = bdrv_open_blockdev_ref(luks_opts->file, errp);
     if (bs == NULL) {
         return -EIO;
@@ -667,6 +678,39 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
 }
 
 
+static int
+block_crypto_amend_options_generic(BlockDriverState *bs,
+                                   QCryptoBlockCreateOptions *amend_options,
+                                   bool force,
+                                   Error **errp)
+{
+    BlockCrypto *crypto = bs->opaque;
+    int ret = -1;
+
+    assert(crypto);
+    assert(crypto->block);
+
+    /* apply for exclusive write permissions to the underlying file*/
+    crypto->updating_keys = true;
+    ret = bdrv_child_refresh_perms(bs, bs->file, errp);
+    if (ret) {
+        goto cleanup;
+    }
+
+    ret = qcrypto_block_amend_options(crypto->block,
+                                      block_crypto_read_func,
+                                      block_crypto_write_func,
+                                      bs,
+                                      amend_options,
+                                      force,
+                                      errp);
+cleanup:
+    /* release exclusive write permissions to the underlying file*/
+    crypto->updating_keys = false;
+    bdrv_child_refresh_perms(bs, bs->file, errp);
+    return ret;
+}
+
 static int
 block_crypto_amend_options(BlockDriverState *bs,
                            QemuOpts *opts,
@@ -678,44 +722,45 @@ block_crypto_amend_options(BlockDriverState *bs,
     BlockCrypto *crypto = bs->opaque;
     QDict *cryptoopts = NULL;
     QCryptoBlockCreateOptions *amend_options = NULL;
-    int ret;
+    int ret= -EINVAL;
 
     assert(crypto);
     assert(crypto->block);
 
-    crypto->updating_keys = true;
-
-    ret = bdrv_child_refresh_perms(bs, bs->file, errp);
-    if (ret) {
-        goto cleanup;
-    }
-
     cryptoopts = qemu_opts_to_qdict_filtered(opts, NULL,
                                              &block_crypto_create_opts_luks,
                                              true);
 
     qdict_put_str(cryptoopts, "format", "luks");
     amend_options = block_crypto_create_opts_init(cryptoopts, errp);
+
     if (!amend_options) {
-        ret = -EINVAL;
-        goto cleanup;
+        goto out;
     }
 
-    ret = qcrypto_block_amend_options(crypto->block,
-                                      block_crypto_read_func,
-                                      block_crypto_write_func,
-                                      bs,
-                                      amend_options,
-                                      force,
-                                      errp);
-cleanup:
-    crypto->updating_keys = false;
-    bdrv_child_refresh_perms(bs, bs->file, errp);
+    ret = block_crypto_amend_options_generic(bs, amend_options, force, errp);
+out:
     qapi_free_QCryptoBlockCreateOptions(amend_options);
     qobject_unref(cryptoopts);
     return ret;
 }
 
+static int
+coroutine_fn block_crypto_co_amend(BlockDriverState *bs,
+                                   BlockdevCreateOptions *opts,
+                                   bool force,
+                                   Error **errp)
+{
+    QCryptoBlockCreateOptions amend_opts;
+
+    amend_opts = (QCryptoBlockCreateOptions) {
+        .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
+        .u.luks = *qapi_BlockdevCreateOptionsLUKS_base(&opts->u.luks),
+    };
+
+    return block_crypto_amend_options_generic(bs, &amend_opts, force, errp);
+}
+
 
 static void
 block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
@@ -774,6 +819,7 @@ static BlockDriver bdrv_crypto_luks = {
     .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
     .bdrv_amend_options = block_crypto_amend_options,
+    .bdrv_co_amend      = block_crypto_co_amend,
 
     .strong_runtime_opts = block_crypto_strong_runtime_opts,
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7900914506..02375fb59a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4220,8 +4220,8 @@
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
-  'data': { 'file':             'BlockdevRef',
-            'size':             'size',
+  'data': { '*file':             'BlockdevRef',
+            '*size':             'size',
             '*preallocation':   'PreallocMode' } }
 
 ##
-- 
2.17.2


