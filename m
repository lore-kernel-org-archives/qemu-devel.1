Received: from eggs.gnu.org ([2001:4830:134:3::10]:44815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISo-0004Z7-QS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISn-0004Xz-9p
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:14 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faISn-0004Xl-1X
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:13 -0400
Received: by mail-wm0-x241.google.com with SMTP id b188-v6so1732949wme.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:23:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:44 +0100
Message-Id: <20180703101444.23778-21-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/20] docker: add linux-user powered cross
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
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
index d43af0db32..12852ebbc4 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -121,6 +121,32 @@ docker-image-travis: NOUSER=1
 # Specialist build images, sometimes very limited tools
 docker-image-tricore-cross: docker-image-debian9
 
+# Rules for building linux-user powered images
+#
+# These are slower than using native cross compiler setups but can
+# work around issues with poorly working multi-arch systems and broken
+# packages.
+
+ifeq ($(filter ppc-linux-user,$(TARGET_LIST))$(CONFIG_STATIC),ppc-linux-usery)
+# Jessie is the last supported release for powerpc, but multi-arch is
+# broken so we need a qemu-linux-user for this target
+docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
+docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
+docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
+DOCKER_USER_IMAGES += debian-powerpc-user
+else
+docker-binfmt-image-debian-powerpc-user:
+	$(if,$(call quiet-command, \
+		$(DOCKER_SCRIPT) check --quiet qemu:debian-powerpc-user \
+			$(DOCKER_FILES_DIR)/debian-bootstrap.docker, \
+		"CHECK", "debian-powerpc-user exists"),\
+		$(error To build $@ you need a --static ppc-linux-user and configured binfmt_misc setup))
+endif
+
+# We build the QEMU compiler environment on top of the base image
+docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
+
+
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(filter-out $(DOCKER_INTERMEDIATE_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
@@ -156,6 +182,11 @@ docker:
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
