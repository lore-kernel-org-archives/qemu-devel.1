Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD9BC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6612206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6612206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FSq-0002F7-Cr
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FPv-0008TK-0g
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FPs-00079T-Vn
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:52:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2FPk-0006wB-BI; Mon, 26 Aug 2019 09:52:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24DBE308FC4E;
 Mon, 26 Aug 2019 13:52:05 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80F745D704;
 Mon, 26 Aug 2019 13:52:02 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 16:50:57 +0300
Message-Id: <20190826135103.22410-8-mlevitsk@redhat.com>
In-Reply-To: <20190826135103.22410-1-mlevitsk@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 26 Aug 2019 13:52:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 07/13] qcrypto-luks: use the parsed
 encryption settings in QCryptoBlockLUKS
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

Prior to that patch, the parsed encryptio settings
were alrady stored into the QCryptoBlockLUKS but not
used anywhere but in qcrypto_block_luks_get_info

Using them simplifies the code

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 169 +++++++++++++++++++++-----------------------
 1 file changed, 79 insertions(+), 90 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 0d81f2ac61..cad65ae0aa 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -199,13 +199,25 @@ QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSHeader) != 592);
 struct QCryptoBlockLUKS {
     QCryptoBlockLUKSHeader header;
 
-    /* Cache parsed versions of what's in header fields,
-     * as we can't rely on QCryptoBlock.cipher being
-     * non-NULL */
+    /* Main encryption algorithm used for encryption*/
     QCryptoCipherAlgorithm cipher_alg;
+
+    /* Mode of encryption for the selected encryption algorithm */
     QCryptoCipherMode cipher_mode;
+
+    /* Initialization vector generation algorithm */
     QCryptoIVGenAlgorithm ivgen_alg;
+
+    /* Hash algorithm used for IV generation*/
     QCryptoHashAlgorithm ivgen_hash_alg;
+
+    /*
+     * Encryption algorithm used for IV generation.
+     * Usually the same as main encryption algorithm
+     */
+    QCryptoCipherAlgorithm ivgen_cipher_alg;
+
+    /* Hash algorithm used in pbkdf2 function */
     QCryptoHashAlgorithm hash_alg;
 };
 
