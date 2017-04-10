Received: from eggs.gnu.org ([2001:4830:134:3::10]:54549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCG-0000GB-HN
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCB-0002JA-Ot
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3421
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCA-0002GS-Lm
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:11 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:00:52 +0800
Message-ID: <1491814852-62512-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 14/19] crypto: cipher: add af_alg
 cipher support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Adds afalg-backend cipher support: introduces some private APIs
firstly, and then intergrates them into qcrypto_cipher_afalg_driver.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/Makefile.objs        |   1 +
 crypto/cipher-afalg.c       | 229 ++++++++++++++++++++++++++++++++++++++++++++
 crypto/cipher.c             |  30 +++++-
 include/crypto/afalg-comm.h |  11 +++
 include/crypto/cipher.h     |   7 ++
 tests/test-crypto-cipher.c  |  10 +-
 6 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 crypto/cipher-afalg.c

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 6f244a3..ad1229b 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -11,6 +11,7 @@ crypto-obj-y += aes.o
 crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg-comm.o
+crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredsx509.o
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
new file mode 100644
index 0000000..2da972c
--- /dev/null
+++ b/crypto/cipher-afalg.c
@@ -0,0 +1,229 @@
+/*
+ * QEMU Crypto af_alg-backend cipher support
+ *
+ * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Longpeng(Mike) <longpeng2@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/sockets.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "crypto/cipher.h"
+#include "crypto/afalg-comm.h"
+#include <linux/if_alg.h>
+
+static int afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
+                             QCryptoCipherMode mode,
+                             AfalgSocketAddress *afalg)
+{
+    const char *alg_name = NULL;
+    const char *mode_name = NULL;
+
+    switch (alg) {
+    case QCRYPTO_CIPHER_ALG_AES_128:
+    case QCRYPTO_CIPHER_ALG_AES_192:
+    case QCRYPTO_CIPHER_ALG_AES_256:
+        alg_name = "aes";
+        break;
+    case QCRYPTO_CIPHER_ALG_CAST5_128:
+        alg_name = "cast5";
+        break;
+    case QCRYPTO_CIPHER_ALG_SERPENT_128:
+    case QCRYPTO_CIPHER_ALG_SERPENT_192:
+    case QCRYPTO_CIPHER_ALG_SERPENT_256:
+        alg_name = "serpent";
+        break;
+    case QCRYPTO_CIPHER_ALG_TWOFISH_128:
+    case QCRYPTO_CIPHER_ALG_TWOFISH_192:
+    case QCRYPTO_CIPHER_ALG_TWOFISH_256:
+        alg_name = "twofish";
+        break;
+
+    default:
+        return -1;
+    }
+
+    mode_name = QCryptoCipherMode_lookup[mode];
+    afalg->name = (char *)g_new0(int8_t, SALG_NAME_LEN_MAX);
+    sprintf(afalg->name, "%s(%s)", mode_name, alg_name);
+
+    return 0;
+}
+
+QCryptoAfalg *afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                   QCryptoCipherMode mode,
+                                   const uint8_t *key,
+                                   size_t nkey, Error **errp)
+{
+    SocketAddress *saddr = NULL;
+    QCryptoAfalg *afalg = NULL;
+    size_t except_niv = 0;
+    int ret = 0;
+
+    saddr = g_new0(SocketAddress, 1);
+    saddr->u.afalg.data = g_new0(AfalgSocketAddress, 1);
+    saddr->type = SOCKET_ADDRESS_KIND_AFALG;
+    ret = afalg_cipher_format_name(alg, mode, saddr->u.afalg.data);
+    if (ret != 0) {
+        error_setg(errp, "Unsupported cipher mode %s",
+                   QCryptoCipherMode_lookup[mode]);
+        goto error;
+    }
+    afalg_comm_format_type(saddr->u.afalg.data, ALG_TYPE_CIPHER);
+
+    afalg = afalg_comm_alloc(saddr);
+    if (!afalg) {
+        error_setg(errp, "Alloc QCryptoAfalg object failed");
+        goto error;
+    }
+
+    /* setkey */
+    ret = qemu_setsockopt(afalg->tfmfd, SOL_ALG, ALG_SET_KEY, key,
+                          nkey);
+    if (ret != 0) {
+        error_setg(errp, "Afalg setkey failed");
+        goto error;
+    }
+
+    /* prepare msg header */
+    afalg->msg = g_new0(struct msghdr, 1);
+    afalg->msg->msg_controllen += CMSG_SPACE(ALG_OPTYPE_LEN);
+    except_niv = qcrypto_cipher_get_iv_len(alg, mode);
+    if (except_niv) {
+        afalg->msg->msg_controllen += CMSG_SPACE(ALG_MSGIV_LEN(except_niv));
+    }
+    afalg->msg->msg_control = g_new0(uint8_t, afalg->msg->msg_controllen);
+
+    /* We use 1st msghdr for crypto-info and 2nd msghdr for IV-info */
+    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
+    afalg->cmsg->cmsg_level = SOL_ALG;
+    afalg->cmsg->cmsg_type = ALG_SET_OP;
+    afalg->cmsg->cmsg_len = CMSG_SPACE(ALG_OPTYPE_LEN);
+
+cleanup:
+    g_free(saddr->u.afalg.data->type);
+    g_free(saddr->u.afalg.data->name);
+    g_free(saddr->u.afalg.data);
+    g_free(saddr);
+    return afalg;
+
+error:
+    afalg_comm_free(afalg);
+    afalg = NULL;
+    goto cleanup;
+}
+
+static int afalg_cipher_setiv(QCryptoCipher *cipher,
+                               const uint8_t *iv,
+                               size_t niv, Error **errp)
+{
+    struct af_alg_iv *alg_iv = NULL;
+    QCryptoAfalg *afalg = cipher->opaque;
+
+    /* move ->cmsg to next msghdr, for IV-info */
+    afalg->cmsg = CMSG_NXTHDR(afalg->msg, afalg->cmsg);
+
+    /* build setiv msg */
+    afalg->cmsg->cmsg_level = SOL_ALG;
+    afalg->cmsg->cmsg_type = ALG_SET_IV;
+    afalg->cmsg->cmsg_len = CMSG_SPACE(ALG_MSGIV_LEN(niv));
+    alg_iv = (struct af_alg_iv *)CMSG_DATA(afalg->cmsg);
+    alg_iv->ivlen = niv;
+    memcpy(alg_iv->iv, iv, niv);
+
+    return 0;
+}
+
+static int afalg_cipher_op(QCryptoAfalg *afalg,
+                           const void *in, void *out,
+                           size_t len, bool do_encrypt)
+{
+    uint32_t *type = NULL;
+    struct iovec iov;
+    size_t ret, done = 0;
+    uint32_t origin_contorllen;
+
+    origin_contorllen = afalg->msg->msg_controllen;
+    /* movev ->cmsg to first header, for crypto-info */
+    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
+
+    /* build encrypt msg */
+    afalg->msg->msg_iov = &iov;
+    afalg->msg->msg_iovlen = 1;
+    type = (uint32_t *)CMSG_DATA(afalg->cmsg);
+    if (do_encrypt) {
+        *type = ALG_OP_ENCRYPT;
+    } else {
+        *type = ALG_OP_DECRYPT;
+    }
+
+    do {
+        iov.iov_base = (void *)in + done;
+        iov.iov_len = len - done;
+
+        /* send info to AF_ALG core */
+        ret = sendmsg(afalg->opfd, afalg->msg, 0);
+        if (ret == -1) {
+            return -1;
+        }
+
+        /* encrypto && get result */
+        if (ret != read(afalg->opfd, out, ret)) {
+            return -1;
+        }
+
+        /* do not update IV for following chunks */
+        afalg->msg->msg_controllen = 0;
+        done += ret;
+    } while (done < len);
+
+    afalg->msg->msg_controllen = origin_contorllen;
+
+    return 0;
+}
+
+static int afalg_cipher_encrypt(QCryptoCipher *cipher,
+                                const void *in, void *out,
+                                size_t len, Error **errp)
+{
+    int ret;
+
+    ret = afalg_cipher_op(cipher->opaque, in, out, len, 1);
+    if (ret == -1) {
+        error_setg(errp, "Afalg cipher encrypt failed");
+    }
+
+    return ret;
+}
+
+static int afalg_cipher_decrypt(QCryptoCipher *cipher,
+                                const void *in, void *out,
+                                size_t len, Error **errp)
+{
+    int ret;
+
+    ret = afalg_cipher_op(cipher->opaque, in, out, len, 0);
+    if (ret == -1) {
+        error_setg(errp, "Afalg cipher decrypt failed");
+    }
+
+    return ret;
+}
+
+static void afalg_comm_ctx_free(QCryptoCipher *cipher)
+{
+    afalg_comm_free(cipher->opaque);
+}
+
+struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
+    .cipher_encrypt = afalg_cipher_encrypt,
+    .cipher_decrypt = afalg_cipher_decrypt,
+    .cipher_setiv = afalg_cipher_setiv,
+    .cipher_free = afalg_comm_ctx_free,
+};
diff --git a/crypto/cipher.c b/crypto/cipher.c
index fa31f2f..d3a76b3 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -22,6 +22,9 @@
 #include "qapi/error.h"
 #include "crypto/cipher.h"
 
