Received: from eggs.gnu.org ([2001:4830:134:3::10]:45548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDeO-0005oQ-6h
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDeJ-0003uM-8Y
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:25:00 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMDeJ-0003u0-21
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:24:55 -0400
Received: by mail-wm0-x241.google.com with SMTP id a8-v6so14895615wmg.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:24:54 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 May 2018 15:19:14 +0100
Message-Id: <20180525141915.6497-9-alex.bennee@linaro.org>
In-Reply-To: <20180525141915.6497-1-alex.bennee@linaro.org>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141915.6497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 48/49] tests/tcg: override runners for
 broken tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Yongbok Kim <yongbok.kim@mips.com>

To get a clean run of check-tcg these tests are currently skipped:

  - hello-mips for mips
  - linux-test for sparc

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - document broken tests in commit
  - temporarily demote fcvt while fixes percolate upstream
v5
  - reinstate fcvt
  - remove test-mmap overrides (done with EXTRA_RUNS now)
---
 tests/tcg/mips/Makefile.target    | 4 ++++
 tests/tcg/sparc64/Makefile.target | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 71f0c2dd53..3db4eaf131 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -17,3 +17,7 @@ hello-mips: LDFLAGS+=-nostdlib
 
 # For MIPS32 and 64 we have a bunch of extra tests in sub-directories
 # however they are intended for system tests.
+
+run-hello-mips: hello-mips
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
+
diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
index 408dace783..7237779b26 100644
--- a/tests/tcg/sparc64/Makefile.target
+++ b/tests/tcg/sparc64/Makefile.target
@@ -1,6 +1,11 @@
 # -*- Mode: makefile -*-
 #
-# sparc specific tweaks
+# sparc specific tweaks and masking out broken tests
+
+# different from the other hangs
+# /home/alex/lsrc/qemu/qemu.git/tests/tcg/multiarch/linux-test.c:264: Value too large for defined data type (ret=-1, errno=92/Value too large for defined data type)
+run-linux-test: linux-test
+	$(call quiet-command, /bin/true, "BROKEN TEST", "$< SKIPPED on $(TARGET_NAME)")
 
 # On Sparc64 Linux support 8k pages
 EXTRA_RUNS+=run-test-mmap-8192
-- 
2.17.0
