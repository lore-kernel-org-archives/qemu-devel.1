Received: from eggs.gnu.org ([2001:4830:134:3::10]:45082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkB-0002N1-4d
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkA-00004w-5I
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:39 -0400
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:32875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFk9-0008WE-WA
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:38 -0400
Received: by mail-ua0-x231.google.com with SMTP id i4-v6so19295529uak.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:29:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:29:21 -0300
Message-Id: <20180717022924.25428-2-f4bug@amsat.org>
In-Reply-To: <20180717022924.25428-1-f4bug@amsat.org>
References: <20180717022924.25428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] docker: Use the host architecture
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

This image is badly named and not amd64 specific.

Use `dpkg --print-architecture` to get the host architecture.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-amd64.docker | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index eb13f06ed1..3312374304 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -30,9 +30,11 @@ RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disabl
 # netmap
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        linux-headers-amd64
+        linux-headers-$(dpkg --print-architecture)
 RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
-RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install
+RUN cd /usr/src/netmap/LINUX && \
+    ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) && \
+    make install
 ENV QEMU_CONFIGURE_OPTS --enable-netmap
 
 # gcrypt
-- 
2.18.0
