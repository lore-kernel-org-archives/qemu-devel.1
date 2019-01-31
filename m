Received: from eggs.gnu.org ([209.51.188.92]:51781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpKV7-0000qT-KS
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpKL2-0002x1-0K
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:36 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:44165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1gpKL1-0002od-GH
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:35 -0500
From: Michael Walle <michael@walle.cc>
Date: Thu, 31 Jan 2019 22:56:10 +0100
Message-Id: <20190131215611.29341-3-michael@walle.cc>
In-Reply-To: <20190131215611.29341-1-michael@walle.cc>
References: <20190131215611.29341-1-michael@walle.cc>
Subject: [Qemu-devel] [RFC PATCH 2/3] tests/tcg: also pass AS and LD
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Walle <michael@walle.cc>

The lm32 architecture doesn't need the complete compiler. In fact, only
the building of GCC is skipped to make building the docker image faster.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 tests/tcg/Makefile.include | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index 73b5626fc5..19b81400f5 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -41,17 +41,26 @@ ifneq ($(DOCKER_IMAGE),)
 # We also need the Docker make rules to depend on
 include $(SRC_PATH)/tests/docker/Makefile.include
 
-DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
+DOCKER_CC_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
 		--cc $(DOCKER_CROSS_COMPILER) \
 		-i qemu:$(DOCKER_IMAGE) \
 		-s $(SRC_PATH) -- "
+DOCKER_AS_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
+		--cc $(DOCKER_CROSS_ASSEMBLER) \
+		-i qemu:$(DOCKER_IMAGE) \
+		-s $(SRC_PATH) -- "
+DOCKER_LD_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
+		--cc $(DOCKER_CROSS_LINKER) \
+		-i qemu:$(DOCKER_IMAGE) \
+		-s $(SRC_PATH) -- "
 DOCKER_PREREQ=docker-image-$(DOCKER_IMAGE)
 
 .PHONY: docker-build-guest-tests
 docker-build-guest-tests: $(DOCKER_PREREQ)
 	$(call quiet-command, \
 	  (mkdir -p tests && cd tests && \
-	   $(MAKE) -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
+	   $(MAKE) -f $(TCG_MAKE) CC=$(DOCKER_CC_CMD) \
+			AS=$(DOCKER_AS_CMD) LD=$(DOCKER_LD_CMD) \
 			BUILD_STATIC=y \
 			EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
 	"BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
-- 
2.11.0
