Received: from eggs.gnu.org ([2001:4830:134:3::10]:48662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuK-0003XV-Fx
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuI-0001ZK-Df
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqHuI-0001YX-0o
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:42 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 16 Aug 2018 14:01:16 +0100
Message-Id: <20180816130118.31841-10-berrange@redhat.com>
In-Reply-To: <20180816130118.31841-1-berrange@redhat.com>
References: <20180816130118.31841-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/11] authz: add QAuthZListFile object type
 for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add a QAuthZListFile object type that implements the QAuthZ interface. Th=
is
built-in implementation is a proxy around the QAtuhZList object type,
initializing it from an external file, and optionally, automatically
reloading it whenever it changes.

To create an instance of this object via the QMP monitor, the syntax
used would be:

      {
        "execute": "object-add",
        "arguments": {
          "qom-type": "authz-list-file",
          "id": "authz0",
          "parameters": {
            "filename": "/etc/qemu/vnc.acl",
	    "refresh": "yes"
          }
        }
      }

If "refresh" is "yes", inotify is used to monitor the file,
automatically reloading changes. If an error occurs during reloading,
all authorizations will fail until the file is next successfully
loaded.

The /etc/qemu/vnc.acl file would contain a JSON representation of a
QAuthZList object

    {
      "rules": [
         { "match": "fred", "policy": "allow", "format": "exact" },
         { "match": "bob", "policy": "allow", "format": "exact" },
         { "match": "danb", "policy": "deny", "format": "glob" },
         { "match": "dan*", "policy": "allow", "format": "exact" },
      ],
      "policy": "deny"
    }

This sets up an authorization rule that allows 'fred', 'bob' and anyone
whose name starts with 'dan', except for 'danb'. Everyone unmatched is
denied.

The object can be loaded on the comand line using

   -object authz-list-file,id=3Dauthz0,filename=3D/etc/qemu/vnc.acl,refre=
sh=3Dyes

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 authz/Makefile.objs      |   1 +
 authz/listfile.c         | 284 +++++++++++++++++++++++++++++++++++++++
 authz/trace-events       |   4 +
 include/authz/listfile.h | 110 +++++++++++++++
 qemu-options.hx          |  47 +++++++
 5 files changed, 446 insertions(+)
 create mode 100644 authz/listfile.c
 create mode 100644 include/authz/listfile.h

diff --git a/authz/Makefile.objs b/authz/Makefile.objs
index 921fa624d7..8351bf181d 100644
--- a/authz/Makefile.objs
+++ b/authz/Makefile.objs
@@ -1,3 +1,4 @@
 authz-obj-y +=3D base.o
 authz-obj-y +=3D simple.o
 authz-obj-y +=3D list.o
