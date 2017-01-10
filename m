Received: from eggs.gnu.org ([2001:4830:134:3::10]:47415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XN-0005Ng-7X
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XM-0007vh-F8
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0XM-0007vL-8p
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:44 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D809C04B316
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:48:05 +0100
Message-Id: <20170110174810.17748-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/20] spice-char: improve error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Set errp to report errors up to the right monitor.

Use error_append_hint() to give hints about parameters on !qmp monitors,
instead of a direct fprintf() call.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 spice-qemu-char.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 38b1f6c29b..5e5897b189 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -2,6 +2,7 @@
 #include "trace.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/char.h"
+#include "qemu/error-report.h"
 #include <spice.h>
 #include <spice/protocol.h>
=20
@@ -239,23 +240,6 @@ static void spice_port_set_fe_open(struct Chardev *c=
hr, int fe_open)
 #endif
 }
=20
-static void print_allowed_subtypes(void)
-{
-    const char** psubtype;
-    int i;
-
-    fprintf(stderr, "allowed names: ");
-    for(i=3D0, psubtype =3D spice_server_char_device_recognized_subtypes=
();
-        *psubtype !=3D NULL; ++psubtype, ++i) {
-        if (i =3D=3D 0) {
-            fprintf(stderr, "%s", *psubtype);
-        } else {
-            fprintf(stderr, ", %s", *psubtype);
-        }
-    }
-    fprintf(stderr, "\n");
-}
-
 static void spice_chr_accept_input(struct Chardev *chr)
 {
     SpiceChardev *s =3D (SpiceChardev *)chr;
@@ -302,8 +286,14 @@ static Chardev *qemu_chr_open_spice_vmc(const CharDr=
iver *driver,
         }
     }
     if (*psubtype =3D=3D NULL) {
-        fprintf(stderr, "spice-qemu-char: unsupported type: %s\n", type)=
;
-        print_allowed_subtypes();
+        char *subtypes =3D g_strjoinv(", ",
+            (gchar **)spice_server_char_device_recognized_subtypes());
+
+        error_setg(errp, "unsupported type name: %s", type);
+        error_append_hint(errp, "allowed spice char type names: %s\n",
+                          subtypes);
+
+        g_free(subtypes);
         return NULL;
     }
=20
@@ -326,7 +316,7 @@ static Chardev *qemu_chr_open_spice_port(const CharDr=
iver *driver,
     SpiceChardev *s;
=20
     if (name =3D=3D NULL) {
-        fprintf(stderr, "spice-qemu-char: missing name parameter\n");
+        error_setg(errp, "missing name parameter");
         return NULL;
     }
=20
--=20
2.11.0
