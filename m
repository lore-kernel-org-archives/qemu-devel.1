Received: from eggs.gnu.org ([2001:4830:134:3::10]:52482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4Q-00075a-4Z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4O-0003ke-Uj
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:46:58 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:37036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4O-0003jF-Pn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:46:56 -0400
Received: by mail-qk0-x230.google.com with SMTP id t79-v6so3351450qke.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:46:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 13:46:36 -0300
Message-Id: <20180628164643.9668-2-f4bug@amsat.org>
In-Reply-To: <20180628164643.9668-1-f4bug@amsat.org>
References: <20180628164643.9668-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/8] docker: ubuntu: Update the package list
 before installing new ones
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Since docker caches the different layers, updating the package
list does not invalidate the previous "apt-get update" layer,
and it is likely "apt-get install" hits an outdated repository.

See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get

This fixes:

  $ make docker-image-ubuntu V=1
  ./tests/docker/docker.py build qemu:ubuntu tests/docker/dockerfiles/ubuntu.docker   --add-current-user
  Sending build context to Docker daemon  3.072kB
  [...]
  E: Failed to fetch http://archive.ubuntu.com/ubuntu/pool/main/m/mesa/libgles2-mesa_17.0.7-0ubuntu0.16.04.2_amd64.deb  404  Not Found
  E: Failed to fetch http://archive.ubuntu.com/ubuntu/pool/main/m/mesa/libgles2-mesa-dev_17.0.7-0ubuntu0.16.04.2_amd64.deb  404  Not Found
  E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
  The command '/bin/sh -c apt-get -y install $PACKAGES' returned a non-zero code: 100
  tests/docker/Makefile.include:40: recipe for target 'docker-image-ubuntu' failed
  make: *** [docker-image-ubuntu] Error 1

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/ubuntu.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index dabbf2a8a4..c03520ce3f 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -1,7 +1,6 @@
 FROM ubuntu:16.04
 RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> \
     /etc/apt/sources.list
-RUN apt-get update
 ENV PACKAGES flex bison \
     libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
     libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
@@ -13,6 +12,7 @@ ENV PACKAGES flex bison \
     libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
     texinfo \
     gettext git make ccache python-yaml gcc clang sparse
-RUN apt-get -y install $PACKAGES
+RUN apt-get update && \
+    apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml
-- 
2.18.0
