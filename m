Received: from eggs.gnu.org ([2001:4830:134:3::10]:33653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp7-0007dr-AL
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp6-0002ax-B8
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxlp6-0002aX-4p
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Sep 2017 11:18:31 +0800
Message-Id: <20170929031831.10179-6-famz@redhat.com>
In-Reply-To: <20170929031831.10179-1-famz@redhat.com>
References: <20170929031831.10179-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] docker: Don't mount ccache db if NOUSER=1
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
List-ID: <qemu-devel.nongnu.org>

With NOUSER=3D1 the container runs code as root, which may create
privileged files that will not be be accssible next time. Skip ccache
dir mount in this case.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170925075458.18047-1-famz@redhat.com>
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 0e4f159619..6f9ea196a7 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -143,9 +143,11 @@ docker-run: docker-qemu-src
 			-e EXTRA_CONFIGURE_OPTS=3D"$(EXTRA_CONFIGURE_OPTS)" \
 			-e V=3D$V -e J=3D$J -e DEBUG=3D$(DEBUG)		\
 			-e SHOW_ENV=3D$(SHOW_ENV) 			\
-			-e CCACHE_DIR=3D/var/tmp/ccache 			\
+			$(if $(NOUSER),,				\
+				-e CCACHE_DIR=3D/var/tmp/ccache 		\
+				-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z \
+			)						\
 			-v $$(readlink -e $(DOCKER_SRC_COPY)):/var/tmp/qemu:z$(COMMA)ro \
-			-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z 	\
 			$(IMAGE) 					\
 			/var/tmp/qemu/run 				\
 			$(TEST), "  RUN $(TEST) in ${IMAGE}")
--=20
2.13.5
