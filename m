Received: from eggs.gnu.org ([2001:4830:134:3::10]:46635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z74-0000Ao-CP
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z73-0006L4-Cc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:30 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z73-0006KR-6X
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:29 -0400
Received: by mail-wr0-x229.google.com with SMTP id z73so13954336wrb.0
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:03 +0100
Message-Id: <20180410193919.28026-9-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 08/24] docker: Makefile.include introduce
 DOCKER_SCRIPT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Define this in one place to make it easy to re-use.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index de87341528..6a5aa9ec71 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -14,6 +14,8 @@ DOCKER_TESTS := $(notdir $(shell \
 
 DOCKER_TOOLS := travis
 
+DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py
+
 TESTS ?= %
 IMAGES ?= %
 
@@ -37,7 +39,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
 	fi
 	$(call quiet-command,\
-		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
+		$(DOCKER_SCRIPT) build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
 		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
@@ -129,11 +131,11 @@ docker-run: docker-qemu-src
 	fi
 	$(if $(EXECUTABLE),						\
 		$(call quiet-command,					\
-			$(SRC_PATH)/tests/docker/docker.py update 	\
+			$(DOCKER_SCRIPT) update 			\
 			$(IMAGE) $(EXECUTABLE),				\
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
-		$(SRC_PATH)/tests/docker/docker.py run 			\
+		$(DOCKER_SCRIPT) run 					\
 			$(if $(NOUSER),,-u $(shell id -u)) 		\
 			--security-opt seccomp=unconfined		\
 			$(if $V,,--rm) 					\
@@ -163,4 +165,4 @@ docker-run-%:
 	@$(MAKE) docker-run TEST=$(CMD) IMAGE=qemu:$(IMAGE)
 
 docker-clean:
-	$(call quiet-command, $(SRC_PATH)/tests/docker/docker.py clean)
+	$(call quiet-command, $(DOCKER_SCRIPT) clean)
-- 
2.16.2
