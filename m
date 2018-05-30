Received: from eggs.gnu.org ([2001:4830:134:3::10]:37326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywY-0008Ni-Tn
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywX-0001yb-Vv
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:02 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:42434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNywX-0001wd-Pk
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:01 -0400
Received: by mail-wr0-x231.google.com with SMTP id w10-v6so29102655wrk.9
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 04:07:01 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 30 May 2018 12:06:50 +0100
Message-Id: <20180530110655.22022-4-alex.bennee@linaro.org>
In-Reply-To: <20180530110655.22022-1-alex.bennee@linaro.org>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/8] docker: do not display deprecated
 images in 'make docker' help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

the 'debian' base image is deprecated since 3e11974988d8

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 50cd51a54e..31f21a43f5 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -4,7 +4,8 @@
 
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
+DOCKER_DEPRECATED_IMAGES := debian
+DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
@@ -63,7 +64,7 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
 docker-image-travis: NOUSER=1
 
 # Expand all the pre-requistes for each docker image and test combination
-$(foreach i,$(DOCKER_IMAGES), \
+$(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
 		$(eval .PHONY: docker-$t@$i) \
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
-- 
2.17.0
