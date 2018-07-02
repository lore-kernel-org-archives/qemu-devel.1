Received: from eggs.gnu.org ([2001:4830:134:3::10]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZzqh-0005WM-EW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZzqg-0000ZL-7h
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:39 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZzqg-0000YV-0L
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:38 -0400
Received: by mail-wr0-x243.google.com with SMTP id f18-v6so2067630wre.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:30:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  2 Jul 2018 15:30:21 +0100
Message-Id: <20180702143021.18864-21-alex.bennee@linaro.org>
In-Reply-To: <20180702143021.18864-1-alex.bennee@linaro.org>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 20/20] docker: add linux-user powered cross
 builder for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We can't use cross compilers in the current Debian stable and Debian
sid is sketchy as hell. So for powerpc fall back to dog-fooding our
own linux-user to do the build.

As we can only build the base image with a suitably configured
source tree we fall back to checking for it's existence when we can't
build it from scratch. However this does mean you don't have to keep
a static powerpc-linux-user in your active configuration just to
update the cross build image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - fix for rename of docker-binfmt-image-debian-powerpc-user
---
 tests/docker/Makefile.include                 | 29 +++++++++++++++++++
 .../debian-powerpc-user-cross.docker          | 13 +++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fdc87b8a57..85801702dd 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -119,6 +119,31 @@ docker-image-travis: NOUSER=1
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
+	$(call quiet-command, \
+		$(DOCKER_SCRIPT) check --quiet qemu:debian-powerpc-user \
+			$(DOCKER_FILES_DIR)/debian-bootstrap.docker, \
+		"CHECK", "debian-powerpc-user exists")
+endif
+
+# We build the QEMU compiler environment on top of the base image
+docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
+
+
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(filter-out $(DOCKER_INTERMEDIATE_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
@@ -154,6 +179,10 @@ docker:
 	@echo
 	@echo 'Available container images:'
 	@echo '    $(DOCKER_IMAGES)'
+ifneq ($(DOCKER_USER_IMAGES),)
+	@echo 'Available linux-user images:'
+	@echo '    $(DOCKER_USER_IMAGES)'
+endif
 	@echo
 	@echo 'Available tests:'
 	@echo '    $(DOCKER_TESTS)'
diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
new file mode 100644
index 0000000000..eadb142792
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
@@ -0,0 +1,13 @@
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
+RUN apt-get update && apt-get build-dep -yy qemu
-- 
2.17.1
