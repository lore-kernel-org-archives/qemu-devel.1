Received: from eggs.gnu.org ([2001:4830:134:3::10]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1j-0000uP-Us
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1i-0004gt-7K
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1i-0004fX-0A
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:22 +0800
Message-Id: <20170717034825.1524-13-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] docker: Don't enable networking as a
 side-effect of DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

When trying to debug problems with tests it is natural to set
DEBUG=1 when starting the docker environment. Unfortunately
this has a side-effect of enabling an eth0 network interface
in the container, which changes the operating environment of
the test suite. IOW tests with fail may suddenly start
working again if DEBUG=1 is set, due to changed network setup.

Add a separate NETWORK variable to allow enablement of
networking separately from DEBUG=1. This can be used in two
ways. To enable the default docker network backend

  make docker-test-build@fedora NETWORK=1

while to enable a specific network backend, eg join the network
associated with the container 'wibble':

  make docker-test-build@fedora NETWORK=container:wibble

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20170713144352.2212-1-berrange@redhat.com>
[Drop the superfluous second $(subst ...). - Fam]
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 037cb9e..012a2fc 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -106,6 +106,8 @@ docker:
 	@echo '                         (default is 1)'
 	@echo '    DEBUG=1              Stop and drop to shell in the created container'
 	@echo '                         before running the command.'
+	@echo '    NETWORK=1            Enable virtual network interface with default backend.'
+	@echo '    NETWORK=$BACKEND     Enable virtual network interface with $BACKEND.'
 	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
 	@echo '    NOCACHE=1            Ignore cache when build images.'
 	@echo '    EXECUTABLE=<path>    Include executable in image.'
@@ -132,7 +134,8 @@ docker-run: docker-qemu-src
 		$(SRC_PATH)/tests/docker/docker.py run 			\
 			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
 			$(if $V,,--rm) 					\
-			$(if $(DEBUG),-i,--net=none) 			\
+			$(if $(DEBUG),-i,)				\
+			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
 			-e TARGET_LIST=$(TARGET_LIST) 			\
 			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
 			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
-- 
2.9.4
