Received: from eggs.gnu.org ([209.51.188.92]:52164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn225-0003WR-FI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn224-0000jB-8D
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn222-0000fO-ND
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id g67so6732518wmd.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:29 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:14 +0000
Message-Id: <20190125140017.6092-12-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 11/14] tests/vm: call make check directly
 for netbsd/freebsd/ubuntu.i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The "make check" target calls check-qtest which has the appropriate
system binaries as dependencies so we shouldn't need to do two steps
of make invocation. Doing it in two steps was a hangover from when our
make check couldn't run tests in parallel.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/freebsd     | 1 -
 tests/vm/netbsd      | 1 -
 tests/vm/ubuntu.i386 | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 19a3729172..a85c866c30 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -25,7 +25,6 @@ class FreeBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/vtbd1;
         ./configure {configure_opts};
-        gmake --output-sync -j{jobs} {verbose};
         gmake --output-sync -j{jobs} check {verbose};
     """
 
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index fac6a7ce51..edea113bb5 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -25,7 +25,6 @@ class NetBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rld1a;
         ./configure --python=python2.7 {configure_opts};
-        gmake --output-sync -j{jobs} {verbose};
         gmake --output-sync -j{jobs} check {verbose};
     """
 
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 1b7e1ab8f0..252e514859 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -26,7 +26,6 @@ class UbuntuX86VM(basevm.BaseVM):
         sudo chmod a+r /dev/vdb;
         tar -xf /dev/vdb;
         ./configure {configure_opts};
-        make --output-sync -j{jobs};
         make --output-sync check -j{jobs} {verbose};
     """
 
-- 
2.17.1
