Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C36DC3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B7420784
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="qqR4T4PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B7420784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOqUq-0005Vf-Cj
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 18:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTZ-0003qx-62
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTX-0003tn-P1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:45 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:37722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jOqTX-0003s1-CJ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:43 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id CDFB12E1539;
 Thu, 16 Apr 2020 01:25:37 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 gm1yGdowxP-PbM0ZMvo; Thu, 16 Apr 2020 01:25:37 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1586989537; bh=QjEPS2tWD3YYMjy0GG+WeZ4SZywFyrdyda249WVakAk=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=qqR4T4PGFhYeaz2DBlaXRVp8nMFt1pjQaUS/H7B8VTirhJ0g8n1cpdLNAp8fIM81J
 WyI7n/G7F3llvtsWx8mPKi7VXvq6Jr8h67Iy+J45bPvxoEMED1rBxu5hAWSJTYhzOd
 kaML98Ox9MkVuQ0Cbd9LAx7a+G2S+Cu4yAaRebNE=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6410::1:e])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 0wmBaV4yMk-PbXa68Yb; Thu, 16 Apr 2020 01:25:37 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v2 4/5] crypto/linux_keyring: add 'syskey' secret object.
Date: Thu, 16 Apr 2020 01:25:24 +0300
Message-Id: <20200415222525.4022-4-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
References: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
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

* Add the ability for the secret object to obtain secret data from the
  Linux in-kernel key managment and retention facility, as an extra option
  to the existing ones: reading from a file or passing directly as a
  string.

  The secret is identified by the key serial number.  The upper layers
  need to instantiate the key and make sure the QEMU process has access
  rights to read it.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
---
 crypto/Makefile.objs           |   1 +
 crypto/linux_keyring.c         | 140 +++++++++++++++++++++++++++++++++
 include/crypto/linux_keyring.h |  38 +++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 crypto/linux_keyring.c
 create mode 100644 include/crypto/linux_keyring.h

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 3ae0dfd1a4..7fc354a8d5 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -19,6 +19,7 @@ crypto-obj-y += tlscredspsk.o
 crypto-obj-y += tlscredsx509.o
 crypto-obj-y += tlssession.o
 crypto-obj-y += secret_interface.o
+crypto-obj-y += linux_keyring.o
 crypto-obj-y += secret.o
 crypto-obj-y += pbkdf.o
 crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
