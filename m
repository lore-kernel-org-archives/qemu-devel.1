Received: from eggs.gnu.org ([2001:4830:134:3::10]:34079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhv1o-0007R3-Ad
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhv1n-0000li-E6
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:52 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:54857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhv1n-0000lJ-7L
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:51 -0400
Received: by mail-wm0-x22c.google.com with SMTP id c14-v6so2072213wmb.4
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:58:51 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:08 +0100
Message-Id: <20180724105109.8392-17-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/17] docker: perform basic binfmt_misc
 validation in docker.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Setting up binfmt_misc is outside of the scope of the docker.py script
but we can at least validate it with any given executable so we have a
more useful error message than the sed line of deboostrap failing
cryptically.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 2f81c6b13b..d3006d4dae 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -112,6 +112,31 @@ def _copy_binary_with_libs(src, dest_dir):
             so_path = os.path.dirname(l)
             _copy_with_mkdir(l , dest_dir, so_path)
 
+
+def _check_binfmt_misc(executable):
+    """Check binfmt_misc has entry for executable in the right place.
+
+    The details of setting up binfmt_misc are outside the scope of
+    this script but we should at least fail early with a useful
+    message if it won't work."""
+
+    binary = os.path.basename(executable)
+    binfmt_entry = "/proc/sys/fs/binfmt_misc/%s" % (binary)
+
+    if not os.path.exists(binfmt_entry):
+        print ("No binfmt_misc entry for %s" % (binary))
+        return False
+
+    with open(binfmt_entry) as x: entry = x.read()
+
+    qpath = "/usr/bin/%s" % (binary)
+    if not re.search("interpreter %s\n" % (qpath), entry):
+        print ("binfmt_misc for %s does not point to %s" % (binary, qpath))
+        return False
+
+    return True
+
+
 def _read_qemu_dockerfile(img_name):
     # special case for Debian linux-user images
     if img_name.startswith("debian") and img_name.endswith("user"):
@@ -315,6 +340,11 @@ class BuildCommand(SubCommand):
             # Create a docker context directory for the build
             docker_dir = tempfile.mkdtemp(prefix="docker_build")
 
+            # Validate binfmt_misc will work
+            if args.include_executable:
+                if not _check_binfmt_misc(args.include_executable):
+                    return 1
+
             # Is there a .pre file to run in the build context?
             docker_pre = os.path.splitext(args.dockerfile)[0]+".pre"
             if os.path.exists(docker_pre):
-- 
2.17.1
