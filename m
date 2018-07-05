Received: from eggs.gnu.org ([2001:4830:134:3::10]:57607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6ss-0008QF-OV
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6sp-0007WZ-RF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:30 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:51088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6sp-0007WA-Gt
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:27 -0400
Received: by mail-wm0-x233.google.com with SMTP id v25-v6so12197890wmc.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:13:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:29 +0100
Message-Id: <20180705160329.30386-21-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 20/20] docker: add linux-user powered cross
 builder for QEMU
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

We can't use cross compilers in the current Debian stable and Debian
sid is sketchy as hell. So for powerpc fall back to dog-fooding our
own linux-user to do the build.

As we can only build the base image with a suitably configured
source tree we fall back to checking for its existence when we can't
build it from scratch. However this does mean you don't have to keep
a static powerpc-linux-user in your active configuration just to
update the cross build image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7b99df5464..b2a7e761cc 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -64,15 +64,19 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 		$(error DEB_ARCH not set, debootstrap of debian-$* would fail))
 	$(if $(DEB_TYPE),,\
 		$(error DEB_TYPE not set, debootstrap of debian-$* would fail))
-	$(call quiet-command,						\
-		DEB_ARCH=$(DEB_ARCH)					\
-		DEB_TYPE=$(DEB_TYPE)					\
-		$(DOCKER_SCRIPT) build qemu:debian-$* $< 		\
-		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
-		$(if $(NOUSER),,--add-current-user) 			\
-		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
-		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
-		"BUILD","binfmt debian-$* (debootstrapped)")
+	$(if $(filter $(QEMU_TARGET),$(TARGET_DIRS)),				\
+		$(call quiet-command,						\
+			DEB_ARCH=$(DEB_ARCH)					\
+			DEB_TYPE=$(DEB_TYPE)					\
+			$(DOCKER_SCRIPT) build qemu:debian-$* $< 		\
+			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
+			$(if $(NOUSER),,--add-current-user) 			\
+			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
+			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
+			"BUILD","binfmt debian-$* (debootstrapped)"),		\
+		$(call quiet-command,						\
+			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $<,	\
+			"CHECK", "debian-$* exists"))
 
 endif
 
@@ -117,6 +121,21 @@ docker-image-travis: NOUSER=1
 # Specialist build images, sometimes very limited tools
 docker-image-tricore-cross: docker-image-debian9
 
+# Rules for building linux-user powered images
+#
+# These are slower than using native cross compiler setups but can
+# work around issues with poorly working multi-arch systems and broken
+# packages.
+
+# Jessie is the last supported release for powerpc, but multi-arch is
+# broken so we need a qemu-linux-user for this target
+docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
+docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
+docker-binfmt-image-debian-powerpc-user: QEMU_TARGET = ppc-linux-user
+docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
+docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
+DOCKER_USER_IMAGES += debian-powerpc-user
+
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(filter-out $(DOCKER_INTERMEDIATE_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
@@ -146,6 +165,11 @@ docker:
 	@echo
 	@echo 'Available container images:'
 	@echo '    $(DOCKER_IMAGES)'
+ifneq ($(DOCKER_USER_IMAGES),)
+	@echo
+	@echo 'Available linux-user images (docker-binfmt-image-debian-%):'
+	@echo '    $(DOCKER_USER_IMAGES)'
+endif
 	@echo
 	@echo 'Available tests:'
 	@echo '    $(DOCKER_TESTS)'
diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
new file mode 100644
index 0000000000..6938a845ee
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
@@ -0,0 +1,15 @@
+#
+# Docker powerpc cross-compiler target for QEMU
+#
+# We can't use current Debian stable cross-compilers to build powerpc
+# as it has been dropped as a release architecture. Using Debian Sid
+# is just far too sketchy a build environment. This leaves us the
+# final option of using linux-user. This image is based of the
+# debootstrapped qemu:debian-powerpc-user but doesn't need any extra
+# magic once it is setup.
+#
+FROM qemu:debian-powerpc-user
+
+RUN echo man-db man-db/auto-update boolean false | debconf-set-selections
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
-- 
2.17.1
