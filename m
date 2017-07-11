Received: from eggs.gnu.org ([2001:4830:134:3::10]:54185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaO-0001vK-Fo
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaK-0004di-0P
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:40 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaJ-0004de-Rs
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:35 -0400
Received: by mail-qk0-f176.google.com with SMTP id p21so90144507qke.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:11:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:51 -0300
Message-Id: <20170711031000.24844-10-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 09/18] docker: enable netmap to extend code
 coverage on amd64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-amd64-cross.docker | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 88b1b3f4e3..8fb9f90814 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -25,3 +25,11 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
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
2.13.2
