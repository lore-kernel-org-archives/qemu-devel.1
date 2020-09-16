Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC0C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AE6206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/92NKZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AE6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIcDH-0003yW-1A
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 14:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIc7i-0007K3-Pn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:25:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIc7f-00014x-9V
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600280736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXH85WoBqe4Bb5RjGcny6mIFXJfYYnYDPDnu0EstP+Y=;
 b=N/92NKZ+BgOlpBMJirY98nAxU7h6QkjTt8w+Spu7cmEpTPdCskfGLrDMlOVurxGrqLjnlU
 aYkDEqFNKMNjzfSLAyU1tuGh+Ax4JR0ZEgPN6hiYxvseF+nbQoiZoFyaj+WRUG4M1YosHg
 tE78+3ZfOBypXATT/h9PY1K2JSiHeQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-7HDo6yhwMiCFwuAgNgcUvA-1; Wed, 16 Sep 2020 14:25:34 -0400
X-MC-Unique: 7HDo6yhwMiCFwuAgNgcUvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 054C2801AC4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 18:25:34 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06B5A196FB;
 Wed, 16 Sep 2020 18:25:24 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] qom: Remove ParentClassType argument from
 OBJECT_DECLARE_SIMPLE_TYPE
Date: Wed, 16 Sep 2020 14:25:16 -0400
Message-Id: <20200916182519.415636-3-ehabkost@redhat.com>
In-Reply-To: <20200916182519.415636-1-ehabkost@redhat.com>
References: <20200916182519.415636-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The requirement to specify the parent class type makes the macro
harder to use and easy to misuse (silent bugs can be introduced
if the wrong struct type is specified).

Simplify the macro by just not declaring any class struct,
allowing us to remove the class_size field from the TypeInfo
variables for those types.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/authz/list.h                |  2 +-
 include/authz/listfile.h            |  2 +-
 include/authz/pamacct.h             |  2 +-
 include/authz/simple.h              |  2 +-
 include/crypto/secret_keyring.h     |  2 +-
 include/io/dns-resolver.h           |  2 +-
 include/io/net-listener.h           |  2 +-
 include/qom/object.h                | 16 ++++++++--------
 include/sysemu/vhost-user-backend.h |  2 +-
 authz/list.c                        |  1 -
 authz/listfile.c                    |  1 -
 authz/pamacct.c                     |  1 -
 authz/simple.c                      |  1 -
 backends/dbus-vmstate.c             |  3 +--
 backends/vhost-user.c               |  1 -
 crypto/secret_keyring.c             |  1 -
 io/dns-resolver.c                   |  1 -
 io/net-listener.c                   |  1 -
 ui/input-barrier.c                  |  3 +--
 ui/input-linux.c                    |  3 +--
 20 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/include/authz/list.h b/include/authz/list.h
index 5676bb375c..c5eda0f1bf 100644
--- a/include/authz/list.h
+++ b/include/authz/list.h
@@ -28,7 +28,7 @@
 #define TYPE_QAUTHZ_LIST "authz-list"
 
 OBJECT_DECLARE_SIMPLE_TYPE(QAuthZList, qauthz_list,
-                           QAUTHZ_LIST, QAuthZClass)
+                           QAUTHZ_LIST)
 
 
 
diff --git a/include/authz/listfile.h b/include/authz/listfile.h
index b491227bbe..83d78cfa50 100644
--- a/include/authz/listfile.h
+++ b/include/authz/listfile.h
@@ -28,7 +28,7 @@
 #define TYPE_QAUTHZ_LIST_FILE "authz-list-file"
 
 OBJECT_DECLARE_SIMPLE_TYPE(QAuthZListFile, qauthz_list_file,
-                           QAUTHZ_LIST_FILE, QAuthZClass)
+                           QAUTHZ_LIST_FILE)
 
 
 
diff --git a/include/authz/pamacct.h b/include/authz/pamacct.h
index 7804853ddf..18087cee20 100644
--- a/include/authz/pamacct.h
+++ b/include/authz/pamacct.h
@@ -28,7 +28,7 @@
 #define TYPE_QAUTHZ_PAM "authz-pam"
 
 OBJECT_DECLARE_SIMPLE_TYPE(QAuthZPAM, qauthz_pam,
-                           QAUTHZ_PAM, QAuthZClass)
+                           QAUTHZ_PAM)
 
 
 
diff --git a/include/authz/simple.h b/include/authz/simple.h
index 346fcb0c6c..d3ed05b36f 100644
--- a/include/authz/simple.h
+++ b/include/authz/simple.h
@@ -27,7 +27,7 @@
 #define TYPE_QAUTHZ_SIMPLE "authz-simple"
 
 OBJECT_DECLARE_SIMPLE_TYPE(QAuthZSimple, qauthz_simple,
-                           QAUTHZ_SIMPLE, QAuthZClass)
+                           QAUTHZ_SIMPLE)
 
 
 
