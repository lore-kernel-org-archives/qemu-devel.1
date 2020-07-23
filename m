Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD93C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9506F20674
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bspntXpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9506F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfkn-0007R0-Rb
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 14:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyfje-0006CD-57
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:14:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58974
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyfjc-0007j6-BG
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595528063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8YenZwUa/923Ixjz3e6MRLXtghP6xqYYJAJRatjZUc=;
 b=bspntXprBiFA5v7NngdXHF1WkE+aUYs+tTCY+Job/yeztfv6JVL6bBwX4HiUIEMwThdQIi
 juN+nsz+CMNSG/HqS3ETrRlSIJwNEpoUiQTfeINKa4p56wyZqh2zWWsxm1gqNYN46PDj1d
 tIBC3BuBFOCzmpHBKIn/DjRlWt8dDcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-AN-cAQmTOZ6DsXyaUiEfCA-1; Thu, 23 Jul 2020 14:14:21 -0400
X-MC-Unique: AN-cAQmTOZ6DsXyaUiEfCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C0B58017FB
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 18:14:20 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC56A1009940;
 Thu, 23 Jul 2020 18:14:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] crypto: use QOM macros for declaration/definition of
 secret types
Date: Thu, 23 Jul 2020 19:14:09 +0100
Message-Id: <20200723181410.3145233-4-berrange@redhat.com>
In-Reply-To: <20200723181410.3145233-1-berrange@redhat.com>
References: <20200723181410.3145233-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This introduces the use of the OBJECT_DEFINE and OBJECT_DECLARE macro
families in the secret types, in order to eliminate boilerplate code.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/secret.c                 | 24 ++++--------------------
 crypto/secret_common.c          | 32 +++++++++-----------------------
 crypto/secret_keyring.c         | 28 +++++++++-------------------
 include/crypto/secret.h         | 11 ++---------
 include/crypto/secret_common.h  | 13 ++-----------
 include/crypto/secret_keyring.h | 18 ++----------------
 6 files changed, 28 insertions(+), 98 deletions(-)

diff --git a/crypto/secret.c b/crypto/secret.c
index 281cb81f0f..55b406f79e 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -25,6 +25,9 @@
 #include "qemu/module.h"
 #include "trace.h"
 
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(QCryptoSecret, qcrypto_secret,
+                                   QCRYPTO_SECRET, QCRYPTO_SECRET_COMMON,
+                                   { TYPE_USER_CREATABLE }, { NULL })
 
 static void
 qcrypto_secret_load_data(QCryptoSecretCommon *sec_common,
@@ -140,26 +143,7 @@ qcrypto_secret_class_init(ObjectClass *oc, void *data)
                                   qcrypto_secret_prop_set_file);
 }
 
-
-static const TypeInfo qcrypto_secret_info = {
-    .parent = TYPE_QCRYPTO_SECRET_COMMON,
-    .name = TYPE_QCRYPTO_SECRET,
-    .instance_size = sizeof(QCryptoSecret),
-    .instance_finalize = qcrypto_secret_finalize,
-    .class_size = sizeof(QCryptoSecretClass),
-    .class_init = qcrypto_secret_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
-};
-
-
 static void
-qcrypto_secret_register_types(void)
+qcrypto_secret_init(Object *obj)
 {
-    type_register_static(&qcrypto_secret_info);
 }
-
-
-type_init(qcrypto_secret_register_types);
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index b03d530867..9a054b90b5 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -28,6 +28,9 @@
 #include "trace.h"
 
 
