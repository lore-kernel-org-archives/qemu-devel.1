Received: from eggs.gnu.org ([2001:4830:134:3::10]:56264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyBhY-00032A-60
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyBhU-0001Lb-Ej
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:01:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fyBhU-0001JV-7Q
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:01:08 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  7 Sep 2018 11:59:48 +0400
Message-Id: <20180907075948.26917-13-marcandre.lureau@redhat.com>
In-Reply-To: <20180907075948.26917-1-marcandre.lureau@redhat.com>
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/12] vl: list user creatable properties
 when 'help' is argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Iterate over the writable class properties, sort and print them out
with the description if available.

Ex: qemu -object memory-backend-file,help
memory-backend-file.align=3Dint
memory-backend-file.discard-data=3Dbool
memory-backend-file.dump=3Dbool - Set to 'off' to exclude from core dump
memory-backend-file.host-nodes=3Dint - Binds memory to the list of NUMA h=
ost nodes
memory-backend-file.mem-path=3Dstring
memory-backend-file.merge=3Dbool - Mark memory as mergeable
memory-backend-file.pmem=3Dbool
memory-backend-file.policy=3DHostMemPolicy - Set the NUMA policy
memory-backend-file.prealloc=3Dbool - Preallocate memory
memory-backend-file.share=3Dbool - Mark the memory as private to QEMU or =
shared
memory-backend-file.size=3Dint - Size of the memory region (ex: 500M)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object_interfaces.c |  6 +++---
 vl.c                    | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 6 deletions(-)

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
index 71765a2982..880676ecc1 100644
--- a/vl.c
+++ b/vl.c
@@ -2729,8 +2729,10 @@ static int machine_set_property(void *opaque,
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
@@ -2744,6 +2746,38 @@ static bool object_create_initial(const char *type=
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
+                g_string_append_printf(str, " - %s", prop->description);
+            }
+            g_ptr_array_add(array, g_string_free(str, false));
+        }
+        g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp);
+        for (i =3D 0; i < array->len; i++) {
+            printf("%s\n", (char *)array->pdata[i]);
+        }
+        g_ptr_array_set_free_func(array, g_free);
+        g_ptr_array_free(array, true);
+        exit(0);
+    }
+
     if (g_str_equal(type, "rng-egd") ||
         g_str_has_prefix(type, "pr-manager-")) {
         return false;
@@ -2790,9 +2824,9 @@ static bool object_create_initial(const char *type)
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
