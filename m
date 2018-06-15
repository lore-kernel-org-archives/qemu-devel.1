Received: from eggs.gnu.org ([2001:4830:134:3::10]:53931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoX-0000X4-8W
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoT-0006TH-TC
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:17 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:56019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuoT-0006Rh-Lp
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:13 -0400
Received: by mail-wm0-x242.google.com with SMTP id v16-v6so5202034wmh.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:55:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:53 +0100
Message-Id: <20180615194705.28019-43-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 42/54] tests/tcg: enable building for PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Now we have restored debian-image-powerpc-cross using Debian SID
compilers we can build for 32 bit powerpc. Although PPC32 supports a
range of pages sizes currently only 4k works so the others are
commented out for now.

We can also merge the ppc64 support under the base architecture
directory to avoid too much proliferation of directories.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v5
  - new for v5
---
 tests/tcg/ppc/Makefile.include     |  7 +++++++
 tests/tcg/ppc/Makefile.target      | 12 ++++++++++++
 tests/tcg/ppc64le/Makefile.include |  2 --
 3 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/ppc/Makefile.include
 create mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/ppc64le/Makefile.include

diff --git a/tests/tcg/ppc/Makefile.include b/tests/tcg/ppc/Makefile.include
new file mode 100644
index 0000000000..b062c30dd3
--- /dev/null
+++ b/tests/tcg/ppc/Makefile.include
@@ -0,0 +1,7 @@
+ifeq ($(TARGET_NAME),ppc)
+DOCKER_IMAGE=debian-powerpc-cross
+DOCKER_CROSS_COMPILER=powerpc-linux-gnu-gcc
+else ifeq ($(TARGET_NAME),ppc64le)
+DOCKER_IMAGE=debian-ppc64el-cross
+DOCKER_CROSS_COMPILER=powerpc64le-linux-gnu-gcc
+endif
diff --git a/tests/tcg/ppc/Makefile.target b/tests/tcg/ppc/Makefile.target
new file mode 100644
index 0000000000..f5e08c7376
--- /dev/null
+++ b/tests/tcg/ppc/Makefile.target
@@ -0,0 +1,12 @@
+# -*- Mode: makefile -*-
+#
+# PPC - included from tests/tcg/Makefile
+#
+
+ifneq (,$(findstring 64,$(TARGET_NAME)))
+# On PPC64 Linux can be configured with 4k (default) or 64k pages (currently broken)
+EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-65536
+else
+# On PPC32 Linux supports 4K/16K/64K/256K (but currently only 4k works)
+EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-16384 run-test-mmap-65536 run-test-mmap-262144
+endif
diff --git a/tests/tcg/ppc64le/Makefile.include b/tests/tcg/ppc64le/Makefile.include
deleted file mode 100644
index d71cfc9aa7..0000000000
--- a/tests/tcg/ppc64le/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-ppc64el-cross
-DOCKER_CROSS_COMPILER=powerpc64le-linux-gnu-gcc
-- 
2.17.1