+authz-obj-y +=3D listfile.o
diff --git a/authz/listfile.c b/authz/listfile.c
new file mode 100644
index 0000000000..5bd3e37f7e
--- /dev/null
+++ b/authz/listfile.c
@@ -0,0 +1,284 @@
+/*
+ * QEMU access control list file authorization driver
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "authz/listfile.h"
+#include "authz/trace.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "qemu/sockets.h"
+#include "qemu/filemonitor.h"
+#include "qom/object_interfaces.h"
+#include "qapi/qapi-visit-authz.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qobject-input-visitor.h"
+
+
+static bool
+qauthz_list_file_is_allowed(QAuthZ *authz,
+                            const char *identity,
+                            Error **errp)
+{
+    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(authz);
+    if (fauthz->list) {
+        return qauthz_is_allowed(fauthz->list, identity, errp);
+    }
+
+    return false;
+}
+
+
+static QAuthZ *
+qauthz_list_file_load(QAuthZListFile *fauthz, Error **errp)
+{
+    GError *err =3D NULL;
+    gchar *content =3D NULL;
+    gsize len;
+    QObject *obj =3D NULL;
+    QDict *pdict;
+    Visitor *v =3D NULL;
+    QAuthZ *ret =3D NULL;
+
+    trace_qauthz_list_file_load(fauthz, fauthz->filename);
+    if (!g_file_get_contents(fauthz->filename, &content, &len, &err)) {
+        error_setg(errp, "Unable to read '%s': %s",
+                   fauthz->filename, err->message);
+        goto cleanup;
+    }
+
+    obj =3D qobject_from_json(content, errp);
+    if (!obj) {
+        goto cleanup;
+    }
+
+    pdict =3D qobject_to(QDict, obj);
+    if (!pdict) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "obj", "dict");
+        goto cleanup;
+    }
+
+    v =3D qobject_input_visitor_new(obj);
+
+    ret =3D (QAuthZ *)user_creatable_add_type(TYPE_QAUTHZ_LIST,
+                                            NULL, pdict, v, errp);
+
+ cleanup:
+    visit_free(v);
+    qobject_unref(obj);
+    if (err) {
+        g_error_free(err);
+    }
+    g_free(content);
+    return ret;
+}
+
+
+static void
+qauthz_list_file_event(int wd G_GNUC_UNUSED,
+                       QFileMonitorEvent ev G_GNUC_UNUSED,
+                       const char *name G_GNUC_UNUSED,
+                       void *opaque)
+{
+    QAuthZListFile *fauthz =3D opaque;
+    Error *err =3D NULL;
+
+    if (ev !=3D QFILE_MONITOR_EVENT_MODIFIED &&
+        ev !=3D QFILE_MONITOR_EVENT_CREATED)
+        return;
+
+    object_unref(OBJECT(fauthz->list));
+    fauthz->list =3D qauthz_list_file_load(fauthz, &err);
+    trace_qauthz_list_file_refresh(fauthz,
+                                   fauthz->filename, fauthz->list ? 1 : =
0);
+    if (!fauthz->list) {
+        error_report_err(err);
+    }
+}
+
+static void
+qauthz_list_file_complete(UserCreatable *uc, Error **errp)
+{
+    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(uc);
+
+    fauthz->list =3D qauthz_list_file_load(fauthz, errp);
+
+    if (fauthz->refresh) {
+        gchar *dir, *file;
+        fauthz->file_monitor =3D qemu_file_monitor_get_instance(errp);
+        if (!fauthz->file_monitor) {
+            return;
+        }
+
+        dir =3D g_path_get_dirname(fauthz->filename);
+        if (g_str_equal(dir, ".")) {
+            error_setg(errp, "Filename must be an absolute path");
+            g_free(dir);
+            return;
+        }
+        file =3D g_path_get_basename(fauthz->filename);
+        if (g_str_equal(file, ".")) {
+            error_setg(errp, "Path has no trailing filename component");
+            g_free(file);
+            g_free(dir);
+            return;
+        }
+
+        fauthz->file_watch =3D qemu_file_monitor_add_watch(
+            fauthz->file_monitor, dir, file,
+            qauthz_list_file_event, fauthz, errp);
+        g_free(file);
+        g_free(dir);
+        if (fauthz->file_watch < 0) {
+            return;
+        }
+    }
+}
+
+
+static void
+qauthz_list_file_prop_set_filename(Object *obj,
+                                   const char *value,
+                                   Error **errp G_GNUC_UNUSED)
+{
+    QAuthZListFile *authz =3D QAUTHZ_LIST_FILE(obj);
+
+    authz->filename =3D g_strdup(value);
+}
+
+
+static char *
+qauthz_list_file_prop_get_filename(Object *obj,
+                                   Error **errp G_GNUC_UNUSED)
+{
+    QAuthZListFile *authz =3D QAUTHZ_LIST_FILE(obj);
+
+    return g_strdup(authz->filename);
+}
+
+
+static void
+qauthz_list_file_prop_set_refresh(Object *obj,
+                                  bool value,
+                                  Error **errp G_GNUC_UNUSED)
+{
+    QAuthZListFile *authz =3D QAUTHZ_LIST_FILE(obj);
+
+    authz->refresh =3D value;
+}
+
+
+static bool
+qauthz_list_file_prop_get_refresh(Object *obj,
+                                  Error **errp G_GNUC_UNUSED)
+{
+    QAuthZListFile *authz =3D QAUTHZ_LIST_FILE(obj);
+
+    return authz->refresh;
+}
+
+
+static void
+qauthz_list_file_finalize(Object *obj)
+{
+    QAuthZListFile *authz =3D QAUTHZ_LIST_FILE(obj);
+
+    if (authz->file_watch !=3D -1 && authz->file_monitor) {
+        gchar *dir =3D g_path_get_dirname(authz->filename);
+        qemu_file_monitor_remove_watch(authz->file_monitor,
+                                       dir,
+                                       authz->file_watch);
+        g_free(dir);
+    }
+    object_unref(OBJECT(authz->list));
+    g_free(authz->filename);
+}
+
+
+static void
+qauthz_list_file_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
+    QAuthZClass *authz =3D QAUTHZ_CLASS(oc);
+
+    ucc->complete =3D qauthz_list_file_complete;
+
+    object_class_property_add_str(oc, "filename",
+                                  qauthz_list_file_prop_get_filename,
+                                  qauthz_list_file_prop_set_filename,
+                                  NULL);
+    object_class_property_add_bool(oc, "refresh",
+                                   qauthz_list_file_prop_get_refresh,
+                                   qauthz_list_file_prop_set_refresh,
+                                   NULL);
+
+    authz->is_allowed =3D qauthz_list_file_is_allowed;
+}
+
+
+static void
+qauthz_list_file_init(Object *obj)
+{
+    QAuthZListFile *authz =3D QAUTHZ_LIST_FILE(obj);
+
+    authz->file_watch =3D -1;
+#ifdef CONFIG_INOTIFY1
+    authz->refresh =3D TRUE;
+#endif
+}
+
+
+QAuthZListFile *qauthz_list_file_new(const char *id,
+                                     const char *filename,
+                                     Error **errp)
+{
+    return QAUTHZ_LIST_FILE(
+        object_new_with_props(TYPE_QAUTHZ_LIST_FILE,
+                              object_get_objects_root(),
+                              id, errp,
+                              "filename", filename,
+                              NULL));
+}
+
+
+static const TypeInfo qauthz_list_file_info =3D {
+    .parent =3D TYPE_QAUTHZ_LIST,
+    .name =3D TYPE_QAUTHZ_LIST_FILE,
+    .instance_init =3D qauthz_list_file_init,
+    .instance_size =3D sizeof(QAuthZListFile),
+    .instance_finalize =3D qauthz_list_file_finalize,
+    .class_size =3D sizeof(QAuthZListFileClass),
+    .class_init =3D qauthz_list_file_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+
+static void
+qauthz_list_file_register_types(void)
+{
+    type_register_static(&qauthz_list_file_info);
+}
+
+
+type_init(qauthz_list_file_register_types);
diff --git a/authz/trace-events b/authz/trace-events
index a896d876e8..fb65349a90 100644
--- a/authz/trace-events
+++ b/authz/trace-events
@@ -9,3 +9,7 @@ qauthz_simple_is_allowed(void *authz, const char *wantide=
ntity, const char *goti
 # auth/list.c
 qauthz_list_check_rule(void *authz, const char *identity, const char *ru=
le, int format, int policy) "AuthZ list %p check rule=3D%s identity=3D%s =
format=3D%d policy=3D%d"
 qauthz_list_default_policy(void *authz, const char *identity, int policy=
) "AuthZ list %p default identity=3D%s policy=3D%d"
+
+# auth/listfile.c
+qauthz_list_file_load(void *authz, const char *filename) "AuthZ file %p =
load filename=3D%s"
+qauthz_list_file_refresh(void *authz, const char *filename, int success)=
 "AuthZ file %p load filename=3D%s success=3D%d"
diff --git a/include/authz/listfile.h b/include/authz/listfile.h
new file mode 100644
index 0000000000..244aadc064
--- /dev/null
+++ b/include/authz/listfile.h
@@ -0,0 +1,110 @@
+/*
+ * QEMU list file authorization driver
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#ifndef QAUTHZ_LIST_FILE_H__
+#define QAUTHZ_LIST_FILE_H__
+
+#include "authz/list.h"
+#include "qapi/qapi-types-authz.h"
+#include "qemu/filemonitor.h"
+
+#define TYPE_QAUTHZ_LIST_FILE "authz-list-file"
+
+#define QAUTHZ_LIST_FILE_CLASS(klass)                        \
+    OBJECT_CLASS_CHECK(QAuthZListFileClass, (klass),        \
+                       TYPE_QAUTHZ_LIST_FILE)
+#define QAUTHZ_LIST_FILE_GET_CLASS(obj)              \
+    OBJECT_GET_CLASS(QAuthZListFileClass, (obj),    \
+                      TYPE_QAUTHZ_LIST_FILE)
+#define QAUTHZ_LIST_FILE(obj) \
+    INTERFACE_CHECK(QAuthZListFile, (obj),          \
+                    TYPE_QAUTHZ_LIST_FILE)
+
+typedef struct QAuthZListFile QAuthZListFile;
+typedef struct QAuthZListFileClass QAuthZListFileClass;
+
+
+/**
+ * QAuthZListFile:
+ *
+ * This authorization driver provides a file mechanism
+ * for granting access by matching user names against a
+ * file of globs. Each match rule has an associated policy
+ * and a catch all policy applies if no rule matches
+ *
+ * To create an instance of this class via QMP:
+ *
+ *  {
+ *    "execute": "object-add",
+ *    "arguments": {
+ *      "qom-type": "authz-list-file",
+ *      "id": "authz0",
+ *      "parameters": {
+ *        "filename": "/etc/qemu/myvm-vnc.acl",
+ *        "refresh": "yes"
+ *      }
+ *    }
+ *  }
+ *
+ * If 'refresh' is 'yes', inotify is used to monitor for changes
+ * to the file and auto-reload the rules.
+ *
+ * The myvm-vnc.acl file should contain the parameters for
+ * the QAuthZList object in JSON format:
+ *
+ *      {
+ *        "rules": [
+ *           { "match": "fred", "policy": "allow", "format": "exact" },
+ *           { "match": "bob", "policy": "allow", "format": "exact" },
+ *           { "match": "danb", "policy": "deny", "format": "exact" },
+ *           { "match": "dan*", "policy": "allow", "format": "glob" }
+ *        ],
+ *        "policy": "deny"
+ *      }
+ *
+ * The object can be created on the command line using
+ *
+ *   -object authz-list-file,id=3Dauthz0,\
+ *           filename=3D/etc/qemu/myvm-vnc.acl,refresh=3Dyes
+ *
+ */
+struct QAuthZListFile {
+    QAuthZ parent_obj;
+
+    QAuthZ *list;
+    char *filename;
+    bool refresh;
+    QFileMonitor *file_monitor;
+    int file_watch;
+};
+
+
+struct QAuthZListFileClass {
+    QAuthZClass parent_class;
+};
+
+
+QAuthZListFile *qauthz_list_file_new(const char *id,
+                                     const char *filename,
+                                     Error **errp);
+
+
+#endif /* QAUTHZ_LIST_FILE_H__ */
+
diff --git a/qemu-options.hx b/qemu-options.hx
index 6713ebbc0a..8fcea2fae2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4462,6 +4462,53 @@ would look like:
      ...
 @end example
