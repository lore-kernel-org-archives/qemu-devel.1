Received: from eggs.gnu.org ([2001:4830:134:3::10]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8Z-0003eX-Jq
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8Y-0000Dq-Or
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8Y-0000DT-KT
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D892818BAF2
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:13:18 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D1D5B2026DEF
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:13:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:25 +0200
Message-Id: <20180531171253.21012-26-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/53] qom: support orphan objects in
 object_get_canonical_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Mostly a rewrite, in order to keep the loop simple.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 0fc972030e..cb7a8cd589 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1669,25 +1669,29 @@ gchar *object_get_canonical_path(Object *obj)
     Object *root =3D object_get_root();
     char *newpath, *path =3D NULL;
=20
-    while (obj !=3D root) {
+    if (obj =3D=3D root) {
+        return g_strdup("/");
+    }
+
+    do {
         char *component =3D object_get_canonical_path_component(obj);
=20
-        if (path) {
-            newpath =3D g_strdup_printf("%s/%s", component, path);
-            g_free(component);
+        if (!component) {
+            /* A canonical path must be complete, so discard what was
+             * collected so far.
+             */
             g_free(path);
-            path =3D newpath;
-        } else {
-            path =3D component;
+            return NULL;
         }
=20
+        newpath =3D g_strdup_printf("/%s%s", component, path ? path : ""=
);
+        g_free(path);
+        g_free(component);
+        path =3D newpath;
         obj =3D obj->parent;
-    }
-
-    newpath =3D g_strdup_printf("/%s", path ? path : "");
-    g_free(path);
+    } while (obj !=3D root);
=20
-    return newpath;
+    return path;
 }
=20
 Object *object_resolve_path_component(Object *parent, const gchar *part)
--=20
2.17.0
