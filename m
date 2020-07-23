Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B25C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16C820674
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvnyAbXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16C820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfkq-0007Y7-U8
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 14:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyfjf-0006Ef-W2
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:14:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyfjd-0007jy-W5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595528065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/9W4aKIzNmcUYxEK12c4NQy4bbOENp8nQF3Nb267To=;
 b=WvnyAbXABj9/dpTk7HmCNNhUBjSgylmjX6Er/gmMFe3o+0TFEiSL6bo/A0n4HXn0RpW6LP
 LmyrKIYPQrz7zbirc5Xa4iTNsKdr18DKUNaerPTZwKnD/M8veslX5rxQB9Dot6TetR9Yc1
 RWf5pau7uYaXC3RHw5tQ7yJLqweqpbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-bXS_s7ETNgyjDp6O84WpFg-1; Thu, 23 Jul 2020 14:14:23 -0400
X-MC-Unique: bXS_s7ETNgyjDp6O84WpFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 583E9100AA26
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 18:14:22 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B45F01009940;
 Thu, 23 Jul 2020 18:14:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] crypto: use QOM macros for declaration/definition of TLS
 creds types
Date: Thu, 23 Jul 2020 19:14:10 +0100
Message-Id: <20200723181410.3145233-5-berrange@redhat.com>
In-Reply-To: <20200723181410.3145233-1-berrange@redhat.com>
References: <20200723181410.3145233-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
families in the TLS creds types, in order to eliminate boilerplate code.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c             | 25 +++----------------------
 crypto/tlscredsanon.c         | 23 ++++-------------------
 crypto/tlscredspsk.c          | 25 +++++--------------------
 crypto/tlscredsx509.c         | 29 ++++-------------------------
 include/crypto/tlscreds.h     | 13 ++-----------
 include/crypto/tlscredsanon.h | 14 ++------------
 include/crypto/tlscredspsk.h  | 13 ++-----------
 include/crypto/tlscredsx509.h | 13 ++-----------
 8 files changed, 24 insertions(+), 131 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index b68735f06f..c238ff7d4b 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -24,6 +24,9 @@
 #include "tlscredspriv.h"
 #include "trace.h"
 
+OBJECT_DEFINE_ABSTRACT_TYPE(QCryptoTLSCreds, qcrypto_tls_creds,
+                            QCRYPTO_TLS_CREDS, OBJECT)
+
 #define DH_BITS 2048
 
 #ifdef CONFIG_GNUTLS
@@ -258,25 +261,3 @@ qcrypto_tls_creds_finalize(Object *obj)
     g_free(creds->dir);
     g_free(creds->priority);
 }
-
-
-static const TypeInfo qcrypto_tls_creds_info = {
-    .parent = TYPE_OBJECT,
-    .name = TYPE_QCRYPTO_TLS_CREDS,
-    .instance_size = sizeof(QCryptoTLSCreds),
-    .instance_init = qcrypto_tls_creds_init,
-    .instance_finalize = qcrypto_tls_creds_finalize,
-    .class_init = qcrypto_tls_creds_class_init,
-    .class_size = sizeof(QCryptoTLSCredsClass),
-    .abstract = true,
-};
-
-
-static void
-qcrypto_tls_creds_register_types(void)
-{
-    type_register_static(&qcrypto_tls_creds_info);
-}
-
-
-type_init(qcrypto_tls_creds_register_types);
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 30275b6847..dc1b77e37c 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -26,6 +26,9 @@
 #include "qom/object_interfaces.h"
 #include "trace.h"
 
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(QCryptoTLSCredsAnon, qcrypto_tls_creds_anon,
+                                   QCRYPTO_TLS_CREDS_ANON, QCRYPTO_TLS_CREDS,
+                                   { TYPE_USER_CREATABLE }, { NULL })
 
 #ifdef CONFIG_GNUTLS
 
@@ -191,25 +194,7 @@ qcrypto_tls_creds_anon_class_init(ObjectClass *oc, void *data)
 }
 
 
-static const TypeInfo qcrypto_tls_creds_anon_info = {
-    .parent = TYPE_QCRYPTO_TLS_CREDS,
-    .name = TYPE_QCRYPTO_TLS_CREDS_ANON,
-    .instance_size = sizeof(QCryptoTLSCredsAnon),
-    .instance_finalize = qcrypto_tls_creds_anon_finalize,
-    .class_size = sizeof(QCryptoTLSCredsAnonClass),
-    .class_init = qcrypto_tls_creds_anon_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
-};
-
-
 static void
