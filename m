Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04813C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB6723429
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB6723429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3o04-0005Wd-G8
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 17:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwn-0003FJ-BY
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwl-0001VH-Rw
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i3nwi-0001Rz-TN; Fri, 30 Aug 2019 16:56:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C7B3102700C;
 Fri, 30 Aug 2019 20:56:36 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A97585D9CA;
 Fri, 30 Aug 2019 20:56:31 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 23:56:03 +0300
Message-Id: <20190830205608.18192-6-mlevitsk@redhat.com>
In-Reply-To: <20190830205608.18192-1-mlevitsk@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 30 Aug 2019 20:56:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 05/10] block/crypto: implement the encryption
 key management
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

This implements the encryption key management
using the generic code in qcrypto layer
(currently only for qemu-img amend)

This code adds another 'write_func' because the initialization
write_func works directly on the underlying file,
because during the creation, there is no open instance
of the luks driver, but during regular use, we have it,
and should use it instead.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/crypto.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index a6a3e1f1d8..dbd95a99ba 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -36,6 +36,7 @@ typedef struct BlockCrypto BlockCrypto;
 
 struct BlockCrypto {
     QCryptoBlock *block;
+    bool updating_keys;
 };
 
 
@@ -70,6 +71,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock *block,
     return ret;
 }
 
+static ssize_t block_crypto_write_func(QCryptoBlock *block,
+                                      size_t offset,
+                                      const uint8_t *buf,
+                                      size_t buflen,
+                                      void *opaque,
+                                      Error **errp)
+{
+    BlockDriverState *bs = opaque;
+    ssize_t ret;
+
+    ret = bdrv_pwrite(bs->file, offset, buf, buflen);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not write encryption header");
+        return ret;
+    }
+    return ret;
+}
+
 
 struct BlockCryptoCreateData {
     BlockBackend *blk;
@@ -647,6 +666,88 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
     return spec_info;
 }
 
+
+static int
+block_crypto_amend_options(BlockDriverState *bs,
+                           QemuOpts *opts,
+                           BlockDriverAmendStatusCB *status_cb,
+                           void *cb_opaque,
+                           bool force,
+                           Error **errp)
+{
+    BlockCrypto *crypto = bs->opaque;
+    QDict *cryptoopts = NULL;
+    QCryptoBlockCreateOptions *amend_options = NULL;
+    int ret;
+
+    assert(crypto);
+    assert(crypto->block);
+
+    crypto->updating_keys = true;
+
+    ret = bdrv_child_refresh_perms(bs, bs->file, errp);
+    if (ret) {
+        goto cleanup;
+    }
+
+    cryptoopts = qemu_opts_to_qdict_filtered(opts, NULL,
+                                             &block_crypto_create_opts_luks,
+                                             true);
+
+    qdict_put_str(cryptoopts, "format", "luks");
+    amend_options = block_crypto_create_opts_init(cryptoopts, errp);
+    if (!amend_options) {
+        ret = -EINVAL;
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
+    crypto->updating_keys = false;
+    bdrv_child_refresh_perms(bs, bs->file, errp);
+    qapi_free_QCryptoBlockCreateOptions(amend_options);
+    qobject_unref(cryptoopts);
+    return ret;
+}
+
+
+static void
+block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
+                         const BdrvChildRole *role,
+                         BlockReopenQueue *reopen_queue,
+                         uint64_t perm, uint64_t shared,
+                         uint64_t *nperm, uint64_t *nshared)
+{
+
+    BlockCrypto *crypto = bs->opaque;
+
+    /*
+     * This driver doesn't modify LUKS metadata except
+     * when updating the encryption slots.
+     * Allow share-rw=on as a special case.
+     *
+     * Encryption update will set the crypto->updating_keys
+     * during that period and refresh permissions
+     *
+     * */
+
+    if (crypto->updating_keys) {
+        /*need exclusive write access for header update  */
+        perm |= BLK_PERM_WRITE;
+        shared &= ~BLK_PERM_WRITE;
+    }
+
+    bdrv_filter_default_perms(bs, c, role, reopen_queue,
+            perm, shared, nperm, nshared);
+}
+
+
 static const char *const block_crypto_strong_runtime_opts[] = {
     BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,
 
@@ -659,9 +760,7 @@ static BlockDriver bdrv_crypto_luks = {
     .bdrv_probe         = block_crypto_probe_luks,
     .bdrv_open          = block_crypto_open_luks,
     .bdrv_close         = block_crypto_close,
-    /* This driver doesn't modify LUKS metadata except when creating image.
-     * Allow share-rw=on as a special case. */
-    .bdrv_child_perm    = bdrv_filter_default_perms,
+    .bdrv_child_perm    = block_crypto_child_perms,
     .bdrv_co_create     = block_crypto_co_create_luks,
     .bdrv_co_create_opts = block_crypto_co_create_opts_luks,
     .bdrv_co_truncate   = block_crypto_co_truncate,
@@ -674,6 +773,7 @@ static BlockDriver bdrv_crypto_luks = {
     .bdrv_getlength     = block_crypto_getlength,
     .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
+    .bdrv_amend_options = block_crypto_amend_options,
 
     .strong_runtime_opts = block_crypto_strong_runtime_opts,
 };
-- 
2.17.2


