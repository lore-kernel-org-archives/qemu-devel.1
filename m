Received: from eggs.gnu.org ([2001:4830:134:3::10]:48222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pMA-0003fC-Ec
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pM8-0003q8-EG
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3462
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pM7-0003ok-KA
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:20 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Sat, 22 Apr 2017 15:20:21 +0800
Message-ID: <1492845627-4384-13-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 12/18] crypto: introduce some common
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
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

The AF_ALG socket family is the userspace interface for linux
crypto API, this patch adds af_alg family support and some common
functions for af_alg backend. It'll be used by afalg-backend crypto
latter.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 configure            |  21 +++++++++
 crypto/Makefile.objs |   1 +
 crypto/afalg.c       | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto/afalgpriv.h   |  59 ++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 crypto/afalg.c
 create mode 100644 crypto/afalgpriv.h

diff --git a/configure b/configure
index 6db3044..db0e183 100755
--- a/configure
+++ b/configure
@@ -4744,6 +4744,23 @@ if compile_prog "" "" ; then
     have_af_vsock=yes
 fi
 
+##########################################
+# check for usable AF_ALG environment
+hava_af_alg=no
+cat > $TMPC << EOF
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+int main(void) {
+    int sock;
+    sock = socket(AF_ALG, SOCK_SEQPACKET, 0);
+    return sock;
+}
+EOF
+if compile_prog "" "" ; then
+    have_af_alg=yes
+fi
+
 #################################################
 # Sparc implicitly links with --relax, which is
 # incompatible with -r, so --no-relax should be
@@ -5774,6 +5791,10 @@ if test "$have_af_vsock" = "yes" ; then
   echo "CONFIG_AF_VSOCK=y" >> $config_host_mak
 fi
 
+if test "$have_af_alg" = "yes" ; then
+  echo "CONFIG_AF_ALG=y" >> $config_host_mak
+fi
+
 if test "$have_sysmacros" = "yes" ; then
   echo "CONFIG_SYSMACROS=y" >> $config_host_mak
 fi
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 1f749f2..2be5a3a 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -10,6 +10,7 @@ crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib
 crypto-obj-y += aes.o
 crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
+crypto-obj-$(CONFIG_AF_ALG) += afalg.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredsx509.o
diff --git a/crypto/afalg.c b/crypto/afalg.c
new file mode 100644
index 0000000..80c5cfd
--- /dev/null
+++ b/crypto/afalg.c
@@ -0,0 +1,118 @@
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
+#include "afalgpriv.h"
+
+static bool
+qcrypto_afalg_build_saddr(const char *type, const char *name,
+                          struct sockaddr_alg *salg, Error **errp)
+{
+    salg->salg_family = AF_ALG;
+
+    if (qemu_strnlen(type, SALG_TYPE_LEN_MAX) == SALG_TYPE_LEN_MAX) {
+        error_setg(errp, "Afalg type(%s) is larger than %d bytes",
+                   type, SALG_TYPE_LEN_MAX);
+        return false;
+    }
+
+    if (qemu_strnlen(name, SALG_NAME_LEN_MAX) == SALG_NAME_LEN_MAX) {
+        error_setg(errp, "Afalg name(%s) is larger than %d bytes",
+                   name, SALG_NAME_LEN_MAX);
+        return false;
+    }
+
+    pstrcpy((char *)salg->salg_type, SALG_TYPE_LEN_MAX, type);
+    pstrcpy((char *)salg->salg_name, SALG_NAME_LEN_MAX, name);
+
+    return true;
+}
+
+static int
+qcrypto_afalg_socket_bind(const char *type, const char *name,
+                          Error **errp)
+{
+    int sbind;
+    struct sockaddr_alg salg = {0};
+
+    if (!qcrypto_afalg_build_saddr(type, name, &salg, errp)) {
+        return -1;
+    }
+
+    sbind = qemu_socket(AF_ALG, SOCK_SEQPACKET, 0);
+    if (sbind < 0) {
+        error_setg_errno(errp, errno, "Failed to create socket");
+        return -1;
+    }
+
+    if (bind(sbind, (const struct sockaddr *)&salg, sizeof(salg)) != 0) {
+        error_setg_errno(errp, errno, "Failed to bind socket");
+        closesocket(sbind);
+        return -1;
+    }
+
+    return sbind;
+}
+
+QCryptoAFAlg *
+qcrypto_afalg_comm_alloc(const char *type, const char *name,
+                         Error **errp)
+{
+    QCryptoAFAlg *afalg;
+
+    afalg = g_new0(QCryptoAFAlg, 1);
+    /* initilize crypto API socket */
+    afalg->opfd = -1;
+    afalg->tfmfd = qcrypto_afalg_socket_bind(type, name, errp);
+    if (afalg->tfmfd == -1) {
+        goto error;
+    }
+
+    afalg->opfd = qemu_accept(afalg->tfmfd, NULL, 0);
+    if (afalg->opfd == -1) {
+        error_setg_errno(errp, errno, "Failed to accept socket");
+        goto error;
+    }
+
+    return afalg;
+
+error:
+    qcrypto_afalg_comm_free(afalg);
+    return NULL;
+}
+
+void qcrypto_afalg_comm_free(QCryptoAFAlg *afalg)
+{
+    if (afalg) {
+        if (afalg->msg) {
+            g_free(afalg->msg->msg_control);
+            g_free(afalg->msg);
+        }
+
+        if (afalg->name) {
+            g_free(afalg->name);
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
diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
new file mode 100644
index 0000000..f1b0ae5
--- /dev/null
+++ b/crypto/afalgpriv.h
@@ -0,0 +1,59 @@
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
+
+#ifndef QCRYPTO_AFALGPRIV_H
+#define QCRYPTO_AFALGPRIV_H
+
+#ifdef CONFIG_AF_ALG
+
+#include <linux/if_alg.h>
+
+#define SALG_TYPE_LEN_MAX 14
+#define SALG_NAME_LEN_MAX 64
+
+typedef struct QCryptoAFAlg QCryptoAFAlg;
+
+struct QCryptoAFAlg {
+    int tfmfd;
+    int opfd;
+    char *name;
+    struct msghdr *msg;
+    struct cmsghdr *cmsg;
+};
+
+/**
+ * qcrypto_afalg_comm_alloc:
+ * @type: the type of crypto operation
+ * @name: the name of crypto operation
+ *
+ * Allocate a QCryptoAFAlg object and bind itself to
+ * a AF_ALG socket.
+ *
+ * Returns:
+ *  a new QCryptoAFAlg object, or NULL in error.
+ */
+QCryptoAFAlg *
+qcrypto_afalg_comm_alloc(const char *type, const char *name,
+                         Error **errp);
+
+/**
+ * afalg_comm_free:
+ * @afalg: the QCryptoAFAlg object
+ *
+ * Free the @afalg.
+ */
+void qcrypto_afalg_comm_free(QCryptoAFAlg *afalg);
+
+#endif
+
+#endif
-- 
1.8.3.1
