Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AF1C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0522087E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0522087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWk6-0003s3-Tz
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPD-0001TS-1O
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0005DE-Bc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:54 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052o-Rg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:51 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 8C91A3074898
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 7D8F1305B7A0;
 Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 26/26] kvm: vmi: add 'command' and 'event' properties
Date: Wed, 15 Apr 2020 03:59:38 +0300
Message-Id: <20200415005938.23895-27-alazar@bitdefender.com>
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

There are cases when the access to an introspected VM must be limited
to certain introspection commands/events.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c | 86 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index f70d78848a..1574a643c4 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -73,6 +73,9 @@ typedef struct VMIntrospection {
     QDict *qmp_rsp;
=20
     bool kvmi_hooked;
+
+    GArray *allowed_commands;
+    GArray *allowed_events;
 } VMIntrospection;
=20
 typedef struct VMIntrospectionClass {
@@ -94,6 +97,8 @@ static bool suspend_pending;
 static bool migrate_pending;
 static bool shutdown_pending;
=20
+static __s32 all_IDs =3D -1;
+
 #define TYPE_VM_INTROSPECTION "introspection"
=20
 #define VM_INTROSPECTION(obj) \
@@ -239,6 +244,25 @@ static void prop_set_uint32(Object *obj, Visitor *v,=
 const char *name,
     }
 }
=20
+static void prop_add_to_array(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
+{
+    Error *local_err =3D NULL;
+    GArray *arr =3D opaque;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (!local_err && value =3D=3D (uint32_t)all_IDs) {
+        error_setg(&local_err, "VMI: add %s: invalid id %d", name, value=
);
+    }
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        g_array_append_val(arr, value);
+    }
+}
+
 static bool chardev_is_connected(VMIntrospection *i, Error **errp)
 {
     Object *obj =3D OBJECT(i->chr);
@@ -286,6 +310,15 @@ static void instance_init(Object *obj)
     object_property_add_str(obj, "chardev", NULL, prop_set_chardev, NULL=
);
     object_property_add_str(obj, "key", NULL, prop_set_key, NULL);
=20
+    i->allowed_commands =3D g_array_new(FALSE, FALSE, sizeof(uint32_t));
+    object_property_add(obj, "command", "uint32",
+                        prop_add_to_array, NULL,
+                        NULL, i->allowed_commands, NULL);
+    i->allowed_events =3D g_array_new(FALSE, FALSE, sizeof(uint32_t));
+    object_property_add(obj, "event", "uint32",
+                        prop_add_to_array, NULL,
+                        NULL, i->allowed_events, NULL);
+
     i->handshake_timeout =3D HANDSHAKE_TIMEOUT_SEC;
     object_property_add(obj, "handshake_timeout", "uint32",
                         prop_set_uint32, prop_get_uint32,
@@ -368,6 +401,13 @@ static void instance_finalize(Object *obj)
     VMIntrospectionClass *ic =3D VM_INTROSPECTION_CLASS(obj->class);
     VMIntrospection *i =3D VM_INTROSPECTION(obj);
=20
+    if (i->allowed_commands) {
+        g_array_free(i->allowed_commands, TRUE);
+    }
+    if (i->allowed_events) {
+        g_array_free(i->allowed_events, TRUE);
+    }
+
     g_free(i->chardevid);
     g_free(i->keyid);
=20
@@ -531,11 +571,39 @@ static bool validate_handshake(VMIntrospection *i, =
Error **errp)
     return true;
 }
=20
+static bool set_allowed_features(int ioctl, GArray *allowed, Error **err=
p)
+{
+    struct kvm_introspection_feature feature;
+    gint i;
+
+    feature.allow =3D 1;
+
+    if (allowed->len =3D=3D 0) {
+        feature.id =3D all_IDs;
+        if (kvm_vm_ioctl(kvm_state, ioctl, &feature)) {
+            goto out_err;
+        }
+    } else {
+        for (i =3D 0; i < allowed->len; i++) {
+            feature.id =3D g_array_index(allowed, uint32_t, i);
+            if (kvm_vm_ioctl(kvm_state, ioctl, &feature)) {
+                goto out_err;
+            }
+        }
+    }
+
+    return true;
+
+out_err:
+    error_setg_errno(errp, -errno,
+                     "VMI: feature %d with id %d failed",
+                     ioctl, feature.id);
+    return false;
+}
+
 static bool connect_kernel(VMIntrospection *i, Error **errp)
 {
-    struct kvm_introspection_feature commands, events;
     struct kvm_introspection_hook kernel;
-    const __s32 all_ids =3D -1;
=20
     memset(&kernel, 0, sizeof(kernel));
     memcpy(kernel.uuid, &qemu_uuid, sizeof(kernel.uuid));
@@ -553,20 +621,14 @@ static bool connect_kernel(VMIntrospection *i, Erro=
r **errp)
=20
     i->kvmi_hooked =3D true;
=20
-    commands.allow =3D 1;
-    commands.id =3D all_ids;
-    if (kvm_vm_ioctl(kvm_state, KVM_INTROSPECTION_COMMAND, &commands)) {
-        error_setg_errno(errp, -errno,
-                         "VMI: ioctl/KVM_INTROSPECTION_COMMAND failed");
+    if (!set_allowed_features(KVM_INTROSPECTION_COMMAND,
+                             i->allowed_commands, errp)) {
         unhook_kvmi(i);
         return false;
     }
=20
-    events.allow =3D 1;
-    events.id =3D all_ids;
-    if (kvm_vm_ioctl(kvm_state, KVM_INTROSPECTION_EVENT, &events)) {
-        error_setg_errno(errp, -errno,
-                         "VMI: ioctl/KVM_INTROSPECTION_EVENT failed");
+    if (!set_allowed_features(KVM_INTROSPECTION_EVENT,
+                             i->allowed_events, errp)) {
         unhook_kvmi(i);
         return false;
     }

