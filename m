Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98FFC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6A8233A0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6A8233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kmI-0004nG-RE
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0kiQ-0007oJ-Rn
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0kiO-00042a-Ld
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i0kiO-000421-CD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F4EB301E12C
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:53:11 +0000 (UTC)
Received: from dhcp-16-132.lcy.redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4DE5600CD;
 Thu, 22 Aug 2019 10:53:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 11:53:02 +0100
Message-Id: <20190822105302.26823-4-berrange@redhat.com>
In-Reply-To: <20190822105302.26823-1-berrange@redhat.com>
References: <20190822105302.26823-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 22 Aug 2019 10:53:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/3] crypto: use auto cleanup for many stack
 variables
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify cleanup paths by using glib's auto cleanup macros for stack
variables, allowing several goto jumps / labels to be eliminated.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/afsplit.c      | 28 +++++-----------
 crypto/block-luks.c   | 74 +++++++++++++------------------------------
 crypto/block.c        | 15 +++------
 crypto/pbkdf.c        |  5 +--
 crypto/secret.c       | 39 ++++++++++-------------
 crypto/tlscredsanon.c | 16 ++++------
 crypto/tlscredspsk.c  |  5 ++-
 crypto/tlscredsx509.c | 16 +++-------
 8 files changed, 65 insertions(+), 133 deletions(-)

diff --git a/crypto/afsplit.c b/crypto/afsplit.c
index 328d68c96b..b1a5a20899 100644
--- a/crypto/afsplit.c
+++ b/crypto/afsplit.c
@@ -58,7 +58,7 @@ static int qcrypto_afsplit_hash(QCryptoHashAlgorithm ha=
sh,
     }
