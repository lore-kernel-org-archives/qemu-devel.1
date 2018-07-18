Received: from eggs.gnu.org ([2001:4830:134:3::10]:55368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKZ-00038K-HO
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKX-00011K-KW
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:11 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKX-00010a-DQ
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:09 -0400
Received: by mail-wm0-x241.google.com with SMTP id z6-v6so14663207wma.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:04:57 +0100
Message-Id: <20180718100505.7546-3-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 02/10] docker: change docker-image to
 docker-all-images target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We also evaluate this list later in the build rule after all decisions
about what will and won't be built have been made.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index c9e412f9d0..22adf6ac73 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -8,7 +8,6 @@ DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
 DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian8-mxe debian-ports debian-sid debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
-DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
 
@@ -34,8 +33,6 @@ $(DOCKER_SRC_COPY):
 
 docker-qemu-src: $(DOCKER_SRC_COPY)
 
-docker-image: ${DOCKER_TARGETS}
-
 # General rule for building docker images. If we are a sub-make
 # invoked with SKIP_DOCKER_BUILD we still check the image is upto date
 # though
@@ -154,6 +151,10 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPR
 	) \
 )
 
+# Expand a rule to build all useable images
+DOCKER_TARGETS := $(patsubst %,docker-image-%,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)))
+docker-all-images: $(DOCKER_TARGETS)
+
 docker:
 	@echo 'Build QEMU and run tests inside Docker containers'
 	@echo
@@ -167,7 +168,7 @@ docker:
 	@echo '                         Note: "TEST" is one of the listed test name,'
 	@echo '                         or a script name under $$QEMU_SRC/tests/docker/;'
 	@echo '                         "IMAGE" is one of the listed container name."'
-	@echo '    docker-image:        Build all images.'
+	@echo '    docker-all-images:   Build all images.'
 	@echo '    docker-image-IMAGE:  Build image "IMAGE".'
 	@echo '    docker-run:          For manually running a "TEST" with "IMAGE"'
 	@echo
-- 
2.17.1