-qcrypto_tls_creds_anon_register_types(void)
+qcrypto_tls_creds_anon_init(Object *obj)
 {
-    type_register_static(&qcrypto_tls_creds_anon_info);
 }
-
-
-type_init(qcrypto_tls_creds_anon_register_types);
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index e26807b899..0c66be3647 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -27,6 +27,10 @@
 #include "trace.h"
 
 
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(QCryptoTLSCredsPSK, qcrypto_tls_creds_psk,
+                                   QCRYPTO_TLS_CREDS_PSK, QCRYPTO_TLS_CREDS,
+                                   { TYPE_USER_CREATABLE }, { NULL })
+
 #ifdef CONFIG_GNUTLS
 
 static int
@@ -281,26 +285,7 @@ qcrypto_tls_creds_psk_class_init(ObjectClass *oc, void *data)
                                   qcrypto_tls_creds_psk_prop_set_username);
 }
 
-
-static const TypeInfo qcrypto_tls_creds_psk_info = {
-    .parent = TYPE_QCRYPTO_TLS_CREDS,
-    .name = TYPE_QCRYPTO_TLS_CREDS_PSK,
-    .instance_size = sizeof(QCryptoTLSCredsPSK),
-    .instance_finalize = qcrypto_tls_creds_psk_finalize,
-    .class_size = sizeof(QCryptoTLSCredsPSKClass),
-    .class_init = qcrypto_tls_creds_psk_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
-};
-
-
 static void
-qcrypto_tls_creds_psk_register_types(void)
+qcrypto_tls_creds_psk_init(Object *obj)
 {
-    type_register_static(&qcrypto_tls_creds_psk_info);
 }
-
-
-type_init(qcrypto_tls_creds_psk_register_types);
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index dd7267ccdb..a39555e5e6 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -28,6 +28,10 @@
 #include "trace.h"
 
 
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(QCryptoTLSCredsX509, qcrypto_tls_creds_x509,
+                                   QCRYPTO_TLS_CREDS_X509, QCRYPTO_TLS_CREDS,
+                                   { TYPE_USER_CREATABLE }, { NULL })
+
 #ifdef CONFIG_GNUTLS
 
 #include <gnutls/x509.h>
@@ -814,28 +818,3 @@ qcrypto_tls_creds_x509_class_init(ObjectClass *oc, void *data)
                                   qcrypto_tls_creds_x509_prop_get_passwordid,
                                   qcrypto_tls_creds_x509_prop_set_passwordid);
 }
-
-
-static const TypeInfo qcrypto_tls_creds_x509_info = {
-    .parent = TYPE_QCRYPTO_TLS_CREDS,
-    .name = TYPE_QCRYPTO_TLS_CREDS_X509,
-    .instance_size = sizeof(QCryptoTLSCredsX509),
-    .instance_init = qcrypto_tls_creds_x509_init,
-    .instance_finalize = qcrypto_tls_creds_x509_finalize,
-    .class_size = sizeof(QCryptoTLSCredsX509Class),
-    .class_init = qcrypto_tls_creds_x509_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
-};
-
-
-static void
-qcrypto_tls_creds_x509_register_types(void)
-{
-    type_register_static(&qcrypto_tls_creds_x509_info);
-}
-
-
-type_init(qcrypto_tls_creds_x509_register_types);
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
index fd7a284aa2..e9b9b8c20a 100644
--- a/include/crypto/tlscreds.h
+++ b/include/crypto/tlscreds.h
@@ -29,11 +29,8 @@
 #endif
 
 #define TYPE_QCRYPTO_TLS_CREDS "tls-creds"
-#define QCRYPTO_TLS_CREDS(obj)                  \
-    OBJECT_CHECK(QCryptoTLSCreds, (obj), TYPE_QCRYPTO_TLS_CREDS)
-
-typedef struct QCryptoTLSCreds QCryptoTLSCreds;
-typedef struct QCryptoTLSCredsClass QCryptoTLSCredsClass;
+OBJECT_DECLARE_SIMPLE_TYPE(QCryptoTLSCreds, qcrypto_tls_creds,
+                           QCRYPTO_TLS_CREDS, Object)
 
 #define QCRYPTO_TLS_CREDS_DH_PARAMS "dh-params.pem"
 
@@ -58,10 +55,4 @@ struct QCryptoTLSCreds {
     char *priority;
 };
 
-
-struct QCryptoTLSCredsClass {
-    ObjectClass parent_class;
-};
-
-
 #endif /* QCRYPTO_TLSCREDS_H */
