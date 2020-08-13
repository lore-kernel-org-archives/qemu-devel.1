Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E247020771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLBYh4Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E247020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6M0A-0004V9-5w
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6Lh3-0006QQ-F0
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6Lgy-0002wn-7h
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AqjA4h5I5Dp/r4Bm0a1zmu86WiIsKpgt30sbB7FoFI=;
 b=RLBYh4OcFgonIYGjfllg/q2ZvCrdJTh5rI0sdX2htcalrIelHSdlU0rmFBGwBqXOktKhfA
 LQAKLX797JZlPQaoTlTobv1oGZztMzk2BevBA7zGpmZ6VnJNbG4GIwpqEh7VlfMFUwzw+W
 Lx6ixm3HdkTsvIbUiykcMAjt8tK3FPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-QaYsdyhRMeSN3NjjLn7cCg-1; Thu, 13 Aug 2020 18:27:21 -0400
X-MC-Unique: QaYsdyhRMeSN3NjjLn7cCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB71C800683
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:27:20 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A28D15D9D2;
 Thu, 13 Aug 2020 22:27:20 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/41] crypto: use QOM macros for declaration/definition of
 secret types
Date: Thu, 13 Aug 2020 18:26:24 -0400
Message-Id: <20200813222625.243136-41-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:30:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

This introduces the use of the OBJECT_DEFINE and OBJECT_DECLARE macro
families in the secret types, in order to eliminate boilerplate code.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200723181410.3145233-4-berrange@redhat.com>
[ehabkost: rebase, update to pass additional arguments to macro]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/crypto/secret.h | 11 ++---------
 crypto/secret.c         | 25 +++++++------------------
 crypto/secret_common.c  | 27 +++++++++------------------
 crypto/secret_keyring.c | 29 ++++++++++++-----------------
 4 files changed, 30 insertions(+), 62 deletions(-)

diff --git a/include/crypto/secret.h b/include/crypto/secret.h
index 5d20ae6d2f..4eb4e5ffef 100644
--- a/include/crypto/secret.h
+++ b/include/crypto/secret.h
@@ -26,11 +26,9 @@
 #include "crypto/secret_common.h"
 
 #define TYPE_QCRYPTO_SECRET "secret"
-typedef struct QCryptoSecret QCryptoSecret;
-DECLARE_INSTANCE_CHECKER(QCryptoSecret, QCRYPTO_SECRET,
-                         TYPE_QCRYPTO_SECRET)
 
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
diff --git a/crypto/secret.c b/crypto/secret.c
index c07011d388..55b406f79e 100644
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
@@ -140,21 +143,7 @@ qcrypto_secret_class_init(ObjectClass *oc, void *data)
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
-TYPE_INFO(qcrypto_secret_info)
-
-
-
-
+static void
+qcrypto_secret_init(Object *obj)
+{
+}
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index 80d7d75b4d..9a054b90b5 100644
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
@@ -380,19 +387,3 @@ char *qcrypto_secret_lookup_as_base64(const char *secretid,
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
-TYPE_INFO(qcrypto_secret_info)
-
-
-
-
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 821d2e421b..463aefe5dc 100644
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
@@ -124,20 +132,7 @@ qcrypto_secret_keyring_class_init(ObjectClass *oc, void *data)
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
-TYPE_INFO(qcrypto_secret_info)
-
-
-
-
+static void
+qcrypto_secret_keyring_init(Object *obj)
+{
+}
-- 
2.26.2


