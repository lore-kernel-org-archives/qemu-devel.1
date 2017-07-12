Received: from eggs.gnu.org ([2001:4830:134:3::10]:44995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVCUq-0000Iu-T0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVCUp-0000Cb-UA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVCUp-0000BW-8w
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 12 Jul 2017 15:55:28 +0800
Message-Id: <20170712075528.22770-3-famz@redhat.com>
In-Reply-To: <20170712075528.22770-1-famz@redhat.com>
References: <20170712075528.22770-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] docker.py: Improve subprocess exit code
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
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A few error handlings are missing because we ignore the subprocess exit
code, for example "docker build" errors are currently ignored.

Introduce _do_check() aside the existing _do() method and use it in a
few places.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index f5ac86b..ee40ca0 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -117,6 +117,11 @@ class Docker(object):
             kwargs["stdout"] = DEVNULL
         return subprocess.call(self._command + cmd, **kwargs)
 
+    def _do_check(self, cmd, quiet=True, **kwargs):
+        if quiet:
+            kwargs["stdout"] = DEVNULL
+        return subprocess.check_call(self._command + cmd, **kwargs)
+
     def _do_kill_instances(self, only_known, only_active=True):
         cmd = ["ps", "-q"]
         if not only_active:
@@ -175,14 +180,14 @@ class Docker(object):
                                     extra_files_cksum)))
         tmp_df.flush()
 
-        self._do(["build", "-t", tag, "-f", tmp_df.name] + argv + \
-                 [docker_dir],
-                 quiet=quiet)
+        self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv + \
+                       [docker_dir],
+                       quiet=quiet)
 
     def update_image(self, tag, tarball, quiet=True):
         "Update a tagged image using "
 
-        self._do(["build", "-t", tag, "-"], quiet=quiet, stdin=tarball)
+        self._do_check(["build", "-t", tag, "-"], quiet=quiet, stdin=tarball)
 
     def image_matches_dockerfile(self, tag, dockerfile):
         try:
@@ -195,9 +200,9 @@ class Docker(object):
         label = uuid.uuid1().hex
         if not keep:
             self._instances.append(label)
-        ret = self._do(["run", "--label",
-                        "com.qemu.instance.uuid=" + label] + cmd,
-                       quiet=quiet)
+        ret = self._do_check(["run", "--label",
+                             "com.qemu.instance.uuid=" + label] + cmd,
+                             quiet=quiet)
         if not keep:
             self._instances.remove(label)
         return ret
-- 
2.9.4
