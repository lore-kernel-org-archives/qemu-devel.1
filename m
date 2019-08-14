Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F0C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B432133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B432133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxztD-0001XM-Qv
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznR-0004A1-8N
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznL-000425-4E
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:22:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxzn4-0003qz-VN; Wed, 14 Aug 2019 16:22:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8D00302C061;
 Wed, 14 Aug 2019 20:22:36 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3874710002BA;
 Wed, 14 Aug 2019 20:22:34 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:09 +0300
Message-Id: <20190814202219.1870-4-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 14 Aug 2019 20:22:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 03/13] qcrypto-luks: refactoring: extract
 load/store/check/parse header functions
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With upcoming key management, the header will
need to be stored after the image is created.

Extracting load header isn't strictly needed, but
do this anyway for the symmetry.

Also I extracted a function that does basic sanity
checks on the just read header, and a function
which parses all the crypto format to make the
code a bit more readable, plus now the code
doesn't destruct the in-header cipher-mode string,
so that the header now can be stored many times,
which is needed for the key management.

Also this allows to contain the endianess conversions
in these functions alone

The header is no longer endian swapped in place,
to prevent (mostly theoretical races I think)
races where someone could see the header in the
process of beeing byteswapped.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 756 ++++++++++++++++++++++++++------------------
 1 file changed, 440 insertions(+), 316 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 48213abde7..6bb369f3b4 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -417,6 +417,427 @@ static int masterkeylen(QCryptoBlockLUKS *luks)
 }
 
 
