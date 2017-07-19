Received: from eggs.gnu.org ([2001:4830:134:3::10]:38620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXl61-0000nz-2j
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXl5y-0001cj-9B
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXl5x-0001b1-Vq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:38 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 19 Jul 2017 10:15:54 +0100
Message-Id: <20170719091600.8555-13-berrange@redhat.com>
In-Reply-To: <20170719091600.8555-1-berrange@redhat.com>
References: <20170719091600.8555-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 12/18] crypto: introduce some common
 functions for af_alg backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Longpeng(Mike)" <longpeng2@huawei.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

The AF_ALG socket family is the userspace interface for linux
crypto API, this patch adds af_alg family support and some common
functions for af_alg backend. It'll be used by afalg-backend crypto
latter.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

Maintainer: modified to report an error if AF_ALG is requested
but cannot be supported

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 configure            |  37 ++++++++++++++++
 crypto/Makefile.objs |   1 +
 crypto/afalg.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto/afalgpriv.h   |  54 ++++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 crypto/afalg.c
 create mode 100644 crypto/afalgpriv.h

diff --git a/configure b/configure
index e8798cec79..cd0db0b7f3 100755
--- a/configure
+++ b/configure
@@ -375,6 +375,7 @@ libnfs=""
 coroutine=""
 coroutine_pool=""
 debug_stack_usage="no"
+crypto_afalg="no"
 seccomp=""
 glusterfs=""
 glusterfs_xlator_opt="no"
@@ -1124,6 +1125,10 @@ for opt do
   ;;
   --enable-debug-stack-usage) debug_stack_usage="yes"
   ;;
+  --enable-crypto-afalg) crypto_afalg="yes"
+  ;;
+  --disable-crypto-afalg) crypto_afalg="no"
+  ;;
   --disable-docs) docs="no"
   ;;
   --enable-docs) docs="yes"
@@ -1518,6 +1523,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   qom-cast-debug  cast debugging support
   tools           build qemu-io, qemu-nbd and qemu-image tools
   vxhs            Veritas HyperScale vDisk backend support
+  crypto-afalg    Linux AF_ALG crypto backend driver
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -4834,6 +4840,32 @@ if compile_prog "" "" ; then
     have_af_vsock=yes
 fi
 
+##########################################
+# check for usable AF_ALG environment
+hava_afalg=no
+cat > $TMPC << EOF
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <linux/if_alg.h>
+int main(void) {
+    int sock;
+    sock = socket(AF_ALG, SOCK_SEQPACKET, 0);
+    return sock;
+}
+EOF
+if compile_prog "" "" ; then
+    have_afalg=yes
+fi
+if test "$crypto_afalg" = "yes"
+then
+    if test "$have_afalg" != "yes"
+    then
+	error_exit "AF_ALG requested but could not be detected"
+    fi
+fi
+
+
 #################################################
 # Sparc implicitly links with --relax, which is
 # incompatible with -r, so --no-relax should be
@@ -5315,6 +5347,7 @@ echo "seccomp support   $seccomp"
 echo "coroutine backend $coroutine"
 echo "coroutine pool    $coroutine_pool"
 echo "debug stack usage $debug_stack_usage"
+echo "crypto afalg      $crypto_afalg"
 echo "GlusterFS support $glusterfs"
 echo "gcov              $gcov_tool"
 echo "gcov enabled      $gcov"
@@ -5826,6 +5859,10 @@ if test "$debug_stack_usage" = "yes" ; then
   echo "CONFIG_DEBUG_STACK_USAGE=y" >> $config_host_mak
 fi
 
+if test "$crypto_afalg" = "yes" ; then
+  echo "CONFIG_AF_ALG=y" >> $config_host_mak
+fi
+
 if test "$open_by_handle_at" = "yes" ; then
   echo "CONFIG_OPEN_BY_HANDLE=y" >> $config_host_mak
 fi
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 1f749f2087..2be5a3aa1c 100644
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
index 0000000000..10046bb0ae
--- /dev/null
+++ b/crypto/afalg.c
@@ -0,0 +1,116 @@
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
+    if (strnlen(type, SALG_TYPE_LEN_MAX) >= SALG_TYPE_LEN_MAX) {
+        error_setg(errp, "Afalg type(%s) is larger than %d bytes",
+                   type, SALG_TYPE_LEN_MAX);
+        return false;
+    }
+
+    if (strnlen(name, SALG_NAME_LEN_MAX) >= SALG_NAME_LEN_MAX) {
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
+    if (!afalg) {
+        return;
+    }
+
+    if (afalg->msg) {
+        g_free(afalg->msg->msg_control);
+        g_free(afalg->msg);
+    }
+
+    if (afalg->tfmfd != -1) {
+        closesocket(afalg->tfmfd);
+    }
+
+    if (afalg->opfd != -1) {
+        closesocket(afalg->opfd);
+    }
+
+    g_free(afalg);
+}
diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
new file mode 100644
index 0000000000..76118cf962
--- /dev/null
+++ b/crypto/afalgpriv.h
@@ -0,0 +1,54 @@
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
-- 
2.13.0
