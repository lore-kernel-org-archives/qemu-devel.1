Received: from eggs.gnu.org ([2001:4830:134:3::10]:39466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R3-000471-9g
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R1-000239-CF
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R1-0001yd-11
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AACB43001DD8
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:52:53 +0200
Message-Id: <20181015115309.17089-20-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 19/35] qom: Clean up error reporting in
 user_creatable_add_opts_foreach()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Calling error_report() in a function that takes an Error ** argument
is suspicious.  user_creatable_add_opts_foreach() does that, and then
fails without setting an error.  Its caller main(), via
qemu_opts_foreach(), is fine with it, but clean it up anyway.

Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-io.c               |  8 +++-----
 qemu-nbd.c              |  8 +++-----
 qom/object_interfaces.c |  4 +---
 vl.c                    | 16 ++++++----------
 4 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 13829f5e21..6df7731af4 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -620,11 +620,9 @@ int main(int argc, char **argv)
         exit(1);
     }
=20
-    if (qemu_opts_foreach(&qemu_object_opts,
-                          user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(&qemu_object_opts,
+                      user_creatable_add_opts_foreach,
+                      NULL, &error_fatal);
=20
     if (!trace_init_backends()) {
         exit(1);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 7874bc973c..ca7109652e 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -766,11 +766,9 @@ int main(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
=20
-    if (qemu_opts_foreach(&qemu_object_opts,
-                          user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
-        exit(EXIT_FAILURE);
-    }
+    qemu_opts_foreach(&qemu_object_opts,
+                      user_creatable_add_opts_foreach,
+                      NULL, &error_fatal);
=20
     if (!trace_init_backends()) {
         exit(1);
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 941fd63afd..97b79b48bb 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -143,7 +143,6 @@ int user_creatable_add_opts_foreach(void *opaque, Qem=
uOpts *opts, Error **errp)
 {
     bool (*type_opt_predicate)(const char *, QemuOpts *) =3D opaque;
     Object *obj =3D NULL;
-    Error *err =3D NULL;
     const char *type;
=20
     type =3D qemu_opt_get(opts, "qom-type");
@@ -152,9 +151,8 @@ int user_creatable_add_opts_foreach(void *opaque, Qem=
uOpts *opts, Error **errp)
         return 0;
     }
=20
-    obj =3D user_creatable_add_opts(opts, &err);
+    obj =3D user_creatable_add_opts(opts, errp);
     if (!obj) {
-        error_report_err(err);
         return -1;
     }
     object_unref(obj);
diff --git a/vl.c b/vl.c
index 2ef066ad61..bb18f2d995 100644
--- a/vl.c
+++ b/vl.c
@@ -4228,11 +4228,9 @@ int main(int argc, char **argv, char **envp)
     page_size_init();
     socket_init();
=20
-    if (qemu_opts_foreach(qemu_find_opts("object"),
-                          user_creatable_add_opts_foreach,
-                          object_create_initial, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("object"),
+                      user_creatable_add_opts_foreach,
+                      object_create_initial, &error_fatal);
=20
     if (qemu_opts_foreach(qemu_find_opts("chardev"),
                           chardev_init_func, NULL, NULL)) {
@@ -4363,11 +4361,9 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
=20
-    if (qemu_opts_foreach(qemu_find_opts("object"),
-                          user_creatable_add_opts_foreach,
-                          object_create_delayed, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("object"),
+                      user_creatable_add_opts_foreach,
+                      object_create_delayed, &error_fatal);
=20
     if (tpm_init() < 0) {
         exit(1);
--=20
2.17.1
