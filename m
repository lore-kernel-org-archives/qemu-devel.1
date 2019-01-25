Received: from eggs.gnu.org ([209.51.188.92]:52117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn224-0003VP-70
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn222-0000hM-MY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:31 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:43173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn221-0000e5-SF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:30 -0500
Received: by mail-wr1-x435.google.com with SMTP id r10so10385210wrs.10
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:11 +0000
Message-Id: <20190125140017.6092-9-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 08/14] tests: docker.py be even smarter with
 persistent binfmt_misc
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

If we have a persistent mapping we don't need the QEMU binary copied
into the container as the kernel has already opened the file and will
pass the fd in. However the support libraries will still need to be
there.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 56 ++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 768728785f..a74338cb61 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -96,13 +96,22 @@ def _get_so_libs(executable):
 
     return libs
 
-def _copy_binary_with_libs(src, dest_dir):
-    """Copy a binary executable and all its dependent libraries.
+def _copy_binary_with_libs(src, bin_dest, dest_dir):
+    """Maybe copy a binary and all its dependent libraries.
+
+    If bin_dest isn't set we only copy the support libraries because
+    we don't need qemu in the docker path to run (due to persistent
+    mapping). Indeed users may get confused if we aren't running what
+    is in the image.
 
     This does rely on the host file-system being fairly multi-arch
-    aware so the file don't clash with the guests layout."""
+    aware so the file don't clash with the guests layout.
+    """
 
-    _copy_with_mkdir(src, dest_dir, "/usr/bin")
+    if bin_dest:
+        _copy_with_mkdir(src, dest_dir, os.path.dirname(bin_dest))
+    else:
+        print("only copying support libraries for %s" % (src))
 
     libs = _get_so_libs(src)
     if libs:
@@ -116,21 +125,26 @@ def _check_binfmt_misc(executable):
 
     The details of setting up binfmt_misc are outside the scope of
     this script but we should at least fail early with a useful
-    message if it won't work."""
+    message if it won't work.
+
+    Returns the configured binfmt path and a valid flag. For
+    persistent configurations we will still want to copy and dependent
+    libraries.
+    """
 
     binary = os.path.basename(executable)
     binfmt_entry = "/proc/sys/fs/binfmt_misc/%s" % (binary)
 
     if not os.path.exists(binfmt_entry):
         print ("No binfmt_misc entry for %s" % (binary))
-        return None
+        return None, False
 
     with open(binfmt_entry) as x: entry = x.read()
 
     if re.search("flags:.*F.*\n", entry):
         print("binfmt_misc for %s uses persistent(F) mapping to host binary\n" %
               (binary))
-        return None
+        return None, True
 
     m = re.search("interpreter (\S+)\n", entry)
     interp = m.group(1)
@@ -138,7 +152,8 @@ def _check_binfmt_misc(executable):
         print("binfmt_misc for %s does not point to %s, using %s" %
               (binary, executable, interp))
 
-    return interp
+    return interp, True
+
 
 def _read_qemu_dockerfile(img_name):
     # special case for Debian linux-user images
@@ -345,7 +360,8 @@ class BuildCommand(SubCommand):
 
             # Validate binfmt_misc will work
             if args.include_executable:
-                if not _check_binfmt_misc(args.include_executable):
+                qpath, enabled = _check_binfmt_misc(args.include_executable)
+                if not enabled:
                     return 1
 
             # Is there a .pre file to run in the build context?
@@ -368,7 +384,9 @@ class BuildCommand(SubCommand):
                 # FIXME: there is no checksum of this executable and the linked
                 # libraries, once the image built any change of this executable
                 # or any library won't trigger another build.
-                _copy_binary_with_libs(args.include_executable, docker_dir)
+                _copy_binary_with_libs(args.include_executable,
+                                       qpath, docker_dir)
+
             for filename in args.extra_files or []:
                 _copy_with_mkdir(filename, docker_dir)
                 cksum += [(filename, _file_checksum(filename))]
@@ -400,14 +418,16 @@ class UpdateCommand(SubCommand):
         tmp_tar = TarFile(fileobj=tmp, mode='w')
 
         # Add the executable to the tarball, using the current
-        # configured binfmt_misc path.
-        ff = _check_binfmt_misc(args.executable)
-        if not ff:
-            bn = os.path.basename(args.executable)
-            ff = "/usr/bin/%s" % bn
-            print ("No binfmt_misc configured: copied to %s" % (ff))
-
-        tmp_tar.add(args.executable, arcname=ff)
+        # configured binfmt_misc path. If we don't get a path then we
+        # only need the support libraries copied
+        ff, enabled = _check_binfmt_misc(args.executable)
+
+        if not enabled:
+            print("binfmt_misc not enabled, update disabled")
+            return 1
+
+        if ff:
+            tmp_tar.add(args.executable, arcname=ff)
 
         # Add any associated libraries
         libs = _get_so_libs(args.executable)
-- 
2.17.1
