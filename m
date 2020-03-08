Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE499C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941642072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU4/P1Yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941642072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxlC-0005hU-ME
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiJ-0000bk-RI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiI-0001gc-2a
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxiH-0001gA-Ug
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRQWf/0OFSTgG5li7JcUprA00SLolcMQ3NsEtGJcIjw=;
 b=EU4/P1YgJVNA/KwqZLCpV5ZUv4Hu0rmlqgdtIBAe++XrHgx6GsjMe2LAOhJ51GF0GnHUBY
 03G8DJdd/uydi/VjZzl14XIdbmQ5VndfUxRwlcI9QbBsD5NbBZJHeOZ8La/E2fivwcojBH
 SOHLxWeiiDkxcOefTz+mcAkrz8o6UUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-SALnPDAUPEe5it8HmENe7g-1; Sun, 08 Mar 2020 11:19:31 -0400
X-MC-Unique: SALnPDAUPEe5it8HmENe7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BC7E107ACC9;
 Sun,  8 Mar 2020 15:19:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1166D5C1B0;
 Sun,  8 Mar 2020 15:19:27 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/14] block/crypto: implement the encryption key management
Date: Sun,  8 Mar 2020 17:18:56 +0200
Message-Id: <20200308151903.25941-8-mlevitsk@redhat.com>
In-Reply-To: <20200308151903.25941-1-mlevitsk@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
made to make the driver both support write sharing (to avoid breaking the u=
sers),
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
---
 block/crypto.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++--
 block/crypto.h |  44 +++++++++++++++--
 2 files changed, 163 insertions(+), 8 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 0b37dae564..727a3fde58 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -36,6 +36,7 @@ typedef struct BlockCrypto BlockCrypto;
=20
 struct BlockCrypto {
     QCryptoBlock *block;
+    bool updating_keys;
 };
=20
=20
@@ -70,6 +71,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock *bloc=
k,
     return ret;
 }
