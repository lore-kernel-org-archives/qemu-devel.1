Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BC0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8176E20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7kXShI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8176E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecOF-00089Q-B3
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecN0-000783-71
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39847
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jecMx-0004wE-J9
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590748565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSy78qr6Oe6o0jCPl0NKq4EI77Wz8aKk46+Qn6KdhTY=;
 b=V7kXShI0DhulPuGZaWSi6YeG4KARv4qRemKOubmTOVDOmOm7KaA5P0VtlnWRxS/uMHxo9+
 O6SJolMnSe4mPvWLMG5iCfJz1ESbfBLENc6nnwFg3jUOTzM0zl198T6NXoDyvdVxAH7AoE
 kUujWMllD7CtokXLIB1b2rl1ddOegPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-d1ETigbiNi-YjpBQK2rviA-1; Fri, 29 May 2020 06:36:02 -0400
X-MC-Unique: d1ETigbiNi-YjpBQK2rviA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 055BD1855A15;
 Fri, 29 May 2020 10:36:02 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DC4B1A7C8;
 Fri, 29 May 2020 10:36:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] crypto/secret: move main logic from 'secret' to
 'secret_common'.
Date: Fri, 29 May 2020 11:35:52 +0100
Message-Id: <20200529103555.2759928-3-berrange@redhat.com>
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

Create base class 'common secret'. Move common data and logic from
'secret' to 'common_secret' class. This allowed adding abstraction layer
for easier adding new 'secret' objects in future.
Convert 'secret' class to child from basic 'secret_common' with 'data'
and 'file' properties.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/Makefile.objs           |   1 +
 crypto/secret.c                | 347 +---------------------------
 crypto/secret_common.c         | 403 +++++++++++++++++++++++++++++++++
 include/crypto/secret.h        |  20 +-
 include/crypto/secret_common.h |  68 ++++++
 5 files changed, 482 insertions(+), 357 deletions(-)
 create mode 100644 crypto/secret_common.c
 create mode 100644 include/crypto/secret_common.h

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index cdee92b4e5..110dec1b87 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -18,6 +18,7 @@ crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredspsk.o
 crypto-obj-y += tlscredsx509.o
 crypto-obj-y += tlssession.o
+crypto-obj-y += secret_common.o
 crypto-obj-y += secret.o
 crypto-obj-y += pbkdf.o
 crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
diff --git a/crypto/secret.c b/crypto/secret.c
index 3107aecb47..3447e2f64b 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -20,16 +20,14 @@
 
 #include "qemu/osdep.h"
 #include "crypto/secret.h"
-#include "crypto/cipher.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "qemu/base64.h"
 #include "qemu/module.h"
 #include "trace.h"
 
 
 static void
