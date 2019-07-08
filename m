Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0447AC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17582084A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17582084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkO3N-0004NF-CH
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 03:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkO1T-0002SJ-9e
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkO1P-000158-S2
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:25:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hkO1P-00013p-HR
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:25:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCBC6A836
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 07:25:10 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7174753C30;
 Mon,  8 Jul 2019 07:25:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 11:24:37 +0400
Message-Id: <20190708072437.3339-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190708072437.3339-1-marcandre.lureau@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 08 Jul 2019 07:25:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] Add dbus-vmstate object
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When instanciated, this object will connect to the given D-Bus
bus. During migration, it will take the data from org.qemu.VMState1
instances.

See documentation for further details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS                   |   6 +
 backends/Makefile.objs        |   4 +
 backends/dbus-vmstate.c       | 497 ++++++++++++++++++++++++++++++++++
 configure                     |   7 +
 docs/interop/dbus-vmstate.rst |  64 +++++
 docs/interop/index.rst        |   1 +
 tests/Makefile.include        |  18 +-
 tests/dbus-vmstate-test.c     | 387 ++++++++++++++++++++++++++
 tests/dbus-vmstate1.xml       |  12 +
 9 files changed, 995 insertions(+), 1 deletion(-)
 create mode 100644 backends/dbus-vmstate.c
 create mode 100644 docs/interop/dbus-vmstate.rst
 create mode 100644 tests/dbus-vmstate-test.c
 create mode 100644 tests/dbus-vmstate1.xml

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cce50287a..9fa592f1b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2144,6 +2144,12 @@ F: tests/migration-test.c
 F: docs/devel/migration.rst
 F: qapi/migration.json
=20
+DBus VMState
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+S: Maintained
+F: backends/dbus-vmstate.c
+F: tests/dbus-vmstate*
+
 Seccomp
 M: Eduardo Otubo <otubo@redhat.com>
 S: Supported
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 981e8e122f..dbbe12b225 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -17,3 +17,7 @@ endif
 common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) +=3D vhost=
-user.o
=20
 common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
