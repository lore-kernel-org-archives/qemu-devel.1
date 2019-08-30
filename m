Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B5AC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A824523429
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A824523429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3o2R-0007XK-QV
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 17:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwg-000357-AO
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i3nwe-0001P6-6d
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:56:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33864)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i3nwY-0001L0-D4; Fri, 30 Aug 2019 16:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8065A10F23F9;
 Fri, 30 Aug 2019 20:56:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FCB55D9CA;
 Fri, 30 Aug 2019 20:56:21 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 23:56:01 +0300
Message-Id: <20190830205608.18192-4-mlevitsk@redhat.com>
In-Reply-To: <20190830205608.18192-1-mlevitsk@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 30 Aug 2019 20:56:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 03/10] qcrypto-luks: implement the encryption
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

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 366 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 364 insertions(+), 2 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index ba20d55246..21325fbc79 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -70,6 +70,9 @@ typedef struct QCryptoBlockLUKSKeySlot QCryptoBlockLUKSKeySlot;
 
 #define QCRYPTO_BLOCK_LUKS_SECTOR_SIZE 512LL
 
+#define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME 2000
+#define QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS 40
+
 static const char qcrypto_block_luks_magic[QCRYPTO_BLOCK_LUKS_MAGIC_LEN] = {
     'L', 'U', 'K', 'S', 0xBA, 0xBE
 };
@@ -219,6 +222,9 @@ struct QCryptoBlockLUKS {
 
     /* Hash algorithm used in pbkdf2 function */
     QCryptoHashAlgorithm hash_alg;
+
+    /* Name of the secret that was used to open the image */
+    char *secret;
 };
 
 
@@ -1089,6 +1095,175 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
 }
 
 