+OBJECT_DEFINE_ABSTRACT_TYPE(QCryptoSecretCommon, qcrypto_secret_common,
+                            QCRYPTO_SECRET_COMMON, OBJECT)
+
 static void qcrypto_secret_decrypt(QCryptoSecretCommon *secret,
                                    const uint8_t *input,
                                    size_t inputlen,
@@ -269,7 +272,7 @@ qcrypto_secret_prop_get_keyid(Object *obj,
 
 
 static void
-qcrypto_secret_finalize(Object *obj)
+qcrypto_secret_common_finalize(Object *obj)
 {
     QCryptoSecretCommon *secret = QCRYPTO_SECRET_COMMON(obj);
 
@@ -279,7 +282,7 @@ qcrypto_secret_finalize(Object *obj)
 }
 
 static void
-qcrypto_secret_class_init(ObjectClass *oc, void *data)
+qcrypto_secret_common_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_bool(oc, "loaded",
                                    qcrypto_secret_prop_get_loaded,
@@ -297,6 +300,10 @@ qcrypto_secret_class_init(ObjectClass *oc, void *data)
                                   qcrypto_secret_prop_set_iv);
 }
 
+static void
+qcrypto_secret_common_init(Object *obj)
+{
+}
 
 int qcrypto_secret_lookup(const char *secretid,
                           uint8_t **data,
@@ -380,24 +387,3 @@ char *qcrypto_secret_lookup_as_base64(const char *secretid,
     g_free(data);
     return ret;
 }
-
-
-static const TypeInfo qcrypto_secret_info = {
-    .parent = TYPE_OBJECT,
-    .name = TYPE_QCRYPTO_SECRET_COMMON,
-    .instance_size = sizeof(QCryptoSecretCommon),
-    .instance_finalize = qcrypto_secret_finalize,
-    .class_size = sizeof(QCryptoSecretCommonClass),
-    .class_init = qcrypto_secret_class_init,
-    .abstract = true,
-};
-
-
-static void
-qcrypto_secret_register_types(void)
-{
-    type_register_static(&qcrypto_secret_info);
-}
-
-
-type_init(qcrypto_secret_register_types);
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 8bfc58ebf4..463aefe5dc 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -26,6 +26,9 @@
 #include "trace.h"
 #include "crypto/secret_keyring.h"
 
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(QCryptoSecretKeyring, qcrypto_secret_keyring,
+                                   QCRYPTO_SECRET_KEYRING, QCRYPTO_SECRET_COMMON,
+                                   { TYPE_USER_CREATABLE }, { NULL })
 
 static inline
 long keyctl_read(int32_t key, uint8_t *buffer, size_t buflen)
@@ -109,6 +112,11 @@ qcrypto_secret_keyring_complete(UserCreatable *uc, Error **errp)
 }
 
 
+static void
+qcrypto_secret_keyring_finalize(Object *obj)
+{
+}
+
 static void
 qcrypto_secret_keyring_class_init(ObjectClass *oc, void *data)
 {
@@ -124,25 +132,7 @@ qcrypto_secret_keyring_class_init(ObjectClass *oc, void *data)
                                   NULL, NULL);
 }
 
-
-static const TypeInfo qcrypto_secret_info = {
-    .parent = TYPE_QCRYPTO_SECRET_COMMON,
-    .name = TYPE_QCRYPTO_SECRET_KEYRING,
-    .instance_size = sizeof(QCryptoSecretKeyring),
-    .class_size = sizeof(QCryptoSecretKeyringClass),
-    .class_init = qcrypto_secret_keyring_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
-};
-
-
 static void
-qcrypto_secret_register_types(void)
+qcrypto_secret_keyring_init(Object *obj)
 {
-    type_register_static(&qcrypto_secret_info);
 }
-
-
-type_init(qcrypto_secret_register_types);
diff --git a/include/crypto/secret.h b/include/crypto/secret.h
index 2deb461d2f..4eb4e5ffef 100644
--- a/include/crypto/secret.h
+++ b/include/crypto/secret.h
@@ -26,11 +26,9 @@
 #include "crypto/secret_common.h"
 
 #define TYPE_QCRYPTO_SECRET "secret"
-#define QCRYPTO_SECRET(obj)                  \
-    OBJECT_CHECK(QCryptoSecret, (obj), TYPE_QCRYPTO_SECRET)
 