+
+common-obj-$(CONFIG_GIO) +=3D dbus-vmstate.o
+dbus-vmstate.o-cflags =3D $(GIO_CFLAGS)
+dbus-vmstate.o-libs =3D $(GIO_LIBS)
diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
new file mode 100644
index 0000000000..f9117d9fce
--- /dev/null
+++ b/backends/dbus-vmstate.c
@@ -0,0 +1,497 @@
+/*
+ * QEMU dbus-vmstate
+ *
+ * Copyright (C) 2019 Red Hat Inc
+ *
+ * Authors:
+ *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qapi/qmp/qerror.h"
+#include "migration/register.h"
+#include "migration/qemu-file-types.h"
+#include <gio/gio.h>
+
+typedef struct DBusVMState DBusVMState;
+typedef struct DBusVMStateClass DBusVMStateClass;
+
+#define TYPE_DBUS_VMSTATE "dbus-vmstate"
+#define DBUS_VMSTATE(obj)                                \
+    OBJECT_CHECK(DBusVMState, (obj), TYPE_DBUS_VMSTATE)
+#define DBUS_VMSTATE_GET_CLASS(obj)                              \
+    OBJECT_GET_CLASS(DBusVMStateClass, (obj), TYPE_DBUS_VMSTATE)
+#define DBUS_VMSTATE_CLASS(klass)                                    \
+    OBJECT_CLASS_CHECK(DBusVMStateClass, (klass), TYPE_DBUS_VMSTATE)
+
+struct DBusVMStateClass {
+    ObjectClass parent_class;
+};
+
+struct DBusVMState {
+    Object parent;
+
+    GDBusConnection *bus;
+    char *dbus_addr;
+    char *id_list;
+};
+
+static const GDBusPropertyInfo vmstate_property_info[] =3D {
+    { -1, (char *) "Id", (char *) "s",
+      G_DBUS_PROPERTY_INFO_FLAGS_READABLE, NULL },
+};
+
+static const GDBusPropertyInfo * const vmstate_property_info_pointers[] =
=3D {
+    &vmstate_property_info[0],
+    NULL
+};
+
+static const GDBusInterfaceInfo vmstate1_interface_info =3D {
+    -1,
+    (char *) "org.qemu.VMState1",
+    (GDBusMethodInfo **) NULL,
+    (GDBusSignalInfo **) NULL,
+    (GDBusPropertyInfo **) &vmstate_property_info_pointers,
+    NULL,
+};
+
+#define DBUS_VMSTATE_SIZE_LIMIT (1 << 20) /* 1mb */
+#define DBUS_VMSTATE_SECTION 0x00
+#define DBUS_VMSTATE_EOF 0xff
+
+
+static char **
+dbus_get_vmstate1_names(DBusVMState *self, GError **err)
+{
+    char **names =3D NULL;
+    GDBusProxy *proxy;
+    GVariant *result =3D NULL, *child =3D NULL;
+
+    proxy =3D g_dbus_proxy_new_sync(self->bus, G_DBUS_PROXY_FLAGS_NONE, =
NULL,
+                                  "org.freedesktop.DBus",
+                                  "/org/freedesktop/DBus",
+                                  "org.freedesktop.DBus",
+                                  NULL, err);
+    if (!proxy) {
+        goto end;
+    }
+
+    result =3D g_dbus_proxy_call_sync(proxy, "ListQueuedOwners",
+                                    g_variant_new("(s)", "org.qemu.VMSta=
te1"),
+                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
+                                    -1, NULL, err);
+    if (!result) {
+        goto end;
+    }
+
+    child =3D g_variant_get_child_value(result, 0);
+    names =3D g_variant_dup_strv(child, NULL);
+
+end:
+    g_clear_pointer(&child, g_variant_unref);
+    g_clear_pointer(&result, g_variant_unref);
+    g_clear_object(&proxy);
+    return names;
+}
+
+static GHashTable *
+get_id_list_set(DBusVMState *self)
+{
+    char **ids;
+    GHashTable *set;
+    int i;
+
+    if (!self->id_list) {
+        return NULL;
+    }
+
+    ids =3D g_strsplit(self->id_list, ",", -1);
+    set =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL)=
;
+    for (i =3D 0; ids[i]; i++) {
+        g_hash_table_add(set, ids[i]);
+        ids[i] =3D NULL;
+    }
+
+    g_strfreev(ids);
+    return set;
+}
+
+static GHashTable *
+dbus_get_proxies(DBusVMState *self, GError **err)
+{
+    GError *local_err =3D NULL;
+    GHashTable *proxies =3D NULL;
+    GVariant *result =3D NULL;
+    char **names =3D NULL;
+    char **left =3D NULL;
+    GHashTable *ids =3D get_id_list_set(self);
+    size_t i;
+
+    proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+                                    g_free, g_object_unref);
+
+    names =3D dbus_get_vmstate1_names(self, &local_err);
+    if (!names) {
+        if (g_error_matches(local_err,
+                            G_DBUS_ERROR, G_DBUS_ERROR_NAME_HAS_NO_OWNER=
)) {
+            return proxies;
+        }
+        g_propagate_error(err, local_err);
+        goto err;
+    }
+
+    for (i =3D 0; names[i]; i++) {
+        GDBusProxy *proxy;
+        char *id;
+        size_t size;
+
+        proxy =3D g_dbus_proxy_new_sync(self->bus, G_DBUS_PROXY_FLAGS_NO=
NE,
+                    (GDBusInterfaceInfo *) &vmstate1_interface_info,
+                    names[i],
+                    "/org/qemu/VMState1",
+                    "org.qemu.VMState1",
+                    NULL, err);
+        if (!proxy) {
+            goto err;
+        }
+
+        result =3D g_dbus_proxy_get_cached_property(proxy, "Id");
+        if (!result) {
+            g_set_error_literal(err, G_IO_ERROR, G_IO_ERROR_FAILED,
+                                "VMState Id property is missing.");
+            g_clear_object(&proxy);
+            goto err;
+        }
+
+        id =3D g_variant_dup_string(result, &size);
+        if (ids && !g_hash_table_remove(ids, id)) {
+            g_free(id);
+            g_clear_object(&proxy);
+            continue;
+        }
+        if (size =3D=3D 0 || size >=3D 256) {
+            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
+                        "VMState Id '%s' is invalid.", id);
+            g_free(id);
+            g_clear_object(&proxy);
+            goto err;
+        }
+
+        if (!g_hash_table_insert(proxies, id, proxy)) {
+            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
+                        "Duplicated VMState Id '%s'", id);
+            goto err;
+        }
+
+        g_clear_pointer(&result, g_variant_unref);
+    }
+
+    if (ids) {
+        left =3D (char **)g_hash_table_get_keys_as_array(ids, NULL);
+        if (*left) {
+            char *leftids =3D g_strjoinv(",", left);
+            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
+                        "Required VMState Id are missing: %s", leftids);
+            g_free(leftids);
+            goto err;
+        }
+        g_free(left);
+    }
+
+    g_clear_pointer(&ids, g_hash_table_unref);
+    g_strfreev(names);
+    return proxies;
+
+err:
+    g_free(left);
+    g_clear_pointer(&proxies, g_hash_table_unref);
+    g_clear_pointer(&result, g_variant_unref);
+    g_clear_pointer(&ids, g_hash_table_unref);
+    g_strfreev(names);
+    return NULL;
+}
+
+static int
+dbus_load_state_proxy(GDBusProxy *proxy, const uint8_t *data, size_t siz=
e)
+{
+    GError *err =3D NULL;
+    GVariant *value, *result;
+    int ret =3D -1;
+
+    value =3D g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
+                                      data, size, sizeof(char));
+    result =3D g_dbus_proxy_call_sync(proxy, "Load",
+                                    g_variant_new("(@ay)", value),
+                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
+                                    -1, NULL, &err);
+    if (!result) {
+        error_report("Failed to Load: %s", err->message);
+        goto end;
+    }
+
+    ret =3D 0;
+
+end:
+    g_clear_pointer(&result, g_variant_unref);
+    g_clear_error(&err);
+    return ret;
+}
+
+static int
+dbus_load_state(QEMUFile *f, void *opaque, int version_id)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(opaque);
+    GError *err =3D NULL;
+    GHashTable *proxies =3D NULL;
+    uint8_t *data =3D NULL;
+    int ret =3D -1;
+
+    proxies =3D dbus_get_proxies(self, &err);
+    if (!proxies) {
+        error_report("Failed to get proxies: %s", err->message);
+        goto end;
+    }
+
+    while (qemu_get_byte(f) !=3D DBUS_VMSTATE_EOF) {
+        GDBusProxy *proxy =3D NULL;
+        char id[256];
+        unsigned int size;
+
+        if (qemu_get_counted_string(f, id) =3D=3D 0) {
+            error_report("Invalid vmstate Id");
+            goto end;
+        }
+
+        proxy =3D g_hash_table_lookup(proxies, id);
+        if (!proxy) {
+            error_report("Failed to find proxy Id '%s'", id);
+            goto end;
+        }
+
+        size =3D qemu_get_be32(f);
+        if (size > DBUS_VMSTATE_SIZE_LIMIT) {
+            error_report("Invalid vmstate size: %u", size);
+            goto end;
+        }
+
+        data =3D g_malloc(size);
+        if (qemu_get_buffer(f, data, size) !=3D size) {
+            error_report("Failed to read %u bytes", size);
+            goto end;
+        }
+
+        if (dbus_load_state_proxy(proxy, data, size) < 0) {
+            error_report("Failed to restore Id '%s'", id);
+            goto end;
+        }
+
+        g_clear_pointer(&data, g_free);
+        g_hash_table_remove(proxies, id);
+    }
+
+    if (g_hash_table_size(proxies) !=3D 0) {
+        error_report("Missing DBus states from migration stream.");
+        goto end;
+    }
+
+    ret =3D 0;
+
+end:
+    g_clear_pointer(&proxies, g_hash_table_unref);
+    g_clear_pointer(&data, g_free);
+    g_clear_error(&err);
+    return ret;
+}
+
+static void
+dbus_save_state_proxy(gpointer key,
+                      gpointer value,
+                      gpointer user_data)
+{
+    QEMUFile *f =3D user_data;
+    const char *id =3D key;
+    GDBusProxy *proxy =3D value;
+    GVariant *result =3D NULL, *child =3D NULL;
+    const uint8_t *data;
+    size_t size;
+    GError *err =3D NULL;
+
+    result =3D g_dbus_proxy_call_sync(proxy, "Save",
+                                    NULL, G_DBUS_CALL_FLAGS_NO_AUTO_STAR=
T,
+                                    -1, NULL, &err);
+    if (!result) {
+        error_report("Failed to Save: %s", err->message);
+        g_clear_error(&err);
+        goto end;
+    }
+
+    child =3D g_variant_get_child_value(result, 0);
+    data =3D g_variant_get_fixed_array(child, &size, sizeof(char));
+    if (!data) {
+        error_report("Failed to Save: not a byte array");
+        goto end;
+    }
+    if (size > DBUS_VMSTATE_SIZE_LIMIT) {
+        error_report("Too much vmstate data to save: %lu", size);
+        goto end;
+    }
+
+    qemu_put_byte(f, DBUS_VMSTATE_SECTION);
+    qemu_put_counted_string(f, id);
+    qemu_put_be32(f, size);
+    qemu_put_buffer(f, data, size);
+
+end:
+    g_clear_pointer(&child, g_variant_unref);
+    g_clear_pointer(&result, g_variant_unref);
+}
+
+static void
+dbus_save_state(QEMUFile *f, void *opaque)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(opaque);
+    GHashTable *proxies;
+    GError *err =3D NULL;
+
+    proxies =3D dbus_get_proxies(self, &err);
+    if (!proxies) {
+        error_report("Failed to get proxies: %s", err->message);
+        goto end;
+    }
+
+    /* TODO: how to report an error and cancel? */
+    g_hash_table_foreach(proxies, dbus_save_state_proxy, f);
+    qemu_put_byte(f, DBUS_VMSTATE_EOF);
+
+end:
+    g_clear_error(&err);
+    g_clear_pointer(&proxies, g_hash_table_unref);
+}
+
+static const SaveVMHandlers savevm_handlers =3D {
+    .save_state =3D dbus_save_state,
+    .load_state =3D dbus_load_state,
+};
+
+static void
+dbus_vmstate_complete(UserCreatable *uc, Error **errp)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(uc);
+    GError *err =3D NULL;
+    GDBusConnection *bus;
+
+    if (!object_resolve_path_type("", TYPE_DBUS_VMSTATE, NULL)) {
+        error_setg(errp, "There is already an instance of %s",
+                   TYPE_DBUS_VMSTATE);
+        return;
+    }
+
+    if (!self->dbus_addr) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "addr");
+        return;
+    }
+
+    if (register_savevm_live(NULL, TYPE_DBUS_VMSTATE, 0, 0,
+                             &savevm_handlers, self) < 0) {
+        error_setg(errp, "Failed to register savevm handler");
+        return;
+    }
+
+    bus =3D g_dbus_connection_new_for_address_sync(self->dbus_addr,
+             G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT |
+             G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION,
+             NULL, NULL, &err);
+    if (err) {
+        error_setg(errp, "failed to connect to DBus: '%s'", err->message=
);
+        g_clear_error(&err);
+    }
+
+    self->bus =3D bus;
+}
+
+static void
+dbus_vmstate_finalize(Object *o)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(o);
+
+    unregister_savevm(NULL, TYPE_DBUS_VMSTATE, self);
+    g_clear_object(&self->bus);
+    g_free(self->dbus_addr);
+    g_free(self->id_list);
+}
+
+static char *
+get_dbus_addr(Object *o, Error **errp)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(o);
+
+    return g_strdup(self->dbus_addr);
+}
+
+static void
+set_dbus_addr(Object *o, const char *str, Error **errp)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(o);
+
+    g_free(self->dbus_addr);
+    self->dbus_addr =3D g_strdup(str);
+}
+
+static char *
+get_id_list(Object *o, Error **errp)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(o);
+
+    return g_strdup(self->id_list);
+}
+
+static void
+set_id_list(Object *o, const char *str, Error **errp)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(o);
+
+    g_free(self->id_list);
+    self->id_list =3D g_strdup(str);
+}
+
+static void
+dbus_vmstate_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
+
+    ucc->complete =3D dbus_vmstate_complete;
+
+    object_class_property_add_str(oc, "addr",
+                                  get_dbus_addr, set_dbus_addr,
+                                  &error_abort);
+    object_class_property_add_str(oc, "id-list",
+                                  get_id_list, set_id_list,
+                                  &error_abort);
+}
+
+static const TypeInfo dbus_vmstate_info =3D {
+    .name =3D TYPE_DBUS_VMSTATE,
+    .parent =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(DBusVMState),
+    .instance_finalize =3D dbus_vmstate_finalize,
+    .class_size =3D sizeof(DBusVMStateClass),
+    .class_init =3D dbus_vmstate_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void
+register_types(void)
+{
+    type_register_static(&dbus_vmstate_info);
+}
+
+type_init(register_types);
diff --git a/configure b/configure
index 4983c8b533..2a64f85d20 100755
--- a/configure
+++ b/configure
@@ -3659,10 +3659,16 @@ if $pkg_config --atleast-version=3D$glib_req_ver =
gio-2.0; then
     gio=3Dyes
     gio_cflags=3D$($pkg_config --cflags gio-2.0)
     gio_libs=3D$($pkg_config --libs gio-2.0)
+    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)
 else
     gio=3Dno
 fi
