Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuZ-0000vi-7Z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuY-0006Wx-H1
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:23 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:51433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuY-0006Wa-Am
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:22 -0400
Received: by mail-wm0-x235.google.com with SMTP id y2-v6so1446901wma.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:03 +0100
Message-Id: <20180724105109.8392-12-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/17] docker: drop QEMU_TARGET check,
 fallback in EXECUTABLE not set
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

The addition of QEMU_TARGET was intended to ensure we fall back to
checking for the existence of an image if the build system was not
currently configured to build it. However this breaks the direct use
of the rule for building custom binfmt_misc images. We already check
for EXECUTABLE so let us just use that as a proxy for deciding if we
are just going to check the image exits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8fbb076396..05afeb64a7 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -58,13 +58,11 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 	$(if $(EXECUTABLE),,\
 		$(error EXECUTABLE not set, debootstrap of debian-$* would fail))
-	$(if $(wildcard $(EXECUTABLE)),,\
-		$(error Please build $(EXECUTABLE) first))
 	$(if $(DEB_ARCH),,\
 		$(error DEB_ARCH not set, debootstrap of debian-$* would fail))
 	$(if $(DEB_TYPE),,\
 		$(error DEB_TYPE not set, debootstrap of debian-$* would fail))
-	$(if $(filter $(QEMU_TARGET),$(TARGET_DIRS)),				\
+	$(if $(wildcard $(EXECUTABLE)),						\
 		$(call quiet-command,						\
 			DEB_ARCH=$(DEB_ARCH)					\
 			DEB_TYPE=$(DEB_TYPE)					\
@@ -136,7 +134,6 @@ DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross fedora-i386-c
 # broken so we need a qemu-linux-user for this target
 docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
 docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
-docker-binfmt-image-debian-powerpc-user: QEMU_TARGET = ppc-linux-user
 docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
 docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
 DOCKER_USER_IMAGES += debian-powerpc-user
-- 
2.17.1
