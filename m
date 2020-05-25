Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3A9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A82720787
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="oe2oqC+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A82720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBCi-0008JX-P7
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jdB8g-0000zJ-7l
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:19:26 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:41238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jdB8e-0008Mu-O5
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:19:25 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5B4872E151A;
 Mon, 25 May 2020 14:19:23 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 aBUpewoFa4-JMY8dewN; Mon, 25 May 2020 14:19:23 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590405563; bh=sXoF/dr1GHAxXqNuyW7HXi2Lv+Al7/WUD4Taqeei4qo=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=oe2oqC+Q87C/HnJjc4Tqb05yQQ40JvGmPa8h7HTdmuzbi2Wk8Ti2nQYi3/ppK14A/
 iFpwaA4qcAGviiQheBMfcvmla4v8M/ItcgU/ZQnwGLHvL9QdnXxGrxnE/KDfdsNFmB
 EbsSMOKeSr62IWlBj7BKTB8GVs4vv2K+QpeZVOfg=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:518::1:6])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 ZxU7UXwtFf-JMXufU9k; Mon, 25 May 2020 14:19:22 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 2/3] crypto/linux_keyring: add 'secret_keyring' secret
 object.
Date: Mon, 25 May 2020 14:19:12 +0300
Message-Id: <20200525111913.4274-1-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=alex-krasikov@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 07:17:05
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the ability for the secret object to obtain secret data from the
Linux in-kernel key managment and retention facility, as an extra option
to the existing ones: reading from a file or passing directly as a
string.

The secret is identified by the key serial number. The upper layers
need to instantiate the key and make sure the QEMU process has access
permissions to read it.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure                       |  38 ++++++++
 crypto/Makefile.objs            |   1 +
 crypto/secret_keyring.c         | 148 ++++++++++++++++++++++++++++++++
 include/crypto/secret_keyring.h |  52 +++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 crypto/secret_keyring.c
 create mode 100644 include/crypto/secret_keyring.h

diff --git a/configure b/configure
index 2fc05c4465..3c83504c95 100755
--- a/configure
+++ b/configure
@@ -509,6 +509,7 @@ libpmem=""
 default_devices="yes"
 plugins="no"
 fuzzing="no"
+secret_keyring="yes"
 
 supported_cpu="no"
 supported_os="no"
@@ -1601,6 +1602,10 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-keyring) secret_keyring="yes"
+  ;;
+  --disable-keyring) secret_keyring="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -6250,6 +6255,34 @@ case "$slirp" in
     ;;
 esac
 
+##########################################
+# check for usable __NR_keyctl syscall
+
+if test "$linux" = "yes" ; then
+
+    have_keyring=no
+    cat > $TMPC << EOF
+#include <errno.h>
+#include <asm/unistd.h>
+#include <linux/keyctl.h>
+#include <unistd.h>
+int main(void) {
+    return syscall(__NR_keyctl, KEYCTL_READ, 0, NULL, NULL, 0);
+}
+EOF
+    if compile_prog "" "" ; then
+        have_keyring=yes
+    fi
+fi
+if test "$secret_keyring" = "yes"
+then
+    if test "$have_keyring" != "yes"
+    then
+    error_exit "syscall __NR_keyctl requested, \
+but not implemented on your system"
+    fi
+fi
+
 
 ##########################################
 # End of CC checks
@@ -6733,6 +6766,7 @@ echo "default devices   $default_devices"
 echo "plugin support    $plugins"
 echo "fuzzing support   $fuzzing"
 echo "gdb               $gdb_bin"
+echo "Linux keyring     $secret_keyring"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7614,6 +7648,10 @@ if test -n "$gdb_bin" ; then
     echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
 fi
 
+if test "$secret_keyring" = "yes" ; then
+  echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 695da72dd1..872c928ac0 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -20,6 +20,7 @@ crypto-obj-y += tlscredsx509.o
 crypto-obj-y += tlssession.o
 crypto-obj-y += secret_common.o
 crypto-obj-y += secret.o
+crypto-obj-$(CONFIG_SECRET_KEYRING) += secret_keyring.o
 crypto-obj-y += pbkdf.o
 crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
