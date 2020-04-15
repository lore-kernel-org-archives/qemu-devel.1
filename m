Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4DAC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17E920732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17E920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWaT-0005qg-Ts
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOz-0000wV-PF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOx-00052D-JZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:41 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWOx-00050t-75
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:39 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 0390F30747C7; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id C749B305B7A0;
 Wed, 15 Apr 2020 03:59:34 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 09/26] kvm: introduce the VM introspection object
Date: Wed, 15 Apr 2020 03:59:21 +0300
Message-Id: <20200415005938.23895-10-alazar@bitdefender.com>
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used to initiate the connection with the introspection tool and
hand over the file descriptor to KVM. The object needs a chardev socket
(in client mode) created with the 'reconnect' property set.

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/Makefile.objs |   1 +
 accel/kvm/vmi.c         | 168 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 accel/kvm/vmi.c

diff --git a/accel/kvm/Makefile.objs b/accel/kvm/Makefile.objs
index fdfa481578..5e85294eb3 100644
--- a/accel/kvm/Makefile.objs
+++ b/accel/kvm/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y +=3D kvm-all.o
+obj-y +=3D vmi.o
 obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
new file mode 100644
index 0000000000..883c666a2a
--- /dev/null
+++ b/accel/kvm/vmi.c
@@ -0,0 +1,168 @@
+/*
+ * VM Introspection
+ *
+ * Copyright (C) 2017-2020 Bitdefender S.R.L.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qom/object_interfaces.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/kvm.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+
+typedef struct VMIntrospection {
+    Object parent_obj;
+
+    Error *init_error;
+
+    char *chardevid;
+    Chardev *chr;
+
+    Notifier machine_ready;
+    bool created_from_command_line;
+} VMIntrospection;
+
+#define TYPE_VM_INTROSPECTION "introspection"
+
+#define VM_INTROSPECTION(obj) \
+    OBJECT_CHECK(VMIntrospection, (obj), TYPE_VM_INTROSPECTION)
+
+static Error *vm_introspection_init(VMIntrospection *i);
+
+static void machine_ready(Notifier *notifier, void *data)
+{
+    VMIntrospection *i =3D container_of(notifier, VMIntrospection, machi=
ne_ready);
+
+    i->init_error =3D vm_introspection_init(i);
+    if (i->init_error) {
+        Error *err =3D error_copy(i->init_error);
+
+        error_report_err(err);
+        if (i->created_from_command_line) {
+            exit(1);
+        }
+    }
+}
+
+static void complete(UserCreatable *uc, Error **errp)
+{
+    VMIntrospection *i =3D VM_INTROSPECTION(uc);
+
+    if (!i->chardevid) {
+        error_setg(errp, "VMI: chardev is not set");
+        return;
+    }
+
+    i->machine_ready.notify =3D machine_ready;
+    qemu_add_machine_init_done_notifier(&i->machine_ready);
+
+    /*
+     * If the introspection object is created while parsing the command =
line,
+     * the machine_ready callback will be called later. At that time,
+     * it vm_introspection_init() fails, exit() will be called.
+     *
+     * If the introspection object is created through QMP, machine_init_=
done
+     * is already set and qemu_add_machine_init_done_notifier() will
+     * call our machine_done() callback. If vm_introspection_init() fail=
s,
+     * we don't call exit() and report the error back to the user.
+     */
+    if (i->init_error) {
+        *errp =3D i->init_error;
+        i->init_error =3D NULL;
+        return;
+    }
+}
+
+static void prop_set_chardev(Object *obj, const char *value, Error **err=
p)
+{
+    VMIntrospection *i =3D VM_INTROSPECTION(obj);
+
+    g_free(i->chardevid);
+    i->chardevid =3D g_strdup(value);
+}
+
+static void class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *uc =3D USER_CREATABLE_CLASS(oc);
+
+    uc->complete =3D complete;
+}
+
+static void instance_init(Object *obj)
+{
+    VMIntrospection *i =3D VM_INTROSPECTION(obj);
+
+    i->created_from_command_line =3D (qdev_hotplug =3D=3D false);
+
+    object_property_add_str(obj, "chardev", NULL, prop_set_chardev, NULL=
);
+}
+
+static void instance_finalize(Object *obj)
+{
+    VMIntrospection *i =3D VM_INTROSPECTION(obj);
+
+    g_free(i->chardevid);
+
+    error_free(i->init_error);
+}
+
+static const TypeInfo info =3D {
+    .name              =3D TYPE_VM_INTROSPECTION,
+    .parent            =3D TYPE_OBJECT,
+    .class_init        =3D class_init,
+    .instance_size     =3D sizeof(VMIntrospection),
+    .instance_finalize =3D instance_finalize,
+    .instance_init     =3D instance_init,
+    .interfaces        =3D (InterfaceInfo[]){
+        {TYPE_USER_CREATABLE},
+        {}
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&info);
+}
+
+type_init(register_types);
+
+static Error *vm_introspection_init(VMIntrospection *i)
+{
+    Error *err =3D NULL;
+    int kvmi_version;
+    Chardev *chr;
+
+    if (!kvm_enabled()) {
+        error_setg(&err, "VMI: missing KVM support");
+        return err;
+    }
+
+    kvmi_version =3D kvm_check_extension(kvm_state, KVM_CAP_INTROSPECTIO=
N);
+    if (kvmi_version =3D=3D 0) {
+        error_setg(&err,
+                   "VMI: missing kernel built with CONFIG_KVM_INTROSPECT=
ION");
+        return err;
+    }
+
+    chr =3D qemu_chr_find(i->chardevid);
+    if (!chr) {
+        error_setg(&err, "VMI: device '%s' not found", i->chardevid);
+        return err;
+    }
+
+    if (!object_property_get_bool(OBJECT(chr), "reconnecting", &err)) {
+        error_append_hint(&err, "VMI: missing reconnect=3DN for '%s'",
+                          i->chardevid);
+        return err;
+    }
+
+    i->chr =3D chr;
+
+    return NULL;
+}

