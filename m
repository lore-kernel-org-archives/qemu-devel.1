Received: from eggs.gnu.org ([2001:4830:134:3::10]:44261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QL-0008ED-SM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QK-0000Ep-R3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ch9QK-0000Eg-IK
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:12 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Feb 2017 14:32:01 +0800
Message-Id: <20170224063205.2537-2-famz@redhat.com>
In-Reply-To: <20170224063205.2537-1-famz@redhat.com>
References: <20170224063205.2537-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] tests/docker: add basic user mapping support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Currently all docker builds are done by exporting a tarball to the
docker container and running the build as the containers root user.
Other use cases are possible however and it is possible to map a part
of users file-system to the container. This is useful for example for
doing cross-builds of arbitrary source trees. For this to work
smoothly the container needs to have a user created that maps cleanly
to the host system.

This adds a -u option to the docker script so that:

  DEB_ARCH=3Darmhf DEB_TYPE=3Dstable ./tests/docker/docker.py build \
    -u --include-executable=3Darm-linux-user/qemu-arm \
    debian:armhf ./tests/docker/dockerfiles/debian-bootstrap.docker

Will build a container that can then be run like:

  docker run --rm -it -v /home/alex/lsrc/qemu/risu.git/:/src \
    --user=3Dalex:alex -w /src/ debian:armhf \
    sh -c "make clean && ./configure -s && make"

All docker containers built will add the current user unless
explicitly disabled by specifying NOUSER when invoking the Makefile:

  make docker-image-debian-armhf-cross NOUSER=3D1

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170220105139.21581-2-alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include |  2 ++
 tests/docker/docker.py        | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 3f15d5a..3b5ffec 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -50,6 +50,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	$(call quiet-command,\
 		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
+		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
 		"BUILD","$*")
=20
@@ -99,6 +100,7 @@ docker:
 	@echo '                         (default is 1)'
 	@echo '    DEBUG=3D1              Stop and drop to shell in the created=
 container'
 	@echo '                         before running the command.'
+	@echo '    NOUSER               Define to disable adding current user t=
o containers passwd.'
 	@echo '    NOCACHE=3D1            Ignore cache when build images.'
 	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
=20
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 37d8319..9fd32ab 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -25,6 +25,7 @@ import signal
 from tarfile import TarFile, TarInfo
 from StringIO import StringIO
 from shutil import copy, rmtree
+from pwd import getpwuid
=20
=20
 DEVNULL =3D open(os.devnull, 'wb')
@@ -149,13 +150,21 @@ class Docker(object):
         labels =3D json.loads(resp)[0]["Config"].get("Labels", {})
         return labels.get("com.qemu.dockerfile-checksum", "")
=20
-    def build_image(self, tag, docker_dir, dockerfile, quiet=3DTrue, arg=
v=3DNone):
+    def build_image(self, tag, docker_dir, dockerfile,
+                    quiet=3DTrue, user=3DFalse, argv=3DNone):
         if argv =3D=3D None:
             argv =3D []
=20
         tmp_df =3D tempfile.NamedTemporaryFile(dir=3Ddocker_dir, suffix=3D=
".docker")
         tmp_df.write(dockerfile)
=20
+        if user:
+            uid =3D os.getuid()
+            uname =3D getpwuid(uid).pw_name
+            tmp_df.write("\n")
+            tmp_df.write("RUN id %s 2>/dev/null || useradd -u %d -U %s" =
%
+                         (uname, uid, uname))
+
         tmp_df.write("\n")
         tmp_df.write("LABEL com.qemu.dockerfile-checksum=3D%s" %
                      _text_checksum(dockerfile))
@@ -225,6 +234,9 @@ class BuildCommand(SubCommand):
                             help=3D"""Specify a binary that will be copi=
ed to the
                             container together with all its dependent
                             libraries""")
+        parser.add_argument("--add-current-user", "-u", dest=3D"user",
+                            action=3D"store_true",
+                            help=3D"Add the current user to image's pass=
wd")
         parser.add_argument("tag",
                             help=3D"Image Tag")
         parser.add_argument("dockerfile",
@@ -261,7 +273,7 @@ class BuildCommand(SubCommand):
                                        docker_dir)
=20
             dkr.build_image(tag, docker_dir, dockerfile,
-                            quiet=3Dargs.quiet, argv=3Dargv)
+                            quiet=3Dargs.quiet, user=3Dargs.user, argv=3D=
argv)
=20
             rmtree(docker_dir)
=20
--=20
2.9.3
