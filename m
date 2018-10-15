Received: from eggs.gnu.org ([2001:4830:134:3::10]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R3-000472-AG
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R1-00022q-6H
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R0-0001yT-Sj
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74971C029385
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FF187C593
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:52:52 +0200
Message-Id: <20181015115309.17089-19-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/35] vl: Clean up error reporting in
 parse_add_fd()
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
is suspicious.  parse_add_fd() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Also change call of cleanup_add_fd(), which can't fail, for symmetry.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/vl.c b/vl.c
index 643121e5d4..2ef066ad61 100644
--- a/vl.c
+++ b/vl.c
@@ -1059,12 +1059,12 @@ static int parse_add_fd(void *opaque, QemuOpts *o=
pts, Error **errp)
     fd_opaque =3D qemu_opt_get(opts, "opaque");
=20
     if (fd < 0) {
-        error_report("fd option is required and must be non-negative");
+        error_setg(errp, "fd option is required and must be non-negative=
");
         return -1;
     }
=20
     if (fd <=3D STDERR_FILENO) {
-        error_report("fd cannot be a standard I/O stream");
+        error_setg(errp, "fd cannot be a standard I/O stream");
         return -1;
     }
=20
@@ -1074,12 +1074,12 @@ static int parse_add_fd(void *opaque, QemuOpts *o=
pts, Error **errp)
      */
     flags =3D fcntl(fd, F_GETFD);
     if (flags =3D=3D -1 || (flags & FD_CLOEXEC)) {
-        error_report("fd is not valid or already in use");
+        error_setg(errp, "fd is not valid or already in use");
         return -1;
     }
=20
     if (fdset_id < 0) {
-        error_report("set option is required and must be non-negative");
+        error_setg(errp, "set option is required and must be non-negativ=
e");
         return -1;
     }
=20
@@ -1092,7 +1092,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opt=
s, Error **errp)
     }
 #endif
     if (dupfd =3D=3D -1) {
-        error_report("error duplicating fd: %s", strerror(errno));
+        error_setg(errp, "error duplicating fd: %s", strerror(errno));
         return -1;
     }
=20
@@ -3983,15 +3983,11 @@ int main(int argc, char **argv, char **envp)
     }
=20
 #ifndef _WIN32
-    if (qemu_opts_foreach(qemu_find_opts("add-fd"),
-                          parse_add_fd, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("add-fd"),
+                      parse_add_fd, NULL, &error_fatal);
=20
-    if (qemu_opts_foreach(qemu_find_opts("add-fd"),
-                          cleanup_add_fd, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("add-fd"),
+                      cleanup_add_fd, NULL, &error_fatal);
 #endif
=20
     current_machine =3D MACHINE(object_new(object_class_get_name(
--=20
2.17.1
