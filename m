Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF331C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C0E20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGCzFNoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C0E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecPQ-0003Ju-Lm
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecN3-00079m-KM
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecMx-0004wc-VS
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590748567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7DE749+q1fvMao8lVVHDqzxvMOn8AXc5dYlGBoHMw0=;
 b=ZGCzFNoqKWozOdbyrZsTbR9NZ8fDPDvD9M7HBurNuPJuFoFjU2QdK2QhogMuKp8GzX8wHK
 hxTTyM6gxa7LOKmiE2SVahkl5lyuaBcaf7fdT4XRDV05gX45/Y8L2+3z1lvWyBOmyK8SX5
 UQuwi0N+c9kedscR9+5CsaV6r+KVCvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-jDKwLwr7PxGHYmgW9KZZXw-1; Fri, 29 May 2020 06:36:04 -0400
X-MC-Unique: jDKwLwr7PxGHYmgW9KZZXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1068C107ACCA;
 Fri, 29 May 2020 10:36:04 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 926F51A7C8;
 Fri, 29 May 2020 10:36:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] crypto/linux_keyring: add 'secret_keyring' secret object.
Date: Fri, 29 May 2020 11:35:53 +0100
Message-Id: <20200529103555.2759928-4-berrange@redhat.com>
In-Reply-To: <20200529103555.2759928-1-berrange@redhat.com>
References: <20200529103555.2759928-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Krasikov <alex-krasikov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Krasikov <alex-krasikov@yandex-team.ru>

Add the ability for the secret object to obtain secret data from the
Linux in-kernel key managment and retention facility, as an extra option
to the existing ones: reading from a file or passing directly as a
string.

The secret is identified by the key serial number. The upper layers
need to instantiate the key and make sure the QEMU process has access
permissions to read it.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure                       |  38 ++++++++
 crypto/Makefile.objs            |   1 +
 crypto/secret_keyring.c         | 148 ++++++++++++++++++++++++++++++++
 include/crypto/secret_keyring.h |  52 +++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 crypto/secret_keyring.c
 create mode 100644 include/crypto/secret_keyring.h

diff --git a/configure b/configure
index 2ffe365e2c..d95ff4e0b3 100755
--- a/configure
+++ b/configure
@@ -510,6 +510,7 @@ default_devices="yes"
 plugins="no"
 fuzzing="no"
 rng_none="no"
+secret_keyring="yes"
 
 supported_cpu="no"
 supported_os="no"
@@ -1606,6 +1607,10 @@ for opt do
   ;;
   --disable-rng-none) rng_none=no
   ;;
+  --enable-keyring) secret_keyring="yes"
+  ;;
+  --disable-keyring) secret_keyring="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -6272,6 +6277,34 @@ case "$slirp" in
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
@@ -6756,6 +6789,7 @@ echo "plugin support    $plugins"
 echo "fuzzing support   $fuzzing"
 echo "gdb               $gdb_bin"
 echo "rng-none          $rng_none"
+echo "Linux keyring     $secret_keyring"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7638,6 +7672,10 @@ if test -n "$gdb_bin" ; then
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
index 110dec1b87..707c02ad37 100644
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
index 0000000000..4f132d6370
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
+                                  NULL, NULL);
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
2.26.2


