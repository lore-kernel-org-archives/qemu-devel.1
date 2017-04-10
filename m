Received: from eggs.gnu.org ([2001:4830:134:3::10]:54412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVC5-0008WL-0s
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBz-0002D0-8h
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3420
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBy-0002BU-BF
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:59 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:00:47 +0800
Message-ID: <1491814847-63240-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 13/19] crypto: introduce some common
 functions for af_alg backend
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

This patch introduces some common functions for af_alg backend,
they would be used in af_alg-backend cipher/hash/hmac latter.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/Makefile.objs        |  1 +
 crypto/afalg-comm.c         | 71 +++++++++++++++++++++++++++++++++++++++++++++
 include/crypto/afalg-comm.h | 61 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 crypto/afalg-comm.c
 create mode 100644 include/crypto/afalg-comm.h

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 1f749f2..6f244a3 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -10,6 +10,7 @@ crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib
 crypto-obj-y += aes.o
 crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
+crypto-obj-$(CONFIG_AF_ALG) += afalg-comm.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredsx509.o
diff --git a/crypto/afalg-comm.c b/crypto/afalg-comm.c
new file mode 100644
index 0000000..27bc88c
--- /dev/null
+++ b/crypto/afalg-comm.c
@@ -0,0 +1,71 @@
+/*
+ * QEMU Crypto af_alg support
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
+#include "qemu/cutils.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "crypto/afalg-comm.h"
+
+void afalg_comm_format_type(AfalgSocketAddress *afalg,
+                            const char *type)
+{
+    afalg->type = (char *)g_new0(int8_t, SALG_TYPE_LEN_MAX);
+    pstrcpy(afalg->type, SALG_TYPE_LEN_MAX, type);
+}
+
+void afalg_comm_free(QCryptoAfalg *afalg)
+{
+    if (afalg) {
+        if (afalg->msg) {
+            g_free(afalg->msg->msg_control);
+            g_free(afalg->msg);
+        }
+
+        if (afalg->tfmfd != -1) {
+            closesocket(afalg->tfmfd);
+        }
+
+        if (afalg->opfd != -1) {
+            closesocket(afalg->opfd);
+        }
+
+        g_free(afalg);
+    }
+}
+
+QCryptoAfalg *afalg_comm_alloc(SocketAddress *saddr)
+{
+    QCryptoAfalg *afalg = NULL;
+    Error *err = NULL;
+
+    afalg = g_new0(QCryptoAfalg, 1);
+    /* initilize crypto API socket */
+    afalg->opfd = -1;
+    afalg->tfmfd = socket_bind(saddr, &err);
+    if (afalg->tfmfd == -1) {
+        goto error;
+    }
+
+    afalg->opfd = qemu_accept(afalg->tfmfd, NULL, 0);
+    if (afalg->opfd == -1) {
+        closesocket(afalg->tfmfd);
+        goto error;
+    }
+
+    return afalg;
+
+error:
+    error_free(err);
+    afalg_comm_free(afalg);
+    return NULL;
+}
diff --git a/include/crypto/afalg-comm.h b/include/crypto/afalg-comm.h
new file mode 100644
index 0000000..b6b9464
--- /dev/null
+++ b/include/crypto/afalg-comm.h
@@ -0,0 +1,61 @@
+/*
+ * QEMU Crypto af_alg support
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
+#ifndef QCRYPTO_AFALG_H
+#define QCRYPTO_AFALG_H
+
+#include "qapi-types.h"
+
+#ifndef SOL_ALG
+#define SOL_ALG 279
+#endif
+
+typedef struct QCryptoAfalg QCryptoAfalg;
+struct QCryptoAfalg {
+    int tfmfd;
+    int opfd;
+    struct msghdr *msg;
+    struct cmsghdr *cmsg;
+};
+
+
+/**
+ * afalg_comm_format_type:
+ * @afalg: the AfalgSocketAddress object
+ * @type: the type of crypto alg.
+ *
+ * Set the type field of the @afalg according to @type.
+ */
+void afalg_comm_format_type(AfalgSocketAddress *afalg,
+                            const char *type);
+
+/**
+ * afalg_comm_alloc:
+ * @saddr: the SocketAddress object
+ *
+ * Allocate a QCryptoAfalg object and bind itself to
+ * a AF_ALG socket.
+ *
+ * Returns:
+ *  a new QCryptoAfalg object, or NULL in error.
+ */
+QCryptoAfalg *afalg_comm_alloc(SocketAddress *saddr);
+
+/**
+ * afalg_comm_free:
+ * @afalg: the QCryptoAfalg object
+ *
+ * Free the @afalg.
+ */
+void afalg_comm_free(QCryptoAfalg *afalg);
+
+#endif
-- 
1.8.3.1
