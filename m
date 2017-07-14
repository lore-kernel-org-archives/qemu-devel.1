Received: from eggs.gnu.org ([2001:4830:134:3::10]:55361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dW4x8-0005Nk-Kg
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dW4x7-0003Jb-DD
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:34 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dW4x7-0003JA-5M
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:33 -0400
Received: by mail-pg0-x241.google.com with SMTP id y129so11394675pgy.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 11:04:33 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 14:04:07 -0400
Message-Id: <1500055451-14041-15-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500055451-14041-1-git-send-email-longpeng.mike@gmail.com>
References: <1500055451-14041-1-git-send-email-longpeng.mike@gmail.com>
Subject: [Qemu-devel] [PATCH v6 14/18] crypto: hash: add afalg-backend hash
 support
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

Adds afalg-backend hash support: introduces some private APIs
firstly, and then intergrates them into qcrypto_hash_afalg_driver.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/Makefile.objs |   1 +
 crypto/afalgpriv.h   |   1 +
 crypto/hash-afalg.c  | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto/hash.c        |  17 +++++++
 crypto/hashpriv.h    |   8 +++
 5 files changed, 163 insertions(+)
 create mode 100644 crypto/hash-afalg.c

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index d2e8fa8..2b99e08 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -12,6 +12,7 @@ crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
+crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredsx509.o
diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
index d0941d4..f6550b5 100644
--- a/crypto/afalgpriv.h
+++ b/crypto/afalgpriv.h
@@ -24,6 +24,7 @@
 #endif
 
 #define AFALG_TYPE_CIPHER "skcipher"
+#define AFALG_TYPE_HASH "hash"
 
 #define ALG_OPTYPE_LEN 4
 #define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
new file mode 100644
index 0000000..70ab414
--- /dev/null
+++ b/crypto/hash-afalg.c
@@ -0,0 +1,136 @@
+/*
+ * QEMU Crypto af_alg-backend hash support
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
+#include "qemu/iov.h"
+#include "qemu/sockets.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "crypto/hash.h"
+#include "hashpriv.h"
+
+static char *
+qcrypto_afalg_hash_format_name(QCryptoHashAlgorithm alg,
+                               Error **errp)
+{
+    char *name;
+    const char *alg_name;
+
+    switch (alg) {
+    case QCRYPTO_HASH_ALG_MD5:
+        alg_name = "md5";
+        break;
+    case QCRYPTO_HASH_ALG_SHA1:
+        alg_name = "sha1";
+        break;
+    case QCRYPTO_HASH_ALG_SHA224:
+        alg_name = "sha224";
+        break;
+    case QCRYPTO_HASH_ALG_SHA256:
+        alg_name = "sha256";
+        break;
+    case QCRYPTO_HASH_ALG_SHA384:
+        alg_name = "sha384";
+        break;
+    case QCRYPTO_HASH_ALG_SHA512:
+        alg_name = "sha512";
+        break;
+    case QCRYPTO_HASH_ALG_RIPEMD160:
+        alg_name = "rmd160";
+        break;
+
+    default:
+        error_setg(errp, "Unsupported hash algorithm %d", alg);
+        return NULL;
+    }
+
+    name = g_strdup_printf("%s", alg_name);
+
+    return name;
+}
+
+static QCryptoAFAlg *
+qcrypto_afalg_hash_ctx_new(QCryptoHashAlgorithm alg, Error **errp)
+{
+    QCryptoAFAlg *afalg;
+    char *name;
+
+    name = qcrypto_afalg_hash_format_name(alg, errp);
+    if (!name) {
+        return NULL;
+    }
+
+    afalg = qcrypto_afalg_comm_alloc(AFALG_TYPE_HASH, name, errp);
+    if (!afalg) {
+        g_free(name);
+        return NULL;
+    }
+
+    g_free(name);
+
+    return afalg;
+}
+
+static int
+qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
+                          const struct iovec *iov,
+                          size_t niov, uint8_t **result,
+                          size_t *resultlen,
+                          Error **errp)
+{
+    QCryptoAFAlg *afalg;
+    struct iovec outv;
+    int ret = 0;
+    const int expect_len = qcrypto_hash_digest_len(alg);
+
+    if (*resultlen == 0) {
+        *resultlen = expect_len;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen != expect_len) {
+        error_setg(errp,
+                   "Result buffer size %zu is not match hash %d",
+                   *resultlen, expect_len);
+        return -1;
+    }
+
+    afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
+    if (!afalg) {
+        return -1;
+    }
+
+    /* send data to kernel's crypto core */
+    ret = iov_send_recv(afalg->opfd, iov, niov,
+                        0, iov_size(iov, niov), true);
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Send data to afalg-core failed");
+        goto out;
+    }
+
+    /* hash && get result */
+    outv.iov_base = *result;
+    outv.iov_len = *resultlen;
+    ret = iov_send_recv(afalg->opfd, &outv, 1,
+                        0, iov_size(&outv, 1), false);
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Recv result from afalg-core failed");
+    } else {
+        ret = 0;
+    }
+
+out:
+    qcrypto_afalg_comm_free(afalg);
+    return ret;
+}
+
+QCryptoHashDriver qcrypto_hash_afalg_driver = {
+    .hash_bytesv = qcrypto_afalg_hash_bytesv,
+};
diff --git a/crypto/hash.c b/crypto/hash.c
index c43fd87..ac59c63 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -46,6 +46,23 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
                         size_t *resultlen,
                         Error **errp)
 {
+#ifdef CONFIG_AF_ALG
+    int ret;
+
+    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
+                                                result, resultlen,
+                                                errp);
+    if (ret == 0) {
+        return ret;
+    }
+
+    /*
+     * TODO:
+     * Maybe we should treat some afalg errors as fatal
+     */
+    error_free(*errp);
+#endif
+
     return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
                                                result, resultlen,
                                                errp);
diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
index 5e505e0..cee26cc 100644
--- a/crypto/hashpriv.h
+++ b/crypto/hashpriv.h
@@ -28,4 +28,12 @@ struct QCryptoHashDriver {
 
 extern QCryptoHashDriver qcrypto_hash_lib_driver;
 
+#ifdef CONFIG_AF_ALG
+
+#include "afalgpriv.h"
+
+extern QCryptoHashDriver qcrypto_hash_afalg_driver;
+
+#endif
+
 #endif
-- 
1.8.3.1
