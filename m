Received: from eggs.gnu.org ([2001:4830:134:3::10]:55487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKi-0003Ju-GG
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKf-00019U-3R
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:20 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:50752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKe-00018r-GO
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:16 -0400
Received: by mail-wm0-x229.google.com with SMTP id v25-v6so2202856wmc.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:05:04 +0100
Message-Id: <20180718100505.7546-10-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 09/10] tests: tcg skip docker images we
 can't build
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

We have a mechansim (DOCKER_PARTIAL_IMAGES) for marking stuff that is
incomplete or won't build. We can use this to avoid attempting to
build them at the top of a check-tcg build. We need to move the
inclusion of docker/Makefile.include to ensure everything is resolved
by this point.

We also have to check this in tests/tcg/Makefile.include to cover the
case where users are building directly out of the target tree.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile                   | 4 +++-
 tests/tcg/Makefile.include | 3 +++
 tests/tcg/Makefile.probe   | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 2da686be33..6bb8035557 100644
--- a/Makefile
+++ b/Makefile
@@ -434,6 +434,9 @@ dummy := $(call unnest-vars,, \
                 audio-obj-m \
                 trace-obj-y)
 
+# we need to know what Docker images can be built before we can
+# decide on all the tests that can be built.
+include $(SRC_PATH)/tests/docker/Makefile.include
 include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
@@ -1069,7 +1072,6 @@ endif
 # Dependencies in Makefile.objs files come from our recursive subdir rules
 -include $(wildcard *.d tests/*.d)
 
-include $(SRC_PATH)/tests/docker/Makefile.include
 include $(SRC_PATH)/tests/vm/Makefile.include
 
 .PHONY: help
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index 57470b2a2c..e5f0298375 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -41,6 +41,8 @@ ifneq ($(DOCKER_IMAGE),)
 # We also need the Docker make rules to depend on
 include $(SRC_PATH)/tests/docker/Makefile.include
 
+ifneq ($(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGE)),)
+
 DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
 		--cc $(DOCKER_CROSS_COMPILER) \
 		-i qemu:$(DOCKER_IMAGE) \
@@ -58,6 +60,7 @@ docker-build-guest-tests: $(DOCKER_PREREQ)
 
 GUEST_BUILD=docker-build-guest-tests
 
+endif
 endif
 endif
 
diff --git a/tests/tcg/Makefile.probe b/tests/tcg/Makefile.probe
index 15c0412657..22c77d6b88 100644
--- a/tests/tcg/Makefile.probe
+++ b/tests/tcg/Makefile.probe
@@ -20,7 +20,7 @@ DOCKER_PREREQ:=
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
 
 ifndef CROSS_CC_GUEST
-ifneq ($(DOCKER_IMAGE),)
+ifneq ($(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGE)),)
 DOCKER_PREREQ:=docker-image-$(DOCKER_IMAGE)
 endif
 endif
-- 
2.17.1
