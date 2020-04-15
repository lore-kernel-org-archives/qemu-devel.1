Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C07C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7F5206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Cfcjo1TD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7F5206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOqWF-0007hD-1O
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 18:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTZ-0003rb-Lt
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTX-0003tV-NO
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:45 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:38776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jOqTX-0003s0-BL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:43 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 555192E14EB;
 Thu, 16 Apr 2020 01:25:37 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 nvAZaeZxXC-PbMOBgaG; Thu, 16 Apr 2020 01:25:37 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1586989537; bh=wNvf7o1vc6MHjo+d2Eobefmwa8ZhAg7GLZP2YlwZkUs=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=Cfcjo1TDqnzD3EzNd44GkfwGUdV0LEAsOx9FOAv6QnuDaCF/ZppswSlPqjSDR8uYG
 LDaFJiZ2vKIi/ND4pJb1zmEXbnSet6b4tDOwNt7Nj41xHV8NxU8BBZO7XS2KdSjz/A
 2+o4i3himFjKVijkzsE66XNqxUWJSsZYp/devq+4=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6410::1:e])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 0wmBaV4yMk-PaXaKYdF; Thu, 16 Apr 2020 01:25:36 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v2 3/5] crypto/secret: add secret class files.
Date: Thu, 16 Apr 2020 01:25:23 +0300
Message-Id: <20200415222525.4022-3-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
References: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
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

* Add child 'secret' class from basic 'secret_common'
  with 'data' and 'file' properties.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
---
 crypto/secret.c         | 167 ++++++++++++++++++++++++++++++++++++++++
 include/crypto/secret.h | 133 ++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 crypto/secret.c
 create mode 100644 include/crypto/secret.h

