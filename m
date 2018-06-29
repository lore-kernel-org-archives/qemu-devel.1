Received: from eggs.gnu.org ([2001:4830:134:3::10]:57769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Sj-0004Gj-UM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Si-0005LQ-BI
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:57:49 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:46941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZ0Si-0005Kh-4T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:57:48 -0400
Received: by mail-wr0-x234.google.com with SMTP id s11-v6so755784wra.13
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:57:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 29 Jun 2018 21:52:30 +0100
Message-Id: <20180629205232.27190-20-alex.bennee@linaro.org>
In-Reply-To: <20180629205232.27190-1-alex.bennee@linaro.org>
References: <20180629205232.27190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 19/21] docker: add special rule for
 deboostrapped images
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

We might as well have a custom rule for this. For one things the
dependencies are different. We drop the test and EXECUTABLE lines from
the general rule as they are no longer needed there.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8641f5da2c..d3bd2f57dd 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -49,16 +49,32 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		"CHECK", "$*")
 else
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
-	@if test "$@" = docker-image-debian-bootstrap -a -z "$(EXECUTABLE)"; then \
-		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
-	fi
 	$(call quiet-command,\
 		$(DOCKER_SCRIPT) build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
 		$(if $(NOUSER),,--add-current-user) \
-		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
-		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
+		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES)),\
 		"BUILD","$*")
+
+# special rule for debootstrapped debian-FOO-user images
+docker-image-debian-%-user: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
+	@if test -z "$(EXECUTABLE)"; then \
+		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
+	fi
+	@if test -z "$(DEB_ARCH)"; then 					\
+		echo WARNING: DEB_ARCH is not set, debootstrap may fail. 2>&1 ; \
+        fi
+	@if test -z "$(DEB_TYPE)"; then 					\
+		echo WARNING: DEB_TYPE is not set, debootstrap may fail. 2>&1 ; \
+        fi
+	$(call quiet-command,							\
+		$(DOCKER_SCRIPT) build qemu:debian-$*-user $< \
+		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
+		$(if $(NOUSER),,--add-current-user) \
+		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
+		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)) \
+		-E DEB_ARCH=${DEB_ARCH} -E DEB_TYPE=${DEB_TYPE}, \
+		"BUILD","debian-$*-user (debootstrapped linux-user)")
 endif
 
 # Enforce dependencies for composite images
-- 
2.17.1