diff --git a/crypto/linux_keyring.c b/crypto/linux_keyring.c
new file mode 100644
index 0000000000..7950d4c12d
--- /dev/null
+++ b/crypto/linux_keyring.c
@@ -0,0 +1,140 @@
+#ifdef __NR_keyctl
+
+#include "qemu/osdep.h"
+#include <asm/unistd.h>
+#include <linux/keyctl.h>
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "trace.h"
+#include "crypto/linux_keyring.h"
+
+
+static inline
+long keyctl_read(key_serial_t key, uint8_t *buffer, size_t buflen)
+{
+    return syscall(__NR_keyctl, KEYCTL_READ, key, buffer, buflen, 0);
+}
+
+
+static
+long keyctl_read_alloc(key_serial_t key, uint8_t **buffer)
+{
+    uint8_t *loc_buf;
+    long retcode = keyctl_read(key, NULL, 0);
+    if (retcode <= 0) {
+        return retcode;
+    }
+    loc_buf = g_malloc(retcode);
+    retcode = keyctl_read(key, loc_buf, retcode);
+
+    if (retcode >= 0) {
+        *buffer = loc_buf;
+    } else {
+        g_free(loc_buf);
+    }
+    return retcode;
+}
+
+
+static void
+qcrypto_secret_linux_load_data(Object   *obj,
+                               uint8_t  **output,
+                               size_t   *outputlen,
+                               Error    **errp)
+{
+    QCryptoSecretLinuxKeyring *secret = QCRYPTO_SECRET_LINUX_KEYRING(obj);
+    uint8_t  *buffer = NULL;
+    long     retcode;
+
+    *output    = NULL;
+    *outputlen = 0;
+
+    if (secret->serial) {
+        retcode = keyctl_read_alloc(secret->serial, &buffer);
+        if (retcode < 0) {
+          error_setg_errno(errp, errno,
+                     "Unable to read serial key %08x",
+                     secret->serial);
+          return;
+        } else {
+          *outputlen = retcode;
+          *output    = buffer;
+        }
+    } else {
+      error_setg(errp, "Either 'serial' must be provided");
+    }
+}
+
+
+static void
+qcrypto_secret_prop_set_key(Object     *obj,   Visitor *v,
+                            const char *name,  void    *opaque,
+                            Error      **errp)
+{
+    QCryptoSecretLinuxKeyring *secret = QCRYPTO_SECRET_LINUX_KEYRING(obj);
+    int32_t value;
+    visit_type_int32(v, name, &value, errp);
+    if (!value) {
+        error_setg(errp, "The 'serial' should be not equal 0");
+    }
+    secret->serial = value;
+}
+
+
+static void
+qcrypto_secret_prop_get_key(Object     *obj,   Visitor *v,
+                            const char *name,  void    *opaque,
+                            Error      **errp)
+{
+    QCryptoSecretLinuxKeyring *secret = QCRYPTO_SECRET_LINUX_KEYRING(obj);
+    int32_t value = secret->serial;
+    visit_type_int32(v, name, &value, errp);
+}
+
+
+static void
+qcrypto_secret_linux_complete(UserCreatable *uc, Error **errp)
+{
+    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+}
+
+
+static void
+qcrypto_secret_linux_class_init(ObjectClass *oc, void *data)
+{
+    QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
+    sic->load_data = qcrypto_secret_linux_load_data;
+
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    ucc->complete = qcrypto_secret_linux_complete;
+
+    object_class_property_add(oc, "serial", "key_serial_t",
+                                  qcrypto_secret_prop_get_key,
+                                  qcrypto_secret_prop_set_key,
+                                  NULL, NULL, NULL);
+}
+
+
+static const TypeInfo qcrypto_secret_info = {
+    .parent        = TYPE_QCRYPTO_SECRET_COMMON,
+    .name          = TYPE_QCRYPTO_SECRET_LINUX_KEYRING,
+    .instance_size = sizeof(QCryptoSecretLinuxKeyring),
+    .class_size    = sizeof(QCryptoSecretLinuxKeyringClass),
+    .class_init    = qcrypto_secret_linux_class_init,
+    .interfaces    = (InterfaceInfo[]) {
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
+
+#endif /* __NR_keyctl */
diff --git a/include/crypto/linux_keyring.h b/include/crypto/linux_keyring.h
new file mode 100644
index 0000000000..2618b34444
--- /dev/null
+++ b/include/crypto/linux_keyring.h
@@ -0,0 +1,38 @@
+#ifndef QCRYPTO_SECRET_LINUX_KEYRING_H
+#define QCRYPTO_SECRET_LINUX_KEYRING_H
+
+#ifdef __NR_keyctl
+
+#include "qapi/qapi-types-crypto.h"
+#include "qom/object.h"
+#include "crypto/secret_interface.h"
+
+#define TYPE_QCRYPTO_SECRET_LINUX_KEYRING "syskey"
+#define QCRYPTO_SECRET_LINUX_KEYRING(obj) \
+    OBJECT_CHECK(QCryptoSecretLinuxKeyring, (obj), \
+                 TYPE_QCRYPTO_SECRET_LINUX_KEYRING)
+#define QCRYPTO_SECRET_LINUX_KEYRING_CLASS(class) \
+    OBJECT_CLASS_CHECK(QCryptoSecretLinuxKeyringClass, \
+                       (class), TYPE_QCRYPTO_SECRET_LINUX_KEYRING)
+#define QCRYPTO_SECRET_LINUX_KEYRING_GET_CLASS(class) \
+    OBJECT_GET_CLASS(QCryptoSecretLinuxKeyringClass, \
+                     (class), TYPE_QCRYPTO_SECRET_LINUX_KEYRING)
+
+typedef struct QCryptoSecretLinux QCryptoSecretLinux;
+typedef struct QCryptoSecretLinuxClass QCryptoSecretLinuxClass;
+
+typedef int32_t key_serial_t;
+
+typedef struct QCryptoSecretLinuxKeyring {
+    QCryptoSecretCommon  parent;
+    key_serial_t         serial;
+} QCryptoSecretLinuxKeyring;
+
+
+typedef struct QCryptoSecretLinuxKeyringClass {
+    QCryptoSecretCommonClass  parent;
+} QCryptoSecretLinuxKeyringClass;
+
+#endif /* __NR_keyctl */
+
+#endif /* QCRYPTO_SECRET_LINUX_KEYRING_H */
-- 
2.17.1


