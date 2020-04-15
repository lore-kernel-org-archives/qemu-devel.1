Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AC2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116B4214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116B4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41097 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWhP-0000KF-8w
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPB-0001NF-88
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0005CN-2n
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:53 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052H-HW
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:50 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 A96CA30747D2; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 80EC9305B7A1;
 Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 16/26] kvm: vmi: intercept pause/resume
Date: Wed, 15 Apr 2020 03:59:28 +0300
Message-Id: <20200415005938.23895-17-alazar@bitdefender.com>
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
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marian Rotariu <marian.c.rotariu@gmail.com>

Because the introspection tool can run on another VM, suspending either
of these two VMs requires signaling the introspection tool to remove
any changes made to the introspected VM. This is done through the
KVM_INTROSPECTION_PREUNHOOK ioctl. KVM will send an event through the
introspection socket, if active. QEMU will wait for the introspection too=
l
to let the VM run without being introspected and close the socket.

While the guest is suspended, the socket reconnection is disabled.

CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c                | 147 +++++++++++++++++++++++++++++++++
 accel/stubs/Makefile.objs      |   1 +
 accel/stubs/vmi-stubs.c        |   7 ++
 include/sysemu/vmi-intercept.h |  21 +++++
 monitor/qmp-cmds.c             |  10 +++
 5 files changed, 186 insertions(+)
 create mode 100644 accel/stubs/vmi-stubs.c
 create mode 100644 include/sysemu/vmi-intercept.h

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 5beec2b091..151e27265a 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -14,12 +14,14 @@
 #include "qom/object_interfaces.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "sysemu/kvm.h"
 #include "crypto/secret.h"
 #include "crypto/hash.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
=20
+#include "sysemu/vmi-intercept.h"
 #include "sysemu/vmi-handshake.h"
=20
 #define HANDSHAKE_TIMEOUT_SEC 10
@@ -45,6 +47,10 @@ typedef struct VMIntrospection {
     GSource *hsk_timer;
     uint32_t handshake_timeout;
=20
+    int intercepted_action;
+
+    int reconnect_time;
+
     int64_t vm_start_time;
=20
     Notifier machine_ready;
@@ -59,6 +65,14 @@ typedef struct VMIntrospectionClass {
     VMIntrospection *uniq;
 } VMIntrospectionClass;
=20
+static const char *action_string[] =3D {
+    "none",
+    "suspend",
+    "resume",
+};
+
+static bool suspend_pending;
+
 #define TYPE_VM_INTROSPECTION "introspection"
=20
 #define VM_INTROSPECTION(obj) \
@@ -412,6 +426,39 @@ static bool connect_kernel(VMIntrospection *i, Error=
 **errp)
     return true;
 }