+#ifdef CONFIG_AF_ALG
+#include "crypto/afalg-comm.h"
+#endif
 
 static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_AES_128] = 16,
@@ -162,18 +165,34 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                                   Error **errp)
 {
     QCryptoCipher *cipher;
+    QCryptoCipherDriver *drv;
+    Error *errp2 = NULL;
     void *ctx;
 
+#ifdef CONFIG_AF_ALG
+    ctx = afalg_cipher_ctx_new(alg, mode, key, nkey, &errp2);
+    if (ctx) {
+        drv = &qcrypto_cipher_afalg_driver;
+        goto set;
+    }
+#endif
+
+    if (errp2) {
+        error_free(errp2);
+    }
+
     ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
     if (ctx == NULL) {
         return NULL;
     }
+    drv = &qcrypto_cipher_lib_driver;
 
+set:
     cipher = g_new0(QCryptoCipher, 1);
     cipher->alg = alg;
     cipher->mode = mode;
     cipher->opaque = ctx;
-    cipher->driver = &qcrypto_cipher_lib_driver;
+    cipher->driver = drv;
 
     return cipher;
 }
@@ -214,3 +233,12 @@ void qcrypto_cipher_free(QCryptoCipher *cipher)
         g_free(cipher);
     }
 }
+
+bool qcrypto_cipher_using_afalg_drv(QCryptoCipher *cipher)
+{
+#ifdef CONFIG_AF_ALG
+    return cipher->driver == &qcrypto_cipher_afalg_driver;
+#else
+    return false;
+#endif
+}
diff --git a/include/crypto/afalg-comm.h b/include/crypto/afalg-comm.h
index b6b9464..34f30dc 100644
--- a/include/crypto/afalg-comm.h
+++ b/include/crypto/afalg-comm.h
@@ -19,6 +19,11 @@
 #define SOL_ALG 279
 #endif
 
