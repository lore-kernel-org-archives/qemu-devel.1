Received: from eggs.gnu.org ([2001:4830:134:3::10]:46655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0V-0007em-CS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0U-0003Em-LX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:35 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:32838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0U-0003EO-FN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:34 -0400
Received: by mail-wr0-x232.google.com with SMTP id a10so23440954wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:34 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:54 +0100
Message-Id: <20170718104513.23947-14-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/32] docker: enable virgl to extend code
 coverage on amd64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: mv, comments in dockerfile]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 2ab76120a4..360ecf0360 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -1,7 +1,8 @@
 #
 # Docker x86_64 target
 #
-# This docker target builds on the debian Stretch base image.
+# This docker target builds on the debian Stretch base image. Further
+# libraries which are not widely available are installed by hand.
 #
 FROM qemu:debian9
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
@@ -16,3 +17,12 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         librdmacm-dev \
         libsnappy-dev \
         libvte-dev
+
+# virgl
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libegl1-mesa-dev \
+        libepoxy-dev \
+        libgbm-dev
+RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer
+RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
-- 
2.13.0
