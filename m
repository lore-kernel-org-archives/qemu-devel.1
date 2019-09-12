Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A2C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F38D20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F38D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OKo-0002x4-Br
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OAy-0003cH-KU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OAu-0007dN-MZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:26:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i8OAu-0007cy-BA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:26:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABF0658E23
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:26:11 +0000 (UTC)
Received: from localhost (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FF6C5D9CA;
 Thu, 12 Sep 2019 12:26:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 16:25:14 +0400
Message-Id: <20190912122514.22504-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190912122514.22504-1-marcandre.lureau@redhat.com>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 12 Sep 2019 12:26:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 6/6] Add dbus-vmstate object
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
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
 backends/dbus-vmstate.c       | 530 ++++++++++++++++++++++++++++++++++
 configure                     |   7 +
 docs/interop/dbus-vmstate.rst |  68 +++++
 docs/interop/index.rst        |   1 +
 tests/Makefile.include        |  19 +-
 tests/dbus-vmstate-daemon.sh  |  95 ++++++
 tests/dbus-vmstate-test.c     | 386 +++++++++++++++++++++++++
 tests/dbus-vmstate1.xml       |  12 +
 10 files changed, 1127 insertions(+), 1 deletion(-)
 create mode 100644 backends/dbus-vmstate.c
 create mode 100644 docs/interop/dbus-vmstate.rst
 create mode 100755 tests/dbus-vmstate-daemon.sh
 create mode 100644 tests/dbus-vmstate-test.c
 create mode 100644 tests/dbus-vmstate1.xml

