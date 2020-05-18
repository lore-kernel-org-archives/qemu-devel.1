Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2081AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC57B2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dsd7Z4tS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC57B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaeoh-00019x-Uv
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 08:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaele-0004fT-0g
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:21:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaelZ-0007IN-PY
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589804469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sS4KOv1DCP6FLAO2micqkBP/gR5tcIfazAxiTTKVtgs=;
 b=Dsd7Z4tSv2OVH6bXtP7Io12JXd9Fn/wb4JLqQxqRkF7W7TQS9EZO9J4MXxi0hiPRvmQiTG
 XnUBl6/crnuE25tx9mKDZYChSB/gDyWyKwKZ+tIpvY93Ewy2NtVLFW/qMaMgsuUj681N6G
 GNJwZPbjIcnMI745EAZ3bpFv9UXpcuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-Iyih4xnBMMmdKZmm-dRgXw-1; Mon, 18 May 2020 08:21:07 -0400
X-MC-Unique: Iyih4xnBMMmdKZmm-dRgXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61AE8107B265;
 Mon, 18 May 2020 12:21:06 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1610B60BF1;
 Mon, 18 May 2020 12:21:03 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/14] block/crypto: implement the encryption key management
Date: Mon, 18 May 2020 15:20:34 +0300
Message-Id: <20200518122041.10694-8-mlevitsk@redhat.com>
In-Reply-To: <20200518122041.10694-1-mlevitsk@redhat.com>
References: <20200518122041.10694-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements the encryption key management using the generic code in
qcrypto layer and exposes it to the user via qemu-img

This code adds another 'write_func' because the initialization
write_func works directly on the underlying file, and amend
works on instance of luks device.

This commit also adds a 'hack/workaround' I and Kevin Wolf (thanks)
made to make the driver both support write sharing (to avoid breaking the users),
and be safe against concurrent  metadata update (the keyslots)

Eventually the write sharing for luks driver will be deprecated
and removed together with this hack.

The hack is that we ask (as a format driver) for BLK_PERM_CONSISTENT_READ
and then when we want to update the keys, we unshare that permission.
So if someone else has the image open, even readonly, encryption
key update will fail gracefully.

Also thanks to Daniel Berrange for the idea of
unsharing read, rather that write permission which allows
to avoid cases when the other user had opened the image read-only.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/crypto.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++--
 block/crypto.h |  34 +++++++++++++
 2 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 2e16b62bdc..b14cb0ff06 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -37,6 +37,7 @@ typedef struct BlockCrypto BlockCrypto;
 
 struct BlockCrypto {
     QCryptoBlock *block;
+    bool updating_keys;
 };
 
 
@@ -71,6 +72,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock *block,
     return ret;
 }
 
+static ssize_t block_crypto_write_func(QCryptoBlock *block,
+                                       size_t offset,
+                                       const uint8_t *buf,
+                                       size_t buflen,
+                                       void *opaque,
+                                       Error **errp)
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
@@ -166,6 +185,19 @@ static QemuOptsList block_crypto_create_opts_luks = {
 };
 
 
