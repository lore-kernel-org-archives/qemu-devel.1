Received: from eggs.gnu.org ([2001:4830:134:3::10]:36949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Ke-00064e-50
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Kd-0002EK-B0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:08 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7Kd-0002Dm-4G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:07 -0400
Received: by mail-wm0-x233.google.com with SMTP id t70so17889308wmt.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:49:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:37 +0100
Message-Id: <20170717144848.11793-13-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 12/23] docker: enable virgl to extend code
 coverage on amd64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: mv, comments in dockerfile]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-amd64.docker | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

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
