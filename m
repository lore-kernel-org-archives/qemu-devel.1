Received: from eggs.gnu.org ([2001:4830:134:3::10]:52510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhxn-0004QV-Bm
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhxm-0007Er-2J
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:42:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:41 +0100
Message-Id: <20181105163744.25139-34-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/36] object: Make option help nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Just like in qemu_opts_print_help(), print the object name as a caption
instead of on every single line, indent all options, add angle brackets
around types, and align the descriptions after 24 characters.

Also, indent every object name in the list of available objects.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 vl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 1fcacc5caa..bed97b92ac 100644
--- a/vl.c
+++ b/vl.c
@@ -2743,7 +2743,7 @@ static bool object_create_initial(const char *type,=
 QemuOpts *opts)
         list =3D object_class_get_list_sorted(TYPE_USER_CREATABLE, false=
);
         for (l =3D list; l !=3D NULL; l =3D l->next) {
             ObjectClass *oc =3D OBJECT_CLASS(l->data);
-            printf("%s\n", object_class_get_name(oc));
+            printf("  %s\n", object_class_get_name(oc));
         }
         g_slist_free(list);
         exit(0);
@@ -2765,14 +2765,21 @@ static bool object_create_initial(const char *typ=
e, QemuOpts *opts)
             }
=20
             str =3D g_string_new(NULL);
-            g_string_append_printf(str, "%s.%s=3D%s", type,
-                                   prop->name, prop->type);
+            g_string_append_printf(str, "  %s=3D<%s>", prop->name, prop-=
>type);
             if (prop->description) {
+                if (str->len < 24) {
+                    g_string_append_printf(str, "%*s", 24 - (int)str->le=
n, "");
+                }
                 g_string_append_printf(str, " - %s", prop->description);
             }
             g_ptr_array_add(array, g_string_free(str, false));
         }
         g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
+        if (array->len > 0) {
+            printf("%s options:\n", type);
+        } else {
+            printf("There are no options for %s.\n", type);
+        }
         for (i =3D 0; i < array->len; i++) {
             printf("%s\n", (char *)array->pdata[i]);
         }
--=20
2.19.1
