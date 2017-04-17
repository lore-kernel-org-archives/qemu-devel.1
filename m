Received: from eggs.gnu.org ([2001:4830:134:3::10]:57719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1czvYN-0003s0-CU
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 21:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1czvYL-0005ZH-HQ
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 21:34:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3480
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1czvYK-0005Wm-KM
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 21:34:05 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 17 Apr 2017 09:33:22 +0800
Message-ID: <1492392806-53720-15-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 for-2.10 14/18] crypto: hash: add
 afalg-backend hash support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, armbru@redhat.com, eblake@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Adds afalg-backend hash support: introduces some private APIs
firstly, and then intergrates them into qcrypto_hash_afalg_driver.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/Makefile.objs |   1 +
 crypto/afalgpriv.h   |   1 +
 crypto/hash-afalg.c  | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto/hash.c        |  11 ++++
 crypto/hashpriv.h    |   4 ++
 5 files changed, 168 insertions(+)
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
index 7db0597..71ec267 100644
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
index 0000000..1d0e052
--- /dev/null
+++ b/crypto/hash-afalg.c
@@ -0,0 +1,151 @@
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
+    const char *alg_name = NULL;
+    int ret;
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
+    name = (char *)g_new0(int8_t, SALG_NAME_LEN_MAX);
+    ret = snprintf(name, SALG_NAME_LEN_MAX, "%s", alg_name);
+    if (ret < 0 || ret >= SALG_NAME_LEN_MAX) {
+        error_setg(errp, "Build hash name(name='%s') failed",
+                   alg_name);
+        g_free(name);
+        return NULL;
+    }
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
+        goto error;
+    }
+
+    /* prepare msg header */
+    afalg->msg = g_new0(struct msghdr, 1);
+
+cleanup:
+    g_free(name);
+    return afalg;
+
+error:
+    qcrypto_afalg_comm_free(afalg);
+    goto cleanup;
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
+    const int except_len = qcrypto_hash_digest_len(alg);
+
+    if (*resultlen == 0) {
+        *resultlen = except_len;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen != except_len) {
+        error_setg(errp,
+                   "Result buffer size %zu is not match hash %d",
+                   *resultlen, except_len);
+        return -1;
+    }
+
+    afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
+    if (afalg == NULL) {
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
+    afalg->msg->msg_iov = &outv;
+    afalg->msg->msg_iovlen = 1;
+    ret = recvmsg(afalg->opfd, afalg->msg, 0);
+    if (ret != -1) {
+        ret = 0;
+    } else {
+        error_setg_errno(errp, errno, "Recv result from afalg-core failed");
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
index c43fd87..ba30c9b 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -46,6 +46,17 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
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
+#endif
+
     return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
                                                result, resultlen,
                                                errp);
diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
index 5e505e0..d23662f 100644
--- a/crypto/hashpriv.h
+++ b/crypto/hashpriv.h
@@ -15,6 +15,8 @@
 #ifndef QCRYPTO_HASHPRIV_H
 #define QCRYPTO_HASHPRIV_H
 
+#include "afalgpriv.h"
+
 typedef struct QCryptoHashDriver QCryptoHashDriver;
 
 struct QCryptoHashDriver {
@@ -28,4 +30,6 @@ struct QCryptoHashDriver {
 
 extern QCryptoHashDriver qcrypto_hash_lib_driver;
 
+extern QCryptoHashDriver qcrypto_hash_afalg_driver;
+
 #endif
-- 
1.8.3.1
