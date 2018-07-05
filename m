Received: from eggs.gnu.org ([2001:4830:134:3::10]:54950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jS-0008S3-LC
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jR-00084n-LQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:46 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jR-00084G-Eo
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:45 -0400
Received: by mail-wm0-x241.google.com with SMTP id z6-v6so3199379wma.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:28 +0100
Message-Id: <20180705160329.30386-20-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 19/20] docker: add special rule for
 deboostrapped images
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

We might as well have a custom rule for this. For one thing the
dependencies are different. As the primary dependency for
docker-image-% could never be docker-image-debian-bootstrap we can
drop that test in the main rule as well.

Missing EXECUTABLE, DEB_ARCH and DEB_TYPE are treated as hard faults
now. We also error out if the EXECUTABLE file isn't there. We should
really do this with a dependency on any source rules but currently
subdir-FOO-linux-user isn't enough on a clean build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 942d05649f..7b99df5464 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -46,9 +46,6 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		"CHECK", "$*")
 else
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
-	@if test "$@" = docker-image-debian-bootstrap -a -z "$(EXECUTABLE)"; then \
-		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
-	fi
 	$(call quiet-command,\
 		$(DOCKER_SCRIPT) build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
@@ -56,6 +53,27 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
+
+# Special rule for debootstraped binfmt linux-user images
+docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
+	$(if $(EXECUTABLE),,\
+		$(error EXECUTABLE not set, debootstrap of debian-$* would fail))
+	$(if $(wildcard $(EXECUTABLE)),,\
+		$(error Please build $(EXECUTABLE) first))
+	$(if $(DEB_ARCH),,\
+		$(error DEB_ARCH not set, debootstrap of debian-$* would fail))
+	$(if $(DEB_TYPE),,\
+		$(error DEB_TYPE not set, debootstrap of debian-$* would fail))
+	$(call quiet-command,						\
+		DEB_ARCH=$(DEB_ARCH)					\
+		DEB_TYPE=$(DEB_TYPE)					\
+		$(DOCKER_SCRIPT) build qemu:debian-$* $< 		\
+		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
+		$(if $(NOUSER),,--add-current-user) 			\
+		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
+		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
+		"BUILD","binfmt debian-$* (debootstrapped)")
+
 endif
 
 # Enforce dependencies for composite images
-- 
2.17.1
