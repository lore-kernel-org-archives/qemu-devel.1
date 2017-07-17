Received: from eggs.gnu.org ([2001:4830:134:3::10]:36978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Kh-00066N-30
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Kf-0002FQ-W3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:11 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:32793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7Kf-0002FA-Pe
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:09 -0400
Received: by mail-wr0-x22e.google.com with SMTP id a10so13057832wrd.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:49:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:38 +0100
Message-Id: <20170717144848.11793-14-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 13/23] docker: enable netmap to extend code
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-amd64.docker | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 360ecf0360..71bcfc14d5 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -26,3 +26,11 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libgbm-dev
 RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
+
+# netmap
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        linux-headers-amd64
+RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
+RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install
+ENV QEMU_CONFIGURE_OPTS --enable-netmap
-- 
2.13.0