=20
+if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0; then
+    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-2.0)"
+    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"
+fi
+
 # Sanity check that the current size_t matches the
 # size that glib thinks it should be. This catches
 # problems on multi-arch where people try to build
@@ -6823,6 +6829,7 @@ if test "$gio" =3D "yes" ; then
     echo "CONFIG_GIO=3Dy" >> $config_host_mak
     echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
     echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
+    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
 fi
 echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" =3D "yes" ; then
diff --git a/docs/interop/dbus-vmstate.rst b/docs/interop/dbus-vmstate.rs=
t
new file mode 100644
index 0000000000..32d3475315
--- /dev/null
+++ b/docs/interop/dbus-vmstate.rst
@@ -0,0 +1,64 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+DBus VMState
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Helper processes may have their state migrated with the help of the
+QEMU object "dbus-vmstate".
+
+Upon migration, QEMU will go through the queue of "org.qemu.VMState1"
+DBus name owners and query their "Id". It must be unique among the
+helpers.
+
+It will then save arbitrary data of each Id to be transferred in the
+migration stream and restored/loaded at the corresponding destination
+helper.
+
+The data amount to be transferred is limited to 1Mb. The state must be
+saved quickly (a few seconds maximum). (DBus imposes a time limit on
+reply anyway, and migration would fail if data isn't given quickly
+enough)
+
+dbus-vmstate object can be configured with the expected list of
+helpers by setting its "id-list" property, with a coma-separated Id
+list.
+
+Interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. code:: xml
+
+  <interface name=3D"org.qemu.VMState1">
+    <property name=3D"Id" type=3D"s" access=3D"read"/>
+    <method name=3D"Load">
+      <arg type=3D"ay" name=3D"data" direction=3D"in"/>
+    </method>
+    <method name=3D"Save">
+      <arg type=3D"ay" name=3D"data" direction=3D"out"/>
+    </method>
+  </interface>
+
+"Id" property
+-------------
+
+A string that identifies the helper uniquely.
+
+Load(in u8[] bytes) method
+--------------------------
+
+The method called on destination with the state to restore.
+
+The helper may be initially started in a waiting state (with
+an --incoming argument for example), and it may resume on success.
+
+An error may be returned to the caller.
+
+Save(out u8[] bytes) method
+---------------------------
+
+The method called on the source to get the current state to be
+migrated. The helper should continue to run normally.
+
+An error may be returned to the caller.
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index b4bfcab417..6bb173cfa6 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -13,6 +13,7 @@ Contents:
    :maxdepth: 2
