Received: from eggs.gnu.org ([2001:4830:134:3::10]:54865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jL-0008Ne-SF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jK-00080W-MW
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:39 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jK-0007zq-GN
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:38 -0400
Received: by mail-wm0-x229.google.com with SMTP id s14-v6so11817964wmc.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:16 +0100
Message-Id: <20180705160329.30386-8-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 07/20] travis: add gcovr summary for GCOV
 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This gives a more useful summary, sorted by descending % coverage,
after the tests have run. The final numbers will give an idea if our
coverage is getting better or worse.

To keep the width sane we need to post process the file that the old
gcovr tool generates. This is done with a mix of sed, awk and column
in the scripts/coverage-summary.sh script.

As quite a lot of lines don't get covered at all we filter out all the
0% lines. If the file doesn't appear it is not being exercised.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index 32188d51f1..95be6ec59f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -38,6 +38,7 @@ addons:
       - libvte-2.90-dev
       - sparse
       - uuid-dev
+      - gcovr
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
 # to prevent IRC notifications from forks. This was created using:
@@ -86,6 +87,8 @@ matrix:
       compiler: clang
     # gprof/gcov are GCC features
     - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+      after_success:
+        - ${SRC_DIR}/scripts/travis/coverage-summary.sh
       compiler: gcc
     # We manually include builds which we disable "make check" for
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
diff --git a/MAINTAINERS b/MAINTAINERS
index 6630d691d1..6a13f70f99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2166,6 +2166,7 @@ R: Philippe Mathieu-Daudé <f4bug@amsat.org>
 L: qemu-devel@nongnu.org
 S: Maintained
 F: .travis.yml
+F: scripts/travis/
 F: .shippable.yml
 F: tests/docker/
 F: tests/vm/
diff --git a/scripts/travis/coverage-summary.sh b/scripts/travis/coverage-summary.sh
new file mode 100755
index 0000000000..d7086cf9ca
--- /dev/null
+++ b/scripts/travis/coverage-summary.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Author: Alex Bennée <alex.bennee@linaro.org>
+#
+# Summerise the state of code coverage with gcovr and tweak the output
+# to be more sane on Travis hosts. As we expect to be executed on a
+# throw away CI instance we do spam temp files all over the shop. You
+# most likely don't want to execute this script but just call gcovr
+# directly. See also "make coverage-report"
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+
+# first generate the coverage report
+gcovr -p -o raw-report.txt
+
+# strip the full-path and line markers
+sed s@$PWD\/@@ raw-report.txt | sed s/[0-9]\*[,-]//g > simplified.txt
+
+# reflow lines that got split
+awk '/.[ch]$/ { printf("%s", $0); next } 1' simplified.txt > rejoined.txt
+
+# columnify
+column -t rejoined.txt > final.txt
+
+# and dump, stripping out 0% coverage
+grep -v "0%" final.txt
-- 
2.17.1