+/*
+ * Stores the main LUKS header, taking care of endianess
+ */
+static int
+qcrypto_block_luks_store_header(QCryptoBlock *block,
+                                QCryptoBlockWriteFunc writefunc,
+                                void *opaque,
+                                Error **errp)
+{
+    QCryptoBlockLUKS *luks = block->opaque;
+    Error *local_err = NULL;
+    size_t i;
+    QCryptoBlockLUKSHeader *hdr_copy;
+
+    /* Create a copy of the header */
+    hdr_copy = g_new0(QCryptoBlockLUKSHeader, 1);
+    memcpy(hdr_copy, &luks->header, sizeof(QCryptoBlockLUKSHeader));
+
+    /*
+     * Everything on disk uses Big Endian (tm), so flip header fields
+     * before writing them
+     */
+    cpu_to_be16s(&hdr_copy->version);
+    cpu_to_be32s(&hdr_copy->payload_offset);
+    cpu_to_be32s(&hdr_copy->key_bytes);
+    cpu_to_be32s(&hdr_copy->master_key_iterations);
+
+    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        cpu_to_be32s(&hdr_copy->key_slots[i].active);
+        cpu_to_be32s(&hdr_copy->key_slots[i].iterations);
+        cpu_to_be32s(&hdr_copy->key_slots[i].key_offset);
+        cpu_to_be32s(&hdr_copy->key_slots[i].stripes);
+    }
+
+    /* Write out the partition header and key slot headers */
+    writefunc(block, 0, (const uint8_t *)hdr_copy, sizeof(*hdr_copy),
+              opaque, &local_err);
+
+    g_free(hdr_copy);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -1;
+    }
+    return 0;
+}
+
+/*
+ * Loads the main LUKS header,and byteswaps it to native endianess
+ * And run basic sanity checks on it
+ */
+static int
+qcrypto_block_luks_load_header(QCryptoBlock *block,
+                                QCryptoBlockReadFunc readfunc,
+                                void *opaque,
+                                Error **errp)
+{
+    ssize_t rv;
+    size_t i;
+    int ret = 0;
+    QCryptoBlockLUKS *luks = block->opaque;
+
+    /*
+     * Read the entire LUKS header, minus the key material from
+     * the underlying device
+     */
+
+    rv = readfunc(block, 0,
+                  (uint8_t *)&luks->header,
+                  sizeof(luks->header),
+                  opaque,
+                  errp);
+    if (rv < 0) {
+        ret = rv;
+        goto fail;
+    }
+
+    /*
+     * The header is always stored in big-endian format, so
+     * convert everything to native
+     */
+    be16_to_cpus(&luks->header.version);
+    be32_to_cpus(&luks->header.payload_offset);
+    be32_to_cpus(&luks->header.key_bytes);
+    be32_to_cpus(&luks->header.master_key_iterations);
+
+    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        be32_to_cpus(&luks->header.key_slots[i].active);
+        be32_to_cpus(&luks->header.key_slots[i].iterations);
+        be32_to_cpus(&luks->header.key_slots[i].key_offset);
+        be32_to_cpus(&luks->header.key_slots[i].stripes);
+    }
+
+
+    return 0;
+fail:
+    return ret;
+}
+
+
+/*
+ * Does basic sanity checks on the LUKS header
+ */
+static int
+qcrypto_block_luks_check_header(QCryptoBlockLUKS *luks, Error **errp)
+{
+    int ret;
+
+    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
+               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
+        error_setg(errp, "Volume is not in LUKS format");
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    if (luks->header.version != QCRYPTO_BLOCK_LUKS_VERSION) {
+        error_setg(errp, "LUKS version %" PRIu32 " is not supported",
+                   luks->header.version);
+        ret = -ENOTSUP;
+        goto fail;
+    }
+
+    return 0;
+fail:
+    return ret;
+}
+
+
+/*
+ * Parses the crypto parameters that are stored in the LUKS header
+ * to string
+ */
+
+static int
+qcrypto_block_luks_parse_header(QCryptoBlockLUKS *luks, Error **errp)
+{
+    char *cipher_mode = g_strdup(luks->header.cipher_mode);
+    char *ivgen_name, *ivhash_name;
+    int ret = -1;
+    Error *local_err = NULL;
+
+    /*
+     * The cipher_mode header contains a string that we have
+     * to further parse, of the format
+     *
+     *    <cipher-mode>-<iv-generator>[:<iv-hash>]
+     *
+     * eg  cbc-essiv:sha256, cbc-plain64
+     */
+    ivgen_name = strchr(cipher_mode, '-');
+    if (!ivgen_name) {
+        ret = -EINVAL;
+        error_setg(errp, "Unexpected cipher mode string format %s",
+                   luks->header.cipher_mode);
+        goto out;
+    }
+    *ivgen_name = '\0';
+    ivgen_name++;
+
+    ivhash_name = strchr(ivgen_name, ':');
+    if (!ivhash_name) {
+        luks->ivgen_hash_alg = 0;
+    } else {
+        *ivhash_name = '\0';
+        ivhash_name++;
+
+        luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
+                                                                   &local_err);
+        if (local_err) {
+            ret = -ENOTSUP;
+            error_propagate(errp, local_err);
+            goto out;
+        }
+    }
+
+    luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
+                                                              &local_err);
+    if (local_err) {
+        ret = -ENOTSUP;
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    luks->cipher_alg =
+            qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
+                                                  luks->cipher_mode,
+                                                  luks->header.key_bytes,
+                                                  &local_err);
+    if (local_err) {
+        ret = -ENOTSUP;
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    luks->hash_alg =
+            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
+                                               &local_err);
+    if (local_err) {
+        ret = -ENOTSUP;
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
+                                                           &local_err);
+    if (local_err) {
+        ret = -ENOTSUP;
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
+        if (!ivhash_name) {
+            ret = -EINVAL;
+            error_setg(errp, "Missing IV generator hash specification");
+            goto out;
+        }
+        luks->ivgen_cipher_alg =
+                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
+                                                luks->ivgen_hash_alg,
+                                                &local_err);
+        if (local_err) {
+            ret = -ENOTSUP;
+            error_propagate(errp, local_err);
+            goto out;
+        }
+    } else {
+
+        /*
+         * Note we parsed the ivhash_name earlier in the cipher_mode
+         * spec string even with plain/plain64 ivgens, but we
+         * will ignore it, since it is irrelevant for these ivgens.
+         * This is for compat with dm-crypt which will silently
+         * ignore hash names with these ivgens rather than report
+         * an error about the invalid usage
+         */
+        luks->ivgen_cipher_alg = luks->cipher_alg;
+    }
+    ret = 0;
+out:
+    g_free(cipher_mode);
+    return ret;
+
+}
+
+/*
+ * Given a key slot,  user password, and the master key,
+ * will store the encrypted master key there, and update the
+ * in-memory header. User must then write the in-memory header
+ *
+ * Returns:
+ *    0 if the keyslot was written successfully
+ *      with the provided password
+ *   -1 if a fatal error occurred while storing the key
+ */
+static int
+qcrypto_block_luks_store_key(QCryptoBlock *block,
+                             uint slot_idx,
+                             const char *password,
+                             uint8_t *masterkey,
+                             uint64_t iter_time,
+                             QCryptoBlockWriteFunc writefunc,
+                             void *opaque,
+                             Error **errp)
+{
+    QCryptoBlockLUKS *luks = block->opaque;
+    QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
+    uint8_t *splitkey = NULL;
+    size_t splitkeylen;
+    uint8_t *slotkey = NULL;
+    QCryptoCipher *cipher = NULL;
+    QCryptoIVGen *ivgen = NULL;
+    Error *local_err = NULL;
+    uint64_t iters;
+    int ret = -1;
+
+    if (qcrypto_random_bytes(slot->salt,
+                             QCRYPTO_BLOCK_LUKS_SALT_LEN,
+                             errp) < 0) {
+        goto cleanup;
+    }
+
+    splitkeylen = masterkeylen(luks) * slot->stripes;
+
+    /*
+     * Determine how many iterations are required to
+     * hash the user password while consuming 1 second of compute
+     * time
+     */
+    iters = qcrypto_pbkdf2_count_iters(luks->hash_alg,
+                                       (uint8_t *)password, strlen(password),
+                                       slot->salt,
+                                       QCRYPTO_BLOCK_LUKS_SALT_LEN,
+                                       masterkeylen(luks),
+                                       &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto cleanup;
+    }
+
+    if (iters > (ULLONG_MAX / iter_time)) {
+        error_setg_errno(errp, ERANGE,
+                         "PBKDF iterations %llu too large to scale",
+                         (unsigned long long)iters);
+        goto cleanup;
+    }
+
+    /* iter_time was in millis, but count_iters reported for secs */
+    iters = iters * iter_time / 1000;
+
+    if (iters > UINT32_MAX) {
+        error_setg_errno(errp, ERANGE,
+                         "PBKDF iterations %llu larger than %u",
+                         (unsigned long long)iters, UINT32_MAX);
+        goto cleanup;
+    }
+
+    slot->iterations =
+        MAX(iters, QCRYPTO_BLOCK_LUKS_MIN_SLOT_KEY_ITERS);
+
+
+    /*
+     * Generate a key that we'll use to encrypt the master
+     * key, from the user's password
+     */
+    slotkey = g_new0(uint8_t, masterkeylen(luks));
+    if (qcrypto_pbkdf2(luks->hash_alg,
+                       (uint8_t *)password, strlen(password),
+                       slot->salt,
+                       QCRYPTO_BLOCK_LUKS_SALT_LEN,
+                       slot->iterations,
+                       slotkey, masterkeylen(luks),
+                       errp) < 0) {
+        goto cleanup;
+    }
+
+
+    /*
+     * Setup the encryption objects needed to encrypt the
+     * master key material
+     */
+    cipher = qcrypto_cipher_new(luks->cipher_alg,
+                                luks->cipher_mode,
+                                slotkey, masterkeylen(luks),
+                                errp);
+    if (!cipher) {
+        goto cleanup;
+    }
+
+    ivgen = qcrypto_ivgen_new(luks->ivgen_alg,
+                              luks->ivgen_cipher_alg,
+                              luks->ivgen_hash_alg,
+                              slotkey, masterkeylen(luks),
+                              errp);
+    if (!ivgen) {
+        goto cleanup;
+    }
+
+    /*
+     * Before storing the master key, we need to vastly
+     * increase its size, as protection against forensic
+     * disk data recovery
+     */
+    splitkey = g_new0(uint8_t, splitkeylen);
+
+    if (qcrypto_afsplit_encode(luks->hash_alg,
+                               masterkeylen(luks),
+                               slot->stripes,
+                               masterkey,
+                               splitkey,
+                               errp) < 0) {
+        goto cleanup;
+    }
+
+    /*
+     * Now we encrypt the split master key with the key generated
+     * from the user's password, before storing it
+     */
+    if (qcrypto_block_cipher_encrypt_helper(cipher, block->niv, ivgen,
+                                            QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
+                                            0,
+                                            splitkey,
+                                            splitkeylen,
+                                            errp) < 0) {
+        goto cleanup;
+    }
+
+    /* Write out the slot's master key material. */
+    if (writefunc(block,
+                  slot->key_offset *
+                  QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
+                  splitkey, splitkeylen,
+                  opaque,
+                  errp) != splitkeylen) {
+        goto cleanup;
+    }
+
+    slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
+
+    if (qcrypto_block_luks_store_header(block,  writefunc, opaque, errp)) {
+        goto cleanup;
+    }
+
+    ret = 0;
+
+cleanup:
+    if (slotkey) {
+        memset(slotkey, 0, masterkeylen(luks));
+        g_free(slotkey);
+    }
+
+    if (splitkey) {
+        memset(splitkey, 0, splitkeylen);
+        g_free(splitkey);
+    }
+
+    qcrypto_ivgen_free(ivgen);
+    qcrypto_cipher_free(cipher);
+    return ret;
+}
+
 /*
  * Given a key slot, and user password, this will attempt to unlock
  * the master encryption key from the key slot.
@@ -632,14 +1053,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                         Error **errp)
 {
     QCryptoBlockLUKS *luks = NULL;
-    Error *local_err = NULL;
     int ret = 0;
-    size_t i;
-    ssize_t rv;
     uint8_t *masterkey = NULL;
-    char *ivgen_name, *ivhash_name;
     char *password = NULL;
-    char *cipher_mode = NULL;
 
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         if (!options->u.luks.key_secret) {
@@ -657,154 +1073,25 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks = g_new0(QCryptoBlockLUKS, 1);
     block->opaque = luks;
 
-    /* Read the entire LUKS header, minus the key material from
-     * the underlying device */
-    rv = readfunc(block, 0,
-                  (uint8_t *)&luks->header,
-                  sizeof(luks->header),
-                  opaque,
-                  errp);
-    if (rv < 0) {
-        ret = rv;
-        goto fail;
-    }
-
-    /* The header is always stored in big-endian format, so
-     * convert everything to native */
-    be16_to_cpus(&luks->header.version);
-    be32_to_cpus(&luks->header.payload_offset);
-    be32_to_cpus(&luks->header.key_bytes);
-    be32_to_cpus(&luks->header.master_key_iterations);
-
-    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        be32_to_cpus(&luks->header.key_slots[i].active);
-        be32_to_cpus(&luks->header.key_slots[i].iterations);
-        be32_to_cpus(&luks->header.key_slots[i].key_offset);
-        be32_to_cpus(&luks->header.key_slots[i].stripes);
-    }
-
-    if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
-               QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
-        error_setg(errp, "Volume is not in LUKS format");
-        ret = -EINVAL;
-        goto fail;
-    }
-    if (luks->header.version != QCRYPTO_BLOCK_LUKS_VERSION) {
-        error_setg(errp, "LUKS version %" PRIu32 " is not supported",
-                   luks->header.version);
-        ret = -ENOTSUP;
-        goto fail;
-    }
-
-    cipher_mode = g_strdup(luks->header.cipher_mode);
-
-    /*
-     * The cipher_mode header contains a string that we have
-     * to further parse, of the format
-     *
-     *    <cipher-mode>-<iv-generator>[:<iv-hash>]
-     *
-     * eg  cbc-essiv:sha256, cbc-plain64
-     */
-    ivgen_name = strchr(cipher_mode, '-');
-    if (!ivgen_name) {
-        ret = -EINVAL;
-        error_setg(errp, "Unexpected cipher mode string format %s",
-                   luks->header.cipher_mode);
-        goto fail;
-    }
-    *ivgen_name = '\0';
-    ivgen_name++;
-
-    ivhash_name = strchr(ivgen_name, ':');
-    if (!ivhash_name) {
-        luks->ivgen_hash_alg = 0;
-    } else {
-        *ivhash_name = '\0';
-        ivhash_name++;
-
-        luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
-                                                                   &local_err);
-        if (local_err) {
-            ret = -ENOTSUP;
-            error_propagate(errp, local_err);
-            goto fail;
-        }
-    }
-
-    luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
-                                                              &local_err);
-    if (local_err) {
-        ret = -ENOTSUP;
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-
-    luks->cipher_alg =
-            qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
-                                                  luks->cipher_mode,
-                                                  luks->header.key_bytes,
-                                                  &local_err);
-    if (local_err) {
-        ret = -ENOTSUP;
-        error_propagate(errp, local_err);
+    ret = qcrypto_block_luks_load_header(block, readfunc, opaque, errp);
+    if (ret) {
         goto fail;
     }
 
-    luks->hash_alg =
-            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
-                                               &local_err);
-    if (local_err) {
-        ret = -ENOTSUP;
-        error_propagate(errp, local_err);
+    ret = qcrypto_block_luks_check_header(luks, errp);
+    if (ret) {
         goto fail;
     }
 
-    luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
-                                                           &local_err);
-    if (local_err) {
-        ret = -ENOTSUP;
-        error_propagate(errp, local_err);
+    ret = qcrypto_block_luks_parse_header(luks, errp);
+    if (ret) {
         goto fail;
     }
 
-    if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
-        if (!ivhash_name) {
-            ret = -EINVAL;
-            error_setg(errp, "Missing IV generator hash specification");
-            goto fail;
-        }
-        luks->ivgen_cipher_alg =
-                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
-                                                luks->ivgen_hash_alg,
-                                                &local_err);
-        if (local_err) {
-            ret = -ENOTSUP;
-            error_propagate(errp, local_err);
-            goto fail;
-        }
-    } else {
-        /* Note we parsed the ivhash_name earlier in the cipher_mode
-         * spec string even with plain/plain64 ivgens, but we
-         * will ignore it, since it is irrelevant for these ivgens.
-         * This is for compat with dm-crypt which will silently
-         * ignore hash names with these ivgens rather than report
-         * an error about the invalid usage
-         */
-        luks->ivgen_cipher_alg = luks->cipher_alg;
-    }
-
-
-    g_free(cipher_mode);
-    cipher_mode = NULL;
-    ivgen_name = NULL;
-    ivhash_name = NULL;
-
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         /* Try to find which key slot our password is valid for
          * and unlock the master key from that slot.
          */
