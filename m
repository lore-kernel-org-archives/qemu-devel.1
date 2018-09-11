Received: from eggs.gnu.org ([2001:4830:134:3::10]:55800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJR-0008RW-Jo
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJM-0007Wj-15
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:41 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzjJL-0007VN-N8
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id e1-v6so17150980wrt.3
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 07:06:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Sep 2018 15:06:29 +0100
Message-Id: <20180911140631.18481-3-alex.bennee@linaro.org>
In-Reply-To: <20180911140631.18481-1-alex.bennee@linaro.org>
References: <20180911140631.18481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/4] docker: add buildroot-nios2-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1791796@bugs.launchpad.net, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Build a buildroot toolchain for the nios2 target.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                         |  4 ++++
 tests/docker/dockerfiles/buildroot-nios2-cross.docker | 10 ++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 tests/docker/dockerfiles/buildroot-nios2-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 74a82de48a..a8dfde8ed5 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -120,6 +120,10 @@ docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-debian-powerpc-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
+# Buildroot base images
+# These involve building the toolchains and can take some time
+docker-image-buildroot-nios2-cross: docker-image-debian-buildroot-base
+
 # Specialist build images, sometimes very limited tools
 docker-image-tricore-cross: docker-image-debian9
 
diff --git a/tests/docker/dockerfiles/buildroot-nios2-cross.docker b/tests/docker/dockerfiles/buildroot-nios2-cross.docker
new file mode 100644
index 0000000000..e573f0fa55
--- /dev/null
+++ b/tests/docker/dockerfiles/buildroot-nios2-cross.docker
@@ -0,0 +1,10 @@
+#
+# NIOS II toolchain
+#
+FROM qemu:debian-buildroot-base
+
+RUN cd /opt/buildroot-${BUILDROOT_VERSION} && make qemu_nios2_10m50_defconfig
+RUN cd /opt/buildroot-${BUILDROOT_VERSION} && make toolchain
+
+# The toolchain is in /opt/buildroot-${BUILDROOT_VERSION}/output/host/bin/nios2-*
+RUN ln -s /opt/buildroot-${BUILDROOT_VERSION}/output/host/bin/nios2-* /usr/bin
-- 
2.17.1
