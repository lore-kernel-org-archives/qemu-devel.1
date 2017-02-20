Received: from eggs.gnu.org ([2001:4830:134:3::10]:53383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cflZD-0006iD-HM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cflZB-0006LN-Fh
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:39 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cflZB-0006Ks-6c
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:37 -0500
Received: by mail-wr0-x22a.google.com with SMTP id z61so61481849wrc.1
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 02:51:37 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 20 Feb 2017 10:51:36 +0000
Message-Id: <20170220105139.21581-2-alex.bennee@linaro.org>
In-Reply-To: <20170220105139.21581-1-alex.bennee@linaro.org>
References: <20170220105139.21581-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 1/4] tests/docker: add basic user mapping
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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

All docker containers built will add the current user unless
explicitly disabled by specifying NOUSER when invoking the Makefile:

  make docker-image-debian-armhf-cross NOUSER=1

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v2
  - write the useradd directly
  - change long option to --add-current-user
v3
  - images -> image's
  - add r-b
  - add USER to Makefile
v4
  - s/USER/NOUSER/ and default to on
  - fix the add-user code to skip if user already setup (for chained images)
v5
  - fix whitespace damage in Makefile
  - hide error messages from id when adding user
  - minor re-phrasing of NOUSER line
---
 tests/docker/Makefile.include |  2 ++
 tests/docker/docker.py        | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3f15d5aea8..3b5ffecb04 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -50,6 +50,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	$(call quiet-command,\
 		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
+		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
 
@@ -99,6 +100,7 @@ docker:
 	@echo '                         (default is 1)'
 	@echo '    DEBUG=1              Stop and drop to shell in the created container'
 	@echo '                         before running the command.'
+	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
 	@echo '    NOCACHE=1            Ignore cache when build images.'
 	@echo '    EXECUTABLE=<path>    Include executable in image.'
 
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 37d83199e7..9fd32ab5fa 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -25,6 +25,7 @@ import signal
 from tarfile import TarFile, TarInfo
 from StringIO import StringIO
 from shutil import copy, rmtree
+from pwd import getpwuid
 
 
 DEVNULL = open(os.devnull, 'wb')
@@ -149,13 +150,21 @@ class Docker(object):
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
+            tmp_df.write("RUN id %s 2>/dev/null || useradd -u %d -U %s" %
+                         (uname, uid, uname))
+
         tmp_df.write("\n")
         tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" %
                      _text_checksum(dockerfile))
@@ -225,6 +234,9 @@ class BuildCommand(SubCommand):
                             help="""Specify a binary that will be copied to the
                             container together with all its dependent
                             libraries""")
+        parser.add_argument("--add-current-user", "-u", dest="user",
+                            action="store_true",
+                            help="Add the current user to image's passwd")
         parser.add_argument("tag",
                             help="Image Tag")
         parser.add_argument("dockerfile",
@@ -261,7 +273,7 @@ class BuildCommand(SubCommand):
                                        docker_dir)
 
             dkr.build_image(tag, docker_dir, dockerfile,
-                            quiet=args.quiet, argv=argv)
+                            quiet=args.quiet, user=args.user, argv=argv)
 
             rmtree(docker_dir)
 
-- 
2.11.0