=20
+
+@item -object authz-listfile,id=3D@var{id},filename=3D@var{path},refresh=
=3D@var{yes|no}
+
+Create an authorization object that will control access to network servi=
ces.
+
+The @option{filename} parameter is the fully qualified path to a file
+containing the access control list rules in JSON format.
+
+An example set of rules that match against SASL usernames might look
+like:
+
+@example
+  @{
+    "rules": [
+       @{ "match": "fred", "policy": "allow", "format": "exact" @},
+       @{ "match": "bob", "policy": "allow", "format": "exact" @},
+       @{ "match": "danb", "policy": "deny", "format": "glob" @},
+       @{ "match": "dan*", "policy": "allow", "format": "exact" @},
+    ],
+    "policy": "deny"
+  @}
+@end example
+
+When checking access the object will iterate over all the rules and
+the first rule to match will have its @option{policy} value returned
+as the result. If no rules match, then the default @option{policy}
+value is returned.
+
+The rules can either be an exact string match, or they can use the
+simple UNIX glob pattern matching to allow wildcards to be used.
+
+If @option{refresh} is set to true the file will be monitored
+and automatically reloaded whenever its content changes.
+
+As with the @code{authz-simple} object, the format of the identity
+strings being matched depends on the network service, but is usually
+a TLS x509 distinguished name, or a SASL username.
+
+An example authorization object to validate a SASL username
+would look like:
+@example
+ # $QEMU \
+     ...
+     -object authz-simple,id=3Dauth0,filename=3D/etc/qemu/vnc-sasl.acl,r=
efresh=3Dyes
+     ...
+@end example
+
 @end table
=20
 ETEXI
--=20
2.17.1
