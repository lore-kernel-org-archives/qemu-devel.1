Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvO9i-0005s6-87
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvO1E-0006Rd-Rt
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:34:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvO1E-0006Qw-ND
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C891804BAAC
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 14:33:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 16:33:48 +0200
Message-Id: <20180830143348.10595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] seccomp: check TSYNC host capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, otubo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Remove -sandbox option if the host is not capable of TSYNC, since the
sandbox will fail at setup time otherwise. This will help libvirt, for
ex, to figure out if -sandbox will work.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-seccomp.c | 19 ++++++++++++++++++-
 vl.c           |  4 ++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 4729eb107f..1baa5c69ed 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -282,7 +282,24 @@ static QemuOptsList qemu_sandbox_opts =3D {
=20
 static void seccomp_register(void)
 {
-    qemu_add_opts(&qemu_sandbox_opts);
+    bool add =3D false;
+
+    /* FIXME: use seccomp_api_get() >=3D 2 check when released */
+
+#if defined(SECCOMP_FILTER_FLAG_TSYNC)
+    int check;
+
+    /* check host TSYNC capability, it returns errno =3D=3D ENOSYS if un=
available */
+    check =3D qemu_seccomp(SECCOMP_SET_MODE_FILTER,
+                         SECCOMP_FILTER_FLAG_TSYNC, NULL);
+    if (check < 0 && errno =3D=3D EFAULT) {
+        add =3D true;
+    }
+#endif
+
+    if (add) {
+        qemu_add_opts(&qemu_sandbox_opts);
+    }
 }
 opts_init(seccomp_register);
 #endif
diff --git a/vl.c b/vl.c
index 408bff9c1e..70c2449b86 100644
--- a/vl.c
+++ b/vl.c
@@ -4007,8 +4007,8 @@ int main(int argc, char **argv, char **envp)
     }
=20
 #ifdef CONFIG_SECCOMP
-    if (qemu_opts_foreach(qemu_find_opts("sandbox"),
-                          parse_sandbox, NULL, NULL)) {
+    olist =3D qemu_find_opts_err("sandbox", NULL);
+    if (olist && qemu_opts_foreach(olist, parse_sandbox, NULL, NULL)) {
         exit(1);
     }
 #endif
--=20
2.19.0.rc0.48.gb9dfa238d5
