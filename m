Received: from eggs.gnu.org ([2001:4830:134:3::10]:35142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7t-0005ws-0G
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7o-0001yl-S8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:56 -0500
Received: from mail-wj0-f180.google.com ([209.85.210.180]:33519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHD7o-0001yY-L9
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:52 -0500
Received: by mail-wj0-f180.google.com with SMTP id xy5so42545254wjc.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:13:52 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Dec 2016 17:12:41 +0000
Message-Id: <20161214171244.26813-2-alex.bennee@linaro.org>
In-Reply-To: <20161214171244.26813-1-alex.bennee@linaro.org>
References: <20161214171244.26813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC/POC PATCH 1/4] tests/docker: add basic user
 mapping support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com, marcandre.lureau@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

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
 tests/docker/docker.py                           | 19 +++++++++++++++++++
 tests/docker/dockerfiles/debian-bootstrap.docker |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 37d83199e7..59baac6bae 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -12,6 +12,7 @@
 # the top-level directory.
 
 import os
+import stat
 import sys
 import subprocess
 import json
@@ -25,6 +26,7 @@ import signal
 from tarfile import TarFile, TarInfo
 from StringIO import StringIO
 from shutil import copy, rmtree
+from pwd import getpwuid
 
 
 DEVNULL = open(os.devnull, 'wb')
@@ -225,6 +227,8 @@ class BuildCommand(SubCommand):
                             help="""Specify a binary that will be copied to the
                             container together with all its dependent
                             libraries""")
+        parser.add_argument("--user", "-u", action="store_true",
+                            help="Add the current user to images passwd")
         parser.add_argument("tag",
                             help="Image Tag")
         parser.add_argument("dockerfile",
@@ -260,6 +264,21 @@ class BuildCommand(SubCommand):
                 _copy_binary_with_libs(args.include_executable,
                                        docker_dir)
 
+            if args.user:
+                uid = os.getuid()
+                uname = getpwuid(uid).pw_name
+                scriptlet = docker_dir+"/setup_user.sh"
+
+                # write scriptlet
+                setup = open(scriptlet, "w")
+                setup.write("#!/bin/sh\n")
+                setup.write("useradd -u %d -U %s" % (uid, uname))
+                setup.close()
+
+                st = os.stat(scriptlet)
+                os.chmod(scriptlet,
+                         st.st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)
+
             dkr.build_image(tag, docker_dir, dockerfile,
                             quiet=args.quiet, argv=argv)
 
diff --git a/tests/docker/dockerfiles/debian-bootstrap.docker b/tests/docker/dockerfiles/debian-bootstrap.docker
index 3a9125e497..127782eedf 100644
--- a/tests/docker/dockerfiles/debian-bootstrap.docker
+++ b/tests/docker/dockerfiles/debian-bootstrap.docker
@@ -14,6 +14,9 @@ RUN sed -i 's/in_target mount/echo not for docker in_target mount/g' /debootstra
 # Run stage 2
 RUN /debootstrap/debootstrap --second-stage
 
+# Do we want to tweak the user?
+RUN if test -e /setup_user.sh; then /setup_user.sh; fi
+
 # At this point we can install additional packages if we want
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
-- 
2.11.0
