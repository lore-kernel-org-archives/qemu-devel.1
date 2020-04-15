Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D4EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6ACC206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6ACC206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWe4-0004r9-2j
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPB-0001Mz-4Z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP7-0005BY-MB
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:53 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP7-00050u-8J
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:49 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 11C7830747C8
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id F0C46305B7A1;
 Wed, 15 Apr 2020 03:59:34 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 10/26] kvm: vmi: add the handshake with the
 introspection tool
Date: Wed, 15 Apr 2020 03:59:22 +0300
Message-Id: <20200415005938.23895-11-alazar@bitdefender.com>
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

QEMU sends the name, the UUID and the VM start time and expects the
hash of a secret shared with the introspection tool that can be used to
authenticate it.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c                | 290 +++++++++++++++++++++++++++++++++
 include/sysemu/vmi-handshake.h |  45 +++++
 2 files changed, 335 insertions(+)
 create mode 100644 include/sysemu/vmi-handshake.h

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 883c666a2a..57ded2f69c 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
@@ -16,6 +17,8 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
=20
+#include "sysemu/vmi-handshake.h"
+
 typedef struct VMIntrospection {
     Object parent_obj;
=20
@@ -23,9 +26,19 @@ typedef struct VMIntrospection {
=20
     char *chardevid;
     Chardev *chr;
+    CharBackend sock;
+    int sock_fd;
+
+    qemu_vmi_from_introspector hsk_in;
+    uint64_t hsk_in_read_pos;
+    uint64_t hsk_in_read_size;
+
+    int64_t vm_start_time;
=20
     Notifier machine_ready;
     bool created_from_command_line;
+
+    bool kvmi_hooked;
 } VMIntrospection;
=20
 #define TYPE_VM_INTROSPECTION "introspection"
@@ -50,6 +63,11 @@ static void machine_ready(Notifier *notifier, void *da=
ta)
     }
 }
=20
+static void update_vm_start_time(VMIntrospection *i)
+{
+    i->vm_start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+}
+
 static void complete(UserCreatable *uc, Error **errp)
 {
     VMIntrospection *i =3D VM_INTROSPECTION(uc);
@@ -87,6 +105,13 @@ static void prop_set_chardev(Object *obj, const char =
*value, Error **errp)
     i->chardevid =3D g_strdup(value);
 }
=20
+static bool chardev_is_connected(VMIntrospection *i, Error **errp)
+{
+    Object *obj =3D OBJECT(i->chr);
+
+    return obj && object_property_get_bool(obj, "connected", errp);
+}
+
 static void class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *uc =3D USER_CREATABLE_CLASS(oc);
@@ -98,17 +123,60 @@ static void instance_init(Object *obj)
 {
     VMIntrospection *i =3D VM_INTROSPECTION(obj);
=20
+    i->sock_fd =3D -1;
     i->created_from_command_line =3D (qdev_hotplug =3D=3D false);
=20
+    update_vm_start_time(i);
+
     object_property_add_str(obj, "chardev", NULL, prop_set_chardev, NULL=
);
 }
=20
+static void disconnect_chardev(VMIntrospection *i)
+{
+    if (chardev_is_connected(i, NULL)) {
+        qemu_chr_fe_disconnect(&i->sock);
+    }
+}
+
+static void unhook_kvmi(VMIntrospection *i)
+{
+    if (i->kvmi_hooked) {
+        if (kvm_vm_ioctl(kvm_state, KVM_INTROSPECTION_UNHOOK, NULL)) {
+            error_report("VMI: ioctl/KVM_INTROSPECTION_UNHOOK failed, er=
rno %d",
+                         errno);
+        }
+        i->kvmi_hooked =3D false;
+    }
+}
+
+static void shutdown_socket_fd(VMIntrospection *i)
+{
+    /* signal both ends (kernel, introspector) */
+    if (i->sock_fd !=3D -1) {
+        shutdown(i->sock_fd, SHUT_RDWR);
+        i->sock_fd =3D -1;
+    }
+}
+
+static void disconnect_and_unhook_kvmi(VMIntrospection *i)
+{
+    shutdown_socket_fd(i);
+    disconnect_chardev(i);
+    unhook_kvmi(i);
+}
+
 static void instance_finalize(Object *obj)
 {
     VMIntrospection *i =3D VM_INTROSPECTION(obj);
=20
     g_free(i->chardevid);
=20
+    if (i->chr) {
+        shutdown_socket_fd(i);
+        qemu_chr_fe_deinit(&i->sock, true);
+        unhook_kvmi(i);
+    }
+
     error_free(i->init_error);
 }
=20
@@ -132,6 +200,210 @@ static void register_types(void)
=20
 type_init(register_types);