=20
    bitmaps
+   dbus-vmstate
    live-block-operations
    pr-helper
    vhost-user
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a983dd32da..4023a20c62 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -156,7 +156,9 @@ check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D tests/rtl8=
139-test$(EXESUF)
 check-qtest-pci-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
 check-qtest-pci-$(CONFIG_HDA) +=3D tests/intel-hda-test$(EXESUF)
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EXESUF=
)
-
+ifneq ($(GDBUS_CODEGEN),)
+check-qtest-pci-$(CONFIG_GIO) +=3D tests/dbus-vmstate-test$(EXESUF)
+endif
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF=
)
 check-qtest-i386-y +=3D tests/fdc-test$(EXESUF)
 check-qtest-i386-y +=3D tests/ide-test$(EXESUF)
@@ -616,6 +618,18 @@ tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/te=
sts/qapi-schema/doc-good.jso
 	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
 	@rm -f tests/qapi-schema/doc-good-qapi-*.[ch] tests/qapi-schema/doc-goo=
d-qmp-*.[ch]
=20
+tests/dbus-vmstate1.h tests/dbus-vmstate1.c: tests/dbus-vmstate1-gen-tim=
estamp ;
+tests/dbus-vmstate1-gen-timestamp: $(SRC_PATH)/tests/dbus-vmstate1.xml
+	$(call quiet-command,$(GDBUS_CODEGEN) $< \
+		--interface-prefix org.qemu --generate-c-code tests/dbus-vmstate1, \
+		"GEN","$(@:%-timestamp=3D%)")
+	@>$@
+
+tests/dbus-vmstate1.o-cflags :=3D $(GIO_CFLAGS)
+tests/dbus-vmstate1.o-libs :=3D $(GIO_LIBS)
+
+tests/dbus-vmstate-test.o: tests/dbus-vmstate1.h
+
 tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visi=
