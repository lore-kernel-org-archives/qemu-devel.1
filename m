Received: from eggs.gnu.org ([2001:4830:134:3::10]:37882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgv0-0006nF-55
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNguz-00056q-6N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:42 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNguz-000569-0A
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:41 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 77so138150496wrb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:47:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:48:09 +0100
Message-Id: <20170621144814.15324-17-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/21] shippable: do not initialize submodules
 automatically
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

instead do it in the 'ci' target when needed.

for mips64el-softmmu target:
use dtc submodule if distrib packages are too old.

example with outdated libfdt on mips64el-softmmu target (required is >= 1.4.2):
 # dpkg-query --showformat='${Version}\n' --show libfdt-dev
 1.4.0+dfsg-1

shippable output:
----------------
  LINK    mips64el-softmmu/qemu-system-mips64el
../hw/core/loader-fit.o: In function `load_fit':
/root/src/github.com/philmd/qemu/hw/core/loader-fit.c:278: undefined reference to `fdt_first_subnode'
/root/src/github.com/philmd/qemu/hw/core/loader-fit.c:286: undefined reference to `fdt_next_subnode'
/root/src/github.com/philmd/qemu/hw/core/loader-fit.c:277: undefined reference to `fdt_first_subnode'
collect2: error: ld returned 1 exit status
Makefile:201: recipe for target 'qemu-system-mips64el' failed
make[1]: *** [qemu-system-mips64el] Error 1
Makefile:327: recipe for target 'subdir-mips64el-softmmu' failed
make: *** [subdir-mips64el-softmmu] Error 2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 1e3ae35dd9..46adfa030f 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -1,4 +1,6 @@
 language: c
+git:
+   submodules: false
 env:
   global:
     - LC_ALL=C
@@ -19,5 +21,13 @@ build:
     options: "-e HOME=/root"
   ci:
     - unset CC
+    # some targets require newer up to date packages, for example TARGET_LIST matching
+    # aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
+    # see the configure script:
+    #    error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:"
+    #    "  (1) Preferred: Install the DTC (libfdt) devel package"
+    #    "  (2) Fetch the DTC submodule, using:"
+    #    "      git submodule update --init dtc"
+    - dpkg --compare-versions `dpkg-query --showformat='${Version}' --show libfdt-dev` ge 1.4.2 || git submodule update --init dtc
     - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
     - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
-- 
2.13.0