=20
+static bool send_handshake_info(VMIntrospection *i, Error **errp)
+{
+    qemu_vmi_to_introspector send =3D {};
+    const char *vm_name;
+    int r;
+
+    send.struct_size =3D sizeof(send);
+    send.start_time =3D i->vm_start_time;
+    memcpy(&send.uuid, &qemu_uuid, sizeof(send.uuid));
+    vm_name =3D qemu_get_vm_name();
+    if (vm_name) {
+        snprintf(send.name, sizeof(send.name), "%s", vm_name);
+        send.name[sizeof(send.name) - 1] =3D 0;
+    }
+
+    r =3D qemu_chr_fe_write_all(&i->sock, (uint8_t *)&send, sizeof(send)=
);
+    if (r !=3D sizeof(send)) {
+        error_setg_errno(errp, errno, "VMI: error writing to '%s'",
+                         i->chardevid);
+        return false;
+    }
+
+    /* tcp_chr_write may call tcp_chr_disconnect/CHR_EVENT_CLOSED */
+    if (!chardev_is_connected(i, errp)) {
+        error_append_hint(errp, "VMI: qemu_chr_fe_write_all() failed");
+        return false;
+    }
+
+    return true;
+}
+
+static bool validate_handshake(VMIntrospection *i, Error **errp)
+{
+    uint32_t min_accepted_size;
+
+    min_accepted_size =3D offsetof(qemu_vmi_from_introspector, cookie_ha=
sh)
+                        + QEMU_VMI_COOKIE_HASH_SIZE;
+
+    if (i->hsk_in.struct_size < min_accepted_size) {
+        error_setg(errp, "VMI: not enough or invalid handshake data");
+        return false;
+    }
+
+    /*
+     * Check hsk_in.struct_size and sizeof(hsk_in) before accessing any
+     * other fields. We might get fewer bytes from applications using
+     * old versions if we extended the qemu_vmi_from_introspector struct=
ure.
+     */
+
+    return true;
+}
+
+static bool connect_kernel(VMIntrospection *i, Error **errp)
+{
+    struct kvm_introspection_feature commands, events;
+    struct kvm_introspection_hook kernel;
+    const __s32 all_ids =3D -1;
+
+    memset(&kernel, 0, sizeof(kernel));
+    memcpy(kernel.uuid, &qemu_uuid, sizeof(kernel.uuid));
+    kernel.fd =3D i->sock_fd;
+
+    if (kvm_vm_ioctl(kvm_state, KVM_INTROSPECTION_HOOK, &kernel)) {
+        error_setg_errno(errp, -errno,
+                         "VMI: ioctl/KVM_INTROSPECTION_HOOK failed");
+        if (errno =3D=3D -EPERM) {
+            error_append_hint(errp,
+                              "Reload the kvm module with kvm.introspect=
ion=3Don");
+        }
+        return false;
+    }
+
+    i->kvmi_hooked =3D true;
+
+    commands.allow =3D 1;
+    commands.id =3D all_ids;
+    if (kvm_vm_ioctl(kvm_state, KVM_INTROSPECTION_COMMAND, &commands)) {
+        error_setg_errno(errp, -errno,
+                         "VMI: ioctl/KVM_INTROSPECTION_COMMAND failed");
+        unhook_kvmi(i);
+        return false;
+    }
+
+    events.allow =3D 1;
+    events.id =3D all_ids;
+    if (kvm_vm_ioctl(kvm_state, KVM_INTROSPECTION_EVENT, &events)) {
+        error_setg_errno(errp, -errno,
+                         "VMI: ioctl/KVM_INTROSPECTION_EVENT failed");
+        unhook_kvmi(i);
+        return false;
+    }
+
+    return true;
+}
+
+/*
+ * We should read only the handshake structure,
+ * which might have a different size than what we expect.
+ */
+static int chr_can_read(void *opaque)
+{
+    VMIntrospection *i =3D opaque;
+
+    if (i->sock_fd =3D=3D -1) {
+        return 0;
+    }
+
+    /* first, we read the incoming structure size */
+    if (i->hsk_in_read_pos =3D=3D 0) {
+        return sizeof(i->hsk_in.struct_size);
+    }
+
+    /* validate the incoming structure size */
+    if (i->hsk_in.struct_size < sizeof(i->hsk_in.struct_size)) {
+        return 0;
+    }
+
+    /* read the rest of the incoming structure */
+    return i->hsk_in.struct_size - i->hsk_in_read_pos;
+}
+
+static bool enough_bytes_for_handshake(VMIntrospection *i)
+{
+    return i->hsk_in_read_pos  >=3D sizeof(i->hsk_in.struct_size)
+        && i->hsk_in_read_size =3D=3D i->hsk_in.struct_size;
+}
+
+static void validate_and_connect(VMIntrospection *i)
+{
+    Error *local_err =3D NULL;
+
+    if (!validate_handshake(i, &local_err) || !connect_kernel(i, &local_=
err)) {
+        error_append_hint(&local_err, "reconnecting\n");
+        warn_report_err(local_err);
+        disconnect_chardev(i);
+    }
+}
+
+static void chr_read(void *opaque, const uint8_t *buf, int size)
+{
+    VMIntrospection *i =3D opaque;
+    size_t to_read;
+
+    i->hsk_in_read_size +=3D size;
+
+    to_read =3D sizeof(i->hsk_in) - i->hsk_in_read_pos;
+    if (to_read > size) {
+        to_read =3D size;
+    }
+
+    if (to_read) {
+        memcpy((uint8_t *)&i->hsk_in + i->hsk_in_read_pos, buf, to_read)=
;
+        i->hsk_in_read_pos +=3D to_read;
+    }
+
+    if (enough_bytes_for_handshake(i)) {
+        validate_and_connect(i);
+    }
+}
+
+static void chr_event_open(VMIntrospection *i)
+{
+    Error *local_err =3D NULL;
+
+    if (!send_handshake_info(i, &local_err)) {
+        error_append_hint(&local_err, "reconnecting\n");
+        warn_report_err(local_err);
+        disconnect_chardev(i);
+        return;
+    }
+
+    info_report("VMI: introspection tool connected");
+
+    i->sock_fd =3D object_property_get_int(OBJECT(i->chr), "fd", NULL);
+
+    memset(&i->hsk_in, 0, sizeof(i->hsk_in));
+    i->hsk_in_read_pos =3D 0;
+    i->hsk_in_read_size =3D 0;
+}
+
+static void chr_event_close(VMIntrospection *i)
+{
+    if (i->sock_fd !=3D -1) {
+        warn_report("VMI: introspection tool disconnected");
+        disconnect_and_unhook_kvmi(i);
+    }
+}
+
+static void chr_event(void *opaque, QEMUChrEvent event)
+{
+    VMIntrospection *i =3D opaque;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        chr_event_open(i);
+        break;
+    case CHR_EVENT_CLOSED:
+        chr_event_close(i);
+        break;
+    default:
+        break;
+    }
+}
+
 static Error *vm_introspection_init(VMIntrospection *i)
 {
     Error *err =3D NULL;
@@ -162,7 +434,25 @@ static Error *vm_introspection_init(VMIntrospection =
*i)
         return err;
     }
