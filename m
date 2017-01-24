Received: from eggs.gnu.org ([2001:4830:134:3::10]:37454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AV-0004Wk-4n
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW2AT-0005KX-Bi
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:55 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW2AT-0005Ju-5I
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:33:53 -0500
Received: by mail-wm0-x231.google.com with SMTP id r144so212044459wme.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 06:33:51 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jan 2017 14:33:43 +0000
Message-Id: <20170124143346.22240-5-alex.bennee@linaro.org>
In-Reply-To: <20170124143346.22240-1-alex.bennee@linaro.org>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/7] tests/docker: add basic user mapping
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Currently all docker builds are done by exporting a tarball to the
docker container and running the build as the containers root user.
Other use cases are possible however and it is possible to map a part
of users file-system to the container. This is useful for example for
doing cross-builds of arbitrary source trees. For this to work
smoothly the container needs to have a user created that maps cleanly
to the host system.

This adds a -u option to the docker script so that:

  DEB_ARCH=armhf DEB_TYPE=stable ./tests/docker/docker.py build \
    -u --include-executable=arm-linux-user/qemu-arm \
    debian:armhf ./tests/docker/dockerfiles/debian-bootstrap.docker

Will build a container that can then be run like:

  docker run --rm -it -v /home/alex/lsrc/qemu/risu.git/:/src \
    --user=alex:alex -w /src/ debian:armhf \
    sh -c "make clean && ./configure -s && make"

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - write the useradd directly
  - change long option to --add-current-user
---
 tests/docker/docker.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 37d83199e7..b85739a9e2 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -25,6 +25,7 @@ import signal
 from tarfile import TarFile, TarInfo
 from StringIO import StringIO
 from shutil import copy, rmtree
+from pwd import getpwuid
 
 
 DEVNULL = open(os.devnull, 'wb')
@@ -149,13 +150,20 @@ class Docker(object):
         labels = json.loads(resp)[0]["Config"].get("Labels", {})
         return labels.get("com.qemu.dockerfile-checksum", "")
 
-    def build_image(self, tag, docker_dir, dockerfile, quiet=True, argv=None):
+    def build_image(self, tag, docker_dir, dockerfile,
+                    quiet=True, user=False, argv=None):
         if argv == None:
             argv = []
 
         tmp_df = tempfile.NamedTemporaryFile(dir=docker_dir, suffix=".docker")
         tmp_df.write(dockerfile)
 
+        if user:
+            uid = os.getuid()
+            uname = getpwuid(uid).pw_name
+            tmp_df.write("\n")
+            tmp_df.write("RUN useradd -u %d -U %s" % (uid, uname))
+
         tmp_df.write("\n")
         tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" %
                      _text_checksum(dockerfile))
@@ -225,6 +233,9 @@ class BuildCommand(SubCommand):
                             help="""Specify a binary that will be copied to the
                             container together with all its dependent
                             libraries""")
+        parser.add_argument("--add-current-user", "-u", dest="user",
+                            action="store_true",
+                            help="Add the current user to images passwd")
         parser.add_argument("tag",
                             help="Image Tag")
         parser.add_argument("dockerfile",
@@ -261,7 +272,7 @@ class BuildCommand(SubCommand):
                                        docker_dir)
 
             dkr.build_image(tag, docker_dir, dockerfile,
-                            quiet=args.quiet, argv=argv)
+                            quiet=args.quiet, user=args.user, argv=argv)
 
             rmtree(docker_dir)
 
-- 
2.11.0