diff --git a/include/crypto/tlscredsanon.h b/include/crypto/tlscredsanon.h
index 9e9a5ce1a8..e366132b6b 100644
--- a/include/crypto/tlscredsanon.h
+++ b/include/crypto/tlscredsanon.h
@@ -24,12 +24,8 @@
 #include "crypto/tlscreds.h"
 
 #define TYPE_QCRYPTO_TLS_CREDS_ANON "tls-creds-anon"
-#define QCRYPTO_TLS_CREDS_ANON(obj)                  \
-    OBJECT_CHECK(QCryptoTLSCredsAnon, (obj), TYPE_QCRYPTO_TLS_CREDS_ANON)
-
-
-typedef struct QCryptoTLSCredsAnon QCryptoTLSCredsAnon;
-typedef struct QCryptoTLSCredsAnonClass QCryptoTLSCredsAnonClass;
+OBJECT_DECLARE_SIMPLE_TYPE(QCryptoTLSCredsAnon, qcrypto_tls_creds_anon,
+                           QCRYPTO_TLS_CREDS_ANON, QCryptoTLSCreds)
 
 /**
  * QCryptoTLSCredsAnon:
@@ -102,10 +98,4 @@ struct QCryptoTLSCredsAnon {
 #endif
 };
 
-
-struct QCryptoTLSCredsAnonClass {
-    QCryptoTLSCredsClass parent_class;
-};
-
-
 #endif /* QCRYPTO_TLSCREDSANON_H */
diff --git a/include/crypto/tlscredspsk.h b/include/crypto/tlscredspsk.h
index 907035a29b..0754c6c2d5 100644
--- a/include/crypto/tlscredspsk.h
+++ b/include/crypto/tlscredspsk.h
@@ -24,11 +24,8 @@
 #include "crypto/tlscreds.h"
 
 #define TYPE_QCRYPTO_TLS_CREDS_PSK "tls-creds-psk"
-#define QCRYPTO_TLS_CREDS_PSK(obj)                  \
-    OBJECT_CHECK(QCryptoTLSCredsPSK, (obj), TYPE_QCRYPTO_TLS_CREDS_PSK)
-
-typedef struct QCryptoTLSCredsPSK QCryptoTLSCredsPSK;
-typedef struct QCryptoTLSCredsPSKClass QCryptoTLSCredsPSKClass;
+OBJECT_DECLARE_SIMPLE_TYPE(QCryptoTLSCredsPSK, qcrypto_tls_creds_psk,
+                           QCRYPTO_TLS_CREDS_PSK, QCryptoTLSCreds)
 
 #define QCRYPTO_TLS_CREDS_PSKFILE "keys.psk"
 
@@ -97,10 +94,4 @@ struct QCryptoTLSCredsPSK {
 #endif
 };
 
-
-struct QCryptoTLSCredsPSKClass {
-    QCryptoTLSCredsClass parent_class;
-};
-
-
 #endif /* QCRYPTO_TLSCREDSPSK_H */
diff --git a/include/crypto/tlscredsx509.h b/include/crypto/tlscredsx509.h
index e1542e5c8c..307b169710 100644
--- a/include/crypto/tlscredsx509.h
+++ b/include/crypto/tlscredsx509.h
@@ -24,11 +24,8 @@
 #include "crypto/tlscreds.h"
 
 #define TYPE_QCRYPTO_TLS_CREDS_X509 "tls-creds-x509"
-#define QCRYPTO_TLS_CREDS_X509(obj)                  \
-    OBJECT_CHECK(QCryptoTLSCredsX509, (obj), TYPE_QCRYPTO_TLS_CREDS_X509)
-
-typedef struct QCryptoTLSCredsX509 QCryptoTLSCredsX509;
-typedef struct QCryptoTLSCredsX509Class QCryptoTLSCredsX509Class;
+OBJECT_DECLARE_SIMPLE_TYPE(QCryptoTLSCredsX509, qcrypto_tls_creds_x509,
+                           QCRYPTO_TLS_CREDS_X509, QCryptoTLSCreds)
 
 #define QCRYPTO_TLS_CREDS_X509_CA_CERT "ca-cert.pem"
 #define QCRYPTO_TLS_CREDS_X509_CA_CRL "ca-crl.pem"
@@ -104,10 +101,4 @@ struct QCryptoTLSCredsX509 {
     char *passwordid;
 };
 
-
-struct QCryptoTLSCredsX509Class {
-    QCryptoTLSCredsClass parent_class;
-};
-
-
 #endif /* QCRYPTO_TLSCREDSX509_H */
-- 
2.26.2


