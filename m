Received: from eggs.gnu.org ([209.51.188.92]:52197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn22A-0003c9-6u
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn222-0000gs-4Q
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:51178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn221-0000Zm-PM
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:29 -0500
Received: by mail-wm1-x333.google.com with SMTP id n190so6893197wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:09 +0000
Message-Id: <20190125140017.6092-7-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 06/14] tests: make docker.py update use
 configured binfmt path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

When copying a QEMU binary into a linux-user docker image we should
check what the current configured binfmt_misc path is rather than
just assuming "/usr/bin/qemu-bin". Obviously if the user changes the
configuration afterwards they will break their images again.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 02d8a83847..30f463af9f 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -123,17 +123,17 @@ def _check_binfmt_misc(executable):
 
     if not os.path.exists(binfmt_entry):
         print ("No binfmt_misc entry for %s" % (binary))
-        return False
+        return None
 
     with open(binfmt_entry) as x: entry = x.read()
 
-    qpath = "/usr/bin/%s" % (binary)
-    if not re.search("interpreter %s\n" % (qpath), entry):
-        print ("binfmt_misc for %s does not point to %s" % (binary, qpath))
-        return False
-
-    return True
+    m = re.search("interpreter (\S+)\n", entry)
+    interp = m.group(1)
+    if interp and interp != executable:
+        print("binfmt_misc for %s does not point to %s, using %s" %
+              (binary, executable, interp))
 
+    return interp
 
 def _read_qemu_dockerfile(img_name):
     # special case for Debian linux-user images
@@ -394,9 +394,14 @@ class UpdateCommand(SubCommand):
         tmp = tempfile.NamedTemporaryFile(suffix="dckr.tar.gz")
         tmp_tar = TarFile(fileobj=tmp, mode='w')
 
-        # Add the executable to the tarball
-        bn = os.path.basename(args.executable)
-        ff = "/usr/bin/%s" % bn
+        # Add the executable to the tarball, using the current
+        # configured binfmt_misc path.
+        ff = _check_binfmt_misc(args.executable)
+        if not ff:
+            bn = os.path.basename(args.executable)
+            ff = "/usr/bin/%s" % bn
+            print ("No binfmt_misc configured: copied to %s" % (ff))
+
         tmp_tar.add(args.executable, arcname=ff)
 
         # Add any associated libraries
-- 
2.17.1
