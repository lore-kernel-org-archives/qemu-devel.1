Received: from eggs.gnu.org ([2001:4830:134:3::10]:42147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBf-000230-HH
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBc-000173-Db
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBc-00016G-4l
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0imSB058117
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:15 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm90vw4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:14 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:14 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:10 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-17-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 16/67] crypto: ensure XTS is only used with
 ciphers with 16 byte blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The XTS cipher mode needs to be used with a cipher which has
a block size of 16 bytes. If a mis-matching block size is used,
the code will either corrupt memory beyond the IV array, or
not fully encrypt/decrypt the IV.

This fixes a memory corruption crash when attempting to use
cast5-128 with xts, since the former has an 8 byte block size.

A test case is added to ensure the cipher creation fails with
such an invalid combination.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
(cherry picked from commit a5d2f44d0d3e7523670e103a8c37faed29ff2b76)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 crypto/cipher-gcrypt.c     |  6 ++++++
 crypto/cipher-nettle.c     | 12 +++++++-----
 tests/test-crypto-cipher.c | 43 +++++++++++++++++++++++++++++++++++--------
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index ede2f70..3652aa1 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -192,6 +192,12 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
     }
 
     if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
+        if (ctx->blocksize != XTS_BLOCK_SIZE) {
+            error_setg(errp,
+                       "Cipher block size %zu must equal XTS block size %d",
+                       ctx->blocksize, XTS_BLOCK_SIZE);
+            goto error;
+        }
         ctx->iv = g_new0(uint8_t, ctx->blocksize);
     }
 
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index 70909fb..0267da5 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -361,6 +361,13 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         goto error;
     }
 
+    if (mode == QCRYPTO_CIPHER_MODE_XTS &&
+        ctx->blocksize != XTS_BLOCK_SIZE) {
+        error_setg(errp, "Cipher block size %zu must equal XTS block size %d",
+                   ctx->blocksize, XTS_BLOCK_SIZE);
+        goto error;
+    }
+
     ctx->iv = g_new0(uint8_t, ctx->blocksize);
     cipher->opaque = ctx;
 
@@ -456,11 +463,6 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
         break;
 
     case QCRYPTO_CIPHER_MODE_XTS:
-        if (ctx->blocksize != XTS_BLOCK_SIZE) {
-            error_setg(errp, "Block size must be %d not %zu",
-                       XTS_BLOCK_SIZE, ctx->blocksize);
-            return -1;
-        }
         xts_decrypt(ctx->ctx, ctx->ctx_tweak,
                     ctx->alg_encrypt_wrapper, ctx->alg_decrypt_wrapper,
                     ctx->iv, len, out, in);
diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
index 1b5130d..b89dfa2 100644
--- a/tests/test-crypto-cipher.c
+++ b/tests/test-crypto-cipher.c
@@ -370,6 +370,17 @@ static QCryptoCipherTestData test_data[] = {
             "eb4a427d1923ce3ff262735779a418f2"
             "0a282df920147beabe421ee5319d0568",
     },
+    {
+        /* Bad config - cast5-128 has 8 byte block size
+         * which is incompatible with XTS
+         */
+        .path = "/crypto/cipher/cast5-xts-128",
+        .alg = QCRYPTO_CIPHER_ALG_CAST5_128,
+        .mode = QCRYPTO_CIPHER_MODE_XTS,
+        .key =
+            "27182818284590452353602874713526"
+            "31415926535897932384626433832795",
+    }
 };
 
 
@@ -432,15 +443,23 @@ static void test_cipher(const void *opaque)
     const QCryptoCipherTestData *data = opaque;
 
     QCryptoCipher *cipher;
-    uint8_t *key, *iv, *ciphertext, *plaintext, *outtext;
-    size_t nkey, niv, nciphertext, nplaintext;
-    char *outtexthex;
+    uint8_t *key, *iv = NULL, *ciphertext = NULL,
+        *plaintext = NULL, *outtext = NULL;
+    size_t nkey, niv = 0, nciphertext = 0, nplaintext = 0;
+    char *outtexthex = NULL;
     size_t ivsize, keysize, blocksize;
+    Error *err = NULL;
 
     nkey = unhex_string(data->key, &key);
-    niv = unhex_string(data->iv, &iv);
-    nciphertext = unhex_string(data->ciphertext, &ciphertext);
-    nplaintext = unhex_string(data->plaintext, &plaintext);
+    if (data->iv) {
+        niv = unhex_string(data->iv, &iv);
+    }
+    if (data->ciphertext) {
+        nciphertext = unhex_string(data->ciphertext, &ciphertext);
+    }
+    if (data->plaintext) {
+        nplaintext = unhex_string(data->plaintext, &plaintext);
+    }
 
     g_assert(nciphertext == nplaintext);
 
@@ -449,8 +468,15 @@ static void test_cipher(const void *opaque)
     cipher = qcrypto_cipher_new(
         data->alg, data->mode,
         key, nkey,
-        &error_abort);
-    g_assert(cipher != NULL);
+        &err);
+    if (data->plaintext) {
+        g_assert(err == NULL);
+        g_assert(cipher != NULL);
+    } else {
+        error_free_or_abort(&err);
+        g_assert(cipher == NULL);
+        goto cleanup;
+    }
 
     keysize = qcrypto_cipher_get_key_len(data->alg);
     blocksize = qcrypto_cipher_get_block_len(data->alg);
@@ -498,6 +524,7 @@ static void test_cipher(const void *opaque)
 
     g_assert_cmpstr(outtexthex, ==, data->plaintext);
 
+ cleanup:
     g_free(outtext);
     g_free(outtexthex);
     g_free(key);
-- 
1.9.1
