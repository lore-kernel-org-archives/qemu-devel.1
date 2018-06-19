Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoH-0006Xf-Tc
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoG-0006Ou-W0
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:45 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:38739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIoG-0006OK-PA
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:44 -0400
Received: by mail-wr0-x235.google.com with SMTP id e18-v6so154784wrs.5
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:44:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:43:47 +0100
Message-Id: <20180619154435.18898-9-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/56] docker: Makefile.include introduce
 DOCKER_SCRIPT
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

Define this in one place to make it easy to re-use.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