-typedef struct QCryptoSecret QCryptoSecret;
-typedef struct QCryptoSecretClass QCryptoSecretClass;
+OBJECT_DECLARE_SIMPLE_TYPE(QCryptoSecret, qcrypto_secret,
+                           QCRYPTO_SECRET, QCryptoSecretCommon)
 
 /**
  * QCryptoSecret:
@@ -125,9 +123,4 @@ struct QCryptoSecret {
     char *file;
 };
 
-
-struct QCryptoSecretClass {
-    QCryptoSecretCommonClass parent_class;
-};
-
 #endif /* QCRYPTO_SECRET_H */
diff --git a/include/crypto/secret_common.h b/include/crypto/secret_common.h
index 980c02ab71..999a6b4651 100644
--- a/include/crypto/secret_common.h
+++ b/include/crypto/secret_common.h
@@ -25,17 +25,8 @@
 #include "qom/object.h"
 
 #define TYPE_QCRYPTO_SECRET_COMMON "secret_common"
-#define QCRYPTO_SECRET_COMMON(obj) \
-    OBJECT_CHECK(QCryptoSecretCommon, (obj), TYPE_QCRYPTO_SECRET_COMMON)
-#define QCRYPTO_SECRET_COMMON_CLASS(class) \
-    OBJECT_CLASS_CHECK(QCryptoSecretCommonClass, \
-                       (class), TYPE_QCRYPTO_SECRET_COMMON)
-#define QCRYPTO_SECRET_COMMON_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(QCryptoSecretCommonClass, \
-                     (obj), TYPE_QCRYPTO_SECRET_COMMON)
-
-typedef struct QCryptoSecretCommon QCryptoSecretCommon;
-typedef struct QCryptoSecretCommonClass QCryptoSecretCommonClass;
+OBJECT_DECLARE_TYPE(QCryptoSecretCommon, qcrypto_secret_common,
+                    QCRYPTO_SECRET_COMMON)
 
 struct QCryptoSecretCommon {
     Object parent_obj;
diff --git a/include/crypto/secret_keyring.h b/include/crypto/secret_keyring.h
index 9f371ad251..4470306853 100644
--- a/include/crypto/secret_keyring.h
+++ b/include/crypto/secret_keyring.h
@@ -26,18 +26,8 @@
 #include "crypto/secret_common.h"
 
 #define TYPE_QCRYPTO_SECRET_KEYRING "secret_keyring"
-#define QCRYPTO_SECRET_KEYRING(obj) \
-    OBJECT_CHECK(QCryptoSecretKeyring, (obj), \
-                 TYPE_QCRYPTO_SECRET_KEYRING)
-#define QCRYPTO_SECRET_KEYRING_CLASS(class) \
-    OBJECT_CLASS_CHECK(QCryptoSecretKeyringClass, \
-                       (class), TYPE_QCRYPTO_SECRET_KEYRING)
-#define QCRYPTO_SECRET_KEYRING_GET_CLASS(class) \
-    OBJECT_GET_CLASS(QCryptoSecretKeyringClass, \
-                     (class), TYPE_QCRYPTO_SECRET_KEYRING)
-
-typedef struct QCryptoSecretKeyring QCryptoSecretKeyring;
-typedef struct QCryptoSecretKeyringClass QCryptoSecretKeyringClass;
+OBJECT_DECLARE_SIMPLE_TYPE(QCryptoSecretKeyring, qcrypto_secret_keyring,
+                           QCRYPTO_SECRET_KEYRING, QCryptoSecretCommon)
 
 typedef struct QCryptoSecretKeyring {
     QCryptoSecretCommon parent;
@@ -45,8 +35,4 @@ typedef struct QCryptoSecretKeyring {
 } QCryptoSecretKeyring;
 
 
-typedef struct QCryptoSecretKeyringClass {
-    QCryptoSecretCommonClass parent;
-} QCryptoSecretKeyringClass;
-
 #endif /* QCRYPTO_SECRET_KEYRING_H */
-- 
2.26.2


