Received: from eggs.gnu.org ([2001:4830:134:3::10]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugm-0002XQ-5P
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugl-0005MV-9b
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:16 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:52646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTugl-0005L3-2V
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:15 -0400
Received: by mail-wm0-x236.google.com with SMTP id p126-v6so5199662wmb.2
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:19 +0100
Message-Id: <20180615194705.28019-9-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 08/54] docker: Makefile.include introduce
 DOCKER_SCRIPT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Define this in one place to make it easy to re-use.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 74fd51c22c..8afb383478 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -15,6 +15,8 @@ DOCKER_TESTS := $(notdir $(shell \
 
 DOCKER_TOOLS := travis
 
+DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py
+
 TESTS ?= %
 IMAGES ?= %
 
@@ -38,7 +40,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
 	fi
 	$(call quiet-command,\
-		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
+		$(DOCKER_SCRIPT) build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
 		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
@@ -133,11 +135,11 @@ docker-run: docker-qemu-src
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
@@ -167,4 +169,4 @@ docker-run-%:
 	@$(MAKE) docker-run TEST=$(CMD) IMAGE=qemu:$(IMAGE)
 
 docker-clean:
-	$(call quiet-command, $(SRC_PATH)/tests/docker/docker.py clean)
+	$(call quiet-command, $(DOCKER_SCRIPT) clean)
-- 
2.17.1
