Received: from eggs.gnu.org ([2001:4830:134:3::10]:35668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyw2-0001Ef-JH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyw0-0007ru-Rp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:02 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dVyw0-0007rQ-JW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:00 -0400
Received: by mail-pf0-x244.google.com with SMTP id q85so10728750pfq.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:39:00 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 07:38:35 -0400
Message-Id: <1500032321-13951-14-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
Subject: [Qemu-devel] [PATCH v5 13/18] crypto: cipher: add afalg-backend
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
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

Adds afalg-backend cipher support: introduces some private APIs
firstly, and then intergrates them into qcrypto_cipher_afalg_driver.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/Makefile.objs  |   1 +
 crypto/afalgpriv.h    |   9 ++
 crypto/cipher-afalg.c | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto/cipher.c       |  23 ++++-
 crypto/cipherpriv.h   |  16 ++++
 5 files changed, 271 insertions(+), 4 deletions(-)
 create mode 100644 crypto/cipher-afalg.c

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 2be5a3a..d2e8fa8 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -11,6 +11,7 @@ crypto-obj-y += aes.o
 crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg.o
+crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredsx509.o
diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
index 76118cf..d0941d4 100644
--- a/crypto/afalgpriv.h
+++ b/crypto/afalgpriv.h
@@ -19,6 +19,15 @@
 #define SALG_TYPE_LEN_MAX 14
 #define SALG_NAME_LEN_MAX 64
 
+#ifndef SOL_ALG
+#define SOL_ALG 279
+#endif
+
+#define AFALG_TYPE_CIPHER "skcipher"
+
+#define ALG_OPTYPE_LEN 4
+#define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
+
 typedef struct QCryptoAFAlg QCryptoAFAlg;
 
 struct QCryptoAFAlg {
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
new file mode 100644
index 0000000..01343b2
--- /dev/null
+++ b/crypto/cipher-afalg.c
@@ -0,0 +1,226 @@
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
+#include "cipherpriv.h"
+
+
+static char *
+qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
+                                 QCryptoCipherMode mode,
+                                 Error **errp)
+{
+    char *name;
+    const char *alg_name;
+    const char *mode_name;
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
+        error_setg(errp, "Unsupported cipher algorithm %d", alg);
+        return NULL;
+    }
+
+    mode_name = QCryptoCipherMode_lookup[mode];
+    name = g_strdup_printf("%s(%s)", mode_name, alg_name);
+
+    return name;
+}
+
+QCryptoAFAlg *
+qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                             QCryptoCipherMode mode,
+                             const uint8_t *key,
+                             size_t nkey, Error **errp)
+{
+    QCryptoAFAlg *afalg;
+    size_t expect_niv;
+    char *name;
+
+    name = qcrypto_afalg_cipher_format_name(alg, mode, errp);
+    if (!name) {
+        return NULL;
+    }
+
+    afalg = qcrypto_afalg_comm_alloc(AFALG_TYPE_CIPHER, name, errp);
+    if (!afalg) {
+        g_free(name);
+        return NULL;
+    }
+
+    g_free(name);
+
+    /* setkey */
+    if (qemu_setsockopt(afalg->tfmfd, SOL_ALG, ALG_SET_KEY, key,
+                        nkey) != 0) {
+        error_setg_errno(errp, errno, "Set key failed");
+        qcrypto_afalg_comm_free(afalg);
+        return NULL;
+    }
+
+    /* prepare msg header */
+    afalg->msg = g_new0(struct msghdr, 1);
+    afalg->msg->msg_controllen += CMSG_SPACE(ALG_OPTYPE_LEN);
+    expect_niv = qcrypto_cipher_get_iv_len(alg, mode);
+    if (expect_niv) {
+        afalg->msg->msg_controllen += CMSG_SPACE(ALG_MSGIV_LEN(expect_niv));
+    }
+    afalg->msg->msg_control = g_new0(uint8_t, afalg->msg->msg_controllen);
+
+    /* We use 1st msghdr for crypto-info and 2nd msghdr for IV-info */
+    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
+    afalg->cmsg->cmsg_type = ALG_SET_OP;
+    afalg->cmsg->cmsg_len = CMSG_SPACE(ALG_OPTYPE_LEN);
+    if (expect_niv) {
+        afalg->cmsg = CMSG_NXTHDR(afalg->msg, afalg->cmsg);
+        afalg->cmsg->cmsg_type = ALG_SET_IV;
+        afalg->cmsg->cmsg_len = CMSG_SPACE(ALG_MSGIV_LEN(expect_niv));
+    }
+    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
+
+    return afalg;
+}
+
+static int
+qcrypto_afalg_cipher_setiv(QCryptoCipher *cipher,
+                           const uint8_t *iv,
+                           size_t niv, Error **errp)
+{
+    struct af_alg_iv *alg_iv;
+    size_t expect_niv;
+    QCryptoAFAlg *afalg = cipher->opaque;
+
+    expect_niv = qcrypto_cipher_get_iv_len(cipher->alg, cipher->mode);
+    if (niv != expect_niv) {
+        error_setg(errp, "Set IV len(%zu) not match expected(%zu)",
+                   niv, expect_niv);
+        return -1;
+    }
+
+    /* move ->cmsg to next msghdr, for IV-info */
+    afalg->cmsg = CMSG_NXTHDR(afalg->msg, afalg->cmsg);
+
+    /* build setiv msg */
+    afalg->cmsg->cmsg_level = SOL_ALG;
+    alg_iv = (struct af_alg_iv *)CMSG_DATA(afalg->cmsg);
+    alg_iv->ivlen = niv;
+    memcpy(alg_iv->iv, iv, niv);
+
+    return 0;
+}
+
+static int
+qcrypto_afalg_cipher_op(QCryptoAFAlg *afalg,
+                        const void *in, void *out,
+                        size_t len, bool do_encrypt,
+                        Error **errp)
+{
+    uint32_t *type = NULL;
+    struct iovec iov;
+    size_t ret, rlen, done = 0;
+    uint32_t origin_controllen;
+
+    origin_controllen = afalg->msg->msg_controllen;
+    /* movev ->cmsg to first header, for crypto-info */
+    afalg->cmsg = CMSG_FIRSTHDR(afalg->msg);
+
+    /* build encrypt msg */
+    afalg->cmsg->cmsg_level = SOL_ALG;
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
+            error_setg_errno(errp, errno, "Send data to AF_ALG core failed");
+            return -1;
+        }
+
+        /* encrypto && get result */
+        rlen = read(afalg->opfd, out, ret);
+        if (rlen == -1) {
+            error_setg_errno(errp, errno, "Get result from AF_ALG core failed");
+            return -1;
+        }
+        assert(rlen == ret);
+
+        /* do not update IV for following chunks */
+        afalg->msg->msg_controllen = 0;
+        done += ret;
+    } while (done < len);
+
+    afalg->msg->msg_controllen = origin_controllen;
+
+    return 0;
+}
+
+static int
+qcrypto_afalg_cipher_encrypt(QCryptoCipher *cipher,
+                             const void *in, void *out,
+                             size_t len, Error **errp)
+{
+    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
+                                   len, true, errp);
+}
+
+static int
+qcrypto_afalg_cipher_decrypt(QCryptoCipher *cipher,
+                             const void *in, void *out,
+                             size_t len, Error **errp)
+{
+    return qcrypto_afalg_cipher_op(cipher->opaque, in, out,
+                                   len, false, errp);
+}
+
+static void qcrypto_afalg_comm_ctx_free(QCryptoCipher *cipher)
+{
+    qcrypto_afalg_comm_free(cipher->opaque);
+}
+
+struct QCryptoCipherDriver qcrypto_cipher_afalg_driver = {
+    .cipher_encrypt = qcrypto_afalg_cipher_encrypt,
+    .cipher_decrypt = qcrypto_afalg_cipher_decrypt,
+    .cipher_setiv = qcrypto_afalg_cipher_setiv,
+    .cipher_free = qcrypto_afalg_comm_ctx_free,
+};
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 0a3d2e5..a487270 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -163,18 +163,33 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                                   Error **errp)
 {
     QCryptoCipher *cipher;
-    void *ctx;
+    void *ctx = NULL;
+    Error *err2 = NULL;
+    QCryptoCipherDriver *drv;
+
+#ifdef CONFIG_AF_ALG
+    ctx = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, &err2);
+    if (ctx) {
+        drv = &qcrypto_cipher_afalg_driver;
+    }
+#endif
 