-qcrypto_secret_load_data(QCryptoSecret *secret,
+qcrypto_secret_load_data(QCryptoSecretCommon *sec_common,
                          uint8_t **output,
                          size_t *outputlen,
                          Error **errp)
@@ -38,6 +36,8 @@ qcrypto_secret_load_data(QCryptoSecret *secret,
     size_t length = 0;
     GError *gerr = NULL;
 
+    QCryptoSecret *secret = QCRYPTO_SECRET(sec_common);
+
     *output = NULL;
     *outputlen = 0;
 
@@ -65,198 +65,6 @@ qcrypto_secret_load_data(QCryptoSecret *secret,
 }
 
 
-static void qcrypto_secret_decrypt(QCryptoSecret *secret,
-                                   const uint8_t *input,
-                                   size_t inputlen,
-                                   uint8_t **output,
-                                   size_t *outputlen,
-                                   Error **errp)
-{
-    g_autofree uint8_t *key = NULL;
-    g_autofree uint8_t *ciphertext = NULL;
-    g_autofree uint8_t *iv = NULL;
-    size_t keylen, ciphertextlen, ivlen;
-    g_autoptr(QCryptoCipher) aes = NULL;
-    g_autofree uint8_t *plaintext = NULL;
-
-    *output = NULL;
-    *outputlen = 0;
-
-    if (qcrypto_secret_lookup(secret->keyid,
-                              &key, &keylen,
-                              errp) < 0) {
-        return;
-    }
-
-    if (keylen != 32) {
-        error_setg(errp, "Key should be 32 bytes in length");
-        return;
-    }
-
-    if (!secret->iv) {
-        error_setg(errp, "IV is required to decrypt secret");
-        return;
-    }
-
-    iv = qbase64_decode(secret->iv, -1, &ivlen, errp);
-    if (!iv) {
-        return;
-    }
-    if (ivlen != 16) {
-        error_setg(errp, "IV should be 16 bytes in length not %zu",
-                   ivlen);
-        return;
-    }
-
-    aes = qcrypto_cipher_new(QCRYPTO_CIPHER_ALG_AES_256,
-                             QCRYPTO_CIPHER_MODE_CBC,
-                             key, keylen,
-                             errp);
-    if (!aes) {
-        return;
-    }
-
-    if (qcrypto_cipher_setiv(aes, iv, ivlen, errp) < 0) {
-        return;
-    }
-
-    if (secret->format == QCRYPTO_SECRET_FORMAT_BASE64) {
-        ciphertext = qbase64_decode((const gchar*)input,
-                                    inputlen,
-                                    &ciphertextlen,
-                                    errp);
-        if (!ciphertext) {
-            return;
-        }
-        plaintext = g_new0(uint8_t, ciphertextlen + 1);
-    } else {
-        ciphertextlen = inputlen;
-        plaintext = g_new0(uint8_t, inputlen + 1);
-    }
-    if (qcrypto_cipher_decrypt(aes,
-                               ciphertext ? ciphertext : input,
-                               plaintext,
-                               ciphertextlen,
-                               errp) < 0) {
-        return;
-    }
-
-    if (plaintext[ciphertextlen - 1] > 16 ||
-        plaintext[ciphertextlen - 1] > ciphertextlen) {
-        error_setg(errp, "Incorrect number of padding bytes (%d) "
-                   "found on decrypted data",
-                   (int)plaintext[ciphertextlen - 1]);
-        return;
-    }
-
-    /* Even though plaintext may contain arbitrary NUL
-     * ensure it is explicitly NUL terminated.
-     */
-    ciphertextlen -= plaintext[ciphertextlen - 1];
-    plaintext[ciphertextlen] = '\0';
-
-    *output = g_steal_pointer(&plaintext);
-    *outputlen = ciphertextlen;
-}
-
-
-static void qcrypto_secret_decode(const uint8_t *input,
-                                  size_t inputlen,
-                                  uint8_t **output,
-                                  size_t *outputlen,
-                                  Error **errp)
-{
-    *output = qbase64_decode((const gchar*)input,
-                             inputlen,
-                             outputlen,
-                             errp);
-}
-
-
-static void
-qcrypto_secret_prop_set_loaded(Object *obj,
-                               bool value,
-                               Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-
-    if (value) {
-        Error *local_err = NULL;
-        uint8_t *input = NULL;
-        size_t inputlen = 0;
-        uint8_t *output = NULL;
-        size_t outputlen = 0;
-
-        qcrypto_secret_load_data(secret, &input, &inputlen, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-
-        if (secret->keyid) {
-            qcrypto_secret_decrypt(secret, input, inputlen,
-                                   &output, &outputlen, &local_err);
-            g_free(input);
-            if (local_err) {
-                error_propagate(errp, local_err);
-                return;
-            }
-            input = output;
-            inputlen = outputlen;
-        } else {
-            if (secret->format == QCRYPTO_SECRET_FORMAT_BASE64) {
-                qcrypto_secret_decode(input, inputlen,
-                                      &output, &outputlen, &local_err);
-                g_free(input);
-                if (local_err) {
-                    error_propagate(errp, local_err);
-                    return;
-                }
-                input = output;
-                inputlen = outputlen;
-            }
-        }
-
-        secret->rawdata = input;
-        secret->rawlen = inputlen;
-    } else {
-        g_free(secret->rawdata);
-        secret->rawdata = NULL;
-        secret->rawlen = 0;
-    }
-}
-
-
-static bool
-qcrypto_secret_prop_get_loaded(Object *obj,
-                               Error **errp G_GNUC_UNUSED)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-    return secret->rawdata != NULL;
-}
-
-
-static void
-qcrypto_secret_prop_set_format(Object *obj,
-                               int value,
-                               Error **errp G_GNUC_UNUSED)
-{
-    QCryptoSecret *creds = QCRYPTO_SECRET(obj);
-
-    creds->format = value;
-}
-
-
-static int
-qcrypto_secret_prop_get_format(Object *obj,
-                               Error **errp G_GNUC_UNUSED)
-{
-    QCryptoSecret *creds = QCRYPTO_SECRET(obj);
-
-    return creds->format;
-}
-
-
 static void
 qcrypto_secret_prop_set_data(Object *obj,
                              const char *value,
@@ -299,48 +107,6 @@ qcrypto_secret_prop_get_file(Object *obj,
 }
 
 
-static void
-qcrypto_secret_prop_set_iv(Object *obj,
-                           const char *value,
-                           Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-
-    g_free(secret->iv);
-    secret->iv = g_strdup(value);
-}
-
-
-static char *
-qcrypto_secret_prop_get_iv(Object *obj,
-                           Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-    return g_strdup(secret->iv);
-}
-
-
-static void
-qcrypto_secret_prop_set_keyid(Object *obj,
-                              const char *value,
-                              Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-
-    g_free(secret->keyid);
-    secret->keyid = g_strdup(value);
-}
-
-
-static char *
-qcrypto_secret_prop_get_keyid(Object *obj,
-                              Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-    return g_strdup(secret->keyid);
-}
-
-
 static void
 qcrypto_secret_complete(UserCreatable *uc, Error **errp)
 {
@@ -353,129 +119,30 @@ qcrypto_secret_finalize(Object *obj)
 {
     QCryptoSecret *secret = QCRYPTO_SECRET(obj);
 
-    g_free(secret->iv);
     g_free(secret->file);
-    g_free(secret->keyid);
-    g_free(secret->rawdata);
     g_free(secret->data);
 }
 
 static void
 qcrypto_secret_class_init(ObjectClass *oc, void *data)
 {
-    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
+    sic->load_data = qcrypto_secret_load_data;
 
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
     ucc->complete = qcrypto_secret_complete;
 
-    object_class_property_add_bool(oc, "loaded",
-                                   qcrypto_secret_prop_get_loaded,
-                                   qcrypto_secret_prop_set_loaded);
-    object_class_property_add_enum(oc, "format",
-                                   "QCryptoSecretFormat",
-                                   &QCryptoSecretFormat_lookup,
-                                   qcrypto_secret_prop_get_format,
-                                   qcrypto_secret_prop_set_format);
     object_class_property_add_str(oc, "data",
                                   qcrypto_secret_prop_get_data,
                                   qcrypto_secret_prop_set_data);
     object_class_property_add_str(oc, "file",
                                   qcrypto_secret_prop_get_file,
                                   qcrypto_secret_prop_set_file);
-    object_class_property_add_str(oc, "keyid",
-                                  qcrypto_secret_prop_get_keyid,
-                                  qcrypto_secret_prop_set_keyid);
-    object_class_property_add_str(oc, "iv",
-                                  qcrypto_secret_prop_get_iv,
-                                  qcrypto_secret_prop_set_iv);
-}
-
-
-int qcrypto_secret_lookup(const char *secretid,
-                          uint8_t **data,
-                          size_t *datalen,
-                          Error **errp)
-{
-    Object *obj;
-    QCryptoSecret *secret;
-
-    obj = object_resolve_path_component(
-        object_get_objects_root(), secretid);
-    if (!obj) {
-        error_setg(errp, "No secret with id '%s'", secretid);
-        return -1;
-    }
-
-    secret = (QCryptoSecret *)
-        object_dynamic_cast(obj,
-                            TYPE_QCRYPTO_SECRET);
-    if (!secret) {
-        error_setg(errp, "Object with id '%s' is not a secret",
-                   secretid);
-        return -1;
-    }
-
-    if (!secret->rawdata) {
-        error_setg(errp, "Secret with id '%s' has no data",
-                   secretid);
-        return -1;
-    }
-
-    *data = g_new0(uint8_t, secret->rawlen + 1);
-    memcpy(*data, secret->rawdata, secret->rawlen);
-    (*data)[secret->rawlen] = '\0';
-    *datalen = secret->rawlen;
-
-    return 0;
-}
-
-
-char *qcrypto_secret_lookup_as_utf8(const char *secretid,
-                                    Error **errp)
-{
-    uint8_t *data;
-    size_t datalen;
-
-    if (qcrypto_secret_lookup(secretid,
-                              &data,
-                              &datalen,
-                              errp) < 0) {
-        return NULL;
-    }
-
-    if (!g_utf8_validate((const gchar*)data, datalen, NULL)) {
-        error_setg(errp,
-                   "Data from secret %s is not valid UTF-8",
-                   secretid);
-        g_free(data);
-        return NULL;
-    }
-
-    return (char *)data;
-}
-
-
-char *qcrypto_secret_lookup_as_base64(const char *secretid,
-                                      Error **errp)
-{
-    uint8_t *data;
-    size_t datalen;
-    char *ret;
-
-    if (qcrypto_secret_lookup(secretid,
-                              &data,
-                              &datalen,
-                              errp) < 0) {
-        return NULL;
-    }
-
-    ret = g_base64_encode(data, datalen);
-    g_free(data);
-    return ret;
 }
 
 
 static const TypeInfo qcrypto_secret_info = {
-    .parent = TYPE_OBJECT,
+    .parent = TYPE_QCRYPTO_SECRET_COMMON,
     .name = TYPE_QCRYPTO_SECRET,
     .instance_size = sizeof(QCryptoSecret),
     .instance_finalize = qcrypto_secret_finalize,
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
new file mode 100644
index 0000000000..b03d530867
--- /dev/null
+++ b/crypto/secret_common.c
@@ -0,0 +1,403 @@
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
+#include "crypto/secret_common.h"
+#include "crypto/cipher.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qemu/base64.h"
+#include "qemu/module.h"
+#include "trace.h"
+
+
+static void qcrypto_secret_decrypt(QCryptoSecretCommon *secret,
+                                   const uint8_t *input,
+                                   size_t inputlen,
+                                   uint8_t **output,
+                                   size_t *outputlen,
+                                   Error **errp)
+{
+    g_autofree uint8_t *iv = NULL;
+    g_autofree uint8_t *key = NULL;
+    g_autofree uint8_t *ciphertext = NULL;
+    size_t keylen, ciphertextlen, ivlen;
+    g_autoptr(QCryptoCipher) aes = NULL;
+    g_autofree uint8_t *plaintext = NULL;
+
+    *output = NULL;
+    *outputlen = 0;
+
+    if (qcrypto_secret_lookup(secret->keyid,
+                              &key, &keylen,
+                              errp) < 0) {
+        return;
+    }
+
+    if (keylen != 32) {
+        error_setg(errp, "Key should be 32 bytes in length");
+        return;
+    }
+
+    if (!secret->iv) {
+        error_setg(errp, "IV is required to decrypt secret");
+        return;
+    }
+
+    iv = qbase64_decode(secret->iv, -1, &ivlen, errp);
+    if (!iv) {
+        return;
+    }
+    if (ivlen != 16) {
+        error_setg(errp, "IV should be 16 bytes in length not %zu",
+                   ivlen);
+        return;
+    }
+
+    aes = qcrypto_cipher_new(QCRYPTO_CIPHER_ALG_AES_256,
+                             QCRYPTO_CIPHER_MODE_CBC,
+                             key, keylen,
+                             errp);
+    if (!aes) {
+        return;
+    }
+
+    if (qcrypto_cipher_setiv(aes, iv, ivlen, errp) < 0) {
+        return;
+    }
+
+    if (secret->format == QCRYPTO_SECRET_FORMAT_BASE64) {
+        ciphertext = qbase64_decode((const gchar *)input,
+                                    inputlen,
+                                    &ciphertextlen,
+                                    errp);
+        if (!ciphertext) {
+            return;
+        }
+        plaintext = g_new0(uint8_t, ciphertextlen + 1);
+    } else {
+        ciphertextlen = inputlen;
+        plaintext = g_new0(uint8_t, inputlen + 1);
+    }
+    if (qcrypto_cipher_decrypt(aes,
+                               ciphertext ? ciphertext : input,
+                               plaintext,
+                               ciphertextlen,
+                               errp) < 0) {
+        return;
+    }
+
+    if (plaintext[ciphertextlen - 1] > 16 ||
+        plaintext[ciphertextlen - 1] > ciphertextlen) {
+        error_setg(errp, "Incorrect number of padding bytes (%d) "
+                   "found on decrypted data",
+                   (int)plaintext[ciphertextlen - 1]);
+        return;
+    }
+
+    /*
+     *  Even though plaintext may contain arbitrary NUL
+     * ensure it is explicitly NUL terminated.
+     */
+    ciphertextlen -= plaintext[ciphertextlen - 1];
+    plaintext[ciphertextlen] = '\0';
+
+    *output = g_steal_pointer(&plaintext);
+    *outputlen = ciphertextlen;
+}
+
+
+static void qcrypto_secret_decode(const uint8_t *input,
+                                  size_t inputlen,
+                                  uint8_t **output,
+                                  size_t *outputlen,
+                                  Error **errp)
+{
+    *output = qbase64_decode((const gchar *)input,
+                             inputlen,
+                             outputlen,
+                             errp);
+}
+
+
+static void
+qcrypto_secret_prop_set_loaded(Object *obj,
+                               bool value,
+                               Error **errp)
+{
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
+    QCryptoSecretCommonClass *sec_class
+                                = QCRYPTO_SECRET_COMMON_GET_CLASS(obj);
+
+    if (value) {
+        Error *local_err = NULL;
+        uint8_t *input = NULL;
+        size_t inputlen = 0;
+        uint8_t *output = NULL;
+        size_t outputlen = 0;
+
+        if (sec_class->load_data) {
+            sec_class->load_data(secret, &input, &inputlen, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        } else {
+            error_setg(errp, "%s provides no 'load_data' method'",
+                             object_get_typename(obj));
+            return;
+        }
+
+        if (secret->keyid) {
+            qcrypto_secret_decrypt(secret, input, inputlen,
+                                   &output, &outputlen, &local_err);
+            g_free(input);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+            input = output;
+            inputlen = outputlen;
+        } else {
+            if (secret->format == QCRYPTO_SECRET_FORMAT_BASE64) {
+                qcrypto_secret_decode(input, inputlen,
+                                      &output, &outputlen, &local_err);
+                g_free(input);
+                if (local_err) {
+                    error_propagate(errp, local_err);
+                    return;
+                }
+                input = output;
+                inputlen = outputlen;
+            }
+        }
+
+        secret->rawdata = input;
+        secret->rawlen = inputlen;
+    } else {
+        g_free(secret->rawdata);
+        secret->rawlen = 0;
+    }
+}
+
+
+static bool
+qcrypto_secret_prop_get_loaded(Object *obj,
+                               Error **errp G_GNUC_UNUSED)
+{
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
+    return secret->rawdata != NULL;
+}
+
+
+static void
+qcrypto_secret_prop_set_format(Object *obj,
+                               int value,
+                               Error **errp G_GNUC_UNUSED)
+{
+    QCryptoSecretCommon *creds = QCRYPTO_SECRET_COMMON(obj);
+    creds->format = value;
+}
+
+
+static int
+qcrypto_secret_prop_get_format(Object *obj,
+                               Error **errp G_GNUC_UNUSED)
+{
+    QCryptoSecretCommon *creds = QCRYPTO_SECRET_COMMON(obj);
+    return creds->format;
+}
+
+
+static void
+qcrypto_secret_prop_set_iv(Object *obj,
+                           const char *value,
+                           Error **errp)
+{
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
+
+    g_free(secret->iv);
+    secret->iv = g_strdup(value);
+}
+
+
+static char *
+qcrypto_secret_prop_get_iv(Object *obj,
+                           Error **errp)
+{
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
+    return g_strdup(secret->iv);
+}
+
+
+static void
+qcrypto_secret_prop_set_keyid(Object *obj,
+                              const char *value,
+                              Error **errp)
+{
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
+
+    g_free(secret->keyid);
+    secret->keyid = g_strdup(value);
+}
+
+
+static char *
+qcrypto_secret_prop_get_keyid(Object *obj,
+                              Error **errp)
+{
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
+    return g_strdup(secret->keyid);
+}
+
+
+static void
+qcrypto_secret_finalize(Object *obj)
+{
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
+
+    g_free(secret->iv);
+    g_free(secret->keyid);
+    g_free(secret->rawdata);
+}
+
+static void
+qcrypto_secret_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_bool(oc, "loaded",
+                                   qcrypto_secret_prop_get_loaded,
+                                   qcrypto_secret_prop_set_loaded);
+    object_class_property_add_enum(oc, "format",
+                                   "QCryptoSecretFormat",
+                                   &QCryptoSecretFormat_lookup,
+                                   qcrypto_secret_prop_get_format,
+                                   qcrypto_secret_prop_set_format);
+    object_class_property_add_str(oc, "keyid",
+                                  qcrypto_secret_prop_get_keyid,
+                                  qcrypto_secret_prop_set_keyid);
+    object_class_property_add_str(oc, "iv",
+                                  qcrypto_secret_prop_get_iv,
+                                  qcrypto_secret_prop_set_iv);
+}
+
+
+int qcrypto_secret_lookup(const char *secretid,
+                          uint8_t **data,
+                          size_t *datalen,
+                          Error **errp)
+{
+    Object *obj;
+    QCryptoSecretCommon *secret;
+
+    obj = object_resolve_path_component(
+        object_get_objects_root(), secretid);
+    if (!obj) {
+        error_setg(errp, "No secret with id '%s'", secretid);
+        return -1;
+    }
+
+    secret = (QCryptoSecretCommon *)
+        object_dynamic_cast(obj,
+                            TYPE_QCRYPTO_SECRET_COMMON);
+    if (!secret) {
+        error_setg(errp, "Object with id '%s' is not a secret",
+                   secretid);
+        return -1;
+    }
+
+    if (!secret->rawdata) {
+        error_setg(errp, "Secret with id '%s' has no data",
+                   secretid);
+        return -1;
+    }
+
+    *data = g_new0(uint8_t, secret->rawlen + 1);
+    memcpy(*data, secret->rawdata, secret->rawlen);
+    (*data)[secret->rawlen] = '\0';
+    *datalen = secret->rawlen;
+
+    return 0;
+}
+
+
+char *qcrypto_secret_lookup_as_utf8(const char *secretid,
+                                    Error **errp)
+{
+    uint8_t *data;
+    size_t datalen;
+
+    if (qcrypto_secret_lookup(secretid,
+                              &data,
+                              &datalen,
+                              errp) < 0) {
+        return NULL;
+    }
+
+    if (!g_utf8_validate((const gchar *)data, datalen, NULL)) {
+        error_setg(errp,
+                   "Data from secret %s is not valid UTF-8",
+                   secretid);
+        g_free(data);
+        return NULL;
+    }
+
+    return (char *)data;
+}
+
+
+char *qcrypto_secret_lookup_as_base64(const char *secretid,
+                                      Error **errp)
+{
+    uint8_t *data;
+    size_t datalen;
+    char *ret;
+
+    if (qcrypto_secret_lookup(secretid,
+                              &data,
+                              &datalen,
+                              errp) < 0) {
+        return NULL;
+    }
+
+    ret = g_base64_encode(data, datalen);
+    g_free(data);
+    return ret;
+}
+
+
+static const TypeInfo qcrypto_secret_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_QCRYPTO_SECRET_COMMON,
+    .instance_size = sizeof(QCryptoSecretCommon),
+    .instance_finalize = qcrypto_secret_finalize,
+    .class_size = sizeof(QCryptoSecretCommonClass),
+    .class_init = qcrypto_secret_class_init,
+    .abstract = true,
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
index 5e07e29bae..2deb461d2f 100644
--- a/include/crypto/secret.h
+++ b/include/crypto/secret.h
@@ -23,6 +23,7 @@
 
 #include "qapi/qapi-types-crypto.h"
 #include "qom/object.h"
+#include "crypto/secret_common.h"
 
 #define TYPE_QCRYPTO_SECRET "secret"
 #define QCRYPTO_SECRET(obj)                  \
@@ -119,29 +120,14 @@ typedef struct QCryptoSecretClass QCryptoSecretClass;
  */
 
 struct QCryptoSecret {
-    Object parent_obj;
-    uint8_t *rawdata;
-    size_t rawlen;
-    QCryptoSecretFormat format;
+    QCryptoSecretCommon parent_obj;
     char *data;
     char *file;
-    char *keyid;
-    char *iv;
 };
 
 
 struct QCryptoSecretClass {
-    ObjectClass parent_class;
+    QCryptoSecretCommonClass parent_class;
 };
 
-
-extern int qcrypto_secret_lookup(const char *secretid,
-                                 uint8_t **data,
-                                 size_t *datalen,
-                                 Error **errp);
-extern char *qcrypto_secret_lookup_as_utf8(const char *secretid,
-                                           Error **errp);
-extern char *qcrypto_secret_lookup_as_base64(const char *secretid,
-                                             Error **errp);
-
 #endif /* QCRYPTO_SECRET_H */
diff --git a/include/crypto/secret_common.h b/include/crypto/secret_common.h
new file mode 100644
index 0000000000..980c02ab71
--- /dev/null
+++ b/include/crypto/secret_common.h
@@ -0,0 +1,68 @@
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
+#ifndef QCRYPTO_SECRET_COMMON_H
+#define QCRYPTO_SECRET_COMMON_H
+
+#include "qapi/qapi-types-crypto.h"
+#include "qom/object.h"
+
+#define TYPE_QCRYPTO_SECRET_COMMON "secret_common"
+#define QCRYPTO_SECRET_COMMON(obj) \
+    OBJECT_CHECK(QCryptoSecretCommon, (obj), TYPE_QCRYPTO_SECRET_COMMON)
+#define QCRYPTO_SECRET_COMMON_CLASS(class) \
+    OBJECT_CLASS_CHECK(QCryptoSecretCommonClass, \
+                       (class), TYPE_QCRYPTO_SECRET_COMMON)
+#define QCRYPTO_SECRET_COMMON_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(QCryptoSecretCommonClass, \
+                     (obj), TYPE_QCRYPTO_SECRET_COMMON)
+
+typedef struct QCryptoSecretCommon QCryptoSecretCommon;
+typedef struct QCryptoSecretCommonClass QCryptoSecretCommonClass;
+
+struct QCryptoSecretCommon {
+    Object parent_obj;
+    uint8_t *rawdata;
+    size_t rawlen;
+    QCryptoSecretFormat format;
+    char *keyid;
+    char *iv;
+};
+
+
+struct QCryptoSecretCommonClass {
+    ObjectClass parent_class;
+    void (*load_data)(QCryptoSecretCommon *secret,
+                      uint8_t **output,
+                      size_t *outputlen,
+                      Error **errp);
+};
+
+
+extern int qcrypto_secret_lookup(const char *secretid,
+                                 uint8_t **data,
+                                 size_t *datalen,
+                                 Error **errp);
+extern char *qcrypto_secret_lookup_as_utf8(const char *secretid,
+                                           Error **errp);
+extern char *qcrypto_secret_lookup_as_base64(const char *secretid,
+                                             Error **errp);
+
+#endif /* QCRYPTO_SECRET_COMMON_H */
-- 
2.26.2