=20
+static ssize_t block_crypto_write_func(QCryptoBlock *block,
+                                       size_t offset,
+                                       const uint8_t *buf,
+                                       size_t buflen,
+                                       void *opaque,
+                                       Error **errp)
+{
+    BlockDriverState *bs =3D opaque;
+    ssize_t ret;
+
+    ret =3D bdrv_pwrite(bs->file, offset, buf, buflen);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not write encryption header");
+        return ret;
+    }
+    return ret;
+}
+
=20
 struct BlockCryptoCreateData {
     BlockBackend *blk;
@@ -148,6 +167,19 @@ static QemuOptsList block_crypto_create_opts_luks =3D =
{
 };
=20
=20
+static QemuOptsList block_crypto_amend_opts_luks =3D {
+    .name =3D "crypto",
+    .head =3D QTAILQ_HEAD_INITIALIZER(block_crypto_create_opts_luks.head),
+    .desc =3D {
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
@@ -661,6 +693,95 @@ block_crypto_get_specific_info_luks(BlockDriverState *=
bs, Error **errp)
     return spec_info;
 }
=20
+static int
+block_crypto_amend_options_luks(BlockDriverState *bs,
+                           QemuOpts *opts,
+                           BlockDriverAmendStatusCB *status_cb,
+                           void *cb_opaque,
+                           bool force,
+                           Error **errp)
+{
+    BlockCrypto *crypto =3D bs->opaque;
+    QDict *cryptoopts =3D NULL;
+    QCryptoBlockAmendOptions *amend_options =3D NULL;
+    int ret;
+
+    assert(crypto);
+    assert(crypto->block);
+    crypto->updating_keys =3D true;
+
+    ret =3D bdrv_child_refresh_perms(bs, bs->file, errp);
+    if (ret < 0) {
+        goto cleanup;
+    }
+
+    cryptoopts =3D qemu_opts_to_qdict(opts, NULL);
+    qdict_put_str(cryptoopts, "format", "luks");
+    amend_options =3D block_crypto_amend_opts_init(cryptoopts, errp);
+    if (!amend_options) {
+        ret =3D -EINVAL;
+        goto cleanup;
+    }
+
+    ret =3D qcrypto_block_amend_options(crypto->block,
+                                      block_crypto_read_func,
+                                      block_crypto_write_func,
+                                      bs,
+                                      amend_options,
+                                      force,
+                                      errp);
+cleanup:
+    crypto->updating_keys =3D false;
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
+    BlockCrypto *crypto =3D bs->opaque;
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
+        *nperm |=3D BLK_PERM_CONSISTENT_READ;
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
+        *nperm |=3D BLK_PERM_WRITE;
+        /* unshare read and write permission */
+        *nshared &=3D ~(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE);
+    }
+}
+
+
 static const char *const block_crypto_strong_runtime_opts[] =3D {
     BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,
=20
@@ -673,13 +794,12 @@ static BlockDriver bdrv_crypto_luks =3D {
     .bdrv_probe         =3D block_crypto_probe_luks,
     .bdrv_open          =3D block_crypto_open_luks,
     .bdrv_close         =3D block_crypto_close,
-    /* This driver doesn't modify LUKS metadata except when creating image=
.
-     * Allow share-rw=3Don as a special case. */
-    .bdrv_child_perm    =3D bdrv_filter_default_perms,
+    .bdrv_child_perm    =3D block_crypto_child_perms,
     .bdrv_co_create     =3D block_crypto_co_create_luks,
     .bdrv_co_create_opts =3D block_crypto_co_create_opts_luks,
     .bdrv_co_truncate   =3D block_crypto_co_truncate,
     .create_opts        =3D &block_crypto_create_opts_luks,
+    .amend_opts         =3D &block_crypto_amend_opts_luks,
=20
     .bdrv_reopen_prepare =3D block_crypto_reopen_prepare,
     .bdrv_refresh_limits =3D block_crypto_refresh_limits,
@@ -688,6 +808,7 @@ static BlockDriver bdrv_crypto_luks =3D {
     .bdrv_getlength     =3D block_crypto_getlength,
     .bdrv_get_info      =3D block_crypto_get_info_luks,
     .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
+    .bdrv_amend_options =3D block_crypto_amend_options_luks,
=20
     .strong_runtime_opts =3D block_crypto_strong_runtime_opts,
 };
diff --git a/block/crypto.h b/block/crypto.h
index 06e044c9be..64276b1a15 100644
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
=20
 #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(prefix)                    \
     BLOCK_CRYPTO_OPT_DEF_KEY_SECRET(prefix,                             \
@@ -81,11 +86,40 @@
         .help =3D "Name of encryption hash algorithm",     \
     }
=20
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(prefix)           \
-    {                                                         \
-        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,       \
-        .type =3D QEMU_OPT_NUMBER,                              \
-        .help =3D "Time to spend in PBKDF in milliseconds",     \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(prefix)        \
+    {                                                      \
+        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,    \
+        .type =3D QEMU_OPT_NUMBER,                           \
+        .help =3D "Time to spend in PBKDF in milliseconds",  \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_STATE(prefix)                           =
\
+    {                                                                     =
\
+        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_STATE,                     =
  \
+        .type =3D QEMU_OPT_STRING,                                        =
  \
+        .help =3D "Select new state of affected keyslots (active/inactive)=
",\
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT(prefix)              \
+    {                                                          \
+        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_KEYSLOT,          \
+        .type =3D QEMU_OPT_NUMBER,                               \
+        .help =3D "Select a single keyslot to modify explicitly",\
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_OLD_SECRET(prefix)            \
+    {                                                           \
+        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_OLD_SECRET,        \
+        .type =3D QEMU_OPT_STRING,                                \
+        .help =3D "Select all keyslots that match this password", \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_NEW_SECRET(prefix)            \
+    {                                                           \
+        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_NEW_SECRET,        \
+        .type =3D QEMU_OPT_STRING,                                \
+        .help =3D "New secret to set in the matching keyslots. "  \
+                "Empty string to erase",                        \
     }
=20
 QCryptoBlockCreateOptions *
--=20
2.17.2


