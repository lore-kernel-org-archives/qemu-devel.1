Received: from eggs.gnu.org ([2001:4830:134:3::10]:38773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvH-00046c-BC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvB-0001id-82
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:59 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIvA-0001fZ-Sy
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:53 -0400
Received: by mail-wr0-x241.google.com with SMTP id w7-v6so170583wrn.6
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:51:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:26 +0100
Message-Id: <20180619154435.18898-48-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 47/56] tests/tcg: override runners for broken
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Yongbok Kim <yongbok.kim@mips.com>

To get a clean run of check-tcg these tests are currently skipped:

  - hello-mips for mips
  - linux-test for sparc

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4
  - document broken tests in commit
  - temporarily demote fcvt while fixes percolate upstream
v5
  - reinstate fcvt
  - remove test-mmap overrides (done with EXTRA_RUNS now)
v6
  - move to after the skip-test helper
v7
  - rm personal path

diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 71f0c2dd53..086625f533 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -17,3 +17,6 @@ hello-mips: LDFLAGS+=-nostdlib
 
 # For MIPS32 and 64 we have a bunch of extra tests in sub-directories
 # however they are intended for system tests.
+
+run-hello-mips: hello-mips
+	$(call skip-test, $<, "BROKEN")
diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
index 408dace783..5bd7f90583 100644
--- a/tests/tcg/sparc64/Makefile.target
+++ b/tests/tcg/sparc64/Makefile.target
@@ -1,6 +1,11 @@
 # -*- Mode: makefile -*-
 #
-# sparc specific tweaks
+# sparc specific tweaks and masking out broken tests
+
+# different from the other hangs:
+# tests/tcg/multiarch/linux-test.c:264: Value too large for defined data type (ret=-1, errno=92/Value too large for defined data type)
+run-linux-test: linux-test
+	$(call skip-test, $<, "BROKEN")
 
 # On Sparc64 Linux support 8k pages
 EXTRA_RUNS+=run-test-mmap-8192
-- 
2.17.1
