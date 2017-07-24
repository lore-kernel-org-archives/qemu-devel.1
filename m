Received: from eggs.gnu.org ([2001:4830:134:3::10]:50932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi73-0001Pc-IR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi72-000637-D6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:49 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi72-00062O-9R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:48 -0400
Received: by mail-qt0-x241.google.com with SMTP id n42so3131636qtn.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:29:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:50 -0300
Message-Id: <20170724182751.18261-35-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.10 34/35] docker: add debian
 'bleeding' image with gcc7 and clang5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .../docker/dockerfiles/debian-bleeding-dev.docker  | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-bleeding-dev.docker

diff --git a/tests/docker/dockerfiles/debian-bleeding-dev.docker b/tests/docker/dockerfiles/debian-bleeding-dev.docker
new file mode 100644
index 0000000000..d6ae20692c
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-bleeding-dev.docker
@@ -0,0 +1,94 @@
+#
+# Docker x86_64 bleeding image
+#
+# This docker target builds on the debian unstable base image. Further
+# libraries which are not widely available are installed by hand.
+#
+FROM debian:unstable
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+RUN echo 'Acquire::ForceIPv4 "true";' >> /etc/apt/apt.conf.d/01network
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+
+# Install common build utilities
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        bison \
+        build-essential \
+        ca-certificates \
+        ccache \
+        flex \
+        git \
+        less \
+        pkg-config \
+        psmisc \
+        python \
+        texinfo \
+        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        binutils-multiarch \
+        gdb-multiarch \
+        libnewlib-dev \
+        musl-dev \
+        uclibc-source
+
+############################################################################
+# GCC 7
+
+RUN echo deb http://httpredir.debian.org/debian experimental main >> \
+    /etc/apt/sources.list.d/experimental.list && apt-get update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        gcc-7 \
+        gcc-7-cross-base-ports \
+        gcc-7-multilib \
+        g++-7
+
+############################################################################
+# Clang 5
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        curl gnupg
+RUN curl http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
+    echo 'deb http://apt.llvm.org/unstable/ llvm-toolchain main' \
+        > /etc/apt/sources.list.d/llvm.list && \
+    apt-get update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        clang-5.0 \
+        lldb-5.0 \
+        llvm-5.0 && \
+    test -x /usr/bin/clang || ln -s clang-5.0 /usr/bin/clang
+
+############################################################################
+# QEMU specific starts here
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy qemu
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libbz2-dev \
+        liblzo2-dev \
+        librdmacm-dev \
+        libsnappy-dev \
+        libvte-dev
+
+# virgl
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libegl1-mesa-dev \
+        libepoxy-dev \
+        libgbm-dev
+RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer
+RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
+
+ENV QEMU_CONFIGURE_OPTS --host-cc=clang-5.0 --cc=clang-5.0 --cxx=clang++-5.0
-- 
2.13.3