=20
+static void enable_socket_reconnect(VMIntrospection *i)
+{
+    if (i->sock_fd =3D=3D -1 && i->reconnect_time) {
+        qemu_chr_fe_reconnect_time(&i->sock, i->reconnect_time);
+        qemu_chr_fe_disconnect(&i->sock);
+        i->reconnect_time =3D 0;
+    }
+}
+
+static void maybe_disable_socket_reconnect(VMIntrospection *i)
+{
+    if (i->reconnect_time =3D=3D 0) {
+        info_report("VMI: disable socket reconnect");
+        i->reconnect_time =3D qemu_chr_fe_reconnect_time(&i->sock, 0);
+    }
+}
+
+static void continue_with_the_intercepted_action(VMIntrospection *i)
+{
+    switch (i->intercepted_action) {
+    case VMI_INTERCEPT_SUSPEND:
+        vm_stop(RUN_STATE_PAUSED);
+        break;
+    default:
+        error_report("VMI: %s: unexpected action %d",
+                     __func__, i->intercepted_action);
+        break;
+    }
+
+    info_report("VMI: continue with '%s'",
+                action_string[i->intercepted_action]);
+}
+
 /*
  * We should read only the handshake structure,
  * which might have a different size than what we expect.
@@ -495,6 +542,14 @@ static void chr_event_open(VMIntrospection *i)
 {
     Error *local_err =3D NULL;
=20
+    if (suspend_pending) {
+        info_report("VMI: %s: too soon (suspend=3D%d)",
+                    __func__, suspend_pending);
+        maybe_disable_socket_reconnect(i);
+        qemu_chr_fe_disconnect(&i->sock);
+        return;
+    }
+
     if (!send_handshake_info(i, &local_err)) {
         error_append_hint(&local_err, "reconnecting\n");
         warn_report_err(local_err);
@@ -522,6 +577,15 @@ static void chr_event_close(VMIntrospection *i)
     }
=20
     cancel_handshake_timer(i);
+
+    if (suspend_pending) {
+        maybe_disable_socket_reconnect(i);
+
+        if (i->intercepted_action !=3D VMI_INTERCEPT_NONE) {
+            continue_with_the_intercepted_action(i);
+            i->intercepted_action =3D VMI_INTERCEPT_NONE;
+        }
+    }
 }
=20
 static void chr_event(void *opaque, QEMUChrEvent event)
@@ -540,6 +604,89 @@ static void chr_event(void *opaque, QEMUChrEvent eve=
nt)
     }
 }
=20
+static VMIntrospection *vm_introspection_object(void)
+{
+    VMIntrospectionClass *ic;
+
+    ic =3D VM_INTROSPECTION_CLASS(object_class_by_name(TYPE_VM_INTROSPEC=
TION));
+
+    return ic ? ic->uniq : NULL;
+}
+
+/*
+ * This ioctl succeeds only when KVM signals the introspection tool.
+ * (the socket is connected and the event was sent without error).
+ */
+static bool signal_introspection_tool_to_unhook(VMIntrospection *i)
+{
+    int err;
+
+    err =3D kvm_vm_ioctl(kvm_state, KVM_INTROSPECTION_PREUNHOOK, NULL);
+
+    return !err;
+}
+
+static bool record_intercept_action(VMI_intercept_command action)
+{
+    switch (action) {
+    case VMI_INTERCEPT_SUSPEND:
+        suspend_pending =3D true;
+        break;
+    case VMI_INTERCEPT_RESUME:
+        suspend_pending =3D false;
+        break;
+    default:
+        return false;
+    }
+
+    return true;
+}
+
+static bool intercept_action(VMIntrospection *i,
+                             VMI_intercept_command action, Error **errp)
+{
+    if (i->intercepted_action !=3D VMI_INTERCEPT_NONE) {
+        error_report("VMI: unhook in progress");
+        return false;
+    }
+
+    switch (action) {
+    case VMI_INTERCEPT_RESUME:
+        enable_socket_reconnect(i);
+        return false;
+    default:
+        break;
+    }
+
+    if (!signal_introspection_tool_to_unhook(i)) {
+        disconnect_and_unhook_kvmi(i);
+        return false;
+    }
+
+    i->intercepted_action =3D action;
+    return true;
+}
+
+bool vm_introspection_intercept(VMI_intercept_command action, Error **er=
rp)
+{
+    VMIntrospection *i =3D vm_introspection_object();
+    bool intercepted =3D false;
+
+    info_report("VMI: intercept command: %s",
+                action < ARRAY_SIZE(action_string)
+                ? action_string[action]
+                : "unknown");
+
+    if (record_intercept_action(action) && i) {
+        intercepted =3D intercept_action(i, action, errp);
+    }
+
+    info_report("VMI: intercept action: %s",
+                intercepted ? "delayed" : "continue");
+
+    return intercepted;
+}
+
 static void vm_introspection_reset(void *opaque)
 {
     VMIntrospection *i =3D opaque;
diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index 3894caf95d..fcec6edf0f 100644
--- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -2,4 +2,5 @@ obj-$(call lnot,$(CONFIG_HAX))  +=3D hax-stub.o
 obj-$(call lnot,$(CONFIG_HVF))  +=3D hvf-stub.o
 obj-$(call lnot,$(CONFIG_WHPX)) +=3D whpx-stub.o
 obj-$(call lnot,$(CONFIG_KVM))  +=3D kvm-stub.o
+obj-$(call lnot,$(CONFIG_KVM))  +=3D vmi-stubs.o
 obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o
diff --git a/accel/stubs/vmi-stubs.c b/accel/stubs/vmi-stubs.c
new file mode 100644
index 0000000000..1bd93b2ca5
--- /dev/null
+++ b/accel/stubs/vmi-stubs.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "sysemu/vmi-intercept.h"
+
+bool vm_introspection_intercept(VMI_intercept_command ic, Error **errp)
+{
+    return false;
+}
diff --git a/include/sysemu/vmi-intercept.h b/include/sysemu/vmi-intercep=
t.h
new file mode 100644
index 0000000000..06998ff18a
--- /dev/null
+++ b/include/sysemu/vmi-intercept.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU VM Introspection
+ *
+ * Copyright (C) 2018-2020 Bitdefender S.R.L.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_VMI_INTERCEPT_H
+#define QEMU_VMI_INTERCEPT_H
+
+typedef enum {
+    VMI_INTERCEPT_NONE =3D 0,
+    VMI_INTERCEPT_SUSPEND,
+    VMI_INTERCEPT_RESUME,
+} VMI_intercept_command;
+
+bool vm_introspection_intercept(VMI_intercept_command ic, Error **errp);
+
+#endif /* QEMU_VMI_INTERCEPT_H */
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 864cbfa32e..eabd20fca3 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -39,6 +39,8 @@
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi_dev_interface.h"
=20
+#include "sysemu/vmi-intercept.h"
+
 NameInfo *qmp_query_name(Error **errp)
 {
     NameInfo *info =3D g_malloc0(sizeof(*info));
@@ -87,6 +89,9 @@ void qmp_stop(Error **errp)
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         autostart =3D 0;
     } else {
+        if (vm_introspection_intercept(VMI_INTERCEPT_SUSPEND, errp)) {
+            return;
+        }
         vm_stop(RUN_STATE_PAUSED);
     }
 }
@@ -158,6 +163,11 @@ void qmp_cont(Error **errp)
         autostart =3D 1;
     } else {
         vm_start();
+        /*
+         * this interception is post-event as we might need the vm to ru=
n before
+         * doing the interception, therefore we do not need the return v=
alue.
+         */
+        vm_introspection_intercept(VMI_INTERCEPT_RESUME, errp);
     }
 }
=20