diff --git a/crypto/secret.c b/crypto/secret.c
new file mode 100644
index 0000000000..d9be0409e4
--- /dev/null
+++ b/crypto/secret.c
@@ -0,0 +1,167 @@
+/*
+ * QEMU crypto secret support
+ *
+ * Copyright (c) 2015 Red Hat, Inc.
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
+#include "crypto/secret.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qemu/module.h"
+#include "trace.h"
+
+
+static void
+qcrypto_secret_load_data(Object *obj,
+                         uint8_t **output,
+                         size_t *outputlen,
+                         Error **errp)
+{
+    char *data = NULL;
+    size_t length = 0;
+    GError *gerr = NULL;
+
+    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+
+    *output = NULL;
+    *outputlen = 0;
+
+    if (secret->file) {
+        if (secret->data) {
+            error_setg(errp,
+                       "'file' and 'data' are mutually exclusive");
+            return;
+        }
+        if (!g_file_get_contents(secret->file, &data, &length, &gerr)) {
+            error_setg(errp,
+                       "Unable to read %s: %s",
+                       secret->file, gerr->message);
+            g_error_free(gerr);
+            return;
+        }
+        *output = (uint8_t *)data;
+        *outputlen = length;
+    } else if (secret->data) {
+        *outputlen = strlen(secret->data);
+        *output = (uint8_t *)g_strdup(secret->data);
+    } else {
+        error_setg(errp, "Either 'file' or 'data' must be provided");
+    }
+}
+
+
+static void
+qcrypto_secret_prop_set_data(Object *obj,
+                             const char *value,
+                             Error **errp)
+{
+    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+
+    g_free(secret->data);
+    secret->data = g_strdup(value);
+}
+
+
+static char *
+qcrypto_secret_prop_get_data(Object *obj,
+                             Error **errp)
+{
+    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    return g_strdup(secret->data);
+}
+
+
+static void
+qcrypto_secret_prop_set_file(Object *obj,
+                             const char *value,
+                             Error **errp)
+{
+    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+
+    g_free(secret->file);
+    secret->file = g_strdup(value);
+}
+
+
+static char *
+qcrypto_secret_prop_get_file(Object *obj,
+                             Error **errp)
+{
+    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    return g_strdup(secret->file);
+}
+
+
+static void
+qcrypto_secret_complete(UserCreatable *uc, Error **errp)
+{
+    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+}
+
+
+static void
+qcrypto_secret_finalize(Object *obj)
+{
+    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+
+    g_free(secret->file);
+    g_free(secret->data);
+}
+
+static void
+qcrypto_secret_class_init(ObjectClass *oc, void *data)
+{
+    QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
+    sic->load_data = qcrypto_secret_load_data;
+
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    ucc->complete = qcrypto_secret_complete;
+
+    object_class_property_add_str(oc, "data",
+                                  qcrypto_secret_prop_get_data,
+                                  qcrypto_secret_prop_set_data,
+                                  NULL);
+    object_class_property_add_str(oc, "file",
+                                  qcrypto_secret_prop_get_file,
+                                  qcrypto_secret_prop_set_file,
+                                  NULL);
+}
+
+
+static const TypeInfo qcrypto_secret_info = {
+    .parent = TYPE_QCRYPTO_SECRET_COMMON,
+    .name = TYPE_QCRYPTO_SECRET,
+    .instance_size = sizeof(QCryptoSecret),
+    .instance_finalize = qcrypto_secret_finalize,
+    .class_size = sizeof(QCryptoSecretClass),
+    .class_init = qcrypto_secret_class_init,
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
diff --git a/include/crypto/secret.h b/include/crypto/secret.h
new file mode 100644
index 0000000000..2ce8dcc24f
--- /dev/null
+++ b/include/crypto/secret.h
@@ -0,0 +1,133 @@
+/*
+ * QEMU crypto secret support
+ *
+ * Copyright (c) 2015 Red Hat, Inc.
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
+#ifndef QCRYPTO_SECRET_H
+#define QCRYPTO_SECRET_H
+
+#include "qapi/qapi-types-crypto.h"
+#include "qom/object.h"
+#include "crypto/secret_interface.h"
+
+#define TYPE_QCRYPTO_SECRET "secret"
+#define QCRYPTO_SECRET(obj) \
+    OBJECT_CHECK(QCryptoSecret, (obj), TYPE_QCRYPTO_SECRET)
+
+typedef struct QCryptoSecret QCryptoSecret;
+typedef struct QCryptoSecretClass QCryptoSecretClass;
+
+/**
+ * QCryptoSecret:
+ *
+ * The QCryptoSecret object provides storage of secrets,
+ * which may be user passwords, encryption keys or any
+ * other kind of sensitive data that is represented as
+ * a sequence of bytes.
+ *
+ * The sensitive data associated with the secret can
+ * be provided directly via the 'data' property, or
+ * indirectly via the 'file' property. In the latter
+ * case there is support for file descriptor passing
+ * via the usual /dev/fdset/NN syntax that QEMU uses.
+ *
+ * The data for a secret can be provided in two formats,
+ * either as a UTF-8 string (the default), or as base64
+ * encoded 8-bit binary data. The latter is appropriate
+ * for raw encryption keys, while the former is appropriate
+ * for user entered passwords.
+ *
+ * The data may be optionally encrypted with AES-256-CBC,
+ * and the decryption key provided by another
+ * QCryptoSecret instance identified by the 'keyid'
+ * property. When passing sensitive data directly
+ * via the 'data' property it is strongly recommended
+ * to use the AES encryption facility to prevent the
+ * sensitive data being exposed in the process listing
+ * or system log files.
+ *
+ * Providing data directly, insecurely (suitable for
+ * ad hoc developer testing only)
+ *
+ *  $QEMU -object secret,id=sec0,data=letmein
+ *
+ * Providing data indirectly:
+ *
+ *  # printf "letmein" > password.txt
+ *  # $QEMU \
+ *      -object secret,id=sec0,file=password.txt
+ *
+ * Using a master encryption key with data.
+ *
+ * The master key needs to be created as 32 secure
+ * random bytes (optionally base64 encoded)
+ *
+ *  # openssl rand -base64 32 > key.b64
+ *  # KEY=$(base64 -d key.b64 | hexdump  -v -e '/1 "%02X"')
+ *
+ * Each secret to be encrypted needs to have a random
+ * initialization vector generated. These do not need
+ * to be kept secret
+ *
+ *  # openssl rand -base64 16 > iv.b64
+ *  # IV=$(base64 -d iv.b64 | hexdump  -v -e '/1 "%02X"')
+ *
+ * A secret to be defined can now be encrypted
+ *
+ *  # SECRET=$(printf "letmein" |
+ *             openssl enc -aes-256-cbc -a -K $KEY -iv $IV)
+ *
+ * When launching QEMU, create a master secret pointing
+ * to key.b64 and specify that to be used to decrypt
+ * the user password
+ *
+ *  # $QEMU \
+ *      -object secret,id=secmaster0,format=base64,file=key.b64 \
+ *      -object secret,id=sec0,keyid=secmaster0,format=base64,\
+ *          data=$SECRET,iv=$(<iv.b64)
+ *
+ * When encrypting, the data can still be provided via an
+ * external file, in which case it is possible to use either
+ * raw binary data, or base64 encoded. This example uses
+ * raw format
+ *
+ *  # printf "letmein" |
+ *       openssl enc -aes-256-cbc -K $KEY -iv $IV -o pw.aes
+ *  # $QEMU \
+ *      -object secret,id=secmaster0,format=base64,file=key.b64 \
+ *      -object secret,id=sec0,keyid=secmaster0,\
+ *          file=pw.aes,iv=$(<iv.b64)
+ *
+ * Note that the ciphertext can be in either raw or base64
+ * format, as indicated by the 'format' parameter, but the
+ * plaintext resulting from decryption is expected to always
+ * be in raw format.
+ */
+
+struct QCryptoSecret {
+    QCryptoSecretCommon parent_obj;
+    char *data;
+    char *file;
+};
+
+
+struct QCryptoSecretClass {
+    QCryptoSecretCommonClass parent_class;
+};
+
+#endif /* QCRYPTO_SECRET_H */
-- 
2.17.1


