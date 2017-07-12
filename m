Received: from eggs.gnu.org ([2001:4830:134:3::10]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVKSg-0006Wd-Nd
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVKSd-00071I-KP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:26:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVKSd-0006zm-EW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:25:59 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 12 Jul 2017 17:25:50 +0100
Message-Id: <20170712162550.8061-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] Don't enable networking as a side-effect of
 DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>

When trying to debug problems with tests it is natural to set
DEBUG=1 when starting the docker environment. Unfortunately
this has a side-effect of enabling an eth0 network interface
in the container, which changes the operating environment of
the test suite. IOW tests with fail may suddenly start
working again if DEBUG=1 is set, due to changed network setup.

Add a separate NETWORK=1 option to allow enablement of
networking separately from DEBUG=1, since common debugging
tasks probably don't require networking anyway.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/docker/Makefile.include | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 037cb9e..a8c4b82 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -106,6 +106,7 @@ docker:
 	@echo '                         (default is 1)'
 	@echo '    DEBUG=1              Stop and drop to shell in the created container'
 	@echo '                         before running the command.'
+	@echo '    NETWORK=1            Enable eth0 virtual network interface.'
 	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
 	@echo '    NOCACHE=1            Ignore cache when build images.'
 	@echo '    EXECUTABLE=<path>    Include executable in image.'
@@ -132,7 +133,8 @@ docker-run: docker-qemu-src
 		$(SRC_PATH)/tests/docker/docker.py run 			\
 			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
 			$(if $V,,--rm) 					\
-			$(if $(DEBUG),-i,--net=none) 			\
+			$(if $(DEBUG),-i,)				\
+			$(if $(NETWORK),,--net=none)			\
 			-e TARGET_LIST=$(TARGET_LIST) 			\
 			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
 			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
-- 
2.9.4
