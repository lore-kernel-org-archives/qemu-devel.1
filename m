Received: from eggs.gnu.org ([2001:4830:134:3::10]:48663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvyK-0000cF-DN
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvyG-0002GI-EX
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:13:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxvyG-0002Ex-7m
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:13:24 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Sep 2018 19:12:27 +0400
Message-Id: <20180906151227.25514-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180906151227.25514-1-marcandre.lureau@redhat.com>
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/10] vl: list user creatable propeties if '?'
 as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Iterate over the writable class properties, sort and print them out
with the description if available.

Ex: qemu -object memory-backend-memfd,?
memory-backend-memfd.dump=3Dbool (Set to 'off' to exclude from core dump)
memory-backend-memfd.host-nodes=3Dint (Binds memory to the list of NUMA h=
ost nodes)
memory-backend-memfd.hugetlb=3Dbool (Use huge pages)
memory-backend-memfd.hugetlbsize=3Dint (Huge pages size (ex: 2M, 1G))
memory-backend-memfd.merge=3Dbool (Mark memory as mergeable)
memory-backend-memfd.policy=3DHostMemPolicy (Set the NUMA policy)
memory-backend-memfd.prealloc=3Dbool (Preallocate memory)
memory-backend-memfd.seal=3Dbool (Seal growing & shrinking)
memory-backend-memfd.share=3Dbool (Mark the memory as private to QEMU or =
shared)
memory-backend-memfd.size=3Dint (Size of the memory region (ex: 500M))

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object_interfaces.c |  6 +++---
 vl.c                    | 45 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 72b97a8bed..941fd63afd 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -141,14 +141,14 @@ Object *user_creatable_add_opts(QemuOpts *opts, Err=
or **errp)
=20
 int user_creatable_add_opts_foreach(void *opaque, QemuOpts *opts, Error =
**errp)
 {
-    bool (*type_predicate)(const char *) =3D opaque;
+    bool (*type_opt_predicate)(const char *, QemuOpts *) =3D opaque;
     Object *obj =3D NULL;
     Error *err =3D NULL;
     const char *type;
=20
     type =3D qemu_opt_get(opts, "qom-type");
-    if (type && type_predicate &&
-        !type_predicate(type)) {
+    if (type && type_opt_predicate &&
+        !type_opt_predicate(type, opts)) {
         return 0;
     }
=20
diff --git a/vl.c b/vl.c
index 8a5fd0c81f..75c2bd5130 100644
--- a/vl.c
+++ b/vl.c
@@ -2721,6 +2721,11 @@ static int machine_set_property(void *opaque,
     return 0;
 }
=20
+static gint
+pstrcmp(const char **a, const char **b)
+{
+    return g_strcmp0(*a, *b);
+}
=20
 /*
  * Initial object creation happens before all other
@@ -2729,8 +2734,10 @@ static int machine_set_property(void *opaque,
  * cannot be created here, as it depends on the chardev
  * already existing.
  */
-static bool object_create_initial(const char *type)
+static bool object_create_initial(const char *type, QemuOpts *opts)
 {
+    ObjectClass *klass;
+
     if (is_help_option(type)) {
         GSList *l, *list;
=20
@@ -2744,6 +2751,38 @@ static bool object_create_initial(const char *type=
)
         exit(0);
     }
=20
+    klass =3D object_class_by_name(type);
+    if (klass && qemu_opt_has_help_opt(opts)) {
+        ObjectPropertyIterator iter;
+        ObjectProperty *prop;
+        GPtrArray *array =3D g_ptr_array_new();
+        int i;
+
+        object_class_property_iter_init(&iter, klass);
+        while ((prop =3D object_property_iter_next(&iter))) {
+            GString *str;
+
+            if (!prop->set) {
+                continue;
+            }
+
+            str =3D g_string_new(NULL);
+            g_string_append_printf(str, "%s.%s=3D%s", type,
+                                   prop->name, prop->type);
+            if (prop->description) {
+                g_string_append_printf(str, " (%s)", prop->description);
+            }
+            g_ptr_array_add(array, g_string_free(str, false));
+        }
+        g_ptr_array_sort(array, (GCompareFunc)pstrcmp);
+        for (i =3D 0; i < array->len; i++) {
+            error_printf("%s\n", (char *)array->pdata[i]);
+        }
+        g_ptr_array_set_free_func(array, g_free);
+        g_ptr_array_free(array, true);
+        exit(0);
+    }
+
     if (g_str_equal(type, "rng-egd") ||
         g_str_has_prefix(type, "pr-manager-")) {
         return false;
@@ -2790,9 +2829,9 @@ static bool object_create_initial(const char *type)
  * The remainder of object creation happens after the
  * creation of chardev, fsdev, net clients and device data types.
  */
-static bool object_create_delayed(const char *type)
+static bool object_create_delayed(const char *type, QemuOpts *opts)
 {
-    return !object_create_initial(type);
+    return !object_create_initial(type, opts);
 }
=20
=20
--=20
2.19.0.rc1
