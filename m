Received: from eggs.gnu.org ([2001:4830:134:3::10]:37765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNguv-0006j5-Dy
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgus-00051Q-Tk
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:37 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgus-00050n-MS
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:34 -0400
Received: by mail-wr0-x22a.google.com with SMTP id c11so82679900wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:47:34 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:47:56 +0100
Message-Id: <20170621144814.15324-4-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/21] docker: add --include-files argument to
 'build' command
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

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 0ed8c3d323..61cc0d14e2 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -51,6 +51,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
 		$(if $(NOUSER),,--add-current-user) \
+		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
 
@@ -107,6 +108,8 @@ docker:
 	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
 	@echo '    NOCACHE=1            Ignore cache when build images.'
 	@echo '    EXECUTABLE=<path>    Include executable in image.'
+	@echo '    EXTRA_FILES="<path> [... <path>]"'
+	@echo '                         Include extra files in image.'
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 6ddc6e4c2a..10fa907905 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -237,6 +237,10 @@ class BuildCommand(SubCommand):
                             help="""Specify a binary that will be copied to the
                             container together with all its dependent
                             libraries""")
+        parser.add_argument("--extra-files", "-f", nargs='*',
+                            help="""Specify files that will be copied in the
+                            Docker image, fulfilling the ADD directive from the
+                            Dockerfile""")
         parser.add_argument("--add-current-user", "-u", dest="user",
                             action="store_true",
                             help="Add the current user to image's passwd")
@@ -270,10 +274,12 @@ class BuildCommand(SubCommand):
                     print "%s exited with code %d" % (docker_pre, rc)
                     return 1
 
-            # Do we include a extra binary?
+            # Copy any extra files into the Docker context. These can be
+            # included by the use of the ADD directive in the Dockerfile.
             if args.include_executable:
-                _copy_binary_with_libs(args.include_executable,
-                                       docker_dir)
+                _copy_binary_with_libs(args.include_executable, docker_dir)
+            for filename in args.extra_files or []:
+                _copy_with_mkdir(filename, docker_dir)
 
             argv += ["--build-arg=" + k.lower() + "=" + v
                         for k, v in os.environ.iteritems()
-- 
2.13.0