@@ -412,12 +424,6 @@ static int
 qcrypto_block_luks_load_key(QCryptoBlock *block,
                             unsigned int slot_idx,
                             const char *password,
-                            QCryptoCipherAlgorithm cipheralg,
-                            QCryptoCipherMode ciphermode,
-                            QCryptoHashAlgorithm hash,
-                            QCryptoIVGenAlgorithm ivalg,
-                            QCryptoCipherAlgorithm ivcipheralg,
-                            QCryptoHashAlgorithm ivhash,
                             uint8_t *masterkey,
                             QCryptoBlockReadFunc readfunc,
                             void *opaque,
@@ -449,7 +455,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * the key is correct and validate the results of
      * decryption later.
      */
-    if (qcrypto_pbkdf2(hash,
+    if (qcrypto_pbkdf2(luks->hash_alg,
                        (const uint8_t *)password, strlen(password),
                        slot->salt, QCRYPTO_BLOCK_LUKS_SALT_LEN,
                        slot->iterations,
@@ -477,19 +483,23 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
 
     /* Setup the cipher/ivgen that we'll use to try to decrypt
      * the split master key material */
-    cipher = qcrypto_cipher_new(cipheralg, ciphermode,
-                                possiblekey, luks->header.master_key_len,
+    cipher = qcrypto_cipher_new(luks->cipher_alg,
+                                luks->cipher_mode,
+                                possiblekey,
+                                luks->header.master_key_len,
                                 errp);
     if (!cipher) {
         return -1;
     }
 
-    niv = qcrypto_cipher_get_iv_len(cipheralg,
-                                    ciphermode);
-    ivgen = qcrypto_ivgen_new(ivalg,
-                              ivcipheralg,
-                              ivhash,
-                              possiblekey, luks->header.master_key_len,
+    niv = qcrypto_cipher_get_iv_len(luks->cipher_alg,
+                                    luks->cipher_mode);
+
+    ivgen = qcrypto_ivgen_new(luks->ivgen_alg,
+                              luks->ivgen_cipher_alg,
+                              luks->ivgen_hash_alg,
+                              possiblekey,
+                              luks->header.master_key_len,
                               errp);
     if (!ivgen) {
         return -1;
@@ -518,7 +528,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * Now we've decrypted the split master key, join
      * it back together to get the actual master key.
      */
-    if (qcrypto_afsplit_decode(hash,
+    if (qcrypto_afsplit_decode(luks->hash_alg,
                                luks->header.master_key_len,
                                slot->stripes,
                                splitkey,
@@ -536,7 +546,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * then comparing that to the hash stored in the key slot
      * header
      */
-    if (qcrypto_pbkdf2(hash,
+    if (qcrypto_pbkdf2(luks->hash_alg,
                        masterkey,
                        luks->header.master_key_len,
                        luks->header.master_key_salt,
@@ -570,12 +580,6 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
 static int
 qcrypto_block_luks_find_key(QCryptoBlock *block,
                             const char *password,
-                            QCryptoCipherAlgorithm cipheralg,
-                            QCryptoCipherMode ciphermode,
-                            QCryptoHashAlgorithm hash,
-                            QCryptoIVGenAlgorithm ivalg,
-                            QCryptoCipherAlgorithm ivcipheralg,
-                            QCryptoHashAlgorithm ivhash,
                             uint8_t *masterkey,
                             QCryptoBlockReadFunc readfunc,
                             void *opaque,
@@ -588,12 +592,6 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
         rv = qcrypto_block_luks_load_key(block,
                                          i,
                                          password,
-                                         cipheralg,
-                                         ciphermode,
-                                         hash,
-                                         ivalg,
-                                         ivcipheralg,
-                                         ivhash,
                                          masterkey,
                                          readfunc,
                                          opaque,
@@ -607,7 +605,6 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
     }
 
     error_setg(errp, "Invalid password, cannot unlock any keyslot");
-
  error:
     return -1;
 }
@@ -623,19 +620,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                         size_t n_threads,
                         Error **errp)
 {
-    QCryptoBlockLUKS *luks;
+    QCryptoBlockLUKS *luks = NULL;
     Error *local_err = NULL;
     int ret = 0;
     size_t i;
     ssize_t rv;
     g_autofree uint8_t *masterkey = NULL;
     char *ivgen_name, *ivhash_name;
-    QCryptoCipherMode ciphermode;
-    QCryptoCipherAlgorithm cipheralg;
-    QCryptoIVGenAlgorithm ivalg;
-    QCryptoCipherAlgorithm ivcipheralg;
-    QCryptoHashAlgorithm hash;
-    QCryptoHashAlgorithm ivhash;
     g_autofree char *password = NULL;
     g_autofree char *cipher_mode = NULL;
 
@@ -716,13 +707,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 
     ivhash_name = strchr(ivgen_name, ':');
     if (!ivhash_name) {
-        ivhash = 0;
+        luks->ivgen_hash_alg = 0;
     } else {
         *ivhash_name = '\0';
         ivhash_name++;
 
-        ivhash = qcrypto_block_luks_hash_name_lookup(ivhash_name,
-                                                     &local_err);
+        luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
+                                                                   &local_err);
         if (local_err) {
             ret = -ENOTSUP;
             error_propagate(errp, local_err);
@@ -730,17 +721,17 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         }
     }
 
-    ciphermode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
-                                                       &local_err);
+    luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
+                                                              &local_err);
     if (local_err) {
         ret = -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
 
-    cipheralg =
+    luks->cipher_alg =
         qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
-                                              ciphermode,
+                                              luks->cipher_mode,
                                               luks->header.master_key_len,
                                               &local_err);
     if (local_err) {
@@ -749,31 +740,33 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         goto fail;
     }
 
-    hash = qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
-                                               &local_err);
+    luks->hash_alg =
+            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
+                                                &local_err);
     if (local_err) {
         ret = -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
 
-    ivalg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
-                                                 &local_err);
+    luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
+                                                           &local_err);
     if (local_err) {
         ret = -ENOTSUP;
         error_propagate(errp, local_err);
         goto fail;
     }
 
-    if (ivalg == QCRYPTO_IVGEN_ALG_ESSIV) {
+    if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
         if (!ivhash_name) {
             ret = -EINVAL;
             error_setg(errp, "Missing IV generator hash specification");
             goto fail;
         }
-        ivcipheralg = qcrypto_block_luks_essiv_cipher(cipheralg,
-                                                      ivhash,
-                                                      &local_err);
+        luks->ivgen_cipher_alg =
+                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
+                                                luks->ivgen_hash_alg,
+                                                &local_err);
         if (local_err) {
             ret = -ENOTSUP;
             error_propagate(errp, local_err);
@@ -787,7 +780,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
          * ignore hash names with these ivgens rather than report
          * an error about the invalid usage
          */
-        ivcipheralg = cipheralg;
+        luks->ivgen_cipher_alg = luks->cipher_alg;
     }
 
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
@@ -799,11 +792,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 
         if (qcrypto_block_luks_find_key(block,
                                         password,
-                                        cipheralg, ciphermode,
-                                        hash,
-                                        ivalg,
-                                        ivcipheralg,
-                                        ivhash,
                                         masterkey,
                                         readfunc, opaque,
                                         errp) < 0) {
@@ -814,12 +802,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
         /* We have a valid master key now, so can setup the
          * block device payload decryption objects
          */
-        block->kdfhash = hash;
-        block->niv = qcrypto_cipher_get_iv_len(cipheralg,
-                                               ciphermode);
-        block->ivgen = qcrypto_ivgen_new(ivalg,
-                                         ivcipheralg,
-                                         ivhash,
+        block->kdfhash = luks->hash_alg;
+        block->niv = qcrypto_cipher_get_iv_len(luks->cipher_alg,
+                                               luks->cipher_mode);
+
+        block->ivgen = qcrypto_ivgen_new(luks->ivgen_alg,
+                                         luks->ivgen_cipher_alg,
+                                         luks->ivgen_hash_alg,
                                          masterkey,
                                          luks->header.master_key_len,
                                          errp);
@@ -828,7 +817,9 @@ qcrypto_block_luks_open(QCryptoBlock *block,
             goto fail;
         }
 
-        ret = qcrypto_block_init_cipher(block, cipheralg, ciphermode,
+        ret = qcrypto_block_init_cipher(block,
+                                        luks->cipher_alg,
+                                        luks->cipher_mode,
                                         masterkey,
                                         luks->header.master_key_len,
                                         n_threads,
@@ -843,11 +834,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     block->payload_offset = luks->header.payload_offset_sector *
         block->sector_size;
 
-    luks->cipher_alg = cipheralg;
-    luks->cipher_mode = ciphermode;
-    luks->ivgen_alg = ivalg;
-    luks->ivgen_hash_alg = ivhash;
-    luks->hash_alg = hash;
 
     return 0;
 
@@ -893,7 +879,6 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     const char *ivgen_hash_alg = NULL;
     const char *hash_alg;
     g_autofree char *cipher_mode_spec = NULL;
-    QCryptoCipherAlgorithm ivcipheralg = 0;
     uint64_t iters;
 
     memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
@@ -918,6 +903,17 @@ qcrypto_block_luks_create(QCryptoBlock *block,
             luks_opts.has_ivgen_hash_alg = true;
         }
     }
+
+    luks = g_new0(QCryptoBlockLUKS, 1);
+    block->opaque = luks;
+
+    luks->cipher_alg = luks_opts.cipher_alg;
+    luks->cipher_mode = luks_opts.cipher_mode;
+    luks->ivgen_alg = luks_opts.ivgen_alg;
+    luks->ivgen_hash_alg = luks_opts.ivgen_hash_alg;
+    luks->hash_alg = luks_opts.hash_alg;
+
+
     /* Note we're allowing ivgen_hash_alg to be set even for
      * non-essiv iv generators that don't need a hash. It will
      * be silently ignored, for compatibility with dm-crypt */
@@ -925,15 +921,13 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     if (!options->u.luks.key_secret) {
         error_setg(errp, "Parameter '%skey-secret' is required for cipher",
                    optprefix ? optprefix : "");
-        return -1;
+        goto error;
     }
     password = qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, errp);
     if (!password) {
-        return -1;
+        goto error;
     }
 
-    luks = g_new0(QCryptoBlockLUKS, 1);
-    block->opaque = luks;
 
     memcpy(luks->header.magic, qcrypto_block_luks_magic,
            QCRYPTO_BLOCK_LUKS_MAGIC_LEN);
@@ -980,15 +974,16 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     }
 
     if (luks_opts.ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
-        ivcipheralg = qcrypto_block_luks_essiv_cipher(luks_opts.cipher_alg,
-                                                      luks_opts.ivgen_hash_alg,
-                                                      &local_err);
+        luks->ivgen_cipher_alg =
+                qcrypto_block_luks_essiv_cipher(luks_opts.cipher_alg,
+                                                luks_opts.ivgen_hash_alg,
+                                                &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto error;
         }
     } else {
-        ivcipheralg = luks_opts.cipher_alg;
+        luks->ivgen_cipher_alg = luks_opts.cipher_alg;
     }
 
     strcpy(luks->header.cipher_name, cipher_alg);
@@ -1030,7 +1025,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     block->niv = qcrypto_cipher_get_iv_len(luks_opts.cipher_alg,
                                            luks_opts.cipher_mode);
     block->ivgen = qcrypto_ivgen_new(luks_opts.ivgen_alg,
-                                     ivcipheralg,
+                                     luks->ivgen_cipher_alg,
                                      luks_opts.ivgen_hash_alg,
                                      masterkey, luks->header.master_key_len,
                                      errp);
@@ -1183,7 +1178,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     }
 
     ivgen = qcrypto_ivgen_new(luks_opts.ivgen_alg,
-                              ivcipheralg,
+                              luks->ivgen_cipher_alg,
                               luks_opts.ivgen_hash_alg,
                               slotkey, luks->header.master_key_len,
                               errp);
@@ -1294,12 +1289,6 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
 
-    luks->cipher_alg = luks_opts.cipher_alg;
-    luks->cipher_mode = luks_opts.cipher_mode;
-    luks->ivgen_alg = luks_opts.ivgen_alg;
-    luks->ivgen_hash_alg = luks_opts.ivgen_hash_alg;
-    luks->hash_alg = luks_opts.hash_alg;
-
     memset(masterkey, 0, luks->header.master_key_len);
     memset(slotkey, 0, luks->header.master_key_len);
 
-- 
2.17.2


