Received: from eggs.gnu.org ([2001:4830:134:3::10]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMCvz-00051G-Qb
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMCvy-0005xQ-Lc
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:39:07 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:45991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMCvy-0005xD-Ex
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:39:06 -0400
Received: by mail-wr0-x22e.google.com with SMTP id w3-v6so9301712wrl.12
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 06:39:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 May 2018 14:38:13 +0100
Message-Id: <20180525133851.27161-12-alex.bennee@linaro.org>
In-Reply-To: <20180525133851.27161-1-alex.bennee@linaro.org>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 11/49] docker: Makefile.include introduce
 DOCKER_SCRIPT
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

Define this in one place to make it easy to re-use.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ef1a3e62eb..b56386f49e 100644
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
2.17.0