+static QemuOptsList block_crypto_amend_opts_luks = {
+    .name = "crypto",
+    .head = QTAILQ_HEAD_INITIALIZER(block_crypto_create_opts_luks.head),
+    .desc = {
+        BLOCK_CRYPTO_OPT_DEF_LUKS_STATE(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_OLD_SECRET(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_NEW_SECRET(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
+        { /* end of list */ }
+    },
+};
+
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QDict *opts, Error **errp)
 {
@@ -758,6 +790,95 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
     return spec_info;
 }
 
+static int
+block_crypto_amend_options_luks(BlockDriverState *bs,
+                                QemuOpts *opts,
+                                BlockDriverAmendStatusCB *status_cb,
+                                void *cb_opaque,
+                                bool force,
+                                Error **errp)
+{
+    BlockCrypto *crypto = bs->opaque;
+    QDict *cryptoopts = NULL;
+    QCryptoBlockAmendOptions *amend_options = NULL;
+    int ret;
+
+    assert(crypto);
+    assert(crypto->block);
+    crypto->updating_keys = true;
+
+    ret = bdrv_child_refresh_perms(bs, bs->file, errp);
+    if (ret < 0) {
+        goto cleanup;
+    }
+
+    cryptoopts = qemu_opts_to_qdict(opts, NULL);
+    qdict_put_str(cryptoopts, "format", "luks");
+    amend_options = block_crypto_amend_opts_init(cryptoopts, errp);
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
+    qapi_free_QCryptoBlockAmendOptions(amend_options);
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
+    bdrv_filter_default_perms(bs, c, role, reopen_queue,
+            perm, shared, nperm, nshared);
+    /*
+     * Ask for consistent read permission so that if
+     * someone else tries to open this image with this permission
+     * neither will be able to edit encryption keys, since
+     * we will unshare that permission while trying to
+     * update the encryption keys
+     */
+    if (!(bs->open_flags & BDRV_O_NO_IO)) {
+        *nperm |= BLK_PERM_CONSISTENT_READ;
+    }
+    /*
+     * This driver doesn't modify LUKS metadata except
+     * when updating the encryption slots.
+     * Thus unlike a proper format driver we don't ask for
+     * shared write/read permission. However we need it
+     * when we are updating the keys, to ensure that only we
+     * have access to the device.
+     *
+     * Encryption update will set the crypto->updating_keys
+     * during that period and refresh permissions
+     *
+     */
+    if (crypto->updating_keys) {
+        /* need exclusive write access for header update */
+        *nperm |= BLK_PERM_WRITE;
+        /* unshare read and write permission */
+        *nshared &= ~(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE);
+    }
+}
+
+
 static const char *const block_crypto_strong_runtime_opts[] = {
     BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,
 
@@ -770,13 +891,12 @@ static BlockDriver bdrv_crypto_luks = {
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
     .create_opts        = &block_crypto_create_opts_luks,
+    .amend_opts         = &block_crypto_amend_opts_luks,
 
     .bdrv_reopen_prepare = block_crypto_reopen_prepare,
     .bdrv_refresh_limits = block_crypto_refresh_limits,
@@ -786,6 +906,7 @@ static BlockDriver bdrv_crypto_luks = {
     .bdrv_measure       = block_crypto_measure,
     .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
+    .bdrv_amend_options = block_crypto_amend_options_luks,
 
     .strong_runtime_opts = block_crypto_strong_runtime_opts,
 };
diff --git a/block/crypto.h b/block/crypto.h
index 06e044c9be..c72c3dec61 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -41,6 +41,11 @@
 #define BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG "ivgen-hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
+#define BLOCK_CRYPTO_OPT_LUKS_KEYSLOT "keyslot"
+#define BLOCK_CRYPTO_OPT_LUKS_STATE "state"
+#define BLOCK_CRYPTO_OPT_LUKS_OLD_SECRET "old-secret"
+#define BLOCK_CRYPTO_OPT_LUKS_NEW_SECRET "new-secret"
+
 
 #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(prefix)                    \
     BLOCK_CRYPTO_OPT_DEF_KEY_SECRET(prefix,                             \
@@ -88,6 +93,35 @@
         .help = "Time to spend in PBKDF in milliseconds",     \
     }
 
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_STATE(prefix)                           \
+    {                                                                     \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_STATE,                       \
+        .type = QEMU_OPT_STRING,                                          \
+        .help = "Select new state of affected keyslots (active/inactive)",\
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT(prefix)              \
+    {                                                          \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_KEYSLOT,          \
+        .type = QEMU_OPT_NUMBER,                               \
+        .help = "Select a single keyslot to modify explicitly",\
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_OLD_SECRET(prefix)            \
+    {                                                           \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_OLD_SECRET,        \
+        .type = QEMU_OPT_STRING,                                \
+        .help = "Select all keyslots that match this password", \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_NEW_SECRET(prefix)            \
+    {                                                           \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_NEW_SECRET,        \
+        .type = QEMU_OPT_STRING,                                \
+        .help = "New secret to set in the matching keyslots. "  \
+                "Empty string to erase",                        \
+    }
+
 QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QDict *opts, Error **errp);
 
-- 
2.17.2


