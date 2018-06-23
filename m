Received: from eggs.gnu.org ([2001:4830:134:3::10]:40928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqTF-0005u0-6E
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqTB-0000x7-3o
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:53:25 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqTA-0000wz-Uh
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:53:21 -0400
Received: by mail-qk0-x241.google.com with SMTP id c131-v6so5621429qkb.0
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 14:53:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 23 Jun 2018 18:53:13 -0300
Message-Id: <20180623215313.1252-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Xtensa cpu supported:
- dc232b
- dc233c
- csp

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
based on http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06782.html

Max: Do we need to use the overlay configuration?

This image allow the build of your dc232b tests (using [1]):

$ make check-tcg
...
  CC      vl.o
  CC      qmp.o
  LINK    xtensa-softmmu/qemu-system-xtensa
  BUILD   debian-xtensa-cross
  BUILD   TCG tests for xtensa-softmmu
  CHECK   debian-xtensa-cross
  BUILD   xtensa guest-tests with docker qemu:debian-xtensa-cross
  RUN     TCG tests for xtensa-softmmu
  CHECK   debian-xtensa-cross
  BUILD   xtensa guest-tests with docker qemu:debian-xtensa-cross
$ file xtensa-softmmu/tests/*tst
xtensa-softmmu/tests/test_bi.tst:        ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped
xtensa-softmmu/tests/test_break.tst:     ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped
...
xtensa-softmmu/tests/test_timer.tst:     ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped
xtensa-softmmu/tests/test_windowed.tst:  ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped

[1]: https://github.com/philmd/qemu/tree/testing/gcov-and-other-build-tweaks-v1c

 .../dockerfiles/debian-xtensa-cross.docker    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-xtensa-cross.docker

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
new file mode 100644
index 0000000000..afd2ab9163
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -0,0 +1,31 @@
+#
+# Docker cross-compiler target
+#
+# This docker target builds on the debian stretch base image,
+# using a prebuilt toolchains for Xtensa cores from:
+# https://github.com/foss-xtensa/toolchain/releases
+#
+FROM debian:stretch-slim
+
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        bison \
+        build-essential \
+        ca-certificates \
+        curl \
+        flex \
+        gettext \
+        git \
+        python-minimal
+
+ENV CPU_LIST csp dc232b dc233c
+ENV TOOLCHAIN_RELEASE 2018.02
+
+RUN for cpu in $CPU_LIST; do \
+        curl -#SL http://github.com/foss-xtensa/toolchain/releases/download/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
+        | tar -xzC /opt; \
+    done
+
+ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-csp-elf/bin
-- 
2.18.0