diff --git a/MAINTAINERS b/MAINTAINERS
index 50eaf005f4..f641870c40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2153,6 +2153,12 @@ F: tests/migration-test.c
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
index f0691116e8..28a847cd57 100644
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
index 0000000000..559f5430c5
--- /dev/null
+++ b/backends/dbus-vmstate.c
@@ -0,0 +1,530 @@
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
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qapi/qmp/qerror.h"
+#include "migration/vmstate.h"
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
+
+    uint32_t data_size;
+    uint8_t *data;
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
+#define DBUS_VMSTATE_SIZE_LIMIT (1 * MiB)
+
+static char **
+dbus_get_vmstate1_names(DBusVMState *self, GError **err)
+{
+    g_autoptr(GDBusProxy) proxy =3D NULL;
+    g_autoptr(GVariant) result =3D NULL;
+    g_autoptr(GVariant) child =3D NULL;
+
+    proxy =3D g_dbus_proxy_new_sync(self->bus, G_DBUS_PROXY_FLAGS_NONE, =
NULL,
+                                  "org.freedesktop.DBus",
+                                  "/org/freedesktop/DBus",
+                                  "org.freedesktop.DBus",
+                                  NULL, err);
+    if (!proxy) {
+        return NULL;
+    }
+
+    result =3D g_dbus_proxy_call_sync(proxy, "ListQueuedOwners",
+                                    g_variant_new("(s)", "org.qemu.VMSta=
te1"),
+                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
+                                    -1, NULL, err);
+    if (!result) {
+        return NULL;
+    }
+
+    child =3D g_variant_get_child_value(result, 0);
+    return g_variant_dup_strv(child, NULL);
+}
+
+static GHashTable *
+get_id_list_set(DBusVMState *self)
+{
+    g_auto(GStrv) ids =3D NULL;
+    g_autoptr(GHashTable) set =3D NULL;
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
+    return g_steal_pointer(&set);
+}
+
+static GHashTable *
+dbus_get_proxies(DBusVMState *self, GError **err)
+{
+    g_autoptr(GError) local_err =3D NULL;
+    g_autoptr(GHashTable) proxies =3D NULL;
+    g_autoptr(GHashTable) ids =3D NULL;
+    g_auto(GStrv) names =3D NULL;
+    size_t i;
+
+    ids =3D get_id_list_set(self);
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
+        return NULL;
+    }
+
+    for (i =3D 0; names[i]; i++) {
+        g_autoptr(GDBusProxy) proxy =3D NULL;
+        g_autoptr(GVariant) result =3D NULL;
+        g_autofree char *id =3D NULL;
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
+            return NULL;
+        }
+
+        result =3D g_dbus_proxy_get_cached_property(proxy, "Id");
+        if (!result) {
+            g_set_error_literal(err, G_IO_ERROR, G_IO_ERROR_FAILED,
+                                "VMState Id property is missing.");
+            return NULL;
+        }
+
+        id =3D g_variant_dup_string(result, &size);
+        if (ids && !g_hash_table_remove(ids, id)) {
+            g_clear_pointer(&id, g_free);
+            g_clear_object(&proxy);
+            continue;
+        }
+        if (size =3D=3D 0 || size >=3D 256) {
+            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
+                        "VMState Id '%s' is invalid.", id);
+            return NULL;
+        }
+
+        if (!g_hash_table_insert(proxies, id, proxy)) {
+            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
+                        "Duplicated VMState Id '%s'", id);
+            return NULL;
+        }
+        id =3D NULL;
+        proxy =3D NULL;
+
+        g_clear_pointer(&result, g_variant_unref);
+    }
+
+    if (ids) {
+        g_autofree char **left =3D NULL;
+
+        left =3D (char **)g_hash_table_get_keys_as_array(ids, NULL);
+        if (*left) {
+            g_autofree char *leftids =3D g_strjoinv(",", left);
+            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
+                        "Required VMState Id are missing: %s", leftids);
+            return NULL;
+        }
+    }
+
+    return g_steal_pointer(&proxies);
+}
+
+static int
+dbus_load_state_proxy(GDBusProxy *proxy, const uint8_t *data, size_t siz=
e)
+{
+    g_autoptr(GError) err =3D NULL;
+    g_autoptr(GVariant) result =3D NULL;
+    g_autoptr(GVariant) value =3D NULL;
+
+    value =3D g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
+                                      data, size, sizeof(char));
+    result =3D g_dbus_proxy_call_sync(proxy, "Load",
+                                    g_variant_new("(@ay)",
+                                                  g_steal_pointer(&value=
)),
+                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
+                                    -1, NULL, &err);
+    if (!result) {
+        error_report("Failed to Load: %s", err->message);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int dbus_vmstate_post_load(void *opaque, int version_id)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(opaque);
+    g_autoptr(GInputStream) m =3D NULL;
+    g_autoptr(GDataInputStream) s =3D NULL;
+    g_autoptr(GError) err =3D NULL;
+    g_autoptr(GHashTable) proxies =3D NULL;
+    uint32_t nelem;
+
+    proxies =3D dbus_get_proxies(self, &err);
+    if (!proxies) {
+        error_report("Failed to get proxies: %s", err->message);
+        return -1;
+    }
+
+    m =3D g_memory_input_stream_new_from_data(self->data, self->data_siz=
e, NULL);
+    s =3D g_data_input_stream_new(m);
+    g_data_input_stream_set_byte_order(s, G_DATA_STREAM_BYTE_ORDER_BIG_E=
NDIAN);
+
+    nelem =3D g_data_input_stream_read_uint32(s, NULL, &err);
+    if (err) {
+        goto error;
+    }
+
+    while (nelem > 0) {
+        GDBusProxy *proxy =3D NULL;
+        uint32_t len;
+        gsize bytes_read, avail;
+        char id[256];
+
+        len =3D g_data_input_stream_read_uint32(s, NULL, &err);
+        if (err) {
+            goto error;
+        }
+        if (len >=3D 256) {
+            error_report("Invalid DBus vmstate proxy name %u", len);
+            return -1;
+        }
+        if (!g_input_stream_read_all(G_INPUT_STREAM(s), id, len,
+                                     &bytes_read, NULL, &err)) {
+            goto error;
+        }
+        g_return_val_if_fail(bytes_read =3D=3D len, -1);
+        id[len] =3D 0;
+
+        proxy =3D g_hash_table_lookup(proxies, id);
+        if (!proxy) {
+            error_report("Failed to find proxy Id '%s'", id);
+            return -1;
+        }
+
+        len =3D g_data_input_stream_read_uint32(s, NULL, &err);
+        avail =3D g_buffered_input_stream_get_available(
+            G_BUFFERED_INPUT_STREAM(s));
+
+        if (len > DBUS_VMSTATE_SIZE_LIMIT || len > avail) {
+            error_report("Invalid vmstate size: %u", len);
+            return -1;
+        }
+
+        if (dbus_load_state_proxy(proxy,
+                g_buffered_input_stream_peek_buffer(G_BUFFERED_INPUT_STR=
EAM(s),
+                                                    NULL),
+                len) < 0) {
+            error_report("Failed to restore Id '%s'", id);
+            return -1;
+        }
+
+        if (!g_seekable_seek(G_SEEKABLE(s), len, G_SEEK_CUR, NULL, &err)=
) {
+            goto error;
+        }
+
+        nelem -=3D 1;
+    }
+
+    return 0;
+
+error:
+    error_report("Failed to read from stream: %s", err->message);
+    return -1;
+}
+
+static void
+dbus_save_state_proxy(gpointer key,
+                      gpointer value,
+                      gpointer user_data)
+{
+    GDataOutputStream *s =3D user_data;
+    const char *id =3D key;
+    GDBusProxy *proxy =3D value;
+    g_autoptr(GVariant) result =3D NULL;
+    g_autoptr(GVariant) child =3D NULL;
+    g_autoptr(GError) err =3D NULL;
+    const uint8_t *data;
+    gsize size;
+
+    result =3D g_dbus_proxy_call_sync(proxy, "Save",
+                                    NULL, G_DBUS_CALL_FLAGS_NO_AUTO_STAR=
T,
+                                    -1, NULL, &err);
+    if (!result) {
+        error_report("Failed to Save: %s", err->message);
+        return;
+    }
+
+    child =3D g_variant_get_child_value(result, 0);
+    data =3D g_variant_get_fixed_array(child, &size, sizeof(char));
+    if (!data) {
+        error_report("Failed to Save: not a byte array");
+        return;
+    }
+    if (size > DBUS_VMSTATE_SIZE_LIMIT) {
+        error_report("Too large vmstate data to save: %lu", size);
+        return;
+    }
+
+    if (!g_data_output_stream_put_uint32(s, strlen(id), NULL, &err) ||
+        !g_data_output_stream_put_string(s, id, NULL, &err) ||
+        !g_data_output_stream_put_uint32(s, size, NULL, &err) ||
+        !g_output_stream_write_all(G_OUTPUT_STREAM(s),
+                                   data, size, NULL, NULL, &err)) {
+        error_report("Failed to write to stream: %s", err->message);
+    }
+}
+
+static int dbus_vmstate_pre_save(void *opaque)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(opaque);
+    g_autoptr(GOutputStream) m =3D NULL;
+    g_autoptr(GDataOutputStream) s =3D NULL;
+    g_autoptr(GHashTable) proxies =3D NULL;
+    g_autoptr(GError) err =3D NULL;
+
+    proxies =3D dbus_get_proxies(self, &err);
+    if (!proxies) {
+        error_report("Failed to get proxies: %s", err->message);
+        return -1;
+    }
+
+    m =3D g_memory_output_stream_new_resizable();
+    s =3D g_data_output_stream_new(m);
+    g_data_output_stream_set_byte_order(s, G_DATA_STREAM_BYTE_ORDER_BIG_=
ENDIAN);
+
+    if (!g_data_output_stream_put_uint32(s, g_hash_table_size(proxies),
+                                         NULL, &err)) {
+        error_report("Failed to write to stream: %s", err->message);
+        return -1;
+    }
+
+    g_hash_table_foreach(proxies, dbus_save_state_proxy, s);
+
+    if (g_memory_output_stream_get_size(G_MEMORY_OUTPUT_STREAM(m))
+        > UINT32_MAX) {
+        error_report("DBus vmstate buffer is too large");
+        return -1;
+    }
+
+    if (!g_output_stream_close(G_OUTPUT_STREAM(m), NULL, &err)) {
+        error_report("Failed to close stream: %s", err->message);
+        return -1;
+    }
+
+    g_free(self->data);
+    self->data_size =3D
+        g_memory_output_stream_get_size(G_MEMORY_OUTPUT_STREAM(m));
+    self->data =3D
+        g_memory_output_stream_steal_data(G_MEMORY_OUTPUT_STREAM(m));
+
+    return 0;
+}
+
+static const VMStateDescription dbus_vmstate =3D {
+    .name =3D TYPE_DBUS_VMSTATE,
+    .version_id =3D 0,
+    .pre_save =3D dbus_vmstate_pre_save,
+    .post_load =3D dbus_vmstate_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(data_size, DBusVMState),
+        VMSTATE_VBUFFER_ALLOC_UINT32(data, DBusVMState, 0, 0, data_size)=
,
+        VMSTATE_END_OF_LIST()
+    }
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
+
+    if (vmstate_register(VMSTATE_IF(self), -1, &dbus_vmstate, self) < 0)=
 {
+        error_setg(errp, "Failed to register vmstate");
+    }
+}
+
+static void
+dbus_vmstate_finalize(Object *o)
+{
+    DBusVMState *self =3D DBUS_VMSTATE(o);
+
+    vmstate_unregister(VMSTATE_IF(self), &dbus_vmstate, self);
+
+    g_clear_object(&self->bus);
+    g_free(self->dbus_addr);
+    g_free(self->id_list);
+    g_free(self->data);
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
+static char *
+dbus_vmstate_get_id(VMStateIf *vmif)
+{
+    return g_strdup(TYPE_DBUS_VMSTATE);
+}
+
+static void
+dbus_vmstate_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
+    VMStateIfClass *vc =3D VMSTATE_IF_CLASS(oc);
+
+    ucc->complete =3D dbus_vmstate_complete;
+    vc->get_id =3D dbus_vmstate_get_id;
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
+        { TYPE_VMSTATE_IF },
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
index 95134c0180..0a6eb2ebcd 100755
--- a/configure
+++ b/configure
@@ -3665,10 +3665,16 @@ if $pkg_config --atleast-version=3D$glib_req_ver =
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
@@ -6831,6 +6837,7 @@ if test "$gio" =3D "yes" ; then
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
index 0000000000..78070be1bd
--- /dev/null
+++ b/docs/interop/dbus-vmstate.rst
@@ -0,0 +1,68 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+D-Bus VMState
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The QEMU dbus-vmstate object aim is to migrate helpers data running on
+a QEMU D-Bus bus. (refer to the :doc:`dbus` document for
+recommendation on D-Bus usage)
+
+Upon migration, QEMU will go through the queue of
+``org.qemu.VMState1`` D-Bus name owners and query their ``Id``. It
+must be unique among the helpers.
+
+It will then save arbitrary data of each Id to be transferred in the
+migration stream and restored/loaded at the corresponding destination
+helper.
+
+The data amount to be transferred is limited to 1Mb. The state must be
+saved quickly (a few seconds maximum). (D-Bus imposes a time limit on
+reply anyway, and migration would fail if data isn't given quickly
+enough)
+
+dbus-vmstate object can be configured with the expected list of
+helpers by setting its ``id-list`` property, with a coma-separated
+``Id`` list.
+
+Interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+On object path ``/org/qemu/VMState1``, the following
+``org.qemu.VMState1`` interface should be implemented:
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
index fa4478ce2e..75832f44ac 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -14,6 +14,7 @@ Contents:
=20
    bitmaps
    dbus
+   dbus-vmstate
    live-block-operations
    pr-helper
    vhost-user
diff --git a/tests/Makefile.include b/tests/Makefile.include
index d4502a30eb..eb40e8a5e7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -158,7 +158,9 @@ check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D tests/rtl8=
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
@@ -620,6 +622,19 @@ tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/te=
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
+tests/dbus-vmstate-test.o-cflags :=3D -DSRCDIR=3D"$(SRC_PATH)"
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
@@ -822,6 +837,7 @@ tests/test-filter-mirror$(EXESUF): tests/test-filter-=
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
@@ -1176,6 +1192,7 @@ check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
+	rm -f tests/dbus-vmstate1-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
=20
 clean: check-clean
diff --git a/tests/dbus-vmstate-daemon.sh b/tests/dbus-vmstate-daemon.sh
new file mode 100755
index 0000000000..c4394ac918
--- /dev/null
+++ b/tests/dbus-vmstate-daemon.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+# dbus-daemon wrapper script for dbus-vmstate testing
+#
+# This script allows to tweak the dbus-daemon policy during the test
+# to test different configurations.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# Copyright (C) 2019 Red Hat, Inc.
+
+write_config()
+{
+    CONF=3D"$1"
+    cat > "$CONF" <<EOF
+<busconfig>
+  <type>session</type>
+  <listen>unix:tmpdir=3D/tmp</listen>
+
+  <policy context=3D"default">
+     <!-- Holes must be punched in service configuration files for
+          name ownership and sending method calls -->
+     <deny own=3D"*"/>
+     <deny send_type=3D"method_call"/>
+
+     <!-- Signals and reply messages (method returns, errors) are allowe=
d
+          by default -->
+     <allow send_type=3D"signal"/>
+     <allow send_requested_reply=3D"true" send_type=3D"method_return"/>
+     <allow send_requested_reply=3D"true" send_type=3D"error"/>
+
+     <!-- All messages may be received by default -->
+     <allow receive_type=3D"method_call"/>
+     <allow receive_type=3D"method_return"/>
+     <allow receive_type=3D"error"/>
+     <allow receive_type=3D"signal"/>
+
+     <!-- Allow anyone to talk to the message bus -->
+     <allow send_destination=3D"org.freedesktop.DBus"
+            send_interface=3D"org.freedesktop.DBus" />
+     <allow send_destination=3D"org.freedesktop.DBus"
+            send_interface=3D"org.freedesktop.DBus.Introspectable"/>
+     <allow send_destination=3D"org.freedesktop.DBus"
+            send_interface=3D"org.freedesktop.DBus.Properties"/>
+     <!-- But disallow some specific bus services -->
+     <deny send_destination=3D"org.freedesktop.DBus"
+           send_interface=3D"org.freedesktop.DBus"
+           send_member=3D"UpdateActivationEnvironment"/>
+     <deny send_destination=3D"org.freedesktop.DBus"
+           send_interface=3D"org.freedesktop.DBus.Debug.Stats"/>
+     <deny send_destination=3D"org.freedesktop.DBus"
+           send_interface=3D"org.freedesktop.systemd1.Activator"/>
+
+     <allow own=3D"org.qemu.VMState1"/>
+     <allow send_destination=3D"org.qemu.VMState1"/>
+     <allow receive_sender=3D"org.qemu.VMState1"/>
+
+  </policy>
+
+  <include if_selinux_enabled=3D"yes"
+   selinux_root_relative=3D"yes">contexts/dbus_contexts</include>
+
+</busconfig>
+EOF
+}
+
+ARGS=3D
+for arg in "$@"
+do
+    case $arg in
+        --config-file=3D*)
+          CONF=3D"${arg#*=3D}"
+          write_config "$CONF"
+          ARGS=3D"$ARGS $1"
+          shift
+        ;;
+        *)
+          ARGS=3D"$ARGS $1"
+          shift
+        ;;
+    esac
+done
+
+exec dbus-daemon $ARGS
diff --git a/tests/dbus-vmstate-test.c b/tests/dbus-vmstate-test.c
new file mode 100644
index 0000000000..bcf2372e15
--- /dev/null
+++ b/tests/dbus-vmstate-test.c
@@ -0,0 +1,386 @@
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
+    g_autoptr(GVariant) var =3D NULL;
+    GVariant *args;
+    const uint8_t *data;
+    size_t size;
+
+    args =3D g_dbus_method_invocation_get_parameters(invocation);
+    var =3D g_variant_get_child_value(args, 0);
+    data =3D g_variant_get_fixed_array(var, &size, sizeof(char));
+    g_assert_cmpuint(size, =3D=3D, h->id->size);
+    g_assert(!memcmp(data, h->id->data, h->id->size));
+    h->load_called =3D true;
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
+    g_autofree gchar *addr =3D NULL;
+    WaitNamed *wait;
+    GError *err =3D NULL;
+    GDBusConnection *c;
+
+    wait =3D g_new0(WaitNamed, 1);
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
+    return c;
+}
+
+static GDBusObjectManagerServer *
+get_server(GDBusConnection *conn, TestServer *s, const TestServerId *id)
+{
+    g_autoptr(GDBusObjectSkeleton) sk =3D NULL;
+    g_autoptr(VMState1Skeleton) v =3D NULL;
+    GDBusObjectManagerServer *os;
+
+    s->id =3D id;
+    os =3D g_dbus_object_manager_server_new("/org/qemu");
+    sk =3D g_dbus_object_skeleton_new("/org/qemu/VMState1");
+
+    v =3D VMSTATE1_SKELETON(vmstate1_skeleton_new());
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
+    g_autofree char *src_qemu_args =3D NULL;
+    g_autofree char *dst_qemu_args =3D NULL;
+    g_autoptr(GTestDBus) srcbus =3D NULL;
+    g_autoptr(GTestDBus) dstbus =3D NULL;
+    g_autoptr(GDBusConnection) srcconnA =3D NULL;
+    g_autoptr(GDBusConnection) srcconnB =3D NULL;
+    g_autoptr(GDBusConnection) dstconnA =3D NULL;
+    g_autoptr(GDBusConnection) dstconnB =3D NULL;
+    g_autoptr(GDBusObjectManagerServer) srcserverA =3D NULL;
+    g_autoptr(GDBusObjectManagerServer) srcserverB =3D NULL;
+    g_autoptr(GDBusObjectManagerServer) dstserverA =3D NULL;
+    g_autoptr(GDBusObjectManagerServer) dstserverB =3D NULL;
+    g_auto(GStrv) srcaddr =3D NULL;
+    g_auto(GStrv) dstaddr =3D NULL;
+    g_autofree char *uri =3D NULL;
+    QTestState *src_qemu =3D NULL, *dst_qemu =3D NULL;
+    guint ownsrcA, ownsrcB, owndstA, owndstB;
+
+    uri =3D g_strdup_printf("unix:%s/migsocket", workdir);
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
+    if (test->migrate_fail) {
+        qtest_expect_exit_status(dst_qemu, 1);
+    }
+    qtest_quit(dst_qemu);
+    qtest_quit(src_qemu);
+    g_bus_unown_name(ownsrcA);
+    g_bus_unown_name(ownsrcB);
+    g_bus_unown_name(owndstA);
+    if (!test->without_dst_b) {
+        g_bus_unown_name(owndstB);
+    }
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
+    g_autofree char *dbus_daemon =3D NULL;
+    int ret;
+
+    dbus_daemon =3D g_build_filename(G_STRINGIFY(SRCDIR),
+                                   "tests",
+                                   "dbus-vmstate-daemon.sh",
+                                   NULL);
+    g_setenv("G_TEST_DBUS_DAEMON", dbus_daemon, true);
+
+    g_test_init(&argc, &argv, NULL);
+
+    workdir =3D g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
+    if (!workdir) {
+        g_error("Unable to create temporary dir: %s\n", err->message);
+        exit(1);
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
2.23.0