-
         masterkey = g_new0(uint8_t, masterkeylen(luks));
 
         if (qcrypto_block_luks_find_key(block,
@@ -845,12 +1132,10 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     }
 
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
-    block->payload_offset = luks->header.payload_offset *
-        block->sector_size;
+    block->payload_offset = luks->header.payload_offset * block->sector_size;
 
     g_free(masterkey);
     g_free(password);
-
     return 0;
 
  fail:
@@ -884,12 +1169,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     QCryptoBlockCreateOptionsLUKS luks_opts;
     Error *local_err = NULL;
     uint8_t *masterkey = NULL;
-    uint8_t *slotkey = NULL;
-    uint8_t *splitkey = NULL;
     size_t splitkeylen = 0;
     size_t i;
-    QCryptoCipher *cipher = NULL;
-    QCryptoIVGen *ivgen = NULL;
     char *password;
     const char *cipher_alg;
     const char *cipher_mode;
@@ -1112,9 +1393,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
      * to use the first key slot */
     splitkeylen = luks->header.key_bytes * QCRYPTO_BLOCK_LUKS_STRIPES;
     for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        luks->header.key_slots[i].active = i == 0 ?
-            QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED :
-            QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
+        luks->header.key_slots[i].active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
         luks->header.key_slots[i].stripes = QCRYPTO_BLOCK_LUKS_STRIPES;
 
         /* This calculation doesn't match that shown in the spec,
@@ -1128,107 +1407,6 @@ qcrypto_block_luks_create(QCryptoBlock *block,
                        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) * i);
     }
 
-    if (qcrypto_random_bytes(luks->header.key_slots[0].salt,
-                             QCRYPTO_BLOCK_LUKS_SALT_LEN,
-                             errp) < 0) {
-        goto error;
-    }
-
-    /* Again we determine how many iterations are required to
-     * hash the user password while consuming 1 second of compute
-     * time */
-    iters = qcrypto_pbkdf2_count_iters(luks_opts.hash_alg,
-                                       (uint8_t *)password, strlen(password),
-                                       luks->header.key_slots[0].salt,
-                                       QCRYPTO_BLOCK_LUKS_SALT_LEN,
-                                       luks->header.key_bytes,
-                                       &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto error;
-    }
-
-    if (iters > (ULLONG_MAX / luks_opts.iter_time)) {
-        error_setg_errno(errp, ERANGE,
-                         "PBKDF iterations %llu too large to scale",
-                         (unsigned long long)iters);
-        goto error;
-    }
-
-    /* iter_time was in millis, but count_iters reported for secs */
-    iters = iters * luks_opts.iter_time / 1000;
-
-    if (iters > UINT32_MAX) {
-        error_setg_errno(errp, ERANGE,
-                         "PBKDF iterations %llu larger than %u",
-                         (unsigned long long)iters, UINT32_MAX);
-        goto error;
-    }
-
-    luks->header.key_slots[0].iterations =
-        MAX(iters, QCRYPTO_BLOCK_LUKS_MIN_SLOT_KEY_ITERS);
-
-
-    /* Generate a key that we'll use to encrypt the master
-     * key, from the user's password
-     */
-    slotkey = g_new0(uint8_t, luks->header.key_bytes);
-    if (qcrypto_pbkdf2(luks_opts.hash_alg,
-                       (uint8_t *)password, strlen(password),
-                       luks->header.key_slots[0].salt,
-                       QCRYPTO_BLOCK_LUKS_SALT_LEN,
-                       luks->header.key_slots[0].iterations,
-                       slotkey, luks->header.key_bytes,
-                       errp) < 0) {
-        goto error;
-    }
-
-
-    /* Setup the encryption objects needed to encrypt the
-     * master key material
-     */
-    cipher = qcrypto_cipher_new(luks_opts.cipher_alg,
-                                luks_opts.cipher_mode,
-                                slotkey, luks->header.key_bytes,
-                                errp);
-    if (!cipher) {
-        goto error;
-    }
-
-    ivgen = qcrypto_ivgen_new(luks_opts.ivgen_alg,
-                              ivcipheralg,
-                              luks_opts.ivgen_hash_alg,
-                              slotkey, luks->header.key_bytes,
-                              errp);
-    if (!ivgen) {
-        goto error;
-    }
-
-    /* Before storing the master key, we need to vastly
-     * increase its size, as protection against forensic
-     * disk data recovery */
-    splitkey = g_new0(uint8_t, splitkeylen);
-
-    if (qcrypto_afsplit_encode(luks_opts.hash_alg,
-                               luks->header.key_bytes,
-                               luks->header.key_slots[0].stripes,
-                               masterkey,
-                               splitkey,
-                               errp) < 0) {
-        goto error;
-    }
-
-    /* Now we encrypt the split master key with the key generated
-     * from the user's password, before storing it */
-    if (qcrypto_block_cipher_encrypt_helper(cipher, block->niv, ivgen,
-                                            QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                            0,
-                                            splitkey,
-                                            splitkeylen,
-                                            errp) < 0) {
-        goto error;
-    }
-
 
     /* The total size of the LUKS headers is the partition header + key
      * slot headers, rounded up to the nearest sector, combined with
@@ -1253,71 +1431,25 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
 
-    /* Everything on disk uses Big Endian, so flip header fields
-     * before writing them */
-    cpu_to_be16s(&luks->header.version);
-    cpu_to_be32s(&luks->header.payload_offset);
-    cpu_to_be32s(&luks->header.key_bytes);
-    cpu_to_be32s(&luks->header.master_key_iterations);
-
-    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        cpu_to_be32s(&luks->header.key_slots[i].active);
-        cpu_to_be32s(&luks->header.key_slots[i].iterations);
-        cpu_to_be32s(&luks->header.key_slots[i].key_offset);
-        cpu_to_be32s(&luks->header.key_slots[i].stripes);
-    }
-
-
-    /* Write out the partition header and key slot headers */
-    writefunc(block, 0,
-              (const uint8_t *)&luks->header,
-              sizeof(luks->header),
-              opaque,
-              &local_err);
-
-    /* Delay checking local_err until we've byte-swapped */
-
-    /* Byte swap the header back to native, in case we need
-     * to read it again later */
-    be16_to_cpus(&luks->header.version);
-    be32_to_cpus(&luks->header.payload_offset);
-    be32_to_cpus(&luks->header.key_bytes);
-    be32_to_cpus(&luks->header.master_key_iterations);
-
-    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
-        be32_to_cpus(&luks->header.key_slots[i].active);
-        be32_to_cpus(&luks->header.key_slots[i].iterations);
-        be32_to_cpus(&luks->header.key_slots[i].key_offset);
-        be32_to_cpus(&luks->header.key_slots[i].stripes);
-    }
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    /* populate the slot 0 with the password encrypted master key*/
+    /* This will also store the header */
+    if (qcrypto_block_luks_store_key(block,
+                                     0,
+                                     password,
+                                     masterkey,
+                                     luks_opts.iter_time,
+                                     writefunc,
+                                     opaque,
+                                     errp)) {
         goto error;
-    }
+     }
 
-    /* Write out the master key material, starting at the
-     * sector immediately following the partition header. */
-    if (writefunc(block,
-                  luks->header.key_slots[0].key_offset *
-                  QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                  splitkey, splitkeylen,
-                  opaque,
-                  errp) != splitkeylen) {
-        goto error;
-    }
 
     memset(masterkey, 0, luks->header.key_bytes);
     g_free(masterkey);
-    memset(slotkey, 0, luks->header.key_bytes);
-    g_free(slotkey);
-    g_free(splitkey);
     g_free(password);
     g_free(cipher_mode_spec);
 
-    qcrypto_ivgen_free(ivgen);
-    qcrypto_cipher_free(cipher);
-
     return 0;
 
  error:
@@ -1325,17 +1457,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         memset(masterkey, 0, luks->header.key_bytes);
     }
     g_free(masterkey);
-    if (slotkey) {
-        memset(slotkey, 0, luks->header.key_bytes);
-    }
-    g_free(slotkey);
-    g_free(splitkey);
     g_free(password);
     g_free(cipher_mode_spec);
 
-    qcrypto_ivgen_free(ivgen);
-    qcrypto_cipher_free(cipher);
-
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
 
-- 
2.17.2


