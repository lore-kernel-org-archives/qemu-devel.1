Received: from eggs.gnu.org ([2001:4830:134:3::10]:42588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1n-0000wm-Hi
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1m-0004jh-Nl
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1m-0004jP-HM
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:24 +0800
Message-Id: <20170717034825.1524-15-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/15] docker.py: Improve subprocess exit code
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

A few error handlings are missing because we ignore the subprocess exit
code, for example "docker build" errors are currently ignored.

Introduce _do_check() aside the existing _do() method and use it in a
few places.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170712075528.22770-3-famz@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index f5ac86b..ee40ca0 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -117,6 +117,11 @@ class Docker(object):
             kwargs["stdout"] =3D DEVNULL
         return subprocess.call(self._command + cmd, **kwargs)
=20
+    def _do_check(self, cmd, quiet=3DTrue, **kwargs):
+        if quiet:
+            kwargs["stdout"] =3D DEVNULL
+        return subprocess.check_call(self._command + cmd, **kwargs)
+
     def _do_kill_instances(self, only_known, only_active=3DTrue):
         cmd =3D ["ps", "-q"]
         if not only_active:
@@ -175,14 +180,14 @@ class Docker(object):
                                     extra_files_cksum)))
         tmp_df.flush()
=20
-        self._do(["build", "-t", tag, "-f", tmp_df.name] + argv + \
-                 [docker_dir],
-                 quiet=3Dquiet)
+        self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv + =
\
+                       [docker_dir],
+                       quiet=3Dquiet)
=20
     def update_image(self, tag, tarball, quiet=3DTrue):
         "Update a tagged image using "
=20
-        self._do(["build", "-t", tag, "-"], quiet=3Dquiet, stdin=3Dtarba=
ll)
+        self._do_check(["build", "-t", tag, "-"], quiet=3Dquiet, stdin=3D=
tarball)
=20
     def image_matches_dockerfile(self, tag, dockerfile):
         try:
@@ -195,9 +200,9 @@ class Docker(object):
         label =3D uuid.uuid1().hex
         if not keep:
             self._instances.append(label)
-        ret =3D self._do(["run", "--label",
-                        "com.qemu.instance.uuid=3D" + label] + cmd,
-                       quiet=3Dquiet)
+        ret =3D self._do_check(["run", "--label",
+                             "com.qemu.instance.uuid=3D" + label] + cmd,
+                             quiet=3Dquiet)
         if not keep:
             self._instances.remove(label)
         return ret
--=20
2.9.4
