Received: from eggs.gnu.org ([2001:4830:134:3::10]:40332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwOER-0002uG-TI
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwOEN-0006FJ-Vf
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:55:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwOEN-0006E4-QR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 03:55:07 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 25 Sep 2017 15:54:58 +0800
Message-Id: <20170925075458.18047-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: Don't mount ccache db if NOUSER=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

With NOUSER=1 the container runs code as root, which may create
privileged files that will not be be accssible next time. Skip ccache
dir mount in this case.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 0e4f159619..6f9ea196a7 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -143,9 +143,11 @@ docker-run: docker-qemu-src
 			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
 			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
 			-e SHOW_ENV=$(SHOW_ENV) 			\
-			-e CCACHE_DIR=/var/tmp/ccache 			\
+			$(if $(NOUSER),,				\
+				-e CCACHE_DIR=/var/tmp/ccache 		\
+				-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z \
+			)						\
 			-v $$(readlink -e $(DOCKER_SRC_COPY)):/var/tmp/qemu:z$(COMMA)ro \
-			-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z 	\
 			$(IMAGE) 					\
 			/var/tmp/qemu/run 				\
 			$(TEST), "  RUN $(TEST) in ${IMAGE}")
-- 
2.13.5