tor.o $(test-qapi-obj-y)
 tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visito=
r.o $(test-qapi-obj-y)
 tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)=
 tests/test-qapi-events.o
@@ -818,6 +832,7 @@ tests/test-filter-mirror$(EXESUF): tests/test-filter-=
mirror.o $(qtest-obj-y)
 tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(=
qtest-obj-y)
 tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qt=
est-obj-y)
 tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server=
/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+tests/dbus-vmstate-test$(EXESUF): tests/dbus-vmstate-test.o tests/dbus-v=
mstate1.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-=
obj-y) libvhost-user.a
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
@@ -1170,6 +1185,7 @@ check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
+	rm -f tests/dbus-vmstate1-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
=20
 clean: check-clean
diff --git a/tests/dbus-vmstate-test.c b/tests/dbus-vmstate-test.c
new file mode 100644
index 0000000000..11e806442f
--- /dev/null
+++ b/tests/dbus-vmstate-test.c
@@ -0,0 +1,387 @@
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+#include <gio/gio.h>
+#include "libqtest.h"
+#include "qemu-common.h"
+#include "dbus-vmstate1.h"
+
+static char *workdir;
+
+typedef struct TestServerId {
+    const char *name;
+    const char *data;
+    size_t size;
+} TestServerId;
+
+static const TestServerId idA =3D {
+    "idA", "I'am\0idA!", sizeof("I'am\0idA!")
+};
+
+static const TestServerId idB =3D {
+    "idB", "I'am\0idB!", sizeof("I'am\0idB!")
+};
+
+typedef struct TestServer {
+    const TestServerId *id;
+    bool save_called;
+    bool load_called;
+} TestServer;
+
+typedef struct Test {
+    const char *id_list;
+    bool migrate_fail;
+    bool without_dst_b;
+    TestServer srcA;
+    TestServer dstA;
+    TestServer srcB;
+    TestServer dstB;
+    GMainLoop *loop;
+    QTestState *src_qemu;
+} Test;
+
+static gboolean
+vmstate_load(VMState1 *object, GDBusMethodInvocation *invocation,
+             const gchar *arg_data, gpointer user_data)
+{
+    TestServer *h =3D user_data;
+    GVariant *args, *var;
+    const uint8_t *data;
+    size_t size;
+
+    args =3D g_dbus_method_invocation_get_parameters(invocation);
+    var =3D g_variant_get_child_value(args, 0);
+    data =3D g_variant_get_fixed_array(var, &size, sizeof(char));
+    g_assert_cmpuint(size, =3D=3D, h->id->size);
+    g_assert(!memcmp(data, h->id->data, h->id->size));
+    h->load_called =3D true;
+    g_variant_unref(var);
+
+    g_dbus_method_invocation_return_value(invocation, g_variant_new("()"=
));
+    return TRUE;
+}
+
+static gboolean
+vmstate_save(VMState1 *object, GDBusMethodInvocation *invocation,
+             gpointer user_data)
+{
+    TestServer *h =3D user_data;
+    GVariant *var;
+
+    var =3D g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
+                                    h->id->data, h->id->size, sizeof(cha=
r));
+    g_dbus_method_invocation_return_value(invocation,
+                                          g_variant_new("(@ay)", var));
+    h->save_called =3D true;
+
+    return TRUE;
+}
+
+static gboolean
+wait_for_migration_complete(gpointer user_data)
+{
+    Test *test =3D user_data;
+    QDict *rsp_return;
+    bool stop =3D false;
+    const char *status;
+
+    qtest_qmp_send(test->src_qemu, "{ 'execute': 'query-migrate' }");
+    rsp_return =3D qtest_qmp_receive_success(test->src_qemu, NULL, NULL)=
;
+    status =3D qdict_get_str(rsp_return, "status");
+    if (g_str_equal(status, "completed") || g_str_equal(status, "failed"=
)) {
+        stop =3D true;
+        g_assert_cmpstr(status, =3D=3D,
+                        test->migrate_fail ? "failed" : "completed");
+    }
+    qobject_unref(rsp_return);
+
+    if (stop) {
+        g_main_loop_quit(test->loop);
+    }
+    return stop ? G_SOURCE_REMOVE : G_SOURCE_CONTINUE;
+}
+
+static void migrate(QTestState *who, const char *uri)
+{
+    QDict *args, *rsp;
+
+    args =3D qdict_new();
+    qdict_put_str(args, "uri", uri);
+
+    rsp =3D qtest_qmp(who, "{ 'execute': 'migrate', 'arguments': %p }", =
args);
+
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+}
+
+typedef struct WaitNamed {
+    GMainLoop *loop;
+    bool named;
+} WaitNamed;
+
+static void
+named_cb(GDBusConnection *connection,
+         const gchar *name,
+         gpointer user_data)
+{
+    WaitNamed *t =3D user_data;
+
+    t->named =3D true;
+    g_main_loop_quit(t->loop);
+}
+
+static GDBusConnection *
+get_connection(Test *test, guint *ownid)
+{
+    WaitNamed *wait =3D g_new0(WaitNamed, 1);
+    GError *err =3D NULL;
+    GDBusConnection *c;
+    gchar *addr;
+
+    wait->loop =3D test->loop;
+    addr =3D g_dbus_address_get_for_bus_sync(G_BUS_TYPE_SESSION, NULL, &=
err);
+    g_assert_no_error(err);
+
+    c =3D g_dbus_connection_new_for_address_sync(
+        addr,
+        G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION |
+        G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT,
+        NULL, NULL, &err);
+    g_assert_no_error(err);
+    *ownid =3D g_bus_own_name_on_connection(c, "org.qemu.VMState1",
+                                          G_BUS_NAME_OWNER_FLAGS_NONE,
+                                          named_cb, named_cb, wait, g_fr=
ee);
+    if (!wait->named) {
+        g_main_loop_run(wait->loop);
+    }
+
+    g_free(addr);
+    return c;
+}
+
+static GDBusObjectManagerServer *
+get_server(GDBusConnection *conn, TestServer *s, const TestServerId *id)
+{
+    GDBusObjectManagerServer *os;
+    GDBusObjectSkeleton *sk;
+    VMState1 *v;
+
+    s->id =3D id;
+    os =3D g_dbus_object_manager_server_new("/org/qemu");
+    sk =3D g_dbus_object_skeleton_new("/org/qemu/VMState1");
+
+    v =3D vmstate1_skeleton_new();
+    g_object_set(v, "id", id->name, NULL);
+
+    g_signal_connect(v, "handle-load", G_CALLBACK(vmstate_load), s);
+    g_signal_connect(v, "handle-save", G_CALLBACK(vmstate_save), s);
+
+    g_dbus_object_skeleton_add_interface(sk, G_DBUS_INTERFACE_SKELETON(v=
));
+    g_dbus_object_manager_server_export(os, sk);
+    g_dbus_object_manager_server_set_connection(os, conn);
+
+    g_clear_object(&v);
+    g_clear_object(&sk);
+
+    return os;
+}
+
+static void
+set_id_list(Test *test, QTestState *s)
+{
+    if (!test->id_list) {
+        return;
+    }
+
+    g_assert(!qmp_rsp_is_err(qtest_qmp(s,
+        "{ 'execute': 'qom-set', 'arguments': "
+        "{ 'path': '/objects/dv', 'property': 'id-list', 'value': %s } }=
",
+        test->id_list)));
+}
+static void
+test_dbus_vmstate(Test *test)
+{
+    QTestState *src_qemu =3D NULL, *dst_qemu =3D NULL;
+    char *src_qemu_args =3D NULL, *dst_qemu_args =3D NULL;
+    GTestDBus *srcbus =3D NULL, *dstbus =3D NULL;
+    GDBusConnection *srcconnA =3D NULL, *srcconnB =3D NULL;
+    GDBusConnection *dstconnA =3D NULL, *dstconnB =3D NULL;
+    guint ownsrcA, ownsrcB, owndstA, owndstB;
+    GDBusObjectManagerServer *srcserverA =3D NULL, *srcserverB =3D NULL;
+    GDBusObjectManagerServer *dstserverA =3D NULL, *dstserverB =3D NULL;
+    char **srcaddr =3D NULL, **dstaddr =3D NULL;
+    char *uri =3D g_strdup_printf("unix:%s/migsocket", workdir);
+
+    test->loop =3D g_main_loop_new(NULL, TRUE);
+
+    srcbus =3D g_test_dbus_new(G_TEST_DBUS_NONE);
+    g_test_dbus_up(srcbus);
+    srcconnA =3D get_connection(test, &ownsrcA);
+    srcserverA =3D get_server(srcconnA, &test->srcA, &idA);
+    srcconnB =3D get_connection(test, &ownsrcB);
+    srcserverB =3D get_server(srcconnB, &test->srcB, &idB);
+
+    /* remove ,guid=3Dfoo part */
+    srcaddr =3D g_strsplit(g_test_dbus_get_bus_address(srcbus), ",", 2);
+    src_qemu_args =3D
+        g_strdup_printf("-object dbus-vmstate,id=3Ddv,addr=3D%s", srcadd=
r[0]);
+
+    dstbus =3D g_test_dbus_new(G_TEST_DBUS_NONE);
+    g_test_dbus_up(dstbus);
+    dstconnA =3D get_connection(test, &owndstA);
+    dstserverA =3D get_server(dstconnA, &test->dstA, &idA);
+    if (!test->without_dst_b) {
+        dstconnB =3D get_connection(test, &owndstB);
+        dstserverB =3D get_server(dstconnB, &test->dstB, &idB);
+    }
+
+    dstaddr =3D g_strsplit(g_test_dbus_get_bus_address(dstbus), ",", 2);
+    dst_qemu_args =3D
+        g_strdup_printf("-object dbus-vmstate,id=3Ddv,addr=3D%s -incomin=
g %s",
+                        dstaddr[0], uri);
+
+    src_qemu =3D qtest_init(src_qemu_args);
+    dst_qemu =3D qtest_init(dst_qemu_args);
+    set_id_list(test, src_qemu);
+    set_id_list(test, dst_qemu);
+
+    migrate(src_qemu, uri);
+    test->src_qemu =3D src_qemu;
+    g_timeout_add_seconds(1, wait_for_migration_complete, test);
+
+    g_main_loop_run(test->loop);
+    g_main_loop_unref(test->loop);
+
+    g_free(uri);
+    if (test->migrate_fail) {
+        qtest_set_exit_status(dst_qemu, 1);
+    }
+    qtest_quit(dst_qemu);
+    qtest_quit(src_qemu);
+    g_free(dst_qemu_args);
+    g_free(src_qemu_args);
+    g_bus_unown_name(ownsrcA);
+    g_bus_unown_name(ownsrcB);
+    g_bus_unown_name(owndstA);
+    if (!test->without_dst_b) {
+        g_bus_unown_name(owndstB);
+    }
+    g_clear_object(&srcbus);
+    g_clear_object(&dstbus);
+    g_clear_object(&srcserverA);
+    g_clear_object(&dstserverA);
+    g_clear_object(&srcserverB);
+    g_clear_object(&dstserverB);
+    g_clear_object(&srcconnA);
+    g_clear_object(&dstconnA);
+    g_clear_object(&srcconnB);
+    g_clear_object(&dstconnB);
+    g_strfreev(srcaddr);
+    g_strfreev(dstaddr);
+}
+
+static void
+check_not_migrated(TestServer *s, TestServer *d)
+{
+    assert(!s->save_called);
+    assert(!s->load_called);
+    assert(!d->save_called);
+    assert(!d->load_called);
+}
+
+static void
+check_migrated(TestServer *s, TestServer *d)
+{
+    assert(s->save_called);
+    assert(!s->load_called);
+    assert(!d->save_called);
+    assert(d->load_called);
+}
+
+static void
+test_dbus_vmstate_without_list(void)
+{
+    Test test =3D { 0, };
+
+    test_dbus_vmstate(&test);
+
+    check_migrated(&test.srcA, &test.dstA);
+    check_migrated(&test.srcB, &test.dstB);
+}
+
+static void
+test_dbus_vmstate_with_list(void)
+{
+    Test test =3D { .id_list =3D "idA,idB" };
+
+    test_dbus_vmstate(&test);
+
+    check_migrated(&test.srcA, &test.dstA);
+    check_migrated(&test.srcB, &test.dstB);
+}
+
+static void
+test_dbus_vmstate_only_a(void)
+{
+    Test test =3D { .id_list =3D "idA" };
+
+    test_dbus_vmstate(&test);
+
+    check_migrated(&test.srcA, &test.dstA);
+    check_not_migrated(&test.srcB, &test.dstB);
+}
+
+static void
+test_dbus_vmstate_missing_src(void)
+{
+    Test test =3D { .id_list =3D "idA,idC", .migrate_fail =3D true };
+
+    test_dbus_vmstate(&test);
+    check_not_migrated(&test.srcA, &test.dstA);
+    check_not_migrated(&test.srcB, &test.dstB);
+}
+
+static void
+test_dbus_vmstate_missing_dst(void)
+{
+    Test test =3D { .id_list =3D "idA,idB",
+                  .without_dst_b =3D true,
+                  .migrate_fail =3D true };
+
+    test_dbus_vmstate(&test);
+
+    assert(test.srcA.save_called);
+    assert(test.srcB.save_called);
+    assert(!test.dstB.save_called);
+}
+
+int
+main(int argc, char **argv)
+{
+    GError *err =3D NULL;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    workdir =3D g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
+    if (!workdir) {
+        g_error("Unable to create temporary dir: %s\n", err->message);
+    }
+
+    qtest_add_func("/dbus-vmstate/without-list",
+                   test_dbus_vmstate_without_list);
+    qtest_add_func("/dbus-vmstate/with-list",
+                   test_dbus_vmstate_with_list);
+    qtest_add_func("/dbus-vmstate/only-a",
+                   test_dbus_vmstate_only_a);
+    qtest_add_func("/dbus-vmstate/missing-src",
+                   test_dbus_vmstate_missing_src);
+    qtest_add_func("/dbus-vmstate/missing-dst",
+                   test_dbus_vmstate_missing_dst);
+
+    ret =3D g_test_run();
+
+    rmdir(workdir);
+    g_free(workdir);
+
+    return ret;
+}
diff --git a/tests/dbus-vmstate1.xml b/tests/dbus-vmstate1.xml
new file mode 100644
index 0000000000..cc8563be4c
--- /dev/null
+++ b/tests/dbus-vmstate1.xml
@@ -0,0 +1,12 @@
+<?xml version=3D"1.0"?>
+<node name=3D"/" xmlns:doc=3D"http://www.freedesktop.org/dbus/1.0/doc.dt=
d">
+  <interface name=3D"org.qemu.VMState1">
+    <property name=3D"Id" type=3D"s" access=3D"read"/>
+    <method name=3D"Load">
+      <arg type=3D"ay" name=3D"data" direction=3D"in"/>
+    </method>
+    <method name=3D"Save">
+      <arg type=3D"ay" name=3D"data" direction=3D"out"/>
+    </method>
+  </interface>
+</node>
--=20
2.22.0.214.g8dca754b1e


