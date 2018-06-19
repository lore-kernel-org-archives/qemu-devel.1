Received: from eggs.gnu.org ([2001:4830:134:3::10]:45897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4q-0004X4-ET
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4l-0007Z9-Kl
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:52 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:53058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVJ4l-0007Z1-F3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:47 -0400
Received: by mail-wm0-x231.google.com with SMTP id p126-v6so1277816wmb.2
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:01:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:32 +0100
Message-Id: <20180619154435.18898-54-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 53/56] tests/Makefile: call sub-makes with
 SKIP_DOCKER_BUILD=1
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

As we now ensure all the images we are going to use are built in the
top level make file lets not over complicate things by running the
full script again. We do run the check script just in case someone
deletes the docker image while we are running.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2dd0700a88..dad20e1b9b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -947,10 +947,14 @@ $(foreach PROBE_TARGET,$(TARGET_LIST), 				\
 		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
 
 build-tcg-tests-%:
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
+		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" guest-tests, \
+		"BUILD", "TCG tests for $*")
 
 run-tcg-tests-%: build-tcg-tests-%
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" run-guest-tests,)
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
+		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" run-guest-tests, \
+		"RUN", "TCG tests for $*")
 
 clean-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 87f449264f..c0f09505bb 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -34,7 +34,15 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
 
 docker-image: ${DOCKER_TARGETS}
 
-# General rule for building docker images
+# General rule for building docker images. If we are a sub-make
+# invoked with SKIP_DOCKER_BUILD we still check the image is upto date
+# though
+ifdef SKIP_DOCKER_BUILD
+docker-image-%: $(DOCKER_FILES_DIR)/%.docker
+	$(call quiet-command, \
+		$(DOCKER_SCRIPT) check --quiet qemu:$* $<, \
+		"CHECK", "$*")
+else
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	@if test "$@" = docker-image-debian-bootstrap -a -z "$(EXECUTABLE)"; then \
 		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
@@ -46,6 +54,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
+endif
 
 # Enforce dependencies for composite images
 docker-image-debian: docker-image-debian9
@@ -65,7 +74,9 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
 # Debian SID images - we are tracking a rolling distro so we want to
 # force a re-build of the base image if we ever need to build one of
 # its children.
+ifndef SKIP_DOCKER_BUILD
 docker-image-debian-sid: NOCACHE=1
+endif
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
-- 
2.17.1
