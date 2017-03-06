Received: from eggs.gnu.org ([2001:4830:134:3::10]:55070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckqot-0004TM-9x
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckqoq-0001Rf-N8
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:28:51 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ckqoq-0001RT-Fa
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:28:48 -0500
Received: by mail-wr0-x230.google.com with SMTP id g10so114167304wrg.2
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 03:28:48 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  6 Mar 2017 11:28:48 +0000
Message-Id: <20170306112848.659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker/dockerfiles/debian-s390-cross: include
 clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

It's a silly little limitation on Shippable that is looks for clang
in the container even though we won't use it. The arm/aarch64 cross
builds inherit this from debian.docker but as we needed to use
debian-testing for this we add it here. We also collapse the update
step into one RUN line to remove and intermediate layer of the docker
build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-s390x-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index bbb21ed088..3a687feda0 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -13,8 +13,8 @@ RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
 RUN dpkg --add-architecture s390x
 
 # Grab the updated list of packages
-RUN apt update
-RUN apt dist-upgrade -yy
+RUN apt update && apt dist-upgrade -yy
+RUN apt install -yy build-essential clang
 RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
 RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
 
-- 
2.11.0