=20
+    if (!qemu_chr_fe_init(&i->sock, chr, &err)) {
+        error_append_hint(&err, "VMI: device '%s' not initialized",
+                          i->chardevid);
+        return err;
+    }
+
     i->chr =3D chr;
=20
+    qemu_chr_fe_set_handlers(&i->sock, chr_can_read, chr_read, chr_event=
,
+                             NULL, i, NULL, true);
+
+    /*
+     * The reconnect timer is triggered by either machine init or by a c=
hardev
+     * disconnect. For the QMP creation, when the machine is already sta=
rted,
+     * use an artificial disconnect just to restart the timer.
+     */
+    if (!i->created_from_command_line) {
+        qemu_chr_fe_disconnect(&i->sock);
+    }
+
     return NULL;
 }
diff --git a/include/sysemu/vmi-handshake.h b/include/sysemu/vmi-handshak=
e.h
new file mode 100644
index 0000000000..19bdfb6740
--- /dev/null
+++ b/include/sysemu/vmi-handshake.h
@@ -0,0 +1,45 @@
+/*
+ * QEMU VM Introspection Handshake
+ *
+ */
+
+#ifndef QEMU_VMI_HANDSHAKE_H
+#define QEMU_VMI_HANDSHAKE_H
+
+enum { QEMU_VMI_NAME_SIZE =3D 64 };
+enum { QEMU_VMI_COOKIE_HASH_SIZE =3D 20};
+
+/**
+ * qemu_vmi_to_introspector:
+ *
+ * This structure is passed to the introspection tool during the handsha=
ke.
+ *
+ * @struct_size: the structure size
+ * @uuid: the UUID
+ * @start_time: the VM start time
+ * @name: the VM name
+ */
+typedef struct qemu_vmi_to_introspector {
+    uint32_t struct_size;
+    uint8_t  uuid[16];
+    uint32_t padding;
+    int64_t  start_time;
+    char     name[QEMU_VMI_NAME_SIZE];
+    /* ... */
+} qemu_vmi_to_introspector;
+
+/**
+ * qemu_vmi_from_introspector:
+ *
+ * This structure is passed by the introspection tool during the handsha=
ke.
+ *
+ * @struct_size: the structure size
+ * @cookie_hash: the hash of the cookie know by the introspection tool
+ */
+typedef struct qemu_vmi_from_introspector {
+    uint32_t struct_size;
+    uint8_t  cookie_hash[QEMU_VMI_COOKIE_HASH_SIZE];
+    /* ... */
+} qemu_vmi_from_introspector;
+
+#endif /* QEMU_VMI_HANDSHAKE_H */

