Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F96C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC108206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 22:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="0jgMiYRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC108206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOqW0-0007XK-5n
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 18:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTZ-0003rp-Qv
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex-krasikov@yandex-team.ru>) id 1jOqTX-0003ta-Ng
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:45 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:43346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex-krasikov@yandex-team.ru>)
 id 1jOqTX-0003rj-CA
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 18:25:43 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id DC3B92E09F4;
 Thu, 16 Apr 2020 01:25:36 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 sDhv2LGrOW-PYnOQ2jF; Thu, 16 Apr 2020 01:25:36 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1586989536; bh=CvKhEIs1qkRBDGxFHE+n4hSswawaMqWf+pb7pBG9vbE=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=0jgMiYRsFZja9AIE46qLG5z3MeD20n9n8ZpuTloFU6FnQnyFmeaFnVqruv6AmYW86
 SFbujOrlFMeQ0aMNKKG/ptf8RsVfSW4v4ws2A5vVlH7Kc29fCDwKUNuULv7p66NYK8
 fFVwphNzPzEGYB9zr3wng6SaVfOpRH0IvgxtWATA=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6410::1:e])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 0wmBaV4yMk-PYXapb54; Thu, 16 Apr 2020 01:25:34 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v2 2/5] crypto/secret_interface: conversion to common
 basic class.
Date: Thu, 16 Apr 2020 01:25:22 +0300
Message-Id: <20200415222525.4022-2-alex-krasikov@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
References: <20200415222525.4022-1-alex-krasikov@yandex-team.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
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

* Remove individual option fields. Common field have been left.

Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
---
 crypto/Makefile.objs              |   1 +
 crypto/secret_interface.c         | 156 ++++++------------------------
 include/crypto/secret_interface.h | 119 ++++-------------------
 3 files changed, 51 insertions(+), 225 deletions(-)

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index c2a371b0b4..3ae0dfd1a4 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -18,6 +18,7 @@ crypto-obj-y += tlscredsanon.o
 crypto-obj-y += tlscredspsk.o
 crypto-obj-y += tlscredsx509.o
 crypto-obj-y += tlssession.o
+crypto-obj-y += secret_interface.o
 crypto-obj-y += secret.o
 crypto-obj-y += pbkdf.o
 crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
diff --git a/crypto/secret_interface.c b/crypto/secret_interface.c
index 1cf0ad0ce8..9d8accdea3 100644
--- a/crypto/secret_interface.c
+++ b/crypto/secret_interface.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "crypto/secret.h"
+#include "crypto/secret_interface.h"
 #include "crypto/cipher.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
@@ -28,44 +28,7 @@
 #include "trace.h"
 
 
