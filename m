Received: from eggs.gnu.org ([2001:4830:134:3::10]:48373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGfo-0005pX-Iz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGfn-0000yv-4Z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:20 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRGfm-0000yR-UG
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:19 -0400
Received: by mail-wr0-x244.google.com with SMTP id f16-v6so13263094wrm.3
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:39:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 13:33:06 +0100
Message-Id: <20180608123307.24773-49-alex.bennee@linaro.org>
In-Reply-To: <20180608123307.24773-1-alex.bennee@linaro.org>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 48/49] tests/docker: prevent sub-makes
 re-building debian-sid
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

This is a bit of a hack but having ensured Debian SID is built at
least once in the top-level we don't need to do it over and over
again. Perhaps a better solution would be to have docker.py spit out
the dependency if a base image is too old?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 6 +++++-
 tests/tcg/Makefile.include    | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 78568d7c61..3393e9f97d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -63,8 +63,12 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
 
 # Debian SID images - we are tracking a rolling distro so we want to
 # force a re-build of the base image if we ever need to build one of
-# its children.
+# its children. However when doing check-tcg we ensure everything is
+# built at top-level make so we can dispense with NOCACHE here to
+# avoid excessive re-builds.
+ifneq ($(SUBMAKE_NOCACHE_HACK),y)
 docker-image-debian-sid: NOCACHE=1
+endif
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index 4851df0951..951f40c28d 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -39,6 +39,7 @@ ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
 ifneq ($(DOCKER_IMAGE),)
 
 # We also need the Docker make rules to depend on
+SUBMAKE_NOCACHE_HACK=y
 include $(SRC_PATH)/tests/docker/Makefile.include
 
 DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
-- 
2.17.1