-    ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
     if (!ctx) {
-        return NULL;
+        ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
+        if (!ctx) {
+            error_free(err2);
+            return NULL;
+        }
+
+        drv = &qcrypto_cipher_lib_driver;
+        error_free(err2);
     }
 
     cipher = g_new0(QCryptoCipher, 1);
     cipher->alg = alg;
     cipher->mode = mode;
     cipher->opaque = ctx;
-    cipher->driver = (void *)&qcrypto_cipher_lib_driver;
+    cipher->driver = (void *)drv;
 
     return cipher;
 }
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 4af5e85..77da4c2 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -15,6 +15,8 @@
 #ifndef QCRYPTO_CIPHERPRIV_H
 #define QCRYPTO_CIPHERPRIV_H
 
+#include "qapi-types.h"
+
 typedef struct QCryptoCipherDriver QCryptoCipherDriver;
 
 struct QCryptoCipherDriver {
@@ -37,4 +39,18 @@ struct QCryptoCipherDriver {
     void (*cipher_free)(QCryptoCipher *cipher);
 };
 
+#ifdef CONFIG_AF_ALG
+
+#include "afalgpriv.h"
+
+extern QCryptoAFAlg *
+qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                             QCryptoCipherMode mode,
+                             const uint8_t *key,
+                             size_t nkey, Error **errp);
+
+extern struct QCryptoCipherDriver qcrypto_cipher_afalg_driver;
+
+#endif
+
 #endif
-- 
1.8.3.1