-static void
-qcrypto_secret_load_data(QCryptoSecret *secret,
-                         uint8_t **output,
-                         size_t *outputlen,
-                         Error **errp)
-{
-    char *data = NULL;
-    size_t length = 0;
-    GError *gerr = NULL;
-
-    *output = NULL;
-    *outputlen = 0;
-
-    if (secret->file) {
-        if (secret->data) {
-            error_setg(errp,
-                       "'file' and 'data' are mutually exclusive");
-            return;
-        }
-        if (!g_file_get_contents(secret->file, &data, &length, &gerr)) {
-            error_setg(errp,
-                       "Unable to read %s: %s",
-                       secret->file, gerr->message);
-            g_error_free(gerr);
-            return;
-        }
-        *output = (uint8_t *)data;
-        *outputlen = length;
-    } else if (secret->data) {
-        *outputlen = strlen(secret->data);
-        *output = (uint8_t *)g_strdup(secret->data);
-    } else {
-        error_setg(errp, "Either 'file' or 'data' must be provided");
-    }
-}
-
-
-static void qcrypto_secret_decrypt(QCryptoSecret *secret,
+static void qcrypto_secret_decrypt(QCryptoSecretCommon *secret,
                                    const uint8_t *input,
                                    size_t inputlen,
                                    uint8_t **output,
@@ -178,7 +141,9 @@ qcrypto_secret_prop_set_loaded(Object *obj,
                                bool value,
                                Error **errp)
 {
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
+    QCryptoSecretCommonClass *sec_class
+                                = QCRYPTO_SECRET_COMMON_GET_CLASS(obj);
 
     if (value) {
         Error *local_err = NULL;
@@ -187,9 +152,14 @@ qcrypto_secret_prop_set_loaded(Object *obj,
         uint8_t *output = NULL;
         size_t outputlen = 0;
 
-        qcrypto_secret_load_data(secret, &input, &inputlen, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (sec_class->load_data) {
+            sec_class->load_data(obj, &input, &inputlen, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        } else {
+            error_setg(errp, "'load_data' metod has not been initiated");
             return;
         }
 
@@ -230,7 +200,7 @@ static bool
 qcrypto_secret_prop_get_loaded(Object *obj,
                                Error **errp G_GNUC_UNUSED)
 {
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
     return secret->data != NULL;
 }
 
@@ -240,7 +210,7 @@ qcrypto_secret_prop_set_format(Object *obj,
                                int value,
                                Error **errp G_GNUC_UNUSED)
 {
-    QCryptoSecret *creds = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *creds = QCRYPTO_SECRET_COMMON(obj);
 
     creds->format = value;
 }
@@ -250,60 +220,18 @@ static int
 qcrypto_secret_prop_get_format(Object *obj,
                                Error **errp G_GNUC_UNUSED)
 {
-    QCryptoSecret *creds = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *creds = QCRYPTO_SECRET_COMMON(obj);
 
     return creds->format;
 }
 
 
-static void
-qcrypto_secret_prop_set_data(Object *obj,
-                             const char *value,
-                             Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-
-    g_free(secret->data);
-    secret->data = g_strdup(value);
-}
-
-
-static char *
-qcrypto_secret_prop_get_data(Object *obj,
-                             Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-    return g_strdup(secret->data);
-}
-
-
-static void
-qcrypto_secret_prop_set_file(Object *obj,
-                             const char *value,
-                             Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-
-    g_free(secret->file);
-    secret->file = g_strdup(value);
-}
-
-
-static char *
-qcrypto_secret_prop_get_file(Object *obj,
-                             Error **errp)
-{
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-    return g_strdup(secret->file);
-}
-
-
 static void
 qcrypto_secret_prop_set_iv(Object *obj,
                            const char *value,
                            Error **errp)
 {
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
 
     g_free(secret->iv);
     secret->iv = g_strdup(value);
@@ -314,7 +242,7 @@ static char *
 qcrypto_secret_prop_get_iv(Object *obj,
                            Error **errp)
 {
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
     return g_strdup(secret->iv);
 }
 
@@ -324,7 +252,7 @@ qcrypto_secret_prop_set_keyid(Object *obj,
                               const char *value,
                               Error **errp)
 {
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
 
     g_free(secret->keyid);
     secret->keyid = g_strdup(value);
@@ -335,37 +263,24 @@ static char *
 qcrypto_secret_prop_get_keyid(Object *obj,
                               Error **errp)
 {
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
     return g_strdup(secret->keyid);
 }
 
 
-static void
-qcrypto_secret_complete(UserCreatable *uc, Error **errp)
-{
-    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
-}
-
-
 static void
 qcrypto_secret_finalize(Object *obj)
 {
-    QCryptoSecret *secret = QCRYPTO_SECRET(obj);
+    QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
 
     g_free(secret->iv);
-    g_free(secret->file);
     g_free(secret->keyid);
     g_free(secret->rawdata);
-    g_free(secret->data);
 }
 
 static void
 qcrypto_secret_class_init(ObjectClass *oc, void *data)
 {
-    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
-
-    ucc->complete = qcrypto_secret_complete;
-
     object_class_property_add_bool(oc, "loaded",
                                    qcrypto_secret_prop_get_loaded,
                                    qcrypto_secret_prop_set_loaded,
@@ -376,14 +291,6 @@ qcrypto_secret_class_init(ObjectClass *oc, void *data)
                                    qcrypto_secret_prop_get_format,
                                    qcrypto_secret_prop_set_format,
                                    NULL);
-    object_class_property_add_str(oc, "data",
-                                  qcrypto_secret_prop_get_data,
-                                  qcrypto_secret_prop_set_data,
-                                  NULL);
-    object_class_property_add_str(oc, "file",
-                                  qcrypto_secret_prop_get_file,
-                                  qcrypto_secret_prop_set_file,
-                                  NULL);
     object_class_property_add_str(oc, "keyid",
                                   qcrypto_secret_prop_get_keyid,
                                   qcrypto_secret_prop_set_keyid,
@@ -401,7 +308,7 @@ int qcrypto_secret_lookup(const char *secretid,
                           Error **errp)
 {
     Object *obj;
-    QCryptoSecret *secret;
+    QCryptoSecretCommon *secret;
 
     obj = object_resolve_path_component(
         object_get_objects_root(), secretid);
@@ -410,9 +317,9 @@ int qcrypto_secret_lookup(const char *secretid,
         return -1;
     }
 
-    secret = (QCryptoSecret *)
+    secret = (QCryptoSecretCommon *)
         object_dynamic_cast(obj,
-                            TYPE_QCRYPTO_SECRET);
+                            TYPE_QCRYPTO_SECRET_COMMON);
     if (!secret) {
         error_setg(errp, "Object with id '%s' is not a secret",
                    secretid);
@@ -480,16 +387,13 @@ char *qcrypto_secret_lookup_as_base64(const char *secretid,
 
 
 static const TypeInfo qcrypto_secret_info = {
-    .parent = TYPE_OBJECT,
-    .name = TYPE_QCRYPTO_SECRET,
-    .instance_size = sizeof(QCryptoSecret),
+    .parent            = TYPE_OBJECT,
+    .name              = TYPE_QCRYPTO_SECRET_COMMON,
+    .instance_size     = sizeof(QCryptoSecretCommon),
     .instance_finalize = qcrypto_secret_finalize,
-    .class_size = sizeof(QCryptoSecretClass),
-    .class_init = qcrypto_secret_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
+    .class_size        = sizeof(QCryptoSecretCommonClass),
+    .class_init        = qcrypto_secret_class_init,
+    .abstract          = true,
 };
 
 
diff --git a/include/crypto/secret_interface.h b/include/crypto/secret_interface.h
index 5e07e29bae..4cd20503d5 100644
--- a/include/crypto/secret_interface.h
+++ b/include/crypto/secret_interface.h
@@ -18,120 +18,41 @@
  *
  */
 
-#ifndef QCRYPTO_SECRET_H
-#define QCRYPTO_SECRET_H
+#ifndef QCRYPTO_SECRET_COMMON_H
+#define QCRYPTO_SECRET_COMMON_H
 
 #include "qapi/qapi-types-crypto.h"
 #include "qom/object.h"
 
-#define TYPE_QCRYPTO_SECRET "secret"
-#define QCRYPTO_SECRET(obj)                  \
-    OBJECT_CHECK(QCryptoSecret, (obj), TYPE_QCRYPTO_SECRET)
+#define TYPE_QCRYPTO_SECRET_COMMON "secret_common"
+#define QCRYPTO_SECRET_COMMON(obj) \
+    OBJECT_CHECK(QCryptoSecretCommon, (obj), TYPE_QCRYPTO_SECRET_COMMON)
+#define QCRYPTO_SECRET_COMMON_CLASS(class) \
+    OBJECT_CLASS_CHECK(QCryptoSecretCommonClass, \
+                       (class), TYPE_QCRYPTO_SECRET_COMMON)
+#define QCRYPTO_SECRET_COMMON_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(QCryptoSecretCommonClass, \
+                     (obj), TYPE_QCRYPTO_SECRET_COMMON)
 
-typedef struct QCryptoSecret QCryptoSecret;
-typedef struct QCryptoSecretClass QCryptoSecretClass;
+typedef struct QCryptoSecretCommon QCryptoSecretCommon;
+typedef struct QCryptoSecretCommonClass QCryptoSecretCommonClass;
 
-/**
- * QCryptoSecret:
- *
- * The QCryptoSecret object provides storage of secrets,
- * which may be user passwords, encryption keys or any
- * other kind of sensitive data that is represented as
- * a sequence of bytes.
- *
- * The sensitive data associated with the secret can
- * be provided directly via the 'data' property, or
- * indirectly via the 'file' property. In the latter
- * case there is support for file descriptor passing
- * via the usual /dev/fdset/NN syntax that QEMU uses.
- *
- * The data for a secret can be provided in two formats,
- * either as a UTF-8 string (the default), or as base64
- * encoded 8-bit binary data. The latter is appropriate
- * for raw encryption keys, while the former is appropriate
- * for user entered passwords.
- *
- * The data may be optionally encrypted with AES-256-CBC,
- * and the decryption key provided by another
- * QCryptoSecret instance identified by the 'keyid'
- * property. When passing sensitive data directly
- * via the 'data' property it is strongly recommended
- * to use the AES encryption facility to prevent the
- * sensitive data being exposed in the process listing
- * or system log files.
- *
- * Providing data directly, insecurely (suitable for
- * ad hoc developer testing only)
- *
- *  $QEMU -object secret,id=sec0,data=letmein
- *
- * Providing data indirectly:
- *
- *  # printf "letmein" > password.txt
- *  # $QEMU \
- *      -object secret,id=sec0,file=password.txt
- *
- * Using a master encryption key with data.
- *
- * The master key needs to be created as 32 secure
- * random bytes (optionally base64 encoded)
- *
- *  # openssl rand -base64 32 > key.b64
- *  # KEY=$(base64 -d key.b64 | hexdump  -v -e '/1 "%02X"')
- *
- * Each secret to be encrypted needs to have a random
- * initialization vector generated. These do not need
- * to be kept secret
- *
- *  # openssl rand -base64 16 > iv.b64
- *  # IV=$(base64 -d iv.b64 | hexdump  -v -e '/1 "%02X"')
- *
- * A secret to be defined can now be encrypted
- *
- *  # SECRET=$(printf "letmein" |
- *             openssl enc -aes-256-cbc -a -K $KEY -iv $IV)
- *
- * When launching QEMU, create a master secret pointing
- * to key.b64 and specify that to be used to decrypt
- * the user password
- *
- *  # $QEMU \
- *      -object secret,id=secmaster0,format=base64,file=key.b64 \
- *      -object secret,id=sec0,keyid=secmaster0,format=base64,\
- *          data=$SECRET,iv=$(<iv.b64)
- *
- * When encrypting, the data can still be provided via an
- * external file, in which case it is possible to use either
- * raw binary data, or base64 encoded. This example uses
- * raw format
- *
- *  # printf "letmein" |
- *       openssl enc -aes-256-cbc -K $KEY -iv $IV -o pw.aes
- *  # $QEMU \
- *      -object secret,id=secmaster0,format=base64,file=key.b64 \
- *      -object secret,id=sec0,keyid=secmaster0,\
- *          file=pw.aes,iv=$(<iv.b64)
- *
- * Note that the ciphertext can be in either raw or base64
- * format, as indicated by the 'format' parameter, but the
- * plaintext resulting from decryption is expected to always
- * be in raw format.
- */
-
-struct QCryptoSecret {
+struct QCryptoSecretCommon {
     Object parent_obj;
     uint8_t *rawdata;
     size_t rawlen;
     QCryptoSecretFormat format;
-    char *data;
-    char *file;
     char *keyid;
     char *iv;
 };
 
 
-struct QCryptoSecretClass {
+struct QCryptoSecretCommonClass {
     ObjectClass parent_class;
+    void (*load_data)(Object  *obj,
+                      uint8_t **output,
+                      size_t  *outputlen,
+                      Error   **errp);
 };
 
 
@@ -144,4 +65,4 @@ extern char *qcrypto_secret_lookup_as_utf8(const char *secretid,
 extern char *qcrypto_secret_lookup_as_base64(const char *secretid,
                                              Error **errp);
 
-#endif /* QCRYPTO_SECRET_H */
+#endif /* QCRYPTO_SECRET_COMMON_H */
-- 
2.17.1


