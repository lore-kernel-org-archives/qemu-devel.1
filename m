Received: from eggs.gnu.org ([2001:4830:134:3::10]:49974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1g0noP-0000gi-0N
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1g0noM-0006xa-LU
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1g0noM-0006MT-9U
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 09:07:02 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 14 Sep 2018 15:06:44 +0200
Message-Id: <20180914130644.15292-2-otubo@redhat.com>
In-Reply-To: <20180914130644.15292-1-otubo@redhat.com>
References: <20180914130644.15292-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] seccomp: check TSYNC host capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Remove -sandbox option if the host is not capable of TSYNC, since the
sandbox will fail at setup time otherwise. This will help libvirt, for
ex, to figure out if -sandbox will work.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
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
index 5ba06adf78..380ae7ba2b 100644
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
2.17.1