+
+/*
+ * Returns true if a slot i is marked as active
+ * (contains encrypted copy of the master key)
+ */
+
+static bool
+qcrypto_block_luks_slot_active(const QCryptoBlockLUKS *luks,
+                               unsigned int slot_idx)
+{
+    uint32_t val = luks->header.key_slots[slot_idx].active;
+    return val ==  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
+}
+
+/*
+ * Returns the number of slots that are marked as active
+ * (contains encrypted copy of the master key)
+ */
+
+static unsigned int
+qcrypto_block_luks_count_active_slots(const QCryptoBlockLUKS *luks)
+{
+    size_t i = 0;
+    unsigned int ret = 0;
+
+    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        if (qcrypto_block_luks_slot_active(luks, i)) {
+            ret++;
+        }
+    }
+    return ret;
+}
+
+
+/*
+ * Finds first key slot which is not active
+ * Returns the key slot index, or -1 if doesn't exist
+ */
+
+static int
+qcrypto_block_luks_find_free_keyslot(const QCryptoBlockLUKS *luks)
+{
+    size_t i;
+
+    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+        if (!qcrypto_block_luks_slot_active(luks, i)) {
+            return i;
+        }
+    }
+    return -1;
+
+}
+
+/*
+ * Erases an keyslot given its index
+ * Returns:
+ *    0 if the keyslot was erased successfully
+ *   -1 if a error occurred while erasing the keyslot
+ *
+ */
+
+static int
+qcrypto_block_luks_erase_key(QCryptoBlock *block,
+                             unsigned int slot_idx,
+                             QCryptoBlockWriteFunc writefunc,
+                             void *opaque,
+                             Error **errp)
+{
+    QCryptoBlockLUKS *luks = block->opaque;
+    QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
+    g_autofree uint8_t *garbagesplitkey = NULL;
+    size_t splitkeylen = luks->header.master_key_len * slot->stripes;
+    size_t i;
+
+    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
+    assert(splitkeylen > 0);
+
+    garbagesplitkey = g_malloc0(splitkeylen);
+
+    /* Reset the key slot header */
+    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
+    slot->iterations = 0;
+    slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
+
+    qcrypto_block_luks_store_header(block,  writefunc, opaque, errp);
+
+    /*
+     * Now try to erase the key material, even if the header
+     * update failed
+     */
+
+    for (i = 0 ; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS ; i++) {
+        if (qcrypto_random_bytes(garbagesplitkey, splitkeylen, errp) < 0) {
+                /*
+                 * If we failed to get the random data, still write
+                 * at least zeros to the key slot at least once
+                 */
+
+                if (i > 0) {
+                    return -1;
+                }
+        }
+
+        if (writefunc(block,
+                      slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
+                      garbagesplitkey,
+                      splitkeylen,
+                      opaque,
+                      errp) != splitkeylen) {
+            return -1;
+        }
+    }
+    return 0;
+}
+
+
+/*
+ * Erase all the keys that match the given password
+ * Will stop when only one keyslot is remaining
+ * Returns number of slots that were erased or -1 on failure
+ */
+
+static int
+qcrypto_block_luks_erase_matching_keys(QCryptoBlock *block,
+                                       const char *password,
+                                       QCryptoBlockReadFunc readfunc,
+                                       QCryptoBlockWriteFunc writefunc,
+                                       void *opaque,
+                                       bool force,
+                                       Error **errp)
+{
+    QCryptoBlockLUKS *luks = block->opaque;
+    size_t i;
+    int rv;
+    g_autofree uint8_t *masterkey = NULL;
+    unsigned int erased_cnt = 0;
+    unsigned int active_slot_cnt = qcrypto_block_luks_count_active_slots(luks);
+
+    masterkey = g_new0(uint8_t, luks->header.master_key_len);
+
+    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
+
+        /* refuse to erase last key if not forced */
+        if (!force && active_slot_cnt == 1) {
+            break;
+        }
+
+        rv = qcrypto_block_luks_load_key(block, i, password, masterkey,
+                                         readfunc, opaque, errp);
+        if (rv < 0) {
+            return -1;
+        }
+        if (rv == 0) {
+            continue;
+        }
+
+        rv = qcrypto_block_luks_erase_key(block, i, writefunc, opaque, errp);
+        if (rv < 0) {
+            return -1;
+        }
+
+        erased_cnt++;
+        active_slot_cnt--;
+    }
+
+    return erased_cnt;
+}
+
+
 static int
 qcrypto_block_luks_open(QCryptoBlock *block,
                         QCryptoBlockOpenOptions *options,
@@ -1119,6 +1294,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 
     luks = g_new0(QCryptoBlockLUKS, 1);
     block->opaque = luks;
+    luks->secret = g_strdup(options->u.luks.key_secret);
 
     ret = qcrypto_block_luks_load_header(block, readfunc, opaque, errp);
     if (ret) {
@@ -1234,7 +1410,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
 
     memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
     if (!luks_opts.has_iter_time) {
-        luks_opts.iter_time = 2000;
+        luks_opts.iter_time = QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME;
     }
     if (!luks_opts.has_cipher_alg) {
         luks_opts.cipher_alg = QCRYPTO_CIPHER_ALG_AES_256;
@@ -1292,6 +1468,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
                    optprefix ? optprefix : "");
         goto error;
     }
+    luks->secret = g_strdup(options->u.luks.key_secret);
+
     password = qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, errp);
     if (!password) {
         goto error;
@@ -1522,6 +1700,187 @@ qcrypto_block_luks_create(QCryptoBlock *block,
 }
 
 
+#define CHECK_NON_AMEND_OPTION(luks, luks_opts, name) \
+    if (luks_opts.has_##name && luks_opts.name != luks->name) { \
+            error_setg(errp, "Option \"" #name "\" can't be amended"); \
+            goto cleanup; \
+    }
+
+static int
+qcrypto_block_luks_amend_options(QCryptoBlock *block,
+                                 QCryptoBlockReadFunc readfunc,
+                                 QCryptoBlockWriteFunc writefunc,
+                                 void *opaque,
+                                 QCryptoBlockCreateOptions *options,
+                                 bool force,
+                                 Error **errp)
+{
+    QCryptoBlockLUKS *luks = block->opaque;
+    QCryptoBlockCreateOptionsLUKS luks_opts;
+    g_autofree char *old_password = NULL;
+    g_autofree char *password = NULL;
+    const char *unlock_secret = luks->secret;
+    g_autofree uint8_t *masterkey = NULL;
+    int slot = -1;
+    int ret = -1;
+    bool active = true;
+    int64_t iter_time = QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME;
+
+    memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
+
+    CHECK_NON_AMEND_OPTION(luks, luks_opts, cipher_alg);
+    CHECK_NON_AMEND_OPTION(luks, luks_opts, cipher_mode);
+    CHECK_NON_AMEND_OPTION(luks, luks_opts, ivgen_alg);
+    CHECK_NON_AMEND_OPTION(luks, luks_opts, ivgen_hash_alg);
+    CHECK_NON_AMEND_OPTION(luks, luks_opts, hash_alg);
+
+    /* Read given slot and check it */
+    if (luks_opts.has_slot) {
+        slot = luks_opts.slot;
+        if (slot < 0 || slot >= QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS) {
+            error_setg(errp,
+                       "Given key slot %i is not supported by LUKS", slot);
+             goto cleanup;
+        }
+    }
+
+    if (luks_opts.has_iter_time) {
+        iter_time = luks_opts.iter_time;
+    }
+
+    if (luks_opts.has_active && luks_opts.active == false) {
+        active = false;
+    }
+
+    if (active) {
+
+        /* Check that we are not overwriting an active slot */
+        if (!force && slot != -1 &&
+            qcrypto_block_luks_slot_active(luks, slot)) {
+
+            error_setg(errp, "Can't update an active key slot %i",
+                       slot);
+            goto cleanup;
+        }
+
+        /* check that we have the passwords*/
+        if (!luks_opts.has_key_secret) {
+            error_setg(errp, "Can't add a key slot without a  password");
+            goto cleanup;
+        }
+
+        if (luks_opts.has_unlock_secret) {
+            unlock_secret = luks_opts.unlock_secret;
+        }
+
+        /* Read the old password */
+        old_password = qcrypto_secret_lookup_as_utf8(unlock_secret, errp);
+        if (!old_password) {
+            goto cleanup;
+        }
+
+        masterkey = g_new0(uint8_t, luks->header.master_key_len);
+
+        /* Retrieve the master key*/
+        if (qcrypto_block_luks_find_key(block, old_password, masterkey,
+                                        readfunc, opaque,
+                                        errp) < 0) {
+            error_append_hint(errp,
+                              "unlock secret, doesn't unlock the image");
+            goto cleanup;
+        }
+
+        /* Read the new password*/
+        password = qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, errp);
+        if (!password) {
+            goto cleanup;
+        }
+
+        /* Find the new slot to write to */
+        if (slot == -1) {
+            slot = qcrypto_block_luks_find_free_keyslot(luks);
+
+            if (slot == -1) {
+                error_setg(errp,
+                           "Can't add a keyslot - all key slots are in use");
+                goto cleanup;
+
+            }
+        }
+
+        /* Store the master key to the new slot */
+        if (qcrypto_block_luks_store_key(block, slot, password, masterkey,
+                                         iter_time, writefunc, opaque,
+                                         errp)) {
+
+            error_append_hint(errp, "Failed to store the keyslot %i", slot);
+            goto cleanup;
+        }
+
+    } else {
+
+        /* Check that we are not erasing last key slot */
+        if (qcrypto_block_luks_count_active_slots(luks) <= 1) {
+
+            if (!force) {
+                error_setg(errp, "Only one slot active - can't erase");
+                goto cleanup;
+            }
+        }
+
+        if (slot != -1) {
+            /* Check that we are not erasing an inactive slot */
+            if (!qcrypto_block_luks_slot_active(luks, luks_opts.slot)) {
+                if (!force) {
+                    error_setg(errp, "Can't erase an inactive key slot %i",
+                               slot);
+                    goto cleanup;
+                }
+            }
+
+            /* Erase the given slot */
+            if (qcrypto_block_luks_erase_key(block, slot,
+                                             writefunc, opaque, errp)) {
+                goto cleanup;
+            }
+
+        } else {
+            if (!luks_opts.has_key_secret) {
+                error_setg(errp,
+                           "To erase a keyslot you have to specify either the"
+                           "slot index or a password "
+                           "(to erase all slots that match it)");
+                goto cleanup;
+            }
+
+            password = qcrypto_secret_lookup_as_utf8(luks_opts.key_secret,
+                                                     errp);
+            if (!password) {
+                goto cleanup;
+            }
+
+            ret = qcrypto_block_luks_erase_matching_keys(block, password,
+                                                       readfunc, writefunc,
+                                                       opaque, force, errp);
+            if (ret == 0) {
+                error_setg(errp,
+                           "Didn't erase a keyslot, because no keyslots match"
+                           " the given password");
+                ret = -EINVAL;
+                goto cleanup;
+            }
+
+            if (ret < 0) {
+                goto cleanup;
+            }
+        }
+    }
+    ret = 0;
+cleanup:
+    return ret;
+}
+
+
 static int qcrypto_block_luks_get_info(QCryptoBlock *block,
                                        QCryptoBlockInfo *info,
                                        Error **errp)
@@ -1569,7 +1928,9 @@ static int qcrypto_block_luks_get_info(QCryptoBlock *block,
 
 static void qcrypto_block_luks_cleanup(QCryptoBlock *block)
 {
-    g_free(block->opaque);
+    QCryptoBlockLUKS *luks = block->opaque;
+    g_free(luks->secret);
+    g_free(luks);
 }
 
 
@@ -1606,6 +1967,7 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
 const QCryptoBlockDriver qcrypto_block_driver_luks = {
     .open = qcrypto_block_luks_open,
     .create = qcrypto_block_luks_create,
+    .amend = qcrypto_block_luks_amend_options,
     .get_info = qcrypto_block_luks_get_info,
     .cleanup = qcrypto_block_luks_cleanup,
     .decrypt = qcrypto_block_luks_decrypt,
-- 
2.17.2


