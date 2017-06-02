Received: from eggs.gnu.org ([2001:4830:134:3::10]:39910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkq-0001uK-VU
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkq-0006DH-3x
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:01 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkp-0006D7-VM
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:00 -0400
Received: by mail-oi0-x243.google.com with SMTP id f206so3398846oig.2
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:56:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:08 -0300
Message-Id: <20170602185630.5059-3-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 02/24] docker: add --include-files argument
 to 'build' command
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include |  3 +++
 tests/docker/docker.py        | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 03eda37bf4..fe1a9a53ff 100644
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
2.11.0