diff --git a/include/crypto/secret_keyring.h b/include/crypto/secret_keyring.h
index 73d2a8f501..803f3fc28b 100644
--- a/include/crypto/secret_keyring.h
+++ b/include/crypto/secret_keyring.h
@@ -27,7 +27,7 @@
 
 #define TYPE_QCRYPTO_SECRET_KEYRING "secret_keyring"
 OBJECT_DECLARE_SIMPLE_TYPE(QCryptoSecretKeyring, qcrypto_secret_keyring,
-                           QCRYPTO_SECRET_KEYRING, QCryptoSecretCommonClass)
+                           QCRYPTO_SECRET_KEYRING)
 
 
 struct QCryptoSecretKeyring {
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index e248fba5bd..9d14a8d98f 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -27,7 +27,7 @@
 
 #define TYPE_QIO_DNS_RESOLVER "qio-dns-resolver"
 OBJECT_DECLARE_SIMPLE_TYPE(QIODNSResolver, qio_dns_resolver,
-                           QIO_DNS_RESOLVER, ObjectClass)
+                           QIO_DNS_RESOLVER)
 
 
 /**
diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 60fad29ff4..8145962fbb 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -26,7 +26,7 @@
 
 #define TYPE_QIO_NET_LISTENER "qio-net-listener"
 OBJECT_DECLARE_SIMPLE_TYPE(QIONetListener, qio_net_listener,
-                           QIO_NET_LISTENER, ObjectClass)
+                           QIO_NET_LISTENER)
 
 
 typedef void (*QIONetListenerClientFunc)(QIONetListener *listener,
diff --git a/include/qom/object.h b/include/qom/object.h
index 056f67ab3b..4a23fed586 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -639,19 +639,19 @@ struct Object
  * @InstanceType: instance struct name
  * @module_obj_name: the object name in lowercase with underscore separators
  * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
- * @ParentClassType: class struct name of parent type
  *
- * This does the same as OBJECT_DECLARE_TYPE(), but also declares
- * the class struct, thus only the object struct needs to be declare
- * manually.
+ * This does the same as OBJECT_DECLARE_TYPE(), but with no class struct
+ * declared.
  *
  * This macro should be used unless the class struct needs to have
  * virtual methods declared.
  */
