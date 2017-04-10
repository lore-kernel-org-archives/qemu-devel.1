Received: from eggs.gnu.org ([2001:4830:134:3::10]:54613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCU-0000Qi-Ap
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCP-0002QL-KF
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3422
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCO-0002PL-Q1
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:25 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:01:05 +0800
Message-ID: <1491814865-62912-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 16/19] crypto: hash: add af_alg hash
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
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Adds afalg-backend hash support: introduces some private APIs
firstly, and then intergrates them into qcrypto_hash_afalg_driver.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/Makefile.objs        |   1 +
 crypto/hash-afalg.c         | 150 ++++++++++++++++++++++++++++++++++++++++++++
 crypto/hash.c               |  16 ++++-
 include/crypto/afalg-comm.h |   1 +
 include/crypto/hash.h       |   1 +
 5 files changed, 166 insertions(+), 3 deletions(-)
 create mode 100644 crypto/hash-afalg.c

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index ad1229b..d8e8945 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -12,6 +12,7 @@ crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
 crypto-obj-$(CONFIG_AF_ALG) += afalg-comm.o
 crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
+crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredsx509.o
diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
new file mode 100644
index 0000000..d96d7568
--- /dev/null
+++ b/crypto/hash-afalg.c
@@ -0,0 +1,150 @@
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
+#include "crypto/afalg-comm.h"
+#include <linux/if_alg.h>
+
+static int afalg_hash_format_name(QCryptoHashAlgorithm alg,
+                                  AfalgSocketAddress *afalg)
+{
+    const char *alg_name = NULL;
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
+        return -1;
+    }
+
+    afalg->name = (char *)g_new0(int8_t, SALG_NAME_LEN_MAX);
+    sprintf(afalg->name, "%s", alg_name);
+
+    return 0;
+}
+
+static QCryptoAfalg *afalg_hash_ctx_new(QCryptoHashAlgorithm alg)
+{
+    SocketAddress *saddr = NULL;
+    QCryptoAfalg *afalg = NULL;
+    int ret = 0;
+
+    saddr = g_new0(SocketAddress, 1);
+    saddr->u.afalg.data = g_new0(AfalgSocketAddress, 1);
+    saddr->type = SOCKET_ADDRESS_KIND_AFALG;
+    ret = afalg_hash_format_name(alg, saddr->u.afalg.data);
+    if (ret != 0) {
+        goto error;
+    }
+    afalg_comm_format_type(saddr->u.afalg.data, ALG_TYPE_HASH);
+
+    afalg = afalg_comm_alloc(saddr);
+    if (!afalg) {
+        goto error;
+    }
+
+    /* prepare msg header */
+    afalg->msg = g_new0(struct msghdr, 1);
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
+static int afalg_hash_bytesv(QCryptoHashAlgorithm alg,
+                             const struct iovec *iov,
+                             size_t niov, uint8_t **result,
+                             size_t *resultlen,
+                             Error **errp)
+{
+    QCryptoAfalg *afalg = NULL;
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
+    afalg = afalg_hash_ctx_new(alg);
+    if (afalg == NULL) {
+        error_setg(errp, "Alloc QCryptoAfalg object failed");
+        return -1;
+    }
+
+    /* send data to kernel's crypto core */
+    ret = iov_send_recv(afalg->opfd, iov, niov,
+                        0, iov_size(iov, niov), true);
+    if (ret < 0) {
+        error_setg(errp, "Send data to afalg-core failed");
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
+        error_setg(errp, "Recv result from afalg-core failed");
+    }
+
+out:
+    afalg_comm_free(afalg);
+    return ret;
+}
+
+QCryptoHashDriver qcrypto_hash_afalg_driver = {
+    .hash_bytesv = afalg_hash_bytesv,
+};
diff --git a/crypto/hash.c b/crypto/hash.c
index 0b0d479..002622c 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -45,9 +45,19 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
                         size_t *resultlen,
                         Error **errp)
 {
-    return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
-                                               result, resultlen,
-                                               errp);
+    int ret;
+
+    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
+                                                result, resultlen,
+                                                errp);
+    if (ret == 0) {
+        return ret;
+    }
+
+    ret = qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
+                                              result, resultlen,
+                                              errp);
+    return ret;
 }
 
 
diff --git a/include/crypto/afalg-comm.h b/include/crypto/afalg-comm.h
index 34f30dc..3293949 100644
--- a/include/crypto/afalg-comm.h
+++ b/include/crypto/afalg-comm.h
@@ -20,6 +20,7 @@
 #endif
 
 #define ALG_TYPE_CIPHER "skcipher"
+#define ALG_TYPE_HASH   "hash"
 
 #define ALG_OPTYPE_LEN 4
 #define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 00b764e..eeb17a8 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -36,6 +36,7 @@ struct QCryptoHashDriver {
 };
 
 extern QCryptoHashDriver qcrypto_hash_lib_driver;
+extern QCryptoHashDriver qcrypto_hash_afalg_driver;
 
 /**
  * qcrypto_hash_supports:
-- 
1.8.3.1
