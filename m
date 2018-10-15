Received: from eggs.gnu.org ([2001:4830:134:3::10]:48110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fi-0005WB-5S
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fh-0005ER-91
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:50 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 19:28:16 +0200
Message-Id: <20181015172817.19796-5-mreitz@redhat.com>
In-Reply-To: <20181015172817.19796-1-mreitz@redhat.com>
References: <20181015172817.19796-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] object: Make option help nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Just like in qemu_opts_print_help(), print the object name as a caption
instead of on every single line, indent all options, and replace the '='
by ': '.

Also, indent every object name in the list of available objects.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 vl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index 4e25c78bff..f9ed053eab 100644
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
@@ -2729,16 +2729,20 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
             }
 
             str = g_string_new(NULL);
-            g_string_append_printf(str, "%s.%s=%s", type,
-                                   prop->name, prop->type);
+            g_string_append_printf(str, "%s: %s", prop->name, prop->type);
             if (prop->description) {
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
-            printf("%s\n", (char *)array->pdata[i]);
+            printf("  %s\n", (char *)array->pdata[i]);
         }
         g_ptr_array_set_free_func(array, g_free);
         g_ptr_array_free(array, true);
-- 
2.17.1