-#define OBJECT_DECLARE_SIMPLE_TYPE(InstanceType, module_obj_name, \
-                                   MODULE_OBJ_NAME, ParentClassType) \
-    OBJECT_DECLARE_TYPE(InstanceType, InstanceType##Class, module_obj_name, MODULE_OBJ_NAME) \
-    struct InstanceType##Class { ParentClassType parent_class; };
+#define OBJECT_DECLARE_SIMPLE_TYPE(InstanceType, module_obj_name, MODULE_OBJ_NAME) \
+    typedef struct InstanceType InstanceType; \
+    \
+    G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
+    \
+    DECLARE_INSTANCE_CHECKER(InstanceType, MODULE_OBJ_NAME, TYPE_##MODULE_OBJ_NAME)
 
 
 /**
diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost-user-backend.h
index 23205edeb8..41d5ff43bd 100644
--- a/include/sysemu/vhost-user-backend.h
+++ b/include/sysemu/vhost-user-backend.h
@@ -23,7 +23,7 @@
 
 #define TYPE_VHOST_USER_BACKEND "vhost-user-backend"
 OBJECT_DECLARE_SIMPLE_TYPE(VhostUserBackend, vhost_user_backend,
-                           VHOST_USER_BACKEND, ObjectClass)
+                           VHOST_USER_BACKEND)
 
 
 
diff --git a/authz/list.c b/authz/list.c
index 8e904bfc93..28b990931a 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -252,7 +252,6 @@ static const TypeInfo qauthz_list_info = {
     .name = TYPE_QAUTHZ_LIST,
     .instance_size = sizeof(QAuthZList),
     .instance_finalize = qauthz_list_finalize,
-    .class_size = sizeof(QAuthZListClass),
     .class_init = qauthz_list_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
diff --git a/authz/listfile.c b/authz/listfile.c
index 666df872ad..cd6163aa40 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -263,7 +263,6 @@ static const TypeInfo qauthz_list_file_info = {
     .instance_init = qauthz_list_file_init,
     .instance_size = sizeof(QAuthZListFile),
     .instance_finalize = qauthz_list_file_finalize,
-    .class_size = sizeof(QAuthZListFileClass),
     .class_init = qauthz_list_file_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
diff --git a/authz/pamacct.c b/authz/pamacct.c
index 3c6be43916..c91593bbd8 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -129,7 +129,6 @@ static const TypeInfo qauthz_pam_info = {
     .name = TYPE_QAUTHZ_PAM,
     .instance_size = sizeof(QAuthZPAM),
     .instance_finalize = qauthz_pam_finalize,
-    .class_size = sizeof(QAuthZPAMClass),
     .class_init = qauthz_pam_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
diff --git a/authz/simple.c b/authz/simple.c
index 84954b80a5..ee061e980d 100644
--- a/authz/simple.c
+++ b/authz/simple.c
@@ -96,7 +96,6 @@ static const TypeInfo qauthz_simple_info = {
     .name = TYPE_QAUTHZ_SIMPLE,
     .instance_size = sizeof(QAuthZSimple),
     .instance_finalize = qauthz_simple_finalize,
-    .class_size = sizeof(QAuthZSimpleClass),
     .class_init = qauthz_simple_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index a13461edea..5bffbc4906 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -24,7 +24,7 @@
 
 #define TYPE_DBUS_VMSTATE "dbus-vmstate"
 OBJECT_DECLARE_SIMPLE_TYPE(DBusVMState, dbus_vmstate,
-                           DBUS_VMSTATE, ObjectClass)
+                           DBUS_VMSTATE)
 
 
 struct DBusVMState {
@@ -483,7 +483,6 @@ static const TypeInfo dbus_vmstate_info = {
     .parent = TYPE_OBJECT,
     .instance_size = sizeof(DBusVMState),
     .instance_finalize = dbus_vmstate_finalize,
-    .class_size = sizeof(DBusVMStateClass),
     .class_init = dbus_vmstate_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 9e6e198546..ae8362d721 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -197,7 +197,6 @@ static const TypeInfo vhost_user_backend_info = {
     .instance_size = sizeof(VhostUserBackend),
     .instance_init = vhost_user_backend_init,
     .instance_finalize = vhost_user_backend_finalize,
-    .class_size = sizeof(VhostUserBackendClass),
 };
 
 static void register_types(void)
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 8bfc58ebf4..10d8bc48a0 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -129,7 +129,6 @@ static const TypeInfo qcrypto_secret_info = {
     .parent = TYPE_QCRYPTO_SECRET_COMMON,
     .name = TYPE_QCRYPTO_SECRET_KEYRING,
     .instance_size = sizeof(QCryptoSecretKeyring),
-    .class_size = sizeof(QCryptoSecretKeyringClass),
     .class_init = qcrypto_secret_keyring_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 6ebe2a5650..b55d8cc3fe 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -267,7 +267,6 @@ static const TypeInfo qio_dns_resolver_info = {
     .parent = TYPE_OBJECT,
     .name = TYPE_QIO_DNS_RESOLVER,
     .instance_size = sizeof(QIODNSResolver),
-    .class_size = sizeof(QIODNSResolverClass),
 };
 
 
diff --git a/io/net-listener.c b/io/net-listener.c
index 5d8a226872..46c2643d00 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -307,7 +307,6 @@ static const TypeInfo qio_net_listener_info = {
     .name = TYPE_QIO_NET_LISTENER,
     .instance_size = sizeof(QIONetListener),
     .instance_finalize = qio_net_listener_finalize,
-    .class_size = sizeof(QIONetListenerClass),
 };
 
 
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 87543a3399..b76697be93 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -21,7 +21,7 @@
 
 #define TYPE_INPUT_BARRIER "input-barrier"
 OBJECT_DECLARE_SIMPLE_TYPE(InputBarrier, input_barrier,
-                           INPUT_BARRIER, ObjectClass)
+                           INPUT_BARRIER)
 
 
 #define MAX_HELLO_LENGTH 1024
@@ -723,7 +723,6 @@ static void input_barrier_class_init(ObjectClass *oc, void *data)
 static const TypeInfo input_barrier_info = {
     .name = TYPE_INPUT_BARRIER,
     .parent = TYPE_OBJECT,
-    .class_size = sizeof(InputBarrierClass),
     .class_init = input_barrier_class_init,
     .instance_size = sizeof(InputBarrier),
     .instance_init = input_barrier_instance_init,
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 5d501c8360..f02557b012 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -32,7 +32,7 @@ static bool linux_is_button(unsigned int lnx)
 
 #define TYPE_INPUT_LINUX "input-linux"
 OBJECT_DECLARE_SIMPLE_TYPE(InputLinux, input_linux,
-                           INPUT_LINUX, ObjectClass)
+                           INPUT_LINUX)
 
 
 struct InputLinux {
@@ -514,7 +514,6 @@ static void input_linux_class_init(ObjectClass *oc, void *data)
 static const TypeInfo input_linux_info = {
     .name = TYPE_INPUT_LINUX,
     .parent = TYPE_OBJECT,
-    .class_size = sizeof(InputLinuxClass),
     .class_init = input_linux_class_init,
     .instance_size = sizeof(InputLinux),
     .instance_init = input_linux_instance_init,
-- 
2.26.2