=20
     for (i =3D 0; i < hashcount; i++) {
-        uint8_t *out =3D NULL;
+        g_autofree uint8_t *out =3D NULL;
         size_t outlen =3D 0;
         uint32_t iv =3D cpu_to_be32(i);
         struct iovec in[] =3D {
@@ -79,7 +79,6 @@ static int qcrypto_afsplit_hash(QCryptoHashAlgorithm ha=
sh,
         assert(outlen =3D=3D digestlen);
         memcpy(block + (i * digestlen), out,
                (i =3D=3D (hashcount - 1)) ? finallen : digestlen);
-        g_free(out);
     }
=20
     return 0;
@@ -93,13 +92,12 @@ int qcrypto_afsplit_encode(QCryptoHashAlgorithm hash,
                            uint8_t *out,
                            Error **errp)
 {
-    uint8_t *block =3D g_new0(uint8_t, blocklen);
+    g_autofree uint8_t *block =3D g_new0(uint8_t, blocklen);
     size_t i;
-    int ret =3D -1;
=20
     for (i =3D 0; i < (stripes - 1); i++) {
         if (qcrypto_random_bytes(out + (i * blocklen), blocklen, errp) <=
 0) {
-            goto cleanup;
+            return -1;
         }
=20
         qcrypto_afsplit_xor(blocklen,
@@ -108,18 +106,14 @@ int qcrypto_afsplit_encode(QCryptoHashAlgorithm has=
h,
                             block);
         if (qcrypto_afsplit_hash(hash, blocklen, block,
                                  errp) < 0) {
-            goto cleanup;
+            return -1;
         }
     }
     qcrypto_afsplit_xor(blocklen,
                         in,
                         block,
                         out + (i * blocklen));
-    ret =3D 0;
-
- cleanup:
-    g_free(block);
-    return ret;
+    return 0;
 }
=20
=20
@@ -130,9 +124,8 @@ int qcrypto_afsplit_decode(QCryptoHashAlgorithm hash,
                            uint8_t *out,
                            Error **errp)
 {
-    uint8_t *block =3D g_new0(uint8_t, blocklen);
+    g_autofree uint8_t *block =3D g_new0(uint8_t, blocklen);
     size_t i;
-    int ret =3D -1;
=20
     for (i =3D 0; i < (stripes - 1); i++) {
         qcrypto_afsplit_xor(blocklen,
@@ -141,7 +134,7 @@ int qcrypto_afsplit_decode(QCryptoHashAlgorithm hash,
                             block);
         if (qcrypto_afsplit_hash(hash, blocklen, block,
                                  errp) < 0) {
-            goto cleanup;
+            return -1;
         }
     }
=20
@@ -149,10 +142,5 @@ int qcrypto_afsplit_decode(QCryptoHashAlgorithm hash=
,
                         in + (i * blocklen),
                         block,
                         out);
-
-    ret =3D 0;
-
- cleanup:
-    g_free(block);
-    return ret;
+    return 0;
 }
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 409ab50f20..743949adbf 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -425,14 +425,13 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                             Error **errp)
 {
     QCryptoBlockLUKS *luks =3D block->opaque;
-    uint8_t *splitkey;
+    g_autofree uint8_t *splitkey =3D NULL;
     size_t splitkeylen;
-    uint8_t *possiblekey;
-    int ret =3D -1;
+    g_autofree uint8_t *possiblekey =3D NULL;
     ssize_t rv;
-    QCryptoCipher *cipher =3D NULL;
+    g_autoptr(QCryptoCipher) cipher =3D NULL;
     uint8_t keydigest[QCRYPTO_BLOCK_LUKS_DIGEST_LEN];
-    QCryptoIVGen *ivgen =3D NULL;
+    g_autoptr(QCryptoIVGen) ivgen =3D NULL;
     size_t niv;
=20
     if (slot->active !=3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED) {
@@ -456,7 +455,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                        slot->iterations,
                        possiblekey, masterkeylen,
                        errp) < 0) {
-        goto cleanup;
+        return -1;
     }
=20
     /*
@@ -472,7 +471,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                   opaque,
                   errp);
     if (rv < 0) {
-        goto cleanup;
+        return -1;
     }
=20
=20
@@ -482,7 +481,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                                 possiblekey, masterkeylen,
                                 errp);
     if (!cipher) {
-        goto cleanup;
+        return -1;
     }
=20
     niv =3D qcrypto_cipher_get_iv_len(cipheralg,
@@ -493,7 +492,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                               possiblekey, masterkeylen,
                               errp);
     if (!ivgen) {
-        goto cleanup;
+        return -1;
     }
=20
=20
@@ -512,7 +511,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                                             splitkey,
                                             splitkeylen,
                                             errp) < 0) {
-        goto cleanup;
+        return -1;
     }
=20
     /*
@@ -525,7 +524,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                                splitkey,
                                masterkey,
                                errp) < 0) {
-        goto cleanup;
+        return -1;
     }
=20
=20
@@ -544,26 +543,18 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
                        luks->header.master_key_iterations,
                        keydigest, G_N_ELEMENTS(keydigest),
                        errp) < 0) {
-        goto cleanup;
+        return -1;
     }
=20
     if (memcmp(keydigest, luks->header.master_key_digest,
                QCRYPTO_BLOCK_LUKS_DIGEST_LEN) =3D=3D 0) {
         /* Success, we got the right master key */
-        ret =3D 1;
-        goto cleanup;
+        return 1;
     }
=20
     /* Fail, user's password was not valid for this key slot,
      * tell caller to try another slot */
-    ret =3D 0;
-
- cleanup:
-    qcrypto_ivgen_free(ivgen);
-    qcrypto_cipher_free(cipher);
-    g_free(splitkey);
-    g_free(possiblekey);
-    return ret;
+    return 0;
 }
=20
=20
@@ -644,7 +635,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     int ret =3D 0;
     size_t i;
     ssize_t rv;
-    uint8_t *masterkey =3D NULL;
+    g_autofree uint8_t *masterkey =3D NULL;
     size_t masterkeylen;
     char *ivgen_name, *ivhash_name;
     QCryptoCipherMode ciphermode;
@@ -653,7 +644,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     QCryptoCipherAlgorithm ivcipheralg;
     QCryptoHashAlgorithm hash;
     QCryptoHashAlgorithm ivhash;
-    char *password =3D NULL;
+    g_autofree char *password =3D NULL;
=20
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         if (!options->u.luks.key_secret) {
@@ -856,17 +847,12 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     luks->ivgen_hash_alg =3D ivhash;
     luks->hash_alg =3D hash;
=20
-    g_free(masterkey);
-    g_free(password);
-
     return 0;
=20
  fail:
-    g_free(masterkey);
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
     g_free(luks);
-    g_free(password);
     return ret;
 }
=20
@@ -891,20 +877,20 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     QCryptoBlockLUKS *luks;
     QCryptoBlockCreateOptionsLUKS luks_opts;
     Error *local_err =3D NULL;
-    uint8_t *masterkey =3D NULL;
-    uint8_t *slotkey =3D NULL;
-    uint8_t *splitkey =3D NULL;
+    g_autofree uint8_t *masterkey =3D NULL;
+    g_autofree uint8_t *slotkey =3D NULL;
+    g_autofree uint8_t *splitkey =3D NULL;
     size_t splitkeylen =3D 0;
     size_t i;
-    QCryptoCipher *cipher =3D NULL;
-    QCryptoIVGen *ivgen =3D NULL;
-    char *password;
+    g_autoptr(QCryptoCipher) cipher =3D NULL;
+    g_autoptr(QCryptoIVGen) ivgen =3D NULL;
+    g_autofree char *password =3D NULL;
     const char *cipher_alg;
     const char *cipher_mode;
     const char *ivgen_alg;
     const char *ivgen_hash_alg =3D NULL;
     const char *hash_alg;
-    char *cipher_mode_spec =3D NULL;
+    g_autofree char *cipher_mode_spec =3D NULL;
     QCryptoCipherAlgorithm ivcipheralg =3D 0;
     uint64_t iters;
=20
@@ -1311,15 +1297,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     luks->hash_alg =3D luks_opts.hash_alg;
=20
     memset(masterkey, 0, luks->header.key_bytes);
-    g_free(masterkey);
     memset(slotkey, 0, luks->header.key_bytes);
-    g_free(slotkey);
-    g_free(splitkey);
-    g_free(password);
-    g_free(cipher_mode_spec);
-
-    qcrypto_ivgen_free(ivgen);
-    qcrypto_cipher_free(cipher);
=20
     return 0;
=20
@@ -1327,17 +1305,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     if (masterkey) {
         memset(masterkey, 0, luks->header.key_bytes);
     }
-    g_free(masterkey);
     if (slotkey) {
         memset(slotkey, 0, luks->header.key_bytes);
     }
-    g_free(slotkey);
-    g_free(splitkey);
-    g_free(password);
-    g_free(cipher_mode_spec);
-
-    qcrypto_ivgen_free(ivgen);
-    qcrypto_cipher_free(cipher);
=20
     qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
diff --git a/crypto/block.c b/crypto/block.c
index ee96759f7d..325752871c 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -299,15 +299,13 @@ static int do_qcrypto_block_cipher_encdec(QCryptoCi=
pher *cipher,
                                           QCryptoCipherEncDecFunc func,
                                           Error **errp)
 {
-    uint8_t *iv;
+    g_autofree uint8_t *iv =3D niv ? g_new0(uint8_t, niv) : NULL;
     int ret =3D -1;
     uint64_t startsector =3D offset / sectorsize;
=20
     assert(QEMU_IS_ALIGNED(offset, sectorsize));
     assert(QEMU_IS_ALIGNED(len, sectorsize));
=20
-    iv =3D niv ? g_new0(uint8_t, niv) : NULL;
-
     while (len > 0) {
         size_t nbytes;
         if (niv) {
@@ -320,19 +318,19 @@ static int do_qcrypto_block_cipher_encdec(QCryptoCi=
pher *cipher,
             }
=20
             if (ret < 0) {
-                goto cleanup;
+                return -1;
             }
=20
             if (qcrypto_cipher_setiv(cipher,
                                      iv, niv,
                                      errp) < 0) {
-                goto cleanup;
+                return -1;
             }
         }
=20
         nbytes =3D len > sectorsize ? sectorsize : len;
         if (func(cipher, buf, buf, nbytes, errp) < 0) {
-            goto cleanup;
+            return -1;
         }
=20
         startsector++;
@@ -340,10 +338,7 @@ static int do_qcrypto_block_cipher_encdec(QCryptoCip=
her *cipher,
         len -=3D nbytes;
     }
=20
-    ret =3D 0;
- cleanup:
-    g_free(iv);
-    return ret;
+    return 0;
 }
=20
=20
diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
index b7c7c4a59b..3775ddc6c5 100644
--- a/crypto/pbkdf.c
+++ b/crypto/pbkdf.c
@@ -69,12 +69,10 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgori=
thm hash,
                                     Error **errp)
 {
     uint64_t ret =3D -1;
-    uint8_t *out;
+    g_autofree uint8_t *out =3D g_new(uint8_t, nout);
     uint64_t iterations =3D (1 << 15);
     unsigned long long delta_ms, start_ms, end_ms;
=20
-    out =3D g_new(uint8_t, nout);
-
     while (1) {
         if (qcrypto_pbkdf2_get_thread_cpu(&start_ms, errp) < 0) {
             goto cleanup;
@@ -108,6 +106,5 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgori=
thm hash,
=20
  cleanup:
     memset(out, 0, nout);
-    g_free(out);
     return ret;
 }
diff --git a/crypto/secret.c b/crypto/secret.c
index a75d50ae0c..1cf0ad0ce8 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -72,10 +72,12 @@ static void qcrypto_secret_decrypt(QCryptoSecret *sec=
ret,
                                    size_t *outputlen,
                                    Error **errp)
 {
-    uint8_t *key =3D NULL, *ciphertext =3D NULL, *iv =3D NULL;
+    g_autofree uint8_t *key =3D NULL;
+    g_autofree uint8_t *ciphertext =3D NULL;
+    g_autofree uint8_t *iv =3D NULL;
     size_t keylen, ciphertextlen, ivlen;
-    QCryptoCipher *aes =3D NULL;
-    uint8_t *plaintext =3D NULL;
+    g_autoptr(QCryptoCipher) aes =3D NULL;
+    g_autofree uint8_t *plaintext =3D NULL;
=20
     *output =3D NULL;
     *outputlen =3D 0;
@@ -83,27 +85,27 @@ static void qcrypto_secret_decrypt(QCryptoSecret *sec=
ret,
     if (qcrypto_secret_lookup(secret->keyid,
                               &key, &keylen,
                               errp) < 0) {
-        goto cleanup;
+        return;
     }
=20
     if (keylen !=3D 32) {
         error_setg(errp, "Key should be 32 bytes in length");
-        goto cleanup;
+        return;
     }
=20
     if (!secret->iv) {
         error_setg(errp, "IV is required to decrypt secret");
-        goto cleanup;
+        return;
     }
=20
     iv =3D qbase64_decode(secret->iv, -1, &ivlen, errp);
     if (!iv) {
-        goto cleanup;
+        return;
     }
     if (ivlen !=3D 16) {
         error_setg(errp, "IV should be 16 bytes in length not %zu",
                    ivlen);
-        goto cleanup;
+        return;
     }
=20
     aes =3D qcrypto_cipher_new(QCRYPTO_CIPHER_ALG_AES_256,
@@ -111,11 +113,11 @@ static void qcrypto_secret_decrypt(QCryptoSecret *s=
ecret,
                              key, keylen,
                              errp);
     if (!aes) {
-        goto cleanup;
+        return;
     }
=20
     if (qcrypto_cipher_setiv(aes, iv, ivlen, errp) < 0) {
-        goto cleanup;
+        return;
     }
=20
     if (secret->format =3D=3D QCRYPTO_SECRET_FORMAT_BASE64) {
@@ -124,7 +126,7 @@ static void qcrypto_secret_decrypt(QCryptoSecret *sec=
ret,
                                     &ciphertextlen,
                                     errp);
         if (!ciphertext) {
-            goto cleanup;
+            return;
         }
         plaintext =3D g_new0(uint8_t, ciphertextlen + 1);
     } else {
@@ -136,8 +138,7 @@ static void qcrypto_secret_decrypt(QCryptoSecret *sec=
ret,
                                plaintext,
                                ciphertextlen,
                                errp) < 0) {
-        plaintext =3D NULL;
-        goto cleanup;
+        return;
     }
=20
     if (plaintext[ciphertextlen - 1] > 16 ||
@@ -145,9 +146,7 @@ static void qcrypto_secret_decrypt(QCryptoSecret *sec=
ret,
         error_setg(errp, "Incorrect number of padding bytes (%d) "
                    "found on decrypted data",
                    (int)plaintext[ciphertextlen - 1]);
-        g_free(plaintext);
-        plaintext =3D NULL;
-        goto cleanup;
+        return;
     }
=20
     /* Even though plaintext may contain arbitrary NUL
@@ -156,14 +155,8 @@ static void qcrypto_secret_decrypt(QCryptoSecret *se=
cret,
     ciphertextlen -=3D plaintext[ciphertextlen - 1];
     plaintext[ciphertextlen] =3D '\0';
=20
-    *output =3D plaintext;
+    *output =3D g_steal_pointer(&plaintext);
     *outputlen =3D ciphertextlen;
-
- cleanup:
-    g_free(ciphertext);
-    g_free(iv);
-    g_free(key);
-    qcrypto_cipher_free(aes);
 }
=20
=20
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index d2adc7c131..a235f60146 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -34,9 +34,8 @@ static int
 qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
                             Error **errp)
 {
-    char *dhparams =3D NULL;
+    g_autofree char *dhparams =3D NULL;
     int ret;
-    int rv =3D -1;
=20
     trace_qcrypto_tls_creds_anon_load(creds,
             creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
@@ -45,20 +44,20 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *cred=
s,
         if (qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0) {
-            goto cleanup;
+            return -1;
         }
=20
         ret =3D gnutls_anon_allocate_server_credentials(&creds->data.ser=
ver);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
-            goto cleanup;
+            return -1;
         }
=20
         if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhp=
arams,
                                                  &creds->parent_obj.dh_p=
arams,
                                                  errp) < 0) {
-            goto cleanup;
+            return -1;
         }
=20
         gnutls_anon_set_server_dh_params(creds->data.server,
@@ -68,14 +67,11 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *cred=
s,
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
-            goto cleanup;
+            return -1;
         }
     }
=20
-    rv =3D 0;
- cleanup:
-    g_free(dhparams);
-    return rv;
+    return 0;
 }
=20
=20
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 4b6cf636ce..15d12e2448 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -69,7 +69,8 @@ static int
 qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
                            Error **errp)
 {
-    char *pskfile =3D NULL, *dhparams =3D NULL;
+    g_autofree char *pskfile =3D NULL;
+    g_autofree char *dhparams =3D NULL;
     const char *username;
     int ret;
     int rv =3D -1;
@@ -139,8 +140,6 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
     rv =3D 0;
  cleanup:
     g_free(key.data);
-    g_free(pskfile);
-    g_free(dhparams);
     return rv;
 }
=20
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 56dcef3673..01fc304e5d 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -378,7 +378,7 @@ qcrypto_tls_creds_load_cert(QCryptoTLSCredsX509 *cred=
s,
 {
     gnutls_datum_t data;
     gnutls_x509_crt_t cert =3D NULL;
-    char *buf =3D NULL;
+    g_autofree char *buf =3D NULL;
     gsize buflen;
     GError *gerr;
     int ret =3D -1;
@@ -420,7 +420,6 @@ qcrypto_tls_creds_load_cert(QCryptoTLSCredsX509 *cred=
s,
         gnutls_x509_crt_deinit(cert);
         cert =3D NULL;
     }
-    g_free(buf);
     return cert;
 }
=20
@@ -434,9 +433,8 @@ qcrypto_tls_creds_load_ca_cert_list(QCryptoTLSCredsX5=
09 *creds,
                                     Error **errp)
 {
     gnutls_datum_t data;
-    char *buf =3D NULL;
+    g_autofree char *buf =3D NULL;
     gsize buflen;
-    int ret =3D -1;
     GError *gerr =3D NULL;
=20
     *ncerts =3D 0;
@@ -446,7 +444,7 @@ qcrypto_tls_creds_load_ca_cert_list(QCryptoTLSCredsX5=
09 *creds,
         error_setg(errp, "Cannot load CA cert list %s: %s",
                    certFile, gerr->message);
         g_error_free(gerr);
-        goto cleanup;
+        return -1;
     }
=20
     data.data =3D (unsigned char *)buf;
@@ -457,15 +455,11 @@ qcrypto_tls_creds_load_ca_cert_list(QCryptoTLSCreds=
X509 *creds,
         error_setg(errp,
                    "Unable to import CA certificate list %s",
                    certFile);
-        goto cleanup;
+        return -1;
     }
     *ncerts =3D certMax;
=20
-    ret =3D 0;
-
- cleanup:
-    g_free(buf);
-    return ret;
+    return 0;
 }
=20
=20
--=20
2.21.0


