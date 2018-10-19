Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyM-0003CF-Gx
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyL-00056w-Ks
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:50:02 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 19 Oct 2018 18:49:28 +0200
Message-Id: <20181019164929.18404-5-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-1-mreitz@redhat.com>
References: <20181019164929.18404-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] object: Make option help nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Just like in qemu_opts_print_help(), print the object name as a caption
instead of on every single line, indent all options, add angle brackets
around types, and align the descriptions after 24 characters.

Also, indent every object name in the list of available objects.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 vl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index ac3ed17de4..ecddbb6b8e 100644
--- a/vl.c
+++ b/vl.c
@@ -2707,7 +2707,7 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
         list = object_class_get_list_sorted(TYPE_USER_CREATABLE, false);
         for (l = list; l != NULL; l = l->next) {
             ObjectClass *oc = OBJECT_CLASS(l->data);
-            printf("%s\n", object_class_get_name(oc));
+            printf("  %s\n", object_class_get_name(oc));
         }
         g_slist_free(list);
         exit(0);
@@ -2729,14 +2729,21 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
             }
 
             str = g_string_new(NULL);
-            g_string_append_printf(str, "%s.%s=%s", type,
-                                   prop->name, prop->type);
+            g_string_append_printf(str, "  %s=<%s>", prop->name, prop->type);
             if (prop->description) {
+                if (str->len < 24) {
+                    g_string_append_printf(str, "%*s", 24 - (int)str->len, "");
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
         for (i = 0; i < array->len; i++) {
             printf("%s\n", (char *)array->pdata[i]);
         }
-- 
2.17.1
