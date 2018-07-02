Received: from eggs.gnu.org ([2001:4830:134:3::10]:58342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZzxx-00036J-Rb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZzxw-0005Ga-RK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:38:09 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZzxw-0005Ft-J4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:38:08 -0400
Received: by mail-wm0-x236.google.com with SMTP id 69-v6so8961597wmf.3
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:38:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  2 Jul 2018 15:30:16 +0100
Message-Id: <20180702143021.18864-16-alex.bennee@linaro.org>
In-Reply-To: <20180702143021.18864-1-alex.bennee@linaro.org>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 15/20] docker: Do not run tests in
 'intermediate' images
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We can still build the DOCKER_INTERMEDIATE_IMAGES images,
but they won't appear in 'make test*@$IMAGE'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 1813ec0781..8641f5da2c 100644
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
@@ -101,7 +103,7 @@ docker-image-travis: NOUSER=1
 docker-image-tricore-cross: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
-$(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
+$(foreach i,$(filter-out $(DOCKER_INTERMEDIATE_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
 		$(eval .PHONY: docker-$t@$i) \
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
-- 
2.17.1
