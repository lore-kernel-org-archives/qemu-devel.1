Received: from eggs.gnu.org ([2001:4830:134:3::10]:51384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRJsV-0008FL-2p
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRJsT-0002va-Qx
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:39 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRJsT-0002uy-K4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:37 -0400
Received: by mail-wr0-x241.google.com with SMTP id e18-v6so5673557wrs.5
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 09:04:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 17:04:32 +0100
Message-Id: <20180608160432.8734-4-alex.bennee@linaro.org>
In-Reply-To: <20180608160432.8734-1-alex.bennee@linaro.org>
References: <20180608160432.8734-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/3] docker: remove SUBMAKE_NOCACHE_HACK
 for debian-sid based images
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

Now we can conditionally make docker-image-debian-sid a dependency
depending on if we actually need to re-build our image we can remove
this hack and use that mechanism.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 25 ++++++++++++++-----------
 tests/tcg/Makefile.include    |  1 -
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3393e9f97d..2ce72de180 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -66,18 +66,21 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
 # its children. However when doing check-tcg we ensure everything is
 # built at top-level make so we can dispense with NOCACHE here to
 # avoid excessive re-builds.
-ifneq ($(SUBMAKE_NOCACHE_HACK),y)
 docker-image-debian-sid: NOCACHE=1
-endif
-
-docker-image-debian-alpha-cross: docker-image-debian-sid
-docker-image-debian-hppa-cross: docker-image-debian-sid
-docker-image-debian-m68k-cross: docker-image-debian-sid
-docker-image-debian-sh4-cross: docker-image-debian-sid
-docker-image-debian-sparc64-cross: docker-image-debian-sid
-docker-image-debian-mips64-cross: docker-image-debian-sid
-docker-image-debian-riscv64-cross: docker-image-debian-sid
-docker-image-debian-powerpc-cross: docker-image-debian-sid
+
+# $1 = dockerfile, $2 = dependancy
+cond-dock-dep = $(if \
+	$(call $(DOCKER_SCRIPT) check --quiet \
+		-t qemu:$1 $(DOCKER_FILES_DIR)/$1.docker),$2)
+
+docker-image-debian-alpha-cross: $(call cond-dock-dep,debian-alpha-cross,docker-image-debian-sid)
+docker-image-debian-hppa-cross: $(call cond-dock-dep,debian-hppa-cross,docker-image-debian-sid)
+docker-image-debian-m68k-cross: $(call cond-dock-dep,debian-m68k-cross,docker-image-debian-sid)
+docker-image-debian-sh4-cross: $(call cond-dock-dep,debian-sh4-cross,docker-image-debian-sid)
+docker-image-debian-sparc64-cross: $(call cond-dock-dep,debian-sparc64-cross,docker-image-debian-sid)
+docker-image-debian-mips64-cross: $(call cond-dock-dep,debian-mip64-cross,docker-image-debian-sid)
+docker-image-debian-riscv64-cross: $(call cond-dock-dep,debian-riscv64-cross,docker-image-debian-sid)
+docker-image-debian-powerpc-cross: $(call cond-dock-dep,debian-powerpc-cross,docker-image-debian-sid)
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index 951f40c28d..4851df0951 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -39,7 +39,6 @@ ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
 ifneq ($(DOCKER_IMAGE),)
 
 # We also need the Docker make rules to depend on
-SUBMAKE_NOCACHE_HACK=y
 include $(SRC_PATH)/tests/docker/Makefile.include
 
 DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
-- 
2.17.1
