Received: from eggs.gnu.org ([2001:4830:134:3::10]:54934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jR-0008RY-RQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jQ-000849-Rv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jQ-00083W-LO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id h10-v6so1470350wrq.8
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:24 +0100
Message-Id: <20180705160329.30386-16-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 15/20] docker: Do not run tests in
 'intermediate' images
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

We can still build the DOCKER_INTERMEDIATE_IMAGES images,
but they won't appear in 'make test*@$IMAGE'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 91d9665517..942d05649f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -5,6 +5,8 @@
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
+# we don't run tests on intermediate images (used as base by another image)
+DOCKER_INTERMEDIATE_IMAGES := debian8 debian9 debian8-mxe debian-ports debian-sid
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
@@ -98,7 +100,7 @@ docker-image-travis: NOUSER=1
 docker-image-tricore-cross: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
-$(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
+$(foreach i,$(filter-out $(DOCKER_INTERMEDIATE_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
 		$(eval .PHONY: docker-$t@$i) \
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
-- 
2.17.1
