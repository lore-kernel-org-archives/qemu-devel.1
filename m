Received: from eggs.gnu.org ([2001:4830:134:3::10]:56800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXPX6-0004y1-CW
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXPX5-0008DY-8d
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:44 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:38944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXPX5-0008Cz-1Z
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:43 -0400
Received: by mail-wr0-x229.google.com with SMTP id b8-v6so7833347wro.6
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:19:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 12:19:31 +0100
Message-Id: <20180625111935.26108-7-alex.bennee@linaro.org>
In-Reply-To: <20180625111935.26108-1-alex.bennee@linaro.org>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 06/10] travis: add gcovr summary for GCOV
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This gives a more useful summary, sorted by descending % coverage,
after the tests have run. The final numbers will give an idea if our
coverage is getting better or worse.

To keep the width sane we need to post process the file that the old
gcovr tool generates. This is done with a mix of sed, awk and column
in the scripts/coverage-summary.sh script.

As quite a lot of lines don't get covered at all we filter out all the
0% lines. If the file doesn't appear it is not being exercised.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - pushed finagling into scripts/coverage-summary.sh
    - dropped r-b as a big change
---
 .travis.yml                 |  3 +++
 scripts/coverage-summary.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100755 scripts/coverage-summary.sh

diff --git a/.travis.yml b/.travis.yml
index 32188d51f1..aa850c913c 100644
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
+        - ${SRC_DIR}/scripts/coverage-summary.sh
       compiler: gcc
     # We manually include builds which we disable "make check" for
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
diff --git a/scripts/coverage-summary.sh b/scripts/coverage-summary.sh
new file mode 100755
index 0000000000..d7086cf9ca
--- /dev/null
+++ b/scripts/coverage-summary.sh
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
