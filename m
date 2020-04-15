Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F0C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916E72072D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916E72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWUL-0006d7-Ij
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP8-0001Gx-Nv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP7-0005BN-GO
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:50 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP7-000512-8k
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:49 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 65CA930747CD
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 54760305B7A0;
 Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 14/26] kvm: vmi: allow only one instance of the
 introspection object
Date: Wed, 15 Apr 2020 03:59:26 +0300
Message-Id: <20200415005938.23895-15-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because only one introspection tool must introspect a VM at a given time,
we block the completion of the second instance.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 2ce8a60565..54c56c6e13 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -52,10 +52,18 @@ typedef struct VMIntrospection {
     bool kvmi_hooked;
 } VMIntrospection;
=20
+typedef struct VMIntrospectionClass {
+    ObjectClass parent_class;
+    uint32_t instance_counter;
+    VMIntrospection *uniq;
+} VMIntrospectionClass;
+
 #define TYPE_VM_INTROSPECTION "introspection"
=20
 #define VM_INTROSPECTION(obj) \
     OBJECT_CHECK(VMIntrospection, (obj), TYPE_VM_INTROSPECTION)
+#define VM_INTROSPECTION_CLASS(class) \
+    OBJECT_CLASS_CHECK(VMIntrospectionClass, (class), TYPE_VM_INTROSPECT=
ION)
=20
 static Error *vm_introspection_init(VMIntrospection *i);
=20
@@ -81,8 +89,14 @@ static void update_vm_start_time(VMIntrospection *i)
=20
 static void complete(UserCreatable *uc, Error **errp)
 {
+    VMIntrospectionClass *ic =3D VM_INTROSPECTION_CLASS(OBJECT(uc)->clas=
s);
     VMIntrospection *i =3D VM_INTROSPECTION(uc);
=20
+    if (ic->instance_counter > 1) {
+        error_setg(errp, "VMI: only one introspection object can be crea=
ted");
+        return;
+    }
+
     if (!i->chardevid) {
         error_setg(errp, "VMI: chardev is not set");
         return;
@@ -106,6 +120,8 @@ static void complete(UserCreatable *uc, Error **errp)
         i->init_error =3D NULL;
         return;
     }
+
+    ic->uniq =3D i;
 }
=20
 static void prop_set_chardev(Object *obj, const char *value, Error **err=
p)
@@ -168,8 +184,11 @@ static void class_init(ObjectClass *oc, void *data)
=20
 static void instance_init(Object *obj)
 {
+    VMIntrospectionClass *ic =3D VM_INTROSPECTION_CLASS(obj->class);
     VMIntrospection *i =3D VM_INTROSPECTION(obj);
=20
+    ic->instance_counter++;
+
     i->sock_fd =3D -1;
     i->created_from_command_line =3D (qdev_hotplug =3D=3D false);
=20
@@ -234,6 +253,7 @@ static void cancel_handshake_timer(VMIntrospection *i=
)
=20
 static void instance_finalize(Object *obj)
 {
+    VMIntrospectionClass *ic =3D VM_INTROSPECTION_CLASS(obj->class);
     VMIntrospection *i =3D VM_INTROSPECTION(obj);
=20
     g_free(i->chardevid);
@@ -248,12 +268,18 @@ static void instance_finalize(Object *obj)
     }
=20
     error_free(i->init_error);
+
+    ic->instance_counter--;
+    if (!ic->instance_counter) {
+        ic->uniq =3D NULL;
+    }
 }
=20
 static const TypeInfo info =3D {
     .name              =3D TYPE_VM_INTROSPECTION,
     .parent            =3D TYPE_OBJECT,
     .class_init        =3D class_init,
+    .class_size        =3D sizeof(VMIntrospectionClass),
     .instance_size     =3D sizeof(VMIntrospection),
     .instance_finalize =3D instance_finalize,
     .instance_init     =3D instance_init,

