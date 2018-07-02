Received: from eggs.gnu.org ([2001:4830:134:3::10]:54335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZzqZ-0005NX-34
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZzqX-0000TU-ON
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:31 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:42976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZzqX-0000Sn-IT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:30:29 -0400
Received: by mail-wr0-x229.google.com with SMTP id p1-v6so15793279wrs.9
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:30:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  2 Jul 2018 15:30:07 +0100
Message-Id: <20180702143021.18864-7-alex.bennee@linaro.org>
In-Reply-To: <20180702143021.18864-1-alex.bennee@linaro.org>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/20] travis: add gcovr summary for GCOV
 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
---
v2
  - pushed finagling into scripts/coverage-summary.sh
    - dropped r-b as a big change
v3
  - move from scripts to scripts/travis and update MAINTAINERS
---
 .travis.yml                        |  3 +++
 MAINTAINERS                        |  1 +
 scripts/travis/coverage-summary.sh | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100755 scripts/travis/coverage-summary.sh

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
index 42a1892d6a..4917b8e48d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2165,6 +2165,7 @@ R: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