new file mode 100644
index 0000000000..aa29004639
--- /dev/null
+++ b/crypto/secret_keyring.c
@@ -0,0 +1,148 @@
+/*
+ * QEMU crypto secret support
+ *
+ * Copyright 2020 Yandex N.V.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <asm/unistd.h>
+#include <linux/keyctl.h>
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "trace.h"
+#include "crypto/secret_keyring.h"
+
+
+static inline
+long keyctl_read(int32_t key, uint8_t *buffer, size_t buflen)
+{
+    return syscall(__NR_keyctl, KEYCTL_READ, key, buffer, buflen, 0);
+}
+
+
+static void
+qcrypto_secret_keyring_load_data(QCryptoSecretCommon *sec_common,
+                                 uint8_t **output,
+                                 size_t *outputlen,
+                                 Error **errp)
+{
+    QCryptoSecretKeyring *secret = QCRYPTO_SECRET_KEYRING(sec_common);
+    uint8_t *buffer = NULL;
+    long retcode;
+
+    *output = NULL;
+    *outputlen = 0;
+
+    if (!secret->serial) {
+        error_setg(errp, "'serial' parameter must be provided");
+        return;
+    }
+
+    retcode = keyctl_read(secret->serial, NULL, 0);
+    if (retcode <= 0) {
+        goto keyctl_error;
+    }
+
+    buffer = g_new0(uint8_t, retcode);
+
+    retcode = keyctl_read(secret->serial, buffer, retcode);
+    if (retcode < 0) {
+        g_free(buffer);
+        goto keyctl_error;
+    }
+
+    *outputlen = retcode;
+    *output = buffer;
+    return;
+
+keyctl_error:
+    error_setg_errno(errp, errno,
+                     "Unable to read serial key %08x",
+                     secret->serial);
+}
+
+
+static void
+qcrypto_secret_prop_set_key(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    QCryptoSecretKeyring *secret = QCRYPTO_SECRET_KEYRING(obj);
+    int32_t value;
+    visit_type_int32(v, name, &value, errp);
+    if (!value) {
+        error_setg(errp, "'serial' should not be equal to 0");
+    }
+    secret->serial = value;
+}
+
+
+static void
+qcrypto_secret_prop_get_key(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    QCryptoSecretKeyring *secret = QCRYPTO_SECRET_KEYRING(obj);
+    int32_t value = secret->serial;
+    visit_type_int32(v, name, &value, errp);
+}
+
+
+static void
+qcrypto_secret_keyring_complete(UserCreatable *uc, Error **errp)
+{
+    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+}
+
+
+static void
+qcrypto_secret_keyring_class_init(ObjectClass *oc, void *data)
+{
+    QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
+    sic->load_data = qcrypto_secret_keyring_load_data;
+
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    ucc->complete = qcrypto_secret_keyring_complete;
+
+    object_class_property_add(oc, "serial", "int32_t",
+                                  qcrypto_secret_prop_get_key,
+                                  qcrypto_secret_prop_set_key,
+                                  NULL, NULL, NULL);
+}
+
+
+static const TypeInfo qcrypto_secret_info = {
+    .parent = TYPE_QCRYPTO_SECRET_COMMON,
+    .name = TYPE_QCRYPTO_SECRET_KEYRING,
+    .instance_size = sizeof(QCryptoSecretKeyring),
+    .class_size = sizeof(QCryptoSecretKeyringClass),
+    .class_init = qcrypto_secret_keyring_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+
+static void
+qcrypto_secret_register_types(void)
+{
+    type_register_static(&qcrypto_secret_info);
+}
+
+
+type_init(qcrypto_secret_register_types);
diff --git a/include/crypto/secret_keyring.h b/include/crypto/secret_keyring.h
new file mode 100644
index 0000000000..9f371ad251
--- /dev/null
+++ b/include/crypto/secret_keyring.h
@@ -0,0 +1,52 @@
+/*
+ * QEMU crypto secret support
+ *
+ * Copyright 2020 Yandex N.V.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QCRYPTO_SECRET_KEYRING_H
+#define QCRYPTO_SECRET_KEYRING_H
+
+#include "qapi/qapi-types-crypto.h"
+#include "qom/object.h"
+#include "crypto/secret_common.h"
+
+#define TYPE_QCRYPTO_SECRET_KEYRING "secret_keyring"
+#define QCRYPTO_SECRET_KEYRING(obj) \
+    OBJECT_CHECK(QCryptoSecretKeyring, (obj), \
+                 TYPE_QCRYPTO_SECRET_KEYRING)
+#define QCRYPTO_SECRET_KEYRING_CLASS(class) \
+    OBJECT_CLASS_CHECK(QCryptoSecretKeyringClass, \
+                       (class), TYPE_QCRYPTO_SECRET_KEYRING)
+#define QCRYPTO_SECRET_KEYRING_GET_CLASS(class) \
+    OBJECT_GET_CLASS(QCryptoSecretKeyringClass, \
+                     (class), TYPE_QCRYPTO_SECRET_KEYRING)
+
+typedef struct QCryptoSecretKeyring QCryptoSecretKeyring;
+typedef struct QCryptoSecretKeyringClass QCryptoSecretKeyringClass;
+
+typedef struct QCryptoSecretKeyring {
+    QCryptoSecretCommon parent;
+    int32_t serial;
+} QCryptoSecretKeyring;
+
+
+typedef struct QCryptoSecretKeyringClass {
+    QCryptoSecretCommonClass parent;
+} QCryptoSecretKeyringClass;
+
+#endif /* QCRYPTO_SECRET_KEYRING_H */
-- 
2.17.1


