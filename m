Received: from eggs.gnu.org ([2001:4830:134:3::10]:41269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNd-0005AL-JT
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005lw-I5
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNY-0005iX-Ru
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BA6DC0BFBC4
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:12 +0200
Message-Id: <20181008173125.19678-19-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/31] qom: Clean up error reporting in
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
index 72b97a8bed..4052d6c4a7 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -143,7 +143,6 @@ int user_creatable_add_opts_foreach(void *opaque, Qem=
uOpts *opts, Error **errp)
 {
     bool (*type_predicate)(const char *) =3D opaque;
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
index 7ce8299d9d..b8576f8f10 100644
--- a/vl.c
+++ b/vl.c
@@ -4181,11 +4181,9 @@ int main(int argc, char **argv, char **envp)
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
@@ -4316,11 +4314,9 @@ int main(int argc, char **argv, char **envp)
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
