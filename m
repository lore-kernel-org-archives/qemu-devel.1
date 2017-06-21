Received: from eggs.gnu.org ([2001:4830:134:3::10]:37863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNguz-0006mi-Ee
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgut-000520-RE
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:41 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgut-00051V-LM
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:35 -0400
Received: by mail-wr0-x236.google.com with SMTP id 77so138147021wrb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:47:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:47:57 +0100
Message-Id: <20170621144814.15324-5-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/21] docker: rebuild image if 'extra files'
 checksum does not match
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 10fa907905..e707e5bcca 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -38,6 +38,9 @@ def _text_checksum(text):
     """Calculate a digest string unique to the text content"""
     return hashlib.sha1(text).hexdigest()
 
+def _file_checksum(filename):
+    return _text_checksum(open(filename, 'rb').read())
+
 def _guess_docker_command():
     """ Guess a working docker command or raise exception if not found"""
     commands = [["docker"], ["sudo", "-n", "docker"]]
@@ -154,7 +157,7 @@ class Docker(object):
         return labels.get("com.qemu.dockerfile-checksum", "")
 
     def build_image(self, tag, docker_dir, dockerfile,
-                    quiet=True, user=False, argv=None):
+                    quiet=True, user=False, argv=None, extra_files_cksum=[]):
         if argv == None:
             argv = []
 
@@ -170,7 +173,8 @@ class Docker(object):
 
         tmp_df.write("\n")
         tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" %
-                     _text_checksum(dockerfile))
+                     _text_checksum("\n".join([dockerfile] +
+                                    extra_files_cksum)))
         tmp_df.flush()
 
         self._do(["build", "-t", tag, "-f", tmp_df.name] + argv + \
@@ -276,16 +280,22 @@ class BuildCommand(SubCommand):
 
             # Copy any extra files into the Docker context. These can be
             # included by the use of the ADD directive in the Dockerfile.
+            cksum = []
             if args.include_executable:
+                # FIXME: there is no checksum of this executable and the linked
+                # libraries, once the image built any change of this executable
+                # or any library won't trigger another build.
                 _copy_binary_with_libs(args.include_executable, docker_dir)
             for filename in args.extra_files or []:
                 _copy_with_mkdir(filename, docker_dir)
+                cksum += [_file_checksum(filename)]
 
             argv += ["--build-arg=" + k.lower() + "=" + v
                         for k, v in os.environ.iteritems()
                         if k.lower() in FILTERED_ENV_NAMES]
             dkr.build_image(tag, docker_dir, dockerfile,
-                            quiet=args.quiet, user=args.user, argv=argv)
+                            quiet=args.quiet, user=args.user, argv=argv,
+                            extra_files_cksum=cksum)
 
             rmtree(docker_dir)
 
-- 
2.13.0
