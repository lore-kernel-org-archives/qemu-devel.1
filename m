Received: from eggs.gnu.org ([2001:4830:134:3::10]:56800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQ8-0006EG-DH
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQ7-0005g3-Iv
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:28 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:35011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQ7-0005fC-Dn
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:27 -0400
Received: by mail-oi0-x235.google.com with SMTP id l18so42730341oig.2
	for <qemu-devel@nongnu.org>; Sat, 27 May 2017 09:18:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 27 May 2017 13:17:34 -0300
Message-Id: <20170527161755.7761-4-f4bug@amsat.org>
In-Reply-To: <20170527161755.7761-1-f4bug@amsat.org>
References: <20170527161755.7761-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 03/24] docker: rebuild image if 'extra
 files' checksum does not match
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/docker.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 5401e58fce..b5ee8bd6e3 100755
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
@@ -275,16 +279,22 @@ class BuildCommand(SubCommand):
                     return 1
 
             # Include files used by ADD directives found within the Dockerfile.
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
2.11.0
