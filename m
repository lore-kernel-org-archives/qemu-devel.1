Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fq1p3-0003JT-Nt
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fq1ow-0000sI-Q3
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:51:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fq1ow-0000rr-Ie
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:51:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CB43AE7D
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 19:51:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 15 Aug 2018 21:50:51 +0200
Message-Id: <20180815195051.24586-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180815195051.24586-1-marcandre.lureau@redhat.com>
References: <20180815195051.24586-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] qemu-option: improve
 qemu_opts_print_help() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Modify qemu_opts_print_help():
- to print expected argument type
- skip description if not available
- sort lines
- prefix with the list name (like qdev, to avoid confusion)
- drop 16-chars alignment, use a '-' as seperator for option name and
  description

For ex, "-spice ?" output is changed from:

port             No description available
tls-port         No description available
addr             No description available
[...]
gl               No description available
rendernode       No description available

to:

spice.addr=3Dstr
spice.agent-mouse=3Dbool (on/off)
spice.disable-agent-file-xfer=3Dbool (on/off)
[...]
spice.x509-key-password=3Dstr
spice.zlib-glz-wan-compression=3Dstr

"qemu-img create -f qcow2 -o ?", changed from:

size             Virtual disk size
compat           Compatibility level (0.10 or 1.1)
backing_file     File name of a base image
[...]
lazy_refcounts   Postpone refcount updates
refcount_bits    Width of a reference count entry in bits

to:

backing_file=3Dstr - File name of a base image
backing_fmt=3Dstr - Image format of the base image
cluster_size=3Dsize - qcow2 cluster size
[...]
refcount_bits=3Dnum - Width of a reference count entry in bits
size=3Dsize - Virtual disk size

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-option.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 8839ee6523..9b99f0d0be 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -208,17 +208,57 @@ out:
     return result;
 }
=20
+static const char *opt_type_to_string(enum QemuOptType type)
+{
+    switch (type) {
+    case QEMU_OPT_STRING:
+        return "str";
+    case QEMU_OPT_BOOL:
+        return "bool (on/off)";
+    case QEMU_OPT_NUMBER:
+        return "num";
+    case QEMU_OPT_SIZE:
+        return "size";
+    }
+
+    g_assert_not_reached();
+}
+
+static gint
+pstrcmp(const char **a, const char **b)
+{
+    return g_strcmp0(*a, *b);
+}
+
 void qemu_opts_print_help(QemuOptsList *list)
 {
     QemuOptDesc *desc;
+    int i;
+    GPtrArray *array =3D g_ptr_array_new();
=20
     assert(list);
     desc =3D list->desc;
     while (desc && desc->name) {
-        printf("%-16s %s\n", desc->name,
-               desc->help ? desc->help : "No description available");
+        GString *str =3D g_string_new(NULL);
+        if (list->name) {
+            g_string_append_printf(str, "%s.", list->name);
+        }
+        g_string_append_printf(str, "%s=3D%s", desc->name,
+                               opt_type_to_string(desc->type));
+        if (desc->help) {
+            g_string_append_printf(str, " - %s", desc->help);
+        }
+        g_ptr_array_add(array, g_string_free(str, false));
         desc++;
     }
+
+    g_ptr_array_sort(array, (GCompareFunc)pstrcmp);
+    for (i =3D 0; i < array->len; i++) {
+        printf("%s\n", (char *)array->pdata[i]);
+    }
+    g_ptr_array_set_free_func(array, g_free);
+    g_ptr_array_free(array, true);
+
 }
 /* ------------------------------------------------------------------ */
=20
--=20
2.18.0.547.g1d89318c48