+#define ALG_TYPE_CIPHER "skcipher"
+
+#define ALG_OPTYPE_LEN 4
+#define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
+
 typedef struct QCryptoAfalg QCryptoAfalg;
 struct QCryptoAfalg {
     int tfmfd;
@@ -58,4 +63,10 @@ QCryptoAfalg *afalg_comm_alloc(SocketAddress *saddr);
  */
 void afalg_comm_free(QCryptoAfalg *afalg);
 
+extern QCryptoAfalg *
+afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg, QCryptoCipherMode mode,
+                     const uint8_t *key, size_t nkey, Error **errp);
+
+extern struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
+
 #endif
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 32b6065..a8d9e9a 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -253,5 +253,12 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
 int qcrypto_cipher_setiv(QCryptoCipher *cipher,
                          const uint8_t *iv, size_t niv,
                          Error **errp);
+/**
+ * qcrypto_cipher_using_afalg_drv:
+ * @ the cipher object
+ *
+ * Returns: true if @cipher is using afalg driver, otherwise false.
+ */
+bool qcrypto_cipher_using_afalg_drv(QCryptoCipher *cipher);
 
 #endif /* QCRYPTO_CIPHER_H */
diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
index 07fa2fa..8bb3308 100644
--- a/tests/test-crypto-cipher.c
+++ b/tests/test-crypto-cipher.c
@@ -715,6 +715,7 @@ static void test_cipher_null_iv(void)
     uint8_t key[32] = { 0 };
     uint8_t plaintext[32] = { 0 };
     uint8_t ciphertext[32] = { 0 };
+    Error *err = NULL;
 
     cipher = qcrypto_cipher_new(
         QCRYPTO_CIPHER_ALG_AES_256,
@@ -729,7 +730,14 @@ static void test_cipher_null_iv(void)
                            plaintext,
                            ciphertext,
                            sizeof(plaintext),
-                           &error_abort);
+                           &err);
+
+    if (qcrypto_cipher_using_afalg_drv(cipher)) {
+        g_assert(err != NULL);
+        error_free_or_abort(&err);
+    } else {
+        g_assert(err == NULL);
+    }
 
     qcrypto_cipher_free(cipher);
 }
-- 
1.8.3.1
