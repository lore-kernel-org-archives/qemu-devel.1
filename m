Received: from eggs.gnu.org ([2001:4830:134:3::10]:45108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkE-0002Ou-3s
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkD-00006R-A0
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:42 -0400
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:35705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkD-00006C-3m
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:41 -0400
Received: by mail-ua0-x230.google.com with SMTP id q12-v6so26182578ual.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:29:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:29:22 -0300
Message-Id: <20180717022924.25428-3-f4bug@amsat.org>
In-Reply-To: <20180717022924.25428-1-f4bug@amsat.org>
References: <20180717022924.25428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] docker: Improve how the virgl library is
 built
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

- Call autogen once in the same layer of the git repository clone,
- Disable build warnings (they are not relevant for QEMU),
- Call ldconfig once installed.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-amd64.docker | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 3312374304..d79a599a0d 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -24,8 +24,12 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
-RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer
-RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
+RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer && \
+    cd /usr/src/virglrenderer && ./autogen.sh
+RUN cd /usr/src/virglrenderer && \
+    CPPFLAGS=-w ./configure --with-glx --disable-tests && \
+    make install && \
+    ldconfig
 
 # netmap
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-- 
2.18.0
